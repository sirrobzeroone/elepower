
-----------
-- Nodes --
-----------

-- Device Frame
minetest.register_craft({
	output = "elepower_farming:device_frame",
	recipe = {
		{"homedecor:plastic_sheeting", "group:glass", "homedecor:plastic_sheeting"},
		{"group:glass", "default:mese_crystal", "group:glass"},
		{"homedecor:plastic_sheeting", "group:glass", "homedecor:plastic_sheeting"},
	}
})

-- Planter
minetest.register_craft({
	output = "elepower_farming:planter",
	recipe = {
		{"elepower_dynamics:viridisium_ingot", "elepower_dynamics:control_circuit", "elepower_dynamics:viridisium_ingot"},
		{"farming:hoe_steel", "elepower_farming:device_frame", "farming:hoe_steel"},
		{"elepower_dynamics:wound_copper_coil", "elepower_dynamics:diamond_gear", "elepower_dynamics:wound_copper_coil"},
	}
})

-- Harvester
minetest.register_craft({
	output = "elepower_farming:harvester",
	recipe = {
		{"elepower_dynamics:viridisium_ingot", "elepower_dynamics:control_circuit", "elepower_dynamics:viridisium_ingot"},
		{"default:axe_steel", "elepower_farming:device_frame", "farming:hoe_steel"},
		{"elepower_dynamics:wound_copper_coil", "elepower_dynamics:diamond_gear", "elepower_dynamics:wound_copper_coil"},
	}
})

-- Tree Extractor
minetest.register_craft({
	output = "elepower_farming:tree_extractor",
	recipe = {
		{"default:steel_ingot", "bucket:bucket_empty", "default:steel_ingot"},
		{"elepower_dynamics:tree_tap", "elepower_farming:device_frame", "elepower_dynamics:tree_tap"},
		{"elepower_dynamics:copper_gear", "elepower_dynamics:servo_valve", "elepower_dynamics:copper_gear"},
	}
})
