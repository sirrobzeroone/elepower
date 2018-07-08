
local TIME = 5

local cooler_recipes = {
	["default:cobble"] = {
		lava  = 0,
		water = 0,
	},
	["default:obsidian"] = {
		lava  = 1000,
		water = 0,
	},
	["default:stone"] = {
		lava  = 0,
		water = 1000,
	},
}

local function lava_cooler_timer(pos, elapsed)
	local refresh = false

	local meta = minetest.get_meta(pos)
	local inv  = meta:get_inventory()

	local coolant_buffer = fluid_lib.get_buffer_data(pos, "coolant")
	local hot_buffer     = fluid_lib.get_buffer_data(pos, "hot")

	local capacity = ele.helpers.get_node_property(meta, pos, "capacity")
	local usage    = ele.helpers.get_node_property(meta, pos, "usage")
	local storage  = ele.helpers.get_node_property(meta, pos, "storage")

	local recipe  = meta:get_string("recipe")
	local consume = cooler_recipes[recipe]
	local time    = meta:get_int("src_time")
	local active  = "Active"

	if storage > usage then
		if coolant_buffer.amount >= 1000 and hot_buffer.amount >= 1000 then
			if time >= TIME then
				local room_for_output = true
				local output_stacks   = {recipe}
				inv:set_size("dst_tmp", inv:get_size("dst"))
				inv:set_list("dst_tmp", inv:get_list("dst"))

				for _, o in ipairs(output_stacks) do
					if not inv:room_for_item("dst_tmp", o) then
						room_for_output = false
						break
					end
					inv:add_item("dst_tmp", o)
				end

				if room_for_output then
					inv:set_list("dst", inv:get_list("dst_tmp"))
					time = 0
					refresh = true
					fluid_lib.take_from_buffer(pos, "coolant", consume.water)
					fluid_lib.take_from_buffer(pos, "hot", consume.lava)
				end
			else
				time    = time + 1
				storage = storage - usage
				refresh = true
			end
		else
			active = "Idle"
			refresh = false
		end
	else
		active = "Idle"
	end

	local power = math.floor(100 * storage / capacity)
	local timer = math.floor(100 * time / TIME)

	meta:set_int("src_time", time)
	meta:set_int("storage", storage)
	meta:set_string("infotext", ("Lava Cooler %s\n%s"):format(active, ele.capacity_text(capacity, storage)))

	meta:set_string("formspec", elepm.get_lava_cooler_formspec(timer, coolant_buffer, hot_buffer, 
		power, cooler_recipes, recipe))

	return refresh
end

ele.register_machine("elepower_machines:lava_cooler", {
	description = "Lava Cooler",
	groups = {ele_machine = 1, ele_user = 1, cracky = 2, oddly_breakable_by_hand = 1, fluid_container = 1},
	fluid_buffers = {
		coolant = {
			capacity = 8000,
			accepts  = {"default:water_source"},
		},
		hot = {
			capacity = 8000,
			accepts  = {"default:lava_source"},
		}
	},
	tiles = {
		"elepower_machine_top.png", "elepower_machine_base.png", "elepower_machine_side.png",
		"elepower_machine_side.png", "elepower_machine_side.png", "elepower_lava_cooler.png",
	},
	on_construct = function (pos)
		local meta = minetest.get_meta(pos)
		local inv  = meta:get_inventory()

		inv:set_size("dst", 1)

		meta:set_string("recipe", "default:cobble")
		meta:set_string("formspec", elepm.get_lava_cooler_formspec(0,nil,nil,0,cooler_recipes, "default:cobble"))
	end,
	on_timer = lava_cooler_timer,
	on_receive_fields = function (pos, formname, fields, sender)
		local meta = minetest.get_meta(pos)
		local frecipe = nil

		for f in pairs(fields) do
			if cooler_recipes[f] then
				frecipe = f
				break
			end
		end

		if frecipe then
			meta:set_string("recipe", frecipe)
			minetest.get_node_timer(pos):start(1.0)
		end
	end,
})
