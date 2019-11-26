
minetest.register_craft({
	output = "elepower_mining:miner_controller",
	recipe = {
		{"elepower_dynamics:servo_valve", "elepower_dynamics:soc", "fluid_transfer:fluid_duct"},
		{"elepower_machines:resonant_capacitor", "elepower_machines:machine_block", "elepower_machines:resonant_capacitor"},
		{"elepower_dynamics:viridisium_plate", "elepower_dynamics:lcd_panel", "elepower_dynamics:viridisium_plate"},
	}
})

minetest.register_craft({
	output = "elepower_mining:miner_core",
	recipe = {
		{"default:steelblock", "elepower_dynamics:invar_gear", "default:steelblock"},
		{"elepower_dynamics:invar_gear", "elepower_dynamics:servo_valve", "elepower_dynamics:invar_gear"},
		{"default:steelblock", "elepower_dynamics:invar_gear", "default:steelblock"},
	}
})

minetest.register_craft({
	output = "elepower_mining:miner_drill",
	recipe = {
		{"default:steelblock", "elepower_dynamics:induction_coil_advanced", "default:steelblock"},
		{"basic_materials:motor", "elepower_machines:machine_block", "basic_materials:motor"},
		{"elepower_tools:hand_drill", "elepower_tools:hand_drill", "elepower_tools:hand_drill"},
	}
})
