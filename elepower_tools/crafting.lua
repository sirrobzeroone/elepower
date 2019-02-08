
-- Drill
minetest.register_craft({
	output = "elepower_tools:drill_bit",
	recipe = {
		{"", "default:steel_ingot", ""},
		{"default:steel_ingot", "default:steel_ingot", "default:steel_ingot"},
	}
})

minetest.register_craft({
	output = "elepower_tools:hand_drill",
	recipe = {
		{"", "elepower_dynamics:wound_copper_coil", "elepower_tools:drill_bit"},
		{"default:steel_ingot", "elepower_dynamics:battery", "default:steel_ingot"},
		{"basic_materials:motor", "elepower_dynamics:capacitor", ""},
	}
})

-- Chainsaw
minetest.register_craft({
	output = "elepower_tools:chain",
	recipe = {
		{"", "default:steel_ingot", "default:steel_ingot"},
		{"default:steel_ingot", "elepower_dynamics:steel_plate", "default:steel_ingot"},
		{"default:steel_ingot", "default:steel_ingot", ""},
	}
})

minetest.register_craft({
	output = "elepower_tools:chainsaw",
	recipe = {
		{"", "elepower_dynamics:wound_copper_coil", "elepower_tools:chain"},
		{"default:steel_ingot", "elepower_dynamics:battery", "default:steel_ingot"},
		{"basic_materials:motor", "elepower_dynamics:capacitor", ""},
	}
})

-- Soldering Iron
minetest.register_craft({
	output = "elepower_tools:soldering_iron",
	recipe = {
		{"", "elepower_dynamics:battery", "default:steel_ingot"},
		{"", "elepower_dynamics:wound_silver_coil", ""},
		{"elepower_dynamics:wound_silver_coil", "", ""},
	}
})

-- Repairing
minetest.register_craft({
	output = "elepower_tools:repair_core",
	recipe = {
		{"", "default:diamondblock", "elepower_dynamics:steel_plate"},
		{"elepower_dynamics:lead_plate", "elepower_dynamics:xycrone_lump", "elepower_dynamics:lead_plate"},
		{"elepower_dynamics:steel_plate", "default:mese", ""},
	}
})

minetest.register_craft({
	output = "elepower_tools:ed_reconstructor",
	recipe = {
		{"elepower_dynamics:wound_copper_coil", "elepower_dynamics:micro_circuit", "elepower_dynamics:wound_copper_coil"},
		{"elepower_tools:repair_core", "elepower_machines:machine_block", "elepower_tools:repair_core"},
		{"elepower_dynamics:induction_coil", "elepower_dynamics:induction_coil_advanced", "elepower_dynamics:induction_coil"},
	}
})
