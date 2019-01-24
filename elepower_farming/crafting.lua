
-----------
-- Nodes --
-----------

-- Device Frame
minetest.register_craft({
	output = "elepower_farming:device_frame",
	recipe = {
		{"basic_materials:plastic_sheet", "default:glass", "basic_materials:plastic_sheet"},
		{"default:glass", "default:mese_crystal", "default:glass"},
		{"basic_materials:plastic_sheet", "default:glass", "basic_materials:plastic_sheet"},
	}
})

-- Planter
minetest.register_craft({
	output = "elepower_farming:planter",
	recipe = {
		{"elepower_dynamics:nickel_ingot", "elepower_dynamics:control_circuit", "elepower_dynamics:nickel_ingot"},
		{"farming:hoe_steel", "elepower_farming:device_frame", "farming:hoe_steel"},
		{"elepower_dynamics:wound_copper_coil", "basic_materials:motor", "elepower_dynamics:wound_copper_coil"},
	}
})

-- Harvester
minetest.register_craft({
	output = "elepower_farming:harvester",
	recipe = {
		{"elepower_dynamics:nickel_ingot", "elepower_dynamics:control_circuit", "elepower_dynamics:nickel_ingot"},
		{"default:axe_steel", "elepower_farming:device_frame", "farming:hoe_steel"},
		{"basic_materials:motor", "elepower_dynamics:diamond_gear", "basic_materials:motor"},
	}
})

-- Tree Extractor
minetest.register_craft({
	output = "elepower_farming:tree_extractor",
	recipe = {
		{"basic_materials:motor", "bucket:bucket_empty", "basic_materials:motor"},
		{"elepower_dynamics:tree_tap", "elepower_farming:device_frame", "elepower_dynamics:tree_tap"},
		{"elepower_dynamics:copper_gear", "elepower_dynamics:servo_valve", "elepower_dynamics:copper_gear"},
	}
})

-- Composter
minetest.register_craft({
	output = "elepower_farming:composter",
	recipe = {
		{"basic_materials:motor", "bucket:bucket_empty", "basic_materials:motor"},
		{"elepower_dynamics:electrum_gear", "elepower_farming:device_frame", "elepower_dynamics:electrum_gear"},
		{"elepower_dynamics:copper_gear", "elepower_dynamics:servo_valve", "elepower_dynamics:copper_gear"},
	}
})

-- Tree Processor
minetest.register_craft({
	output = "elepower_farming:tree_processor",
	recipe = {
		{"basic_materials:motor", "bucket:bucket_empty", "basic_materials:motor"},
		{"elepower_dynamics:copper_plate", "elepower_farming:device_frame", "elepower_dynamics:zinc_plate"},
		{"elepower_dynamics:copper_gear", "elepower_dynamics:servo_valve", "elepower_dynamics:copper_gear"},
	}
})
