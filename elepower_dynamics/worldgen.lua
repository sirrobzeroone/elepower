
--------------
-- Worldgen --
--------------

-- Lead

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "elepower_dynamics:stone_with_lead",
	wherein        = "default:stone",
	clust_scarcity = 5 * 5 * 5,
	clust_num_ores = 12,
	clust_size     = 3,
	y_max          = 31000,
	y_min          = 1025,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "elepower_dynamics:stone_with_lead",
	wherein        = "default:stone",
	clust_scarcity = 4 * 4 * 4,
	clust_num_ores = 5,
	clust_size     = 3,
	y_max          = 0,
	y_min          = -31000,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "elepower_dynamics:stone_with_lead",
	wherein        = "default:stone",
	clust_scarcity = 10 * 10 * 10,
	clust_num_ores = 5,
	clust_size     = 3,
	y_max          = -128,
	y_min          = -31000,
})
