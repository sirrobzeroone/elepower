-- Network graphs are built eminating from provider nodes.
--[[
	Power taken from power providers is not balanced so all power comes from
	1st provider in table then 2nd 3rd...etc needs balancing like users.
]]

-- Network cache
ele.graphcache = {devices = {}}

---------------------
-- Graph Functions --
---------------------

local function table_has_string(arr, str)
	for _,astr in ipairs(arr) do
		if astr == str then
			return true
		end
	end
	return false
end

local function add_node(nodes, pos, pnodeid, group)
	local node_id = minetest.hash_node_position(pos)

	if not ele.graphcache.devices[node_id] then
		ele.graphcache.devices[node_id] = {}
	end

	if not table_has_string(ele.graphcache.devices[node_id], pnodeid) then
		table.insert(ele.graphcache.devices[node_id], pnodeid)
	end

	if nodes[node_id] then
		return false
	end

	nodes[node_id] = pos

	if group ~= nil then
		nodes[node_id].group = group
	end
	return true
end

local function add_conductor_node(nodes, pos, pnodeid, queue)
	if add_node(nodes, pos, pnodeid) then
		queue[#queue + 1] = pos
	end
end

local function check_node(users, providers, conductors, pos, pr_pos, pnodeid, queue)
	if minetest.pos_to_string(pos) == pnodeid then return end

	ele.helpers.get_or_load_node(pos)
	local node = minetest.get_node(pos)
	local meta = minetest.get_meta(pos)

	if ele.helpers.get_item_group(node.name, "ele_conductor") then
		add_conductor_node(conductors, pos, pnodeid, queue)
		--minetest.debug("C2"..minetest.pos_to_string(pos))
		return
	end

	if not ele.helpers.get_item_group(node.name, "ele_machine") then
		return
	end

	if ele.helpers.get_item_group(node.name, "ele_user") then
		if add_node(users, pos, pnodeid) then
			queue[#queue + 1] = pos
			--minetest.debug("M2"..minetest.pos_to_string(pos))
		end

	elseif ele.helpers.get_item_group(node.name, "ele_storage") then
		if add_node(users, pos, pnodeid, "ele_storage") then
			queue[#queue + 1] = pos
			--minetest.debug("S2"..minetest.pos_to_string(pos))
		end
		
	elseif ele.helpers.get_item_group(node.name, "ele_provider") then
		if add_node(providers, pos, pnodeid) then
			queue[#queue + 1] = pos
			--minetest.debug("P2"..minetest.pos_to_string(pos))
		end
	end
end

local function traverse_network(users, providers, conductors, pos, pr_pos, pnodeid, queue)
	local positions = {
		{x=pos.x+1, y=pos.y,   z=pos.z},
		{x=pos.x-1, y=pos.y,   z=pos.z},
		{x=pos.x,   y=pos.y+1, z=pos.z},
		{x=pos.x,   y=pos.y-1, z=pos.z},
		{x=pos.x,   y=pos.y,   z=pos.z+1},
		{x=pos.x,   y=pos.y,   z=pos.z-1}}
	for _, cur_pos in pairs(positions) do
		
		-- if node already in table then dont add
		check_node(users, providers, conductors, cur_pos, pr_pos, pnodeid, queue)
	end
end

local function discover_branches(pr_pos, positions)
	local provider = minetest.get_node(pr_pos)
	local pnodeid  = minetest.pos_to_string(pr_pos)

	if ele.graphcache[pnodeid] then
		local cached = ele.graphcache[pnodeid]
		return cached.users, cached.providers
	end

	local users      = {}
	local providers  = {}
	local queue      = {}
	local conductors = {}

	for _,pos in ipairs(positions) do
		queue = {}

		local node = minetest.get_node(pos)
		if node and ele.helpers.get_item_group(node.name, "ele_conductor") then
			add_conductor_node(conductors, pos, pnodeid, queue)
			--minetest.debug("C "..minetest.pos_to_string(pos))
		elseif node and ele.helpers.get_item_group(node.name, "ele_machine") then
			queue = {pr_pos}
			--minetest.debug("M "..minetest.pos_to_string(pr_pos))
		end

		while next(queue) do
			local to_visit = {}
			for _, posi in ipairs(queue) do
				traverse_network(users, providers, conductors, posi, pr_pos, pnodeid, to_visit)
			end
			queue = to_visit
		end
	end

	-- Add self to providers
		add_node(providers, pr_pos, pnodeid)

	users      = ele.helpers.flatten(users)
	providers  = ele.helpers.flatten(providers)
	conductors = ele.helpers.flatten(conductors)

	ele.graphcache[pnodeid] = {conductors = conductors, users = users, providers = providers}

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
	local usage     = ele.helpers.get_node_property(user_meta, pos, "usage")
	local status     = user_meta:get_string("infotext")

	local total_add = 0

	if available >= inrush then
		total_add = inrush
	elseif available < inrush then
		total_add = available
	end

	if total_add + storage > capacity then
		total_add = capacity - storage
	end

	if storage >= capacity then
		total_add = 0
		storage   = capacity
	end

	return total_add, storage, usage, status
end


minetest.register_abm({
	nodenames = {"group:ele_provider"},
	label     = "elepower Power Transfer Tick",
	interval  = 1,
	chance    = 1,
	action    = function(pos, node, active_object_count, active_object_count_wider)
		local meta  = minetest.get_meta(pos)
		local meta1 = nil

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

		local branches = {}
		for _,pos1 in ipairs(positions) do
			local pnode = minetest.get_node(pos1)
			local name  = pnode.name
			local networked = ele.helpers.get_item_group(name, "ele_machine") or
				ele.helpers.get_item_group(name, "ele_conductor")
			
			if networked then
				branches[#branches + 1] = pos1
			end
			--minetest.debug(name.." "..tostring(networked).." :B"..#branches)
		end

		-- No possible branches found
		if #branches == 0 then
			minetest.forceload_free_block(pos)
			return
		else
			minetest.forceload_block(pos)
		end

		-- Find all users and providers
		users, providers = discover_branches(pos, branches)

		-- Calculate power data for providers
		local pw_supply  = 0
		local pw_demand  = 0
		local bat_supply = 0

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

	-- Power Cells / Batteries
		-- Calculate power data for batteries
		-- set two override tables to remove batteries from
		-- users and make them providers.
		local bat_flag       = false
		local bat_users      = {}
		local bat_providers  = {}

		-- Providers all give power on 1st provider hit by abm, then there pr_pos
		-- power avaliable is set to 0. We dont want batteries running on this
		-- secondary + abm hits. On 1st pass a meta value is set on all providers
		-- "dep_time" - depleted time, just a simple os.clock timestamp.
		local dep_timer = true
		local time_since_dep = os.clock() - meta:get_int("dep_time") or 0
			if time_since_dep < 1 then
				dep_timer = false
			end

		if pw_supply == 0 and dep_timer == true then

			for k,pg in pairs(users) do         -- pg = pos and group
				if pg.group == "ele_storage" then
					local bpos        = {x = pg.x, y = pg.y, z = pg.z}
					local smeta       = minetest.get_meta(bpos)
					local bat_storage = smeta:get_int("storage")
					local bat_output  = ele.helpers.get_node_property(smeta, bpos, "output")

					table.insert(bat_providers, pg) -- save node_users who are batteries to providers

					if bat_output and bat_storage >= bat_output then
						bat_supply = bat_supply + bat_output

					elseif bat_output and bat_storage < bat_output then
						bat_supply = bat_supply + bat_storage
					end
				else
					table.insert(bat_users, pg) -- save node_users who aren't batteries
				end
		   end

		   users = bat_users           -- replace users with bat_users so batteries arent users anymore
		   providers = bat_providers   -- replace providers with bat_providers
		   pw_supply = bat_supply      -- override with battery supply
		   bat_flag = true
		end

		-- Give power to users
		local divide_power = {}

		for _,ndv in ipairs(users) do       --ndv = pos table
			-- Check how much power a node wants and can get ie is it close to full charge
			local user_gets, user_storage, user_usage, user_status = give_node_power(ndv, (pw_supply - pw_demand))  -- pw_demand always 0 check old code

			-- when on battery we dont want to provide user_inrush or if
			-- machine is currently not in use we dont want to use bat power
			-- user_status provides the tooltip info when you point at a
			-- machine, only intrested in "Active", any value but "nil" indicates
			-- the word "Active" was found.
			if bat_flag == true then
				local active = string.find(user_status, "Active")
				if active ~= nil then
					if user_gets > user_usage then
						user_gets = user_usage
					end
				else
					user_gets = 0
				end
			end

			-- Add the node_users wanting power to table for later power division
			if user_gets > 0 then
				table.insert(divide_power,{pos = ndv,user_gets = user_gets, user_storage = user_storage})
			end
		end

		-- The below shares avaliable power from a network between node_users
		-- Only whole numbers are accepted so any remainders are added to
		-- the first few node_users. If divided power is less than 1 the
		-- network is overloaded and delivers no power to any nodes.
		-- A node_user can recieve power from two different networks
		-- if pw_supply ~= 0 then minetest.debug(node.name.." - Power Can Supply: "..pw_supply) end      --debug line

		local num_users = #divide_power
		local div_pwr = pw_supply/num_users
		local whole_pwr_num = math.floor(div_pwr)
		local remainder_pwr_num = (math.fmod(div_pwr,1))*num_users

		if div_pwr < 1 then
			num_users = 0 -- network overload
		end

		local i = 1
		while(num_users >= i)do
			local final_pwr_num

			if remainder_pwr_num > 0.5 then
				final_pwr_num = whole_pwr_num + 1
				remainder_pwr_num = remainder_pwr_num - 1

			else
				final_pwr_num = whole_pwr_num
			end

			if final_pwr_num > divide_power[i].user_gets then
				final_pwr_num = divide_power[i].user_gets
			end

			-- minetest.debug("node_user "..minetest.pos_to_string(divide_power[i].pos).." Power Supplied:"..final_pwr_num) -- debug line

			local user_meta = minetest.get_meta(divide_power[i].pos)
		    user_meta:set_int("storage", divide_power[i].user_storage + final_pwr_num)
			pw_demand = pw_demand + final_pwr_num

			ele.helpers.start_timer(divide_power[i].pos)

			i = i+1
		end

		-- Take the power from provider nodes
		if pw_demand > 0 then

			for _, spos in ipairs(providers) do
				if pw_demand == 0 then break end
				local smeta = minetest.get_meta(spos)
				local pw_storage = smeta:get_int("storage")

				if pw_storage >= pw_demand then
					smeta:set_int("storage", pw_storage - pw_demand)
					pw_demand = 0
				else
					pw_demand = pw_demand - pw_storage
					smeta:set_int("storage", 0)
				end

				if bat_flag == false then
					smeta:set_int("dep_time", os.clock())
				end

				ele.helpers.start_timer(spos)

			end
		end
		-- if pw_supply ~= 0 then minetest.debug("end_run") end -- debug line
		-- minetest.debug(dump(ele.graphcache)) -- network dump
	end,
})

------------------------
-- Network Add/Remove --
------------------------
local function check_connections(pos)
	local connections = {}
	local positions = {
		{x=pos.x+1, y=pos.y,   z=pos.z},
		{x=pos.x-1, y=pos.y,   z=pos.z},
		{x=pos.x,   y=pos.y+1, z=pos.z},
		{x=pos.x,   y=pos.y-1, z=pos.z},
		{x=pos.x,   y=pos.y,   z=pos.z+1},
		{x=pos.x,   y=pos.y,   z=pos.z-1}}

	for _,connected_pos in ipairs(positions) do
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

	local hash_pos = minetest.hash_node_position(pos)
	local dead_end = #positions == 1

	for _,connected_pos in ipairs(positions) do

		local networks = ele.graphcache.devices[minetest.hash_node_position(connected_pos)] or
			{minetest.pos_to_string(connected_pos)}

		for _,net in ipairs(networks) do
			if net and ele.graphcache[net] then
				-- This is so we can break the pipeline instead of the network search loop
				while true do
					if dead_end and placed then
						-- Dead end placed, add it to the network
						-- Get the networks
						local network_ids = ele.graphcache.devices[minetest.hash_node_position(positions[1])] or
							{minetest.pos_to_string(positions[1])}

						if not #network_ids then
							-- We're evidently not on a network, nothing to add ourselves to
							break
						end

						for _, int_net in ipairs(network_ids) do
							if ele.graphcache[int_net] then
								local network = ele.graphcache[int_net]

								-- Actually add it to the (cached) network
								if not ele.graphcache.devices[hash_pos] then
									ele.graphcache.devices[hash_pos] = {}
								end

								if not table_has_string(ele.graphcache.devices[hash_pos], int_net) then
									table.insert(ele.graphcache.devices[hash_pos], int_net)
								end

								-- local function to check if value exists in network tables
								-- required as each provider has its own network so placed node
								-- can end up inside overall network grps two or more times
								local function check_exists(table_sub,pos)
									local exist = false
									local tpos_string
									local pos_string
									for k,v in ipairs(table_sub) do
										-- we have group on some of these so need to
										-- manually create tpos cant just use v
										tpos_string = minetest.pos_to_string({x=v.x,y=v.y,z=v.z})
										pos_string = minetest.pos_to_string(pos)
										if tpos_string == pos_string then
											exist = true
										end
									end
									return exist
								end

								if ele.helpers.get_item_group(name, "ele_conductor") then
									--minetest.debug("check : "..tostring(check_exists(network.conductors,pos))) -- debug line
										if not check_exists(network.users,pos) then
											table.insert(network.conductors,pos)
										end

								elseif ele.helpers.get_item_group(name, "ele_machine") then
									if ele.helpers.get_item_group(name, "ele_user") or
										ele.helpers.get_item_group(name, "ele_storage") then
										if not check_exists(network.users,pos) then
											table.insert(network.users, pos)
										end

									elseif ele.helpers.get_item_group(name, "ele_provider") then
										if not check_exists(network.providers, pos) then
											table.insert(network.providers, pos)
										end
									end
								end
							end
						end

						break
					elseif dead_end and not placed then
						-- Dead end removed, remove it from the network
						-- Get the network
						local network_ids = ele.graphcache.devices[minetest.hash_node_position(positions[1])] or
							{minetest.pos_to_string(positions[1])}


						if not #network_ids then
							-- We're evidently not on a network, nothing to remove ourselves from
							break
						end

						for _,int_net in ipairs(network_ids) do
							if ele.graphcache[int_net] then
								local network = ele.graphcache[int_net]

								-- The network was deleted.
								if int_net == minetest.pos_to_string(pos) then
									for _,v in ipairs(network.conductors) do
										local pos1 = minetest.hash_node_position(v)
										ele.graphcache.devices[pos1] = nil
									end
									ele.graphcache[int_net] = nil

								else
									-- Search for and remove device
									-- This checks and removes from network.users,
									-- network.conductors and network.providers
									ele.graphcache.devices[hash_pos] = nil
									for tblname, tables in pairs(network) do
										if type(tables) == "table" then
											for devicenum, device in pairs(tables) do
												if vector.equals(device, pos) then
													table.remove(tables,devicenum)
												end
											end
										end
									end
								end
							end
						end
						break
					else
						-- Not a dead end, so the whole network needs to be recalculated
						for _,v in ipairs(ele.graphcache[net].conductors) do
							local pos1 = minetest.hash_node_position(v)
							ele.graphcache.devices[pos1] = nil
						end
						ele.graphcache[net] = nil
						break
					end
					break
				end
			end
		end
	end
end
