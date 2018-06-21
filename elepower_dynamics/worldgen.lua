
--------------
-- Worldgen --
--------------

-- Lead

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "elepower_dynamics:stone_with_lead",
	wherein        = "default:stone",
	clust_scarcity = 15 * 15 * 15,
	clust_num_ores = 12,
	clust_size     = 3,
	y_max          = 31000,
	y_min          = 1025,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "elepower_dynamics:stone_with_lead",
	wherein        = "default:stone",
	clust_scarcity = 14 * 14 * 14,
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

-- Nickel

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "elepower_dynamics:stone_with_nickel",
	wherein        = "default:stone",
	clust_scarcity = 28 * 28 * 28,
	clust_num_ores = 5,
	clust_size     = 3,
	y_max          = 31000,
	y_min          = -31000,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "elepower_dynamics:stone_with_nickel",
	wherein        = "default:stone",
	clust_scarcity = 15 * 15 * 15,
	clust_num_ores = 5,
	clust_size     = 3,
	y_max          = -1028,
	y_min          = -31000,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "elepower_dynamics:stone_with_nickel",
	wherein        = "default:stone",
	clust_scarcity = 12 * 12 * 12,
	clust_num_ores = 5,
	clust_size     = 3,
	y_max          = -8096,
	y_min          = -31000,
})
