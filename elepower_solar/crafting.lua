
-- Solar Generator
minetest.register_craft({
	output = "elepower_solar:solar_generator",
	recipe = {
		{"group:glass", "elepower_dynamics:pv_cell", "group:glass"},
		{"elepower_dynamics:pv_cell", "group:glass", "elepower_dynamics:pv_cell"},
		{"default:steel_ingot", "default:steel_ingot", "default:steel_ingot"},
	}
})
