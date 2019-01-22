
-- Radiation-shielded Lead Machine Chassis
minetest.register_craft({
	output = "elepower_nuclear:machine_block",
	recipe = {
		{"elepower_dynamics:induction_coil_advanced", "elepower_dynamics:graphite_ingot", "elepower_dynamics:induction_coil_advanced"},
		{"elepower_dynamics:graphite_ingot", "elepower_dynamics:lead_block", "elepower_dynamics:graphite_ingot"},
		{"elepower_dynamics:lead_block", "elepower_dynamics:graphite_ingot", "elepower_dynamics:lead_block"},
	}
})

-- Enrichment Plant
minetest.register_craft({
	output = "elepower_nuclear:enrichment_plant",
	recipe = {
		{"elepower_dynamics:induction_coil_advanced", "elepower_dynamics:soc", "elepower_dynamics:induction_coil_advanced"},
		{"elepower_nuclear:graphite_rod", "elepower_nuclear:machine_block", "elepower_nuclear:graphite_rod"},
		{"elepower_dynamics:wound_silver_coil", "elepower_dynamics:electrum_gear", "elepower_dynamics:wound_silver_coil"},
	}
})

-- Graphite Moderator
minetest.register_craft({
	output = "elepower_nuclear:graphite_moderator",
	recipe = {
		{"", "elepower_nuclear:graphite_rod", ""},
		{"elepower_nuclear:graphite_rod", "elepower_dynamics:graphite_ingot", "elepower_nuclear:graphite_rod"},
		{"", "elepower_nuclear:graphite_rod", ""},
	}
})

-- Reactor Controller
minetest.register_craft({
	output = "elepower_nuclear:fission_controller",
	recipe = {
		{"elepower_dynamics:wound_copper_coil", "elepower_nuclear:graphite_moderator", "elepower_dynamics:wound_copper_coil"},
		{"elepower_nuclear:graphite_moderator", "elepower_nuclear:machine_block", "elepower_nuclear:graphite_moderator"},
		{"elepower_dynamics:electrum_gear", "elepower_nuclear:graphite_moderator", "elepower_dynamics:electrum_gear"},
	}
})

-- Reactor Core
minetest.register_craft({
	output = "elepower_nuclear:fission_core",
	recipe = {
		{"elepower_dynamics:induction_coil_advanced", "elepower_dynamics:graphite_ingot", "elepower_dynamics:induction_coil_advanced"},
		{"elepower_nuclear:graphite_moderator", "elepower_nuclear:machine_block", "elepower_nuclear:graphite_moderator"},
		{"elepower_dynamics:electrum_gear", "elepower_dynamics:copper_plate", "elepower_dynamics:electrum_gear"},
	}
})

-- Reactor Fluid Port
minetest.register_craft({
	output = "elepower_nuclear:reactor_fluid_port",
	recipe = {
		{"elepower_dynamics:portable_tank", "elepower_dynamics:copper_plate", "elepower_dynamics:portable_tank"},
		{"elepower_nuclear:graphite_moderator", "elepower_nuclear:machine_block", "elepower_nuclear:graphite_moderator"},
		{"elepower_dynamics:electrum_gear", "elepower_dynamics:copper_plate", "elepower_dynamics:electrum_gear"},
	}
})

-- Heat Exchanger
minetest.register_craft({
	output = "elepower_nuclear:heat_exchanger",
	recipe = {
		{"elepower_dynamics:portable_tank", "elepower_dynamics:copper_plate", "elepower_dynamics:portable_tank"},
		{"elepower_dynamics:copper_plate",  "elepower_nuclear:machine_block", "elepower_dynamics:copper_plate"},
		{"elepower_dynamics:portable_tank", "elepower_dynamics:copper_plate", "elepower_dynamics:portable_tank"},
	}
})

-- Solar Neutron Activator
minetest.register_craft({
	output = "elepower_nuclear:solar_neutron_activator",
	recipe = {
		{"elepower_dynamics:hardened_glass", "elepower_dynamics:hardened_glass", "elepower_dynamics:hardened_glass"},
		{"elepower_dynamics:servo_valve", "elepower_nuclear:machine_block", "elepower_dynamics:portable_tank"},
		{"elepower_dynamics:brass_plate", "elepower_dynamics:copper_plate", "elepower_dynamics:brass_plate"},
	}
})

-- Empty Fuel Rod
minetest.register_craft({
	output = "elepower_nuclear:fuel_rod_empty",
	recipe = {
		{"elepower_dynamics:graphite_ingot", "", "elepower_dynamics:graphite_ingot"},
		{"elepower_dynamics:graphite_ingot", "", "elepower_dynamics:graphite_ingot"},
		{"elepower_dynamics:graphite_ingot", "elepower_dynamics:graphite_ingot", "elepower_dynamics:graphite_ingot"},
	}
})

-- Graphite Rod
elepm.register_craft({
	type   = "grind",
	recipe = { "elepower_dynamics:graphite_ingot" },
	output = "elepower_nuclear:graphite_rod 3",
	time   = 6,
})

-- Cold Coolant
minetest.register_craft({
	output = "elepower_nuclear:bucket_coolant",
	recipe = {
		{"elepower_dynamics:nitrogen_container", "elepower_dynamics:nitrogen_container", "elepower_dynamics:nitrogen_container"},
		{"",  "bucket:bucket_water", ""},
		{"", "elepower_dynamics:acidic_compound", ""},
	},
	replacements = {
		{'elepower_dynamics:nitrogen_container', "elepower_dynamics:gas_container"},
		{'bucket:bucket_water', "bucket:bucket_empty"}
	}
})

-- Fusion Reactor Coil
minetest.register_craft({
	output = "elepower_nuclear:fusion_coil",
	recipe = {
		{"basic_materials:copper_wire", "elepower_dynamics:graphite_ingot", "basic_materials:copper_wire"},
		{"basic_materials:copper_wire", "elepower_dynamics:copper_plate", "basic_materials:copper_wire"},
		{"basic_materials:copper_wire", "elepower_dynamics:graphite_ingot", "basic_materials:copper_wire"},
	}
})

-- Fusion Reactor Controller
minetest.register_craft({
	output = "elepower_nuclear:reactor_controller",
	recipe = {
		{"elepower_dynamics:electrum_plate", "elepower_dynamics:soc", "elepower_dynamics:electrum_plate"},
		{"elepower_machines:resonant_capacitor", "elepower_machines:advanced_machine_block", "elepower_machines:resonant_capacitor"},
		{"elepower_dynamics:viridisium_plate", "elepower_dynamics:lcd_panel", "elepower_dynamics:viridisium_plate"},
	}
})

-- Fusion Reactor Power Port
minetest.register_craft({
	output = "elepower_nuclear:reactor_power",
	recipe = {
		{"elepower_dynamics:electrum_plate", "elepower_dynamics:soc", "elepower_dynamics:electrum_plate"},
		{"elepower_dynamics:induction_coil_advanced", "elepower_machines:advanced_machine_block", "elepower_dynamics:induction_coil_advanced"},
		{"elepower_dynamics:viridisium_plate", "elepower_machines:resonant_capacitor", "elepower_dynamics:viridisium_plate"},
	}
})

-- Fusion Reactor Fluid Port
minetest.register_craft({
	output = "elepower_nuclear:reactor_fluid",
	recipe = {
		{"elepower_dynamics:electrum_plate", "elepower_dynamics:soc", "elepower_dynamics:electrum_plate"},
		{"fluid_transfer:fluid_duct", "elepower_machines:advanced_machine_block", "elepower_dynamics:servo_valve"},
		{"elepower_dynamics:viridisium_plate", "elepower_dynamics:xycrone_lump", "elepower_dynamics:viridisium_plate"},
	}
})

-- Fusion Reactor Fluid Port (Output)
minetest.register_craft({
	output = "elepower_nuclear:reactor_output",
	recipe = {
		{"elepower_dynamics:electrum_plate", "elepower_dynamics:soc", "elepower_dynamics:electrum_plate"},
		{"elepower_dynamics:servo_valve", "elepower_machines:advanced_machine_block", "fluid_transfer:fluid_duct"},
		{"elepower_dynamics:viridisium_plate", "elepower_dynamics:xycrone_lump", "elepower_dynamics:viridisium_plate"},
	}
})

------------------------
-- Enrichment recipes --
------------------------

elepm.register_craft({
	type   = "enrichment",
	output = { "elepower_nuclear:uranium_dust", "elepower_nuclear:depleted_uranium_dust 3"},
	recipe = { "elepower_nuclear:uranium_lump 4" },
	time   = 30,
})

elepm.register_craft({
	type   = "enrichment",
	output = { "elepower_nuclear:uranium_dust", "elepower_nuclear:depleted_uranium_dust", "elepower_nuclear:nuclear_waste 2"},
	recipe = { "elepower_nuclear:depleted_uranium_dust 4" },
	time   = 40,
})

elepm.register_craft({
	type   = "enrichment",
	output = { "elepower_nuclear:depleted_uranium_dust", "elepower_nuclear:nuclear_waste 3"},
	recipe = { "elepower_nuclear:nuclear_waste 5" },
	time   = 50,
})

-----------
-- Other --
-----------

elepm.register_craft({
	type   = "can",
	recipe = {"elepower_nuclear:uranium_dust 8", "elepower_nuclear:fuel_rod_empty"},
	output = "elepower_nuclear:fuel_rod_fissile",
	time   = 16
})

elepm.register_craft({
	type   = "grind",
	recipe = {"elepower_nuclear:fuel_rod_depleted"},
	output = {
		"elepower_nuclear:depleted_uranium_dust 3",
		"elepower_nuclear:nuclear_waste 5",
		"elepower_nuclear:fuel_rod_empty"
	},
	time = 16
})
