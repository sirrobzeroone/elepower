
-------------------
-- Virtual Nodes --
-------------------

-- These nodes are used as "fluids"
-- They do not actually exist as nodes that should be placed.

minetest.register_node("elepower_nuclear:coolant", {
	description = "Coolant (cold)",
	groups      = {not_in_creative_inventory = 1, oddly_breakable_by_hand = 1, coolant = 1},
	tiles       = {"elenuclear_cold_coolant.png"},
})

minetest.register_node("elepower_nuclear:coolant_hot", {
	description = "Coolant (hot)",
	groups      = {not_in_creative_inventory = 1, oddly_breakable_by_hand = 1, coolant = 1, hot = 1},
	tiles       = {"elenuclear_hot_coolant.png"},
})

minetest.register_node("elepower_nuclear:heavy_water", {
	description = "Heavy Water",
	groups      = {not_in_creative_inventory = 1, oddly_breakable_by_hand = 1, water = 1},
	tiles       = {"elenuclear_heavy_water.png"},
})

minetest.register_node("elepower_nuclear:tritium", {
	description = "Tritium Gas",
	groups      = {not_in_creative_inventory = 1, oddly_breakable_by_hand = 1, gas = 1},
	tiles       = {"elenuclear_gas.png"},
})

minetest.register_node("elepower_nuclear:deuterium", {
	description = "Deuterium Gas",
	groups      = {not_in_creative_inventory = 1, oddly_breakable_by_hand = 1, gas = 1},
	tiles       = {"elenuclear_gas.png"},
})

minetest.register_node("elepower_nuclear:helium", {
	description = "Helium Gas",
	groups      = {not_in_creative_inventory = 1, oddly_breakable_by_hand = 1, gas = 1},
	tiles       = {"elenuclear_helium.png"},
})
