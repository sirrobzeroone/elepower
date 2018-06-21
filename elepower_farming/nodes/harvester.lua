
-- How many seconds there are between runs
local HARVESTER_TICK  = 10

-- How many plants we can collect in one run
local HARVESTER_SWEEP = 9

-- How much sludge is generated as a by-product
local SLUDGE_PRODUCED = 10

local function can_dig(pos, player)
	local meta = minetest.get_meta(pos)
	local inv = meta:get_inventory()
	return inv:is_empty("dst")
end

local fdir_areas = {
	{ -- NEG Z (0)
		{x = -4, z = -8, y = 0},
		{x = 4,  z = 0,  y = 0},
	},
	{ -- NEG X (1)
		{x = -8, z = -4, y = 0},
		{x = 0,  z = 4,  y = 0},
	},
	{ -- POS Z (2)
		{x = -4, z = 0,  y = 0},
		{x = 4,  z = 8,  y = 0},
	},
	{ -- POS X (3)
		{x = 0,  z = -4, y = 0},
		{x = 8,  z = 4,  y = 0},
	},
	nil, nil
}

local function harvest(pos, harvested, fdir)
	local front  = ele.helpers.face_front(pos, fdir)
	local ranges = fdir_areas[fdir + 1]

	if not ranges then return nil end

	local range_st  = vector.add(front, ranges[1])
	local range_end = vector.add(front, ranges[2])

	local shots = HARVESTER_SWEEP

	for x = range_st.x, range_end.x do
		for z = range_st.z, range_end.z do
			if shots == 0 then break end
			local check_pos  = {x = x, y = range_st.y, z = z}
			local check_node = minetest.get_node_or_nil(check_pos)
			if check_node and ele.helpers.get_item_group(check_node.name, "plant") then
				local nodedef = minetest.registered_nodes[check_node.name]
				if (not nodedef['next_plant'] or not minetest.registered_nodes[nodedef.next_plant]) 
					and not ele.helpers.get_item_group(check_node.name, "growing") then
					-- Can harvest
					local drop = minetest.get_node_drops(check_node.name)
					if drop then
						for _,item in ipairs(drop) do
							harvested[#harvested + 1] = item
						end
						minetest.remove_node(check_pos)
						shots = shots - 1
					end
				end
			end
		end
	end

	return harvested
end

local function on_timer(pos, elapsed)
	local refresh = false
	local meta = minetest.get_meta(pos)
	local node = minetest.get_node(pos)
	local inv  = meta:get_inventory()

	local capacity = ele.helpers.get_node_property(meta, pos, "capacity")
	local usage    = ele.helpers.get_node_property(meta, pos, "usage")
	local storage  = ele.helpers.get_node_property(meta, pos, "storage")

	local work   = meta:get_int("src_time")
	local sludge = fluid_lib.get_buffer_data(pos, "sludge")

	if storage > usage and sludge.amount + SLUDGE_PRODUCED < sludge.capacity then
		if work == HARVESTER_TICK then
			local harvested = {}

			harvest(pos, harvested, node.param2)

			work = 0
			if #harvested > 0 then
				storage = storage - usage
				sludge.amount = sludge.amount + SLUDGE_PRODUCED
				for _,itm in ipairs(harvested) do
					local stack = ItemStack(itm)
					if inv:room_for_item("dst", stack) then
						inv:add_item("dst", stack)
					end
				end
			end
		else
			work = work + 1
		end

		refresh = true
		ele.helpers.swap_node(pos, "elepower_farming:harvester_active")
	else
		ele.helpers.swap_node(pos, "elepower_farming:harvester")
	end

	local power_percent = math.floor((storage / capacity)*100)
	local work_percent  = math.floor((work / HARVESTER_TICK)*100)

	meta:set_string("formspec", elefarm.formspec.harvester_formspec(work_percent, power_percent, sludge))
	meta:set_int("storage", storage)
	meta:set_int("src_time", work)

	meta:set_string("sludge_fluid", "elepower_farming:sludge_source")
	meta:set_int("sludge_fluid_storage", sludge.amount)

	return refresh
end

ele.register_machine("elepower_farming:harvester", {
	description  = "Automatic Harvester",
	ele_capacity = 12000,
	ele_inrush   = 288,
	ele_usage    = 128,
	tiles = {
		"elefarming_machine_base.png", "elefarming_machine_base.png", "elefarming_machine_side.png",
		"elefarming_machine_side.png", "elefarming_machine_side.png", "elefarming_machine_harvester.png",
	},
	groups = {
		oddly_breakable_by_hand = 1,
		ele_machine = 1,
		ele_user = 1,
		cracky = 1,
		tubedevice = 1,
		fluid_container = 1,
	},
	fluid_buffers = {
		sludge = {
			capacity  = 8000,
			drainable = true,
		}
	},
	on_construct = function (pos)
		local meta = minetest.get_meta(pos)
		local inv  = meta:get_inventory()
		inv:set_size("layout", 9)
		inv:set_size("dst", 15)

		meta:set_int("src_time", 0)

		meta:set_string("formspec", elefarm.formspec.harvester_formspec(0, 0))

		local node = minetest.get_node(pos)
	end,
	ele_active_node = true,
	ele_active_nodedef = {
		tiles = {
			"elefarming_machine_base.png", "elefarming_machine_base.png", "elefarming_machine_side.png",
			"elefarming_machine_side.png", "elefarming_machine_side.png", {
				name = "elefarming_machine_harvester_animated.png",
				animation = {
					aspect_w = 16,
					aspect_h = 16,
					type     = "vertical_frames",
					length   = 0.25,
				},
			},
		}
	},
	can_dig  = can_dig,
	on_timer = on_timer,
})
