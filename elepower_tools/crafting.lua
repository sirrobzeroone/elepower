
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
		{"default:steel_ingot", "elepower_dynamics:wound_copper_coil", "default:steel_ingot"},
		{"elepower_dynamics:motor", "elepower_dynamics:capacitor", ""},
	}
})
