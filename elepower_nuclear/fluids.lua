
-------------------
-- Virtual Nodes --
-------------------

-- These nodes are used as "fluids"
-- They do not actually exist as nodes that should be placed.

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

minetest.register_node("elepower_nuclear:helium_plasma", {
	description = "Helium Plasma\nSuperheated",
	groups      = {not_in_creative_inventory = 1, oddly_breakable_by_hand = 1, gas = 1},
	tiles       = {"elenuclear_helium_plasma.png"},
})

ele.register_gas(nil, "Tritium", "elepower_nuclear:tritium")
ele.register_gas(nil, "Deuterium", "elepower_nuclear:deuterium")
ele.register_gas("elepower_nuclear:helium_container", "Helium",
	"elepower_nuclear:helium", "elepower_gas_helium.png")
ele.register_gas(nil, "Helium Plasma", "elepower_nuclear:helium_plasma")

-------------
-- Liquids --
-------------

-- Heavy Water
ele.helpers.register_liquid("heavy_water", {
	description = "Heavy Water",
	tiles_source = {
		{
			name = "elenuclear_heavy_water_source_animated.png",
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 2.0,
			},
		},
	},
	tiles_flowing = {"elenuclear_heavy_water.png"},
	special_tiles = {
		{
			name = "elenuclear_heavy_water_flowing_animated.png",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 0.8,
			},
		},
		{
			name = "elenuclear_heavy_water_flowing_animated.png",
			backface_culling = true,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 0.8,
			},
		},
	},
	use_texture_alpha = "blend",
	liquid_viscosity = 4,
	post_effect_color = {a = 103, r = 13, g = 69, b = 121},
	groups = {heavy_water = 3, liquid = 3, puts_out_fire = 1, cools_lava = 1},
})

-- Cold coolant

ele.helpers.register_liquid("coolant", {
	description       = "Cold Coolant",
	tiles             = {"elenuclear_cold_coolant.png"},
	special_tiles     = {"elenuclear_cold_coolant.png", "elenuclear_cold_coolant.png"},
	use_texture_alpha = "blend",
	liquid_viscosity  = 2,
	post_effect_color = {a = 128, r = 36, g = 150, b = 255},
	groups            = {liquid = 3, coolant = 1},
})

-- Hot coolant

ele.helpers.register_liquid("hot_coolant", {
	description       = "Hot Coolant",
	tiles             = {"elenuclear_hot_coolant.png"},
	special_tiles     = {"elenuclear_hot_coolant.png", "elenuclear_hot_coolant.png"},
	use_texture_alpha = "blend",
	liquid_viscosity  = 2,
	post_effect_color = {a = 128, r = 136, g = 100, b = 158},
	groups            = {liquid = 3, coolant = 1, hot = 1},
})

-- Corium

ele.helpers.register_liquid("corium", {
	description       = "Corium",
	drawtype          = "liquid",
	tiles_source      = {
		{
			name = "elenuclear_corium_source_animated.png",
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 2.0,
			},
		},
	},
	tiles_flowing = {"elenuclear_corium.png"},
	special_tiles_flowing = {
		{
			name = "elenuclear_corium_flowing_animated.png",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 0.8,
			},
		},
		{
			name = "elenuclear_corium_flowing_animated.png",
			backface_culling = true,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 0.8,
			},
		},
	},
	liquid_viscosity  = 7,
	damage_per_second = 10,
	post_effect_color = {a = 50, r = 155, g = 255, b = 12},
	groups            = {corium = 3, radioactive = 1, liquid = 3, igniter = 1},
})

if minetest.get_modpath("bucket") ~= nil then
	bucket.register_liquid("elepower_nuclear:coolant_source", "elepower_nuclear:hot_coolant_flowing",
		"elepower_nuclear:bucket_coolant", "#2497ff", "Coolant (Cold)")

	bucket.register_liquid("elepower_nuclear:hot_coolant_source", "elepower_nuclear:hot_coolant_flowing",
		"elepower_nuclear:bucket_hot_coolant", "#88649e", "Coolant (Hot)")

	bucket.register_liquid("elepower_nuclear:heavy_water_source", "elepower_nuclear:heavy_water_flowing",
		"elepower_nuclear:bucket_heavy_water", "#0d4579", "Heavy Water Bucket")

	fluid_tanks.register_tank(":elepower_dynamics:portable_tank", {
		description = "Portable Tank",
		capacity    = 8000,
		accepts     = true,
		tiles       = {
			"elepower_tank_base.png", "elepower_tank_side.png", "elepower_tank_base.png^elepower_power_port.png",
		}
		
	})
end

-- Corium effects

minetest.register_abm({
	label = "Corium: boil water",
	nodenames = {"group:water"},
	neighbors = {"elepower_nuclear:corium_flowing", "elepower_nuclear:corium_source"},
	interval = 1,
	chance = 1,
	action = function(pos, node)
		minetest.remove_node(pos)
	end,
})
