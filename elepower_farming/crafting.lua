
local easycrafting = minetest.settings:get("elepower_easy_crafting") == "true"
local ingot = "elepower_dynamics:viridisium_ingot"
if easycrafting then
	ingot = "elepower_dynamics:wound_copper_coil"
end

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
		{ingot, "elepower_dynamics:control_circuit", ingot},
		{"farming:hoe_steel", "elepower_farming:device_frame", "farming:hoe_steel"},
		{"elepower_dynamics:wound_copper_coil", "elepower_dynamics:motor", "elepower_dynamics:wound_copper_coil"},
	}
})

-- Harvester
minetest.register_craft({
	output = "elepower_farming:harvester",
	recipe = {
		{ingot, "elepower_dynamics:control_circuit", ingot},
		{"default:axe_steel", "elepower_farming:device_frame", "farming:hoe_steel"},
		{"elepower_dynamics:motor", "elepower_dynamics:diamond_gear", "elepower_dynamics:motor"},
	}
})

-- Tree Extractor
minetest.register_craft({
	output = "elepower_farming:tree_extractor",
	recipe = {
		{"elepower_dynamics:motor", "bucket:bucket_empty", "elepower_dynamics:motor"},
		{"elepower_dynamics:tree_tap", "elepower_farming:device_frame", "elepower_dynamics:tree_tap"},
		{"elepower_dynamics:copper_gear", "elepower_dynamics:servo_valve", "elepower_dynamics:copper_gear"},
	}
})

-- Composter
minetest.register_craft({
	output = "elepower_farming:composter",
	recipe = {
		{"elepower_dynamics:motor", "bucket:bucket_empty", "elepower_dynamics:motor"},
		{"elepower_dynamics:electrum_gear", "elepower_farming:device_frame", "elepower_dynamics:electrum_gear"},
		{"elepower_dynamics:copper_gear", "elepower_dynamics:servo_valve", "elepower_dynamics:copper_gear"},
	}
})
