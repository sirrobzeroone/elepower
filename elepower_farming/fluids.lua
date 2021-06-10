
-- Tree Sap

ele.helpers.register_liquid("tree_sap", {
	description       = "Tree Sap",
	tiles             = {"elefarming_tree_sap.png"},
	special_tiles     = {"elefarming_tree_sap.png", "elefarming_tree_sap.png"},
	use_texture_alpha = "blend",
	liquid_viscosity  = 7,
	post_effect_color = {a = 103, r = 84, g = 34, b = 0},
	groups            = {tree_sap = 3, liquid = 3, raw_bio = 1, tree_fluid = 1},
})

-- Tree Resin

ele.helpers.register_liquid("resin", {
	description       = "Resin",
	tiles             = {"elefarming_tree_sap.png"},
	special_tiles     = {"elefarming_tree_sap.png", "elefarming_tree_sap.png"},
	use_texture_alpha = "blend",
	liquid_viscosity  = 8,
	post_effect_color = {a = 103, r = 84, g = 34, b = 0},
	groups            = {resin = 3, liquid = 3, raw_bio = 1, tree_fluid = 1},
})

-- Biomass

ele.helpers.register_liquid("biomass", {
	description       = "Biomass",
	tiles             = {"elefarming_biomass.png"},
	special_tiles     = {"elefarming_biomass.png", "elefarming_biomass.png"},
	use_texture_alpha = "blend",
	liquid_viscosity  = 7,
	post_effect_color = {a = 103, r = 0, g = 42, b = 0},
	groups            = {biomass = 3, liquid = 3},
})

-- Biofuel

ele.helpers.register_liquid("biofuel", {
	description       = "Biofuel",
	tiles             = {"elefarming_biofuel.png"},
	special_tiles     = {"elefarming_biofuel.png", "elefarming_biofuel.png"},
	use_texture_alpha = "blend",
	liquid_viscosity  = 7,
	post_effect_color = {a = 103, r = 255, g = 163, b = 0},
	groups            = {biofuel = 3, liquid = 3},
})

-- Sludge

ele.helpers.register_liquid("sludge", {
	description       = "Sludge",
	tiles             = {"elefarming_tar.png"},
	special_tiles     = {"elefarming_tar.png", "elefarming_tar.png"},
	liquid_viscosity  = 8,
	post_effect_color = {a = 50, r = 0, g = 0, b = 0},
	groups            = {sludge = 3, liquid = 3},
})

if minetest.get_modpath("bucket") ~= nil then
	bucket.register_liquid("elepower_farming:tree_sap_source", "elepower_farming:tree_sap_flowing",
		"elepower_farming:bucket_tree_sap", "#411400", "Tree Sap Bucket")

	bucket.register_liquid("elepower_farming:resin_source",    "elepower_farming:resin_flowing",
		"elepower_farming:bucket_resin",    "#411401", "Resin Bucket")

	bucket.register_liquid("elepower_farming:biomass_source",  "elepower_farming:biomass_flowing",
		"elepower_farming:bucket_biomass",  "#002c01", "Biomass Bucket")

	bucket.register_liquid("elepower_farming:biofuel_source",  "elepower_farming:biofuel_flowing",
		"elepower_farming:bucket_biofuel",  "#762700", "Biofuel Bucket")

	bucket.register_liquid("elepower_farming:sludge_source",   "elepower_farming:sludge_flowing",
		"elepower_farming:bucket_sludge",   "#121212", "Sludge Bucket")

	fluid_tanks.register_tank(":elepower_dynamics:portable_tank", {
		description = "Portable Tank",
		capacity    = 8000,
		accepts     = true,
		tiles       = {
			"elepower_tank_base.png", "elepower_tank_side.png", "elepower_tank_base.png^elepower_power_port.png",
		}
	})
end
