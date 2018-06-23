-- Network graphs are built eminating from provider nodes.
-- TODO: Caching

---------------------
-- Graph Functions --
---------------------

local function clear_networks_from_node(pos)
	local meta = minetest.get_meta(pos)
	meta:set_string("network_id", "")
end

local function add_node(nodes, pos, pnodeid)
	local node_id = minetest.hash_node_position(pos)
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

	if not ele.helpers.get_item_group(node.name, "fluid_container") then
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

local function fluid_targets(p_pos, pos)
	local provider = minetest.get_node(p_pos)
	local pnodeid  = minetest.pos_to_string(p_pos)

	local targets   = {}
	local queue     = {}
	local all_nodes = {}

	local node = minetest.get_node(pos)
	if node and ele.helpers.get_item_group(node.name, "elefluid_transport") then
		add_duct_node(all_nodes, pos, pnodeid, queue)
	elseif node and ele.helpers.get_item_group(node.name, "fluid_container") then
		queue = {p_pos}
	end

	while next(queue) do
		local to_visit = {}
		for _, posi in ipairs(queue) do
			traverse_network(targets, all_nodes, posi, p_pos, pnodeid, to_visit)
		end
		queue = to_visit
	end

	targets   = ele.helpers.flatten(targets)
	all_nodes = ele.helpers.flatten(all_nodes)

	return targets
end

function elefluid.transfer_timer_tick(pos, elapsed)
	local refresh = true
	local meta    = minetest.get_meta(pos)
	local node    = minetest.get_node(pos)
	local meta1   = nil
	local targets = {}

	-- Only allow the node directly behind to be a start of a network
	local tpos  = vector.add(minetest.facedir_to_dir(node.param2), pos)
	local tname = minetest.get_node(tpos).name
	if not ele.helpers.get_item_group(tname, "elefluid_transport") and
		not ele.helpers.get_item_group(tname, "fluid_container") then
		minetest.forceload_free_block(pos)
		return
	end

	-- Retrieve network
	targets = fluid_targets(pos, tpos)

	-- No targets, don't proceed
	if #targets == 0 then
		return true
	end

	-- Begin transfer
	local srcpos  = ele.helpers.face_front(pos, node.param2)
	local srcnode = minetest.get_node(srcpos)

	-- Make sure source node is not air
	if not srcnode or srcnode.name == "air" then
		return true
	end

	-- Make sure source node is a registered fluid container
	if not ele.helpers.get_item_group(srcnode.name, "fluid_container") then
		return true
	end

	local srcmeta = minetest.get_meta(srcpos)
	local srcdef  = minetest.registered_nodes[srcnode.name]
	local buffers = fluid_lib.get_node_buffers(srcpos)
	if not buffers then return true end

	-- Limit the amount of fluid pumped per cycle
	local pcapability = ele.helpers.get_node_property(meta, pos, "fluid_pump_capacity")
	local pumped      = 0

	-- Transfer some fluid here
	for _,pos in pairs(targets) do
		if not vector.equals(pos, srcpos) then
			if pumped >= pcapability then break end
			local pp = fluid_lib.get_node_buffers(pos)

			local changed = false

			if pp ~= nil then
				for name in pairs(pp) do
					for bname in pairs(buffers) do
						if pumped >= pcapability then break end
						local buffer_data = fluid_lib.get_buffer_data(srcpos, bname)
						local target_data = fluid_lib.get_buffer_data(pos, name)

						if (target_data.fluid == buffer_data.fluid or target_data.fluid == "") and
							buffer_data.fluid ~= "" and buffer_data.amount > 0 and
							(buffer_data.drainable == nil or buffer_data.drainable == true) and
							fluid_lib.buffer_accepts_fluid(pos, name, buffer_data.fluid) then
							
							if fluid_lib.can_insert_into_buffer(pos, name, buffer_data.fluid, pcapability) > 0 then
								local res_f, count = fluid_lib.take_from_buffer(srcpos, bname, pcapability)
								if count > 0 then
									fluid_lib.insert_into_buffer(pos, name, res_f, count)
									pumped = pumped + count
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

	return refresh
end

function elefluid.refresh_node(pos)
	minetest.get_node_timer(pos):start(1.0)
	return
end

minetest.register_lbm({
    label = "Fluid Transfer Tick",
    name = "elepower_fapi:fluid_transfer_tick",
    nodenames = {"group:elefluid_transport_source"},
    run_at_every_load = true,
    action = elefluid.refresh_node,
})
