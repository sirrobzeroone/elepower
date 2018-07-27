
-------------------
-- Virtual Nodes --
-------------------

-- These nodes are used as "fluids"
-- They do not actually exist as nodes that should be placed.

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

------------
-- Fluids --
------------

-- Cold coolant

minetest.register_node("elepower_nuclear:coolant_source", {
	description  = "Cold Coolant Source",
	drawtype     = "liquid",
	tiles        = {"elenuclear_cold_coolant.png"},
	alpha        = 200,
	paramtype    = "light",
	walkable     = false,
	pointable    = false,
	diggable     = false,
	buildable_to = true,
	is_ground_content = false,
	drop = "",
	drowning = 1,
	liquidtype = "source",
	liquid_alternative_source = "elepower_nuclear:coolant_source",
	liquid_alternative_flowing = "elepower_nuclear:coolant_flowing",
	liquid_viscosity = 2,
	post_effect_color = {a = 128, r = 36, g = 150, b = 255},
	groups = {liquid = 3, coolant = 1},
	sounds = default.node_sound_water_defaults(),
})

minetest.register_node("elepower_nuclear:coolant_flowing", {
	description = "Cold Coolant Flowing",
	drawtype = "flowingliquid",
	tiles = {"elenuclear_cold_coolant.png"},
	special_tiles = {"elenuclear_cold_coolant.png", "elenuclear_cold_coolant.png"},
	alpha = 200,
	paramtype = "light",
	paramtype2 = "flowingliquid",
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	is_ground_content = false,
	drop = "",
	drowning = 1,
	liquidtype = "flowing",
	liquid_alternative_flowing = "elepower_nuclear:coolant_flowing",
	liquid_alternative_source = "elepower_nuclear:coolant_source",
	liquid_viscosity = 2,
	post_effect_color = {a = 128, r = 36, g = 150, b = 255},
	groups = {coolant = 3, liquid = 3, not_in_creative_inventory = 1},
	sounds = default.node_sound_water_defaults(),
})

-- Hot coolant

minetest.register_node("elepower_nuclear:hot_coolant_source", {
	description  = "Hot Coolant Source",
	drawtype     = "liquid",
	tiles        = {"elenuclear_hot_coolant.png"},
	alpha        = 200,
	paramtype    = "light",
	walkable     = false,
	pointable    = false,
	diggable     = false,
	buildable_to = true,
	is_ground_content = false,
	damage_per_second = 4 * 2,
	drop = "",
	drowning = 1,
	liquidtype = "source",
	liquid_alternative_source = "elepower_nuclear:hot_coolant_source",
	liquid_alternative_flowing = "elepower_nuclear:hot_coolant_flowing",
	liquid_viscosity = 2,
	post_effect_color = {a = 128, r = 136, g = 100, b = 158},
	groups = {liquid = 3, coolant = 1, hot = 1},
	sounds = default.node_sound_water_defaults(),
})

minetest.register_node("elepower_nuclear:hot_coolant_flowing", {
	description = "Hot Coolant Flowing",
	drawtype = "flowingliquid",
	tiles = {"elenuclear_hot_coolant.png"},
	special_tiles = {"elenuclear_hot_coolant.png", "elenuclear_hot_coolant.png"},
	alpha = 200,
	paramtype = "light",
	paramtype2 = "flowingliquid",
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	is_ground_content = false,
	damage_per_second = 4 * 2,
	drop = "",
	drowning = 1,
	liquidtype = "flowing",
	liquid_alternative_flowing = "elepower_nuclear:hot_coolant_flowing",
	liquid_alternative_source = "elepower_nuclear:hot_coolant_source",
	liquid_viscosity = 2,
	post_effect_color = {a = 128, r = 136, g = 100, b = 158},
	groups = {coolant = 3, liquid = 3, not_in_creative_inventory = 1, hot = 1},
	sounds = default.node_sound_water_defaults(),
})

bucket.register_liquid("elepower_nuclear:coolant_source", "elepower_nuclear:hot_coolant_flowing",
	"elepower_nuclear:bucket_coolant", "#2497ff", "Coolant (Cold)")

bucket.register_liquid("elepower_nuclear:hot_coolant_source",    "elepower_nuclear:hot_coolant_flowing",
	"elepower_nuclear:bucket_hot_coolant",    "#88649e", "Coolant (Hot)")
