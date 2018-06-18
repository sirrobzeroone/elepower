-- Network graphs are built eminating from provider nodes.

-- Network cache
elefluid.graphcache = {nodes = {}}

---------------------
-- Graph Functions --
---------------------

local function clear_networks_from_node(pos)
	local meta = minetest.get_meta(pos)
	meta:set_string("network_id", "")
end

local function add_node(nodes, pos, pnodeid)
	local node_id = minetest.hash_node_position(pos)
	if elefluid.graphcache.nodes[node_id] == "" then
		elefluid.graphcache.nodes[node_id] = pnodeid
	end
	if nodes[node_id] then
		return false
	end
	nodes[node_id] = pos
	return true
end

local function add_duct_node(nodes, pos, pnodeid, queue)
	if add_node(nodes, pos, pnodeid) then
		queue[#queue + 1] = pos
	end
end

local function check_node(targets, all_nodes, pos, p_pos, pnodeid, queue)
	ele.helpers.get_or_load_node(pos)
	local node = minetest.get_node(pos)
	local meta = minetest.get_meta(pos)

	if ele.helpers.get_item_group(node.name, "elefluid_transport") then
		add_duct_node(all_nodes, pos, pnodeid, queue)
		return
	end

	if not ele.helpers.get_item_group(node.name, "fluid_container") and
		not ele.helpers.get_item_group(node.name, "fluidity_tank") then
		return
	end

	add_node(targets, pos, pnodeid)
end

local function traverse_network(targets, all_nodes, pos, p_pos, pnodeid, queue)
	local positions = {
		{x=pos.x+1, y=pos.y,   z=pos.z},
		{x=pos.x-1, y=pos.y,   z=pos.z},
		{x=pos.x,   y=pos.y+1, z=pos.z},
		{x=pos.x,   y=pos.y-1, z=pos.z},
		{x=pos.x,   y=pos.y,   z=pos.z+1},
		{x=pos.x,   y=pos.y,   z=pos.z-1}}
	for _, cur_pos in pairs(positions) do
		check_node(targets, all_nodes, cur_pos, p_pos, pnodeid, queue)
	end
end

local function fluid_targets(p_pos, positions)
	local provider = minetest.get_node(p_pos)
	local pnodeid  = minetest.pos_to_string(p_pos)

	if elefluid.graphcache[pnodeid] then
		local cached = elefluid.graphcache[pnodeid]
		return cached.targets
	end

	local targets   = {}
	local queue     = {}
	local all_nodes = {}

	for pos in pairs(positions) do
		queue = {}

		local node = minetest.get_node(pos)
		if node and ele.helpers.get_item_group(node.name, "elefluid_transport") then
			add_duct_node(all_nodes, pos, pnodeid, queue)
		elseif node and (ele.helpers.get_item_group(node.name, "fluid_container") or
			ele.helpers.get_item_group(node.name, "fluidity_tank")) then
			queue = {p_pos}
		end

		while next(queue) do
			local to_visit = {}
			for _, posi in ipairs(queue) do
				traverse_network(targets, all_nodes, posi, p_pos, pnodeid, to_visit)
			end
			queue = to_visit
		end
	end

	local prov_id = minetest.hash_node_position(p_pos)
	elefluid.graphcache.nodes[prov_id] = pnodeid

	targets   = ele.helpers.flatten(targets)
	all_nodes = ele.helpers.flatten(all_nodes)

	elefluid.graphcache[pnodeid] = {all_nodes = all_nodes, targets = targets}

	return targets
end

-----------------------
-- Main Transfer ABM --
-----------------------

minetest.register_abm({
	nodenames = {"group:elefluid_transport_source"},
	label = "elefluitFluidGraphSource",
	interval   = 1,
	chance     = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		local meta  = minetest.get_meta(pos)
		local meta1 = nil

		local targets = {}
		local source  = minetest.registered_nodes[node.name]

		local positions = {vector.add(minetest.facedir_to_dir(node.param2), pos)}

		local ntwks   = {}
		local errored = false
		local nw_branches = 0
		for _,pos1 in pairs(positions) do
			local name = node.name
			local networked = ele.helpers.get_item_group(name, "elefluid_transport_source") or
				ele.helpers.get_item_group(name, "elefluid_transport")
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

		targets = fluid_targets(pos, ntwks)

		-- Begin transfer
		local srcpos  = ele.helpers.face_front(pos, node.param2)
		local srcnode = minetest.get_node(srcpos)

		-- Make sure source node is not air
		if not srcnode or srcnode.name == "air" then
			return
		end

		-- Make sure source node is a registered fluid container
		if not ele.helpers.get_item_group(srcnode.name, "fluid_container") and
			not ele.helpers.get_item_group(srcnode.name, "fluidity_tank") then
			return
		end

		local srcmeta = minetest.get_meta(srcpos)
		local srcdef  = minetest.registered_nodes[srcnode.name]
		local buffers = elefluid.get_node_buffers(srcpos)
		if not buffers then return nil end

		local pcapability = ele.helpers.get_node_property(meta, pos, "fluid_pump_capacity")

		-- Transfer some fluid here
		for _,pos in pairs(targets) do
			if not vector.equals(pos, srcpos) then
				local pp = elefluid.get_node_buffers(pos)

				local changed = false

				if pp ~= nil then
					for name in pairs(pp) do
						for bname in pairs(buffers) do
							local buffer_data = elefluid.get_buffer_data(srcpos, bname)
							local target_data = elefluid.get_buffer_data(pos, name)

							if (target_data.fluid == buffer_data.fluid or target_data.fluid == "") and
								buffer_data.fluid ~= "" and buffer_data.amount > 0 and
								elefluid.buffer_accepts_fluid(pos, name, buffer_data.fluid) then
								
								if elefluid.can_insert_into_buffer(pos, name, buffer_data.fluid, pcapability) > 0 then
									local res_f, count = elefluid.take_from_buffer(srcpos, bname, pcapability)
									if count > 0 then
										elefluid.insert_into_buffer(pos, name, res_f, count)
										changed = true
									end
								end
							end
						end
					end
				end

				if changed then
					minetest.get_node_timer(srcpos):start(1.0)
					minetest.get_node_timer(pos):start(1.0)
				end
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
		if ele.helpers.get_item_group(name, "elefluid_transport") or
			ele.helpers.get_item_group(name, "elefluid_transport_source") or
			ele.helpers.get_item_group(name, "fluid_container") or
			ele.helpers.get_item_group(name, "fluidity_tank") then
			table.insert(connections, connected_pos)
		end
	end
	return connections
end

-- Update networks when a node has been placed or removed
function elefluid.clear_networks(pos)
	local node = minetest.get_node(pos)
	local meta = minetest.get_meta(pos)
	local name = node.name
	local placed = name ~= "air"
	local positions = check_connections(pos)
	if #positions < 1 then return end
	local dead_end = #positions == 1
	for _,connected_pos in pairs(positions) do
		local net = elefluid.graphcache.nodes[minetest.hash_node_position(connected_pos)] or minetest.pos_to_string(connected_pos)
		if net and elefluid.graphcache[net] then
			if dead_end and placed then
				-- Dead end placed, add it to the network
				-- Get the network
				local node_at = minetest.get_node(positions[1])
				local network_id = elefluid.graphcache.nodes[minetest.hash_node_position(positions[1])] or minetest.pos_to_string(positions[1])

				if not network_id or not elefluid.graphcache[network_id] then
					-- We're evidently not on a network, nothing to add ourselves to
					return
				end
				local c_pos = minetest.string_to_pos(network_id)
				local network = elefluid.graphcache[network_id]

				-- Actually add it to the (cached) network
				-- This is similar to check_node_subp
				elefluid.graphcache.nodes[minetest.hash_node_position(pos)] = network_id
				pos.visited = 1

				if ele.helpers.get_item_group(name, "elefluid_transport") then
					table.insert(network.all_nodes, pos)
				end

				if ele.helpers.get_item_group(name, "fluid_container") or
					ele.helpers.get_item_group(name, "fluidity_tank") then
					table.insert(network.targets, pos)
				end
			elseif dead_end and not placed then
				-- Dead end removed, remove it from the network
				-- Get the network
				local network_id = elefluid.graphcache.nodes[minetest.hash_node_position(positions[1])] or minetest.pos_to_string(positions[1])
				if not network_id or not elefluid.graphcache[network_id] then
					-- We're evidently not on a network, nothing to remove ourselves from
					return
				end
				local network = elefluid.graphcache[network_id]

				-- The network was deleted.
				if network_id == minetest.pos_to_string(pos) then
					for _,v in ipairs(network.all_nodes) do
						local pos1 = minetest.hash_node_position(v)
						clear_networks_from_node(v)
						elefluid.graphcache.nodes[pos1] = nil
					end
					elefluid.graphcache[network_id] = nil
					return
				end

				-- Search for and remove device
				elefluid.graphcache.nodes[minetest.hash_node_position(pos)] = nil
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
				for _,v in ipairs(elefluid.graphcache[net].all_nodes) do
					local pos1 = minetest.hash_node_position(v)
					clear_networks_from_node(v)
					elefluid.graphcache.nodes[pos1] = nil
				end
				elefluid.graphcache[net] = nil
			end
		end
	end
end
