
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
		{"homedecor:plastic_sheeting", "elepower_dynamics:copper_wire", "homedecor:plastic_sheeting"},
		{"farming:hoe_steel", "elepower_farming:device_frame", "farming:hoe_steel"},
		{"elepower_dynamics:wound_copper_coil", "elepower_dynamics:diamond_gear", "elepower_dynamics:wound_copper_coil"},
	}
})

-- Harvester
minetest.register_craft({
	output = "elepower_farming:harvester",
	recipe = {
		{"homedecor:plastic_sheeting", "elepower_dynamics:copper_wire", "homedecor:plastic_sheeting"},
		{"default:axe_steel", "elepower_farming:device_frame", "farming:hoe_steel"},
		{"elepower_dynamics:wound_copper_coil", "elepower_dynamics:diamond_gear", "elepower_dynamics:wound_copper_coil"},
	}
})

-- Tree Extractor
minetest.register_craft({
	output = "elepower_farming:tree_extractor",
	recipe = {
		{"homedecor:plastic_sheeting", "bucket:bucket_empty", "homedecor:plastic_sheeting"},
		{"elepower_dynamics:tree_tap", "elepower_farming:device_frame", "elepower_dynamics:tree_tap"},
		{"elepower_dynamics:copper_gear", "elepower_dynamics:servo_valve", "elepower_dynamics:copper_gear"},
	}
})
