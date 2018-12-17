
ele.register_machine("elepower_machines:pump", {
	description = "Pump",
	tiles = {
		"elepower_machine_top.png^elepower_power_port.png", "elepower_pump_base.png", "elepower_pump_side.png",
		"elepower_pump_side.png", "elepower_pump_side.png", "elepower_pump_side.png",
	},
	groups = {
		ele_machine     = 1,
		ele_user        = 1,
		fluid_container = 1,
		oddly_breakable_by_hand = 1,
	},
	ele_no_automatic_ports = true,
	fluid_buffers = {
		pump = {
			capacity = 16000,
			drainable = true,
		},
	},
})

minetest.register_entity("elepower_machines:pump_tube", {
	initial_properties = {
		hp_max   = 1,
		visual   = "mesh",
		mesh     = "elepower_pump_tube.obj",
		physical = true,
		textures = {"elepower_pump_tube.png"}
	}
})
