
ele.register_machine("elepower_machines:lava_generator", {
	description = "Lava Generator",
	groups = {
		fluid_container = 1,
		ele_provider = 1,
		oddly_breakable_by_hand = 1,
	},
	ele_usage = 64,
	tiles = {
		"elepower_machine_top.png", "elepower_machine_base.png", "elepower_machine_side.png",
		"elepower_machine_side.png", "elepower_machine_side.png", "elepower_lava_generator.png",
	},
	ele_active_node = true,
	ele_active_nodedef = {
		tiles = {
			"elepower_machine_top.png", "elepower_machine_base.png", "elepower_machine_side.png",
			"elepower_machine_side.png", "elepower_machine_side.png", "elepower_lava_generator_active.png",
		},
	},
	fluid_buffers = {
		lava = {
			capacity  = 8000,
			accepts   = {"default:lava_source"},
			drainable = false
		}
	},
	tube = false,
	on_timer = function (pos, elapsed)
		local meta     = minetest.get_meta(pos)
		local nodename = "elepower_machines:lava_generator"

		local burn_time      = meta:get_int("burn_time")
		local burn_totaltime = meta:get_int("burn_totaltime")
		
		local capacity   = ele.helpers.get_node_property(meta, pos, "capacity")
		local generation = ele.helpers.get_node_property(meta, pos, "usage")
		local storage    = ele.helpers.get_node_property(meta, pos, "storage")

		-- Fluid buffer
		local flbuffer = fluid_lib.get_buffer_data(pos, "lava")
		if not flbuffer or flbuffer.fluid == "" then return false end

		-- If more to burn and the energy produced was used: produce some more
		if burn_time > 0 then
			if storage + generation > capacity then
				return false
			end

			meta:set_int("storage", storage + generation)

			burn_time = burn_time - 1
			meta:set_int("burn_time", burn_time)
		end

		local pow_percent = math.floor((storage / capacity) * 100)

		-- Burn another bucket of lava
		if burn_time == 0 then
			local inv = meta:get_inventory()
			if flbuffer.amount >= 1000 then
				-- Lava burn time
				local fuel = 60

				meta:set_int("burn_time", fuel)
				meta:set_int("burn_totaltime", fuel)

				-- Take lava
				flbuffer.amount = flbuffer.amount - 1000

				local active_node = nodename.."_active"
				ele.helpers.swap_node(pos, active_node)
			else
				meta:set_string("formspec", ele.formspec.get_lava_generator_formspec(pow_percent, 0, flbuffer))
				meta:set_string("infotext", "Lava Generator Idle\n" .. ele.capacity_text(capacity, storage) .. 
					"\n" .. fluid_lib.buffer_to_string(flbuffer))
				ele.helpers.swap_node(pos, nodename)
				return false
			end
		end
		if burn_totaltime == 0 then burn_totaltime = 1 end

		local percent = math.floor((burn_time / burn_totaltime) * 100)
		meta:set_string("formspec", ele.formspec.get_lava_generator_formspec(pow_percent, percent, flbuffer))
		meta:set_string("infotext", "Lava Generator Active\n" .. ele.capacity_text(capacity, storage) .. 
			"\n" .. fluid_lib.buffer_to_string(flbuffer))

		meta:set_int("lava_fluid_storage", flbuffer.amount)

		return true
	end,
	on_construct = function (pos)
		local meta = minetest.get_meta(pos)

		local capacity = ele.helpers.get_node_property(meta, pos, "capacity")
		local storage  = ele.helpers.get_node_property(meta, pos, "storage")

		meta:set_string("formspec", ele.formspec.get_lava_generator_formspec(math.floor((storage / capacity) * 100), 0))
	end
})
