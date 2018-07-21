
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
		{"elepower_dynamics:wound_silver_coil", "elepower_dynamics:viridisium_gear", "elepower_dynamics:wound_silver_coil"},
	}
})

elepm.register_craft({
	type   = "grind",
	recipe = { "elepower_dynamics:graphite_ingot" },
	output = "elepower_nuclear:graphite_rod 3",
	time   = 6,
})
