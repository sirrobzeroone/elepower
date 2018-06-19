-- Network graphs are built eminating from provider nodes.
--[[
	TODO:
	Currently, there's a problem where storage nodes are allowed to create their own graph.
	When placing the storage onto a cable, it will add itself to the graph of that cable.
	But, when placing a cable onto the storage, that cable is added to the storage's own graph
	and thus cannot be connected to the previous graph.
]]

-- Network cache
ele.graphcache = {devices = {}}

---------------------
-- Graph Functions --
---------------------

local function clear_networks_from_node(pos)
	local meta = minetest.get_meta(pos)
	meta:set_string("network_id", "")
end

local function add_node(nodes, pos, pnodeid)
	local node_id = minetest.hash_node_position(pos)
	if ele.graphcache.devices[node_id] and ele.graphcache.devices[node_id] ~= pnodeid then return end
	ele.graphcache.devices[node_id] = pnodeid
	if nodes[node_id] then
		return false
	end
	nodes[node_id] = pos
	return true
end

local function add_conductor_node(nodes, pos, pnodeid, queue)
	if add_node(nodes, pos, pnodeid) then
		queue[#queue + 1] = pos
	end
end

local function check_node(users, providers, all_nodes, pos, pr_pos, pnodeid, queue)
	ele.helpers.get_or_load_node(pos)
	local node = minetest.get_node(pos)
	local meta = minetest.get_meta(pos)

	if ele.helpers.get_item_group(node.name, "ele_conductor") then
		local nodedef = minetest.registered_nodes[node.name]
		add_conductor_node(all_nodes, pos, pnodeid, queue)
		return
	end

	if not ele.helpers.get_item_group(node.name, "ele_machine") then
		return
	end

	-- Don't add already networked nodes to this network
	if meta:get_string("network_id") ~= "" and meta:get_string("network_id") ~= pnodeid then
		return
	end

	meta:set_string("network_id", pnodeid)

	if ele.helpers.get_item_group(node.name, "ele_user") then
		add_node(users, pos, pnodeid)
	elseif ele.helpers.get_item_group(node.name, "ele_provider") then
		if ele.helpers.get_item_group(node.name, "ele_storage") then
			-- Storage gets added to users, for now
			add_node(users, pos, pnodeid)
		else
			add_node(providers, pos, pnodeid)
		end
	end
end

local function traverse_network(users, providers, all_nodes, pos, pr_pos, pnodeid, queue)
	local positions = {
		{x=pos.x+1, y=pos.y,   z=pos.z},
		{x=pos.x-1, y=pos.y,   z=pos.z},
		{x=pos.x,   y=pos.y+1, z=pos.z},
		{x=pos.x,   y=pos.y-1, z=pos.z},
		{x=pos.x,   y=pos.y,   z=pos.z+1},
		{x=pos.x,   y=pos.y,   z=pos.z-1}}
	for _, cur_pos in pairs(positions) do
		check_node(users, providers, all_nodes, cur_pos, pr_pos, pnodeid, queue)
	end
end

local function power_networks(pr_pos, positions)
	local provider = minetest.get_node(pr_pos)
	local pnodeid  = minetest.pos_to_string(pr_pos)

	if ele.graphcache[pnodeid] then
		local cached = ele.graphcache[pnodeid]
		return cached.users, cached.providers
	end

	local users     = {}
	local providers = {}
	local queue     = {}
	local all_nodes = {}

	for pos in pairs(positions) do
		queue = {}

		local node = minetest.get_node(pos)
		if node and ele.helpers.get_item_group(node.name, "ele_conductor") then
			add_conductor_node(all_nodes, pos, pnodeid, queue)
		elseif node and ele.helpers.get_item_group(node.name, "ele_machine") then
			queue = {pr_pos}
		end

		while next(queue) do
			local to_visit = {}
			for _, posi in ipairs(queue) do
				traverse_network(users, providers, all_nodes, posi, pr_pos, pnodeid, to_visit)
			end
			queue = to_visit
		end
	end

	-- Add self to providers
	local prov_id = minetest.hash_node_position(pr_pos)
	ele.graphcache.devices[prov_id] = pnodeid
	providers[prov_id] = pr_pos

	users     = ele.helpers.flatten(users)
	providers = ele.helpers.flatten(providers)
	all_nodes = ele.helpers.flatten(all_nodes)

	ele.graphcache[pnodeid] = {all_nodes = all_nodes, users = users, providers = providers}

	return users, providers
end

-----------------------
-- Main Transfer ABM --
-----------------------

local function give_node_power(pos, available)
	local user_meta = minetest.get_meta(pos)
	local capacity  = ele.helpers.get_node_property(user_meta, pos, "capacity")
	local inrush    = ele.helpers.get_node_property(user_meta, pos, "inrush")
	local storage   = user_meta:get_int("storage")

	local total_add = 0

	if available >= inrush then
		total_add = inrush
	elseif available < inrush then
		total_add = inrush - available
	end

	if total_add + storage > capacity then
		total_add = capacity - storage
	end

	if storage >= capacity then
		total_add = 0
		storage   = capacity
	end

	return total_add, storage
end

minetest.register_abm({
	nodenames = {"group:ele_provider"},
	label = "elepowerPowerGraphSource",
	interval   = 1,
	chance     = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		local meta  = minetest.get_meta(pos)
		local meta1 = nil

		-- Check if a provider is attached to a network.
		-- If that network has been abolished, we will use this node as the network's root this time.
		local netwrkto = meta:get_string("ele_network")
		if netwrkto ~= "" and netwrkto ~= nil then
			if not ele.helpers.get_item_group(node.name, "ele_storage") then
				local lpos = minetest.string_to_pos(netwrkto)
				if ele.helpers.get_item_group(minetest.get_node(lpos).name, "ele_provider") then
					return
				else
					ele.graphcache[netwrkto] = nil
				end
				meta:set_string("ele_network", "")
			end
		end

		local users     = {}
		local providers = {}

		local providerdef = minetest.registered_nodes[node.name]

		-- TODO: Customizable output sides
		local positions = {
			{x=pos.x,   y=pos.y-1, z=pos.z},
			{x=pos.x,   y=pos.y+1, z=pos.z},
			{x=pos.x-1, y=pos.y,   z=pos.z},
			{x=pos.x+1, y=pos.y,   z=pos.z},
			{x=pos.x,   y=pos.y,   z=pos.z-1},
			{x=pos.x,   y=pos.y,   z=pos.z+1}
		}

		local ntwks   = {}
		local errored = false
		local nw_branches = 0
		for _,pos1 in pairs(positions) do
			local name = node.name
			local networked = ele.helpers.get_item_group(name, "ele_machine") or ele.helpers.get_item_group(name, "ele_conductor")
			if networked then
				ntwks[pos1] = true
				nw_branches = nw_branches + 1
			end
		end

		if errored then
			return
		end

		if nw_branches == 0 then
			minetest.forceload_free_block(pos)
			return
		else
			minetest.forceload_block(pos)
		end

		users, providers = power_networks(pos, ntwks)

		-- Calculate power data
		local pw_supply = 0
		local pw_demand = 0

		for _, spos in ipairs(providers) do
			local smeta      = minetest.get_meta(spos)
			local pw_storage = smeta:get_int("storage")
			local p_output   = ele.helpers.get_node_property(smeta, spos, "output")

			if p_output and pw_storage >= p_output then
				pw_supply = pw_supply + p_output
			elseif p_output and pw_storage < p_output then
				pw_supply = pw_supply + pw_storage
			end
		end

		-- Give power to users
		for _,ndv in ipairs(users) do
			if pw_demand >= pw_supply then
				break
			end

			local user_gets, user_storage = give_node_power(ndv, pw_supply - pw_demand)
			pw_demand = pw_demand + user_gets

			local user_meta = minetest.get_meta(ndv)
			user_meta:set_int("storage", user_storage + user_gets)

			if user_gets > 0 then
				-- Set timer on this node
				local t = minetest.get_node_timer(ndv)
				if not t:is_started() then
					t:start(1.0)
				end
			end
		end

		-- Take the power from a provider node
		if pw_demand > 0 then
			for _, spos in ipairs(providers) do
				local smeta = minetest.get_meta(spos)
				local pw_storage = smeta:get_int("storage")

				if pw_storage >= pw_demand then
					smeta:set_int("storage", pw_storage - pw_demand)
				else
					pw_demand = pw_demand - pw_storage
					smeta:set_int("storage", 0)
				end
				minetest.get_node_timer(spos):start(1.0)
			end
		end
	end,
})

local function check_connections(pos)
	local connections = {}
	local positions = {
		{x=pos.x+1, y=pos.y,   z=pos.z},
		{x=pos.x-1, y=pos.y,   z=pos.z},
		{x=pos.x,   y=pos.y+1, z=pos.z},
		{x=pos.x,   y=pos.y-1, z=pos.z},
		{x=pos.x,   y=pos.y,   z=pos.z+1},
		{x=pos.x,   y=pos.y,   z=pos.z-1}}

	for _,connected_pos in pairs(positions) do
		local name = minetest.get_node(connected_pos).name
		if ele.helpers.get_item_group(name, "ele_conductor") or ele.helpers.get_item_group(name, "ele_machine") then
			table.insert(connections, connected_pos)
		end
	end
	return connections
end

-- Update networks when a node has been placed or removed
function ele.clear_networks(pos)
	local node = minetest.get_node(pos)
	local meta = minetest.get_meta(pos)
	local name = node.name
	local placed = name ~= "air"
	local positions = check_connections(pos)
	if #positions < 1 then return end
	local dead_end = #positions == 1
	for _,connected_pos in pairs(positions) do
		local net = ele.graphcache.devices[minetest.hash_node_position(connected_pos)] or minetest.pos_to_string(connected_pos)
		if net and ele.graphcache[net] then
			if dead_end and placed then
				-- Dead end placed, add it to the network
				-- Get the network
				local node_at = minetest.get_node(positions[1])
				local network_id = ele.graphcache.devices[minetest.hash_node_position(positions[1])] or minetest.pos_to_string(positions[1])

				if not network_id or not ele.graphcache[network_id] then
					-- We're evidently not on a network, nothing to add ourselves to
					return
				end
				local c_pos = minetest.string_to_pos(network_id)
				local network = ele.graphcache[network_id]

				-- Actually add it to the (cached) network
				-- This is similar to check_node_subp
				ele.graphcache.devices[minetest.hash_node_position(pos)] = network_id
				pos.visited = 1

				if ele.helpers.get_item_group(name, "ele_conductor") then
					table.insert(network.all_nodes, pos)
				end

				if ele.helpers.get_item_group(name, "ele_machine") then
					meta:set_string("ele_network", network_id)

					if ele.helpers.get_item_group(name, "ele_provider") then
						if ele.helpers.get_item_group(name, "ele_storage") then
							-- TODO: Add storage to users for now
							table.insert(network.users, pos)
						else
							table.insert(network.providers, pos)
						end
					elseif ele.helpers.get_item_group(name, "ele_user") then
						table.insert(network.users, pos)
					end
				end
			elseif dead_end and not placed then
				-- Dead end removed, remove it from the network
				-- Get the network
				local network_id = ele.graphcache.devices[minetest.hash_node_position(positions[1])] or minetest.pos_to_string(positions[1])
				if not network_id or not ele.graphcache[network_id] then
					-- We're evidently not on a network, nothing to remove ourselves from
					return
				end
				local network = ele.graphcache[network_id]

				-- The network was deleted.
				if network_id == minetest.pos_to_string(pos) then
					for _,v in ipairs(network.all_nodes) do
						local pos1 = minetest.hash_node_position(v)
						clear_networks_from_node(v)
						ele.graphcache.devices[pos1] = nil
					end
					ele.graphcache[network_id] = nil
					return
				end

				-- Search for and remove device
				ele.graphcache.devices[minetest.hash_node_position(pos)] = nil
				for tblname,table in pairs(network) do
					if type(table) == "table" then
						for devicenum,device in pairs(table) do
							if vector.equals(device, pos) then
								table[devicenum] = nil
							end
						end
					end
				end
			else
				-- Not a dead end, so the whole network needs to be recalculated
				for _,v in ipairs(ele.graphcache[net].all_nodes) do
					local pos1 = minetest.hash_node_position(v)
					clear_networks_from_node(v)
					ele.graphcache.devices[pos1] = nil
				end
				ele.graphcache[net] = nil
			end
		end
	end
end
