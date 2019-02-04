
-- Thermal Evaporator Controller
minetest.register_craft({
	output = "elepower_thermal:evaporator_controller",
	recipe = {
		{"elepower_dynamics:electrum_plate", "elepower_dynamics:bronze_plate", "elepower_dynamics:electrum_plate"},
		{"elepower_dynamics:portable_tank", "elepower_machines:heat_casing", "elepower_dynamics:portable_tank"},
		{"elepower_dynamics:brass_plate", "elepower_dynamics:lcd_panel", "elepower_dynamics:brass_plate"},
	}
})

-- Thermal Evaporator Fluid Port
minetest.register_craft({
	output = "elepower_thermal:evaporator_input",
	recipe = {
		{"elepower_dynamics:electrum_plate", "elepower_dynamics:bronze_plate", "elepower_dynamics:electrum_plate"},
		{"fluid_transfer:fluid_duct", "elepower_machines:heat_casing", "elepower_dynamics:servo_valve"},
		{"elepower_dynamics:brass_plate", "elepower_dynamics:steel_plate", "elepower_dynamics:brass_plate"},
	}
})

-- Thermal Evaporator Fluid Port (Output)
minetest.register_craft({
	output = "elepower_thermal:evaporator_output",
	recipe = {
		{"elepower_dynamics:electrum_plate", "elepower_dynamics:bronze_plate", "elepower_dynamics:electrum_plate"},
		{"elepower_dynamics:servo_valve", "elepower_machines:heat_casing", "fluid_transfer:fluid_duct"},
		{"elepower_dynamics:brass_plate", "elepower_dynamics:steel_plate", "elepower_dynamics:brass_plate"},
	}
})
