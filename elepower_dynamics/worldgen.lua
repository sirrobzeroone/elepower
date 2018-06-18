
--------------
-- Worldgen --
--------------

-- Lead

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "elepower_dynamics:stone_with_lead",
	wherein        = "default:stone",
	clust_scarcity = 9 * 9 * 9,
	clust_num_ores = 12,
	clust_size     = 3,
	y_max          = 31000,
	y_min          = 1025,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "elepower_dynamics:stone_with_lead",
	wherein        = "default:stone",
	clust_scarcity = 7 * 7 * 7,
	clust_num_ores = 5,
	clust_size     = 3,
	y_max          = 0,
	y_min          = -31000,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "elepower_dynamics:stone_with_lead",
	wherein        = "default:stone",
	clust_scarcity = 18 * 18 * 18,
	clust_num_ores = 5,
	clust_size     = 3,
	y_max          = -128,
	y_min          = -31000,
})
