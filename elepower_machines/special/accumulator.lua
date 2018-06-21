
local CAPACITY = 8000

minetest.register_node("elepower_machines:accumulator", {
	description = "Water Accumulator",
	groups = {fluid_container = 1, oddly_breakable_by_hand = 1, cracky = 1},
	tiles = {
		"elepower_machine_top.png^elepower_power_port.png", "elepower_machine_base.png", "elepower_machine_accumulator.png",
		"elepower_machine_accumulator.png", "elepower_machine_accumulator.png", "elepower_machine_accumulator.png",
	},
	fluid_buffers = {
		water = {
			capacity = CAPACITY
		}
	},
	on_construct = function ( pos )
		local meta = minetest.get_meta(pos)
		meta:set_string("water_fluid", "default:water_source")
	end
})

minetest.register_abm({
	nodenames = {"elepower_machines:accumulator"},
	label = "elefluidAccumulator",
	interval   = 2,
	chance     = 1/5,
	action = function(pos, node, active_object_count, active_object_count_wider)
		local meta    = minetest.get_meta(pos)
		local water_c = meta:get_int("water_fluid_storage")
		if water_c == CAPACITY then return end

		local positions = {
			{x=pos.x+1,y=pos.y,z=pos.z},
			{x=pos.x-1,y=pos.y,z=pos.z},
			{x=pos.x,  y=pos.y,z=pos.z+1},
			{x=pos.x,  y=pos.y,z=pos.z-1},
		}

		local fluid = 0
		for _,fpos in pairs(positions) do
			local node = minetest.get_node(fpos)
			if node.name == "default:water_source" then
				fluid = fluid + 1000
			end
		end

		if fluid == 0 then
			meta:set_string("infotext", "Submerge me in water!")
			return
		end

		local give = 0
		if water_c + fluid > CAPACITY then
			give = CAPACITY - water_c
		else
			give = fluid
		end

		water_c = water_c + give

		meta:set_int("water_fluid_storage", water_c)
		meta:set_string("infotext", ("Water: %d/%d %s"):format(water_c, CAPACITY, fluid_lib.unit))
	end
})
