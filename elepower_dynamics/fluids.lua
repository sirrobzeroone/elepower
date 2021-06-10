
-- Etching Acid

ele.helpers.register_liquid("etching_acid", {
	description       = "Etching Acid",
	tiles             = {"elepower_etching_acid.png"},
	special_tiles     = {"elepower_etching_acid.png", "elepower_etching_acid.png"},
	use_texture_alpha = "blend",
	liquid_viscosity  = 4,
	damage_per_second = 4,
	post_effect_color = {a = 103, r = 65, g = 8, b = 0},
	groups            = {acid = 1, etching_acid = 1, liquid = 3, tree_fluid = 1},
})

-- Liquid Lithium

ele.helpers.register_liquid("lithium", {
	description       = "Liquid Lithium",
	drawtype          = "liquid",
	tiles             = {"elepower_lithium.png"},
	special_tiles     = {"elepower_lithium.png", "elepower_lithium.png"},
	liquid_viscosity  = 4,
	damage_per_second = 1,
	use_texture_alpha = "blend",
	gas_form          = "elepower_dynamics:lithium_gas",
	post_effect_color = {a = 103, r = 229, g = 227, b = 196},
	groups            = {lithium = 1, liquid = 3},
})

bucket.register_liquid("elepower_dynamics:etching_acid_source", "elepower_dynamics:etching_acid_flowing",
		"elepower_dynamics:bucket_etching_acid",   "#410800", "Etching Acid Bucket")

bucket.register_liquid("elepower_dynamics:lithium_source", "elepower_dynamics:lithium_flowing",
		"elepower_dynamics:bucket_lithium",   "#e5e3c4", "Liquid Lithium Bucket")

-----------
-- Gases --
-----------

minetest.register_node("elepower_dynamics:steam", {
	description = "Steam",
	groups      = {not_in_creative_inventory = 1, gas = 1},
	liquid_form = "default:water_source",
	tiles       = {"elepower_steam.png"},
})

minetest.register_node("elepower_dynamics:oxygen", {
	description = "Oxygen",
	groups      = {not_in_creative_inventory = 1, gas = 1},
	tiles       = {"elepower_steam.png"},
})

minetest.register_node("elepower_dynamics:hydrogen", {
	description = "Hydrogen",
	groups      = {not_in_creative_inventory = 1, gas = 1},
	tiles       = {"elepower_steam.png"},
})

minetest.register_node("elepower_dynamics:nitrogen", {
	description = "Nitrogen",
	groups      = {not_in_creative_inventory = 1, gas = 1},
	tiles       = {"elepower_steam.png"},
})

minetest.register_node("elepower_dynamics:lithium_gas", {
	description = "Lithium Gas",
	groups      = {not_in_creative_inventory = 1, gas = 1, lithium = 1},
	liquid_form = "elepower_dynamics:lithium_source",
	tiles       = {"elepower_lithium.png"},
})

minetest.register_node("elepower_dynamics:chlorine_gas", {
	description = "Chlorine Gas",
	groups      = {not_in_creative_inventory = 1, gas = 1, chlorine = 1},
	tiles       = {"elepower_chlorine.png"},
})
