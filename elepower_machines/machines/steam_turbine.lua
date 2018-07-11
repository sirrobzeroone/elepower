
ele.register_fluid_generator("elepower_machines:steam_turbine", {
	description = "Steam Turbine",
	ele_usage = 64,
	tiles = {
		"elepower_machine_top.png^elepower_power_port.png", "elepower_machine_base.png", "elepower_machine_side.png",
		"elepower_machine_side.png", "elepower_turbine_side.png", "elepower_turbine_side.png",
	},
	ele_active_node = true,
	ele_active_nodedef = {
		tiles = {
			"elepower_machine_top.png^elepower_power_port.png", "elepower_machine_base.png", "elepower_machine_side.png",
			"elepower_machine_side.png", "elepower_turbine_side.png", "elepower_turbine_side.png",
		},
	},
	fluid_buffers = {
		steam = {
			capacity  = 8000,
			accepts   = {"elepower_dynamics:steam"},
			drainable = false
		}
	},
	tube = false,
	ele_no_automatic_ports = true,
})
