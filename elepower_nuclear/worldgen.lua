
--------------
-- Worldgen --
--------------

-- Uranium

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "elepower_nuclear:stone_with_uranium",
	wherein        = "default:stone",
	clust_scarcity = 15 * 15 * 15,
	clust_num_ores = 5,
	clust_size     = 3,
	y_max          = 846,
	y_min          = 248,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "elepower_nuclear:stone_with_uranium",
	wherein        = "default:stone",
	clust_scarcity = 14 * 14 * 14,
	clust_num_ores = 5,
	clust_size     = 3,
	y_max          = -248,
	y_min          = -846,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "elepower_nuclear:stone_with_uranium",
	wherein        = "default:stone",
	clust_scarcity = 10 * 10 * 10,
	clust_num_ores = 8,
	clust_size     = 3,
	y_max          = -1248,
	y_min          = -1846,
})
