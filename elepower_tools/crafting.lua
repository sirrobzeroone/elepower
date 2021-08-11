-- see elepower_papi >> external_nodes_items.lua for explanation
-- shorten table ref
local epi = ele.external.ing

-- Drill
minetest.register_craft({
	output = "elepower_tools:drill_bit",
	recipe = {
		{""             ,epi.steel_ingot, ""            },
		{epi.steel_ingot,epi.steel_ingot,epi.steel_ingot}
	}
})

minetest.register_craft({
	output = "elepower_tools:hand_drill",
	recipe = {
		{""             , "elepower_dynamics:wound_copper_coil", "elepower_tools:drill_bit"},
		{epi.steel_ingot, "elepower_dynamics:battery"          , epi.steel_ingot},
		{"basic_materials:motor", "elepower_dynamics:capacitor", ""},
	}
})

-- Chainsaw
minetest.register_craft({
	output = "elepower_tools:chain",
	recipe = {
		{""             , epi.steel_ingot                ,epi.steel_ingot},
		{epi.steel_ingot, "elepower_dynamics:steel_plate",epi.steel_ingot},
		{epi.steel_ingot, epi.steel_ingot                , ""            }
	}
})

minetest.register_craft({
	output = "elepower_tools:chainsaw",
	recipe = {
		{"", "elepower_dynamics:wound_copper_coil", "elepower_tools:chain"},
		{epi.steel_ingot, "elepower_dynamics:battery", epi.steel_ingot},
		{"basic_materials:motor", "elepower_dynamics:capacitor", ""},
	}
})

-- Soldering Iron
minetest.register_craft({
	output = "elepower_tools:soldering_iron",
	recipe = {
		{"", "elepower_dynamics:battery",epi.steel_ingot},
		{"", "elepower_dynamics:wound_silver_coil", ""},
		{"elepower_dynamics:wound_silver_coil", "", ""},
	}
})

-- Repairing
minetest.register_craft({
	output = "elepower_tools:repair_core",
	recipe = {
		{""                             , epi.diamond_block, "elepower_dynamics:steel_plate"},
		{"elepower_dynamics:lead_plate" , "elepower_dynamics:xycrone_lump", "elepower_dynamics:lead_plate"},
		{"elepower_dynamics:steel_plate", epi.mese, ""},
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
