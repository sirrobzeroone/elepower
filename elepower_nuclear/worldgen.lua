
-- see elepower_papi >> external_nodes_items.lua for explanation
-- shorten table ref
local epr = ele.external.ref

--------------
-- Worldgen --
--------------

-- Uranium

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "elepower_nuclear:stone_with_uranium",
	wherein        = epr.stone,
	clust_scarcity = 16 * 16 * 16,
	clust_num_ores = 5,
	clust_size     = 3,
	y_max          = 846,
	y_min          = 248,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "elepower_nuclear:stone_with_uranium",
	wherein        = epr.stone,
	clust_scarcity = 16 * 16 * 16,
	clust_num_ores = 5,
	clust_size     = 3,
	y_max          = -248,
	y_min          = -846,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "elepower_nuclear:stone_with_uranium",
	wherein        = epr.stone,
	clust_scarcity = 16 * 16 * 16,
	clust_num_ores = 5,
	clust_size     = 3,
	y_max          = -1248,
	y_min          = -1846,
})
