if minetest.get_modpath("basic_materials") == nil then
	minetest.register_craftitem(":basic_materials:oil_extract", {
		    description = "Oil Extract",
		    inventory_image = "elepower_oil_extract.png",
	})

	minetest.register_craftitem(":basic_materials:paraffin", {
		    description = "Unprocessed Paraffin",
		    inventory_image = "elepower_paraffin.png",
	})

	minetest.register_alias("basic_materials:plastic_base", "basic_materials:paraffin")

	minetest.register_craftitem(":basic_materials:plastic_sheet", {
		    description = "Plastic Sheet",
		    inventory_image = "elepower_plastic_sheet.png",
	})

	minetest.register_craft({
		type = "shapeless",
		output = "basic_materials:oil_extract 4",
		recipe = {
			"group:leaves",
			"group:leaves",
			"group:leaves",
			"group:leaves",
			"group:leaves",
			"group:leaves"
		}
	})

	minetest.register_craft({
		    type = "cooking",
		    output = "basic_materials:paraffin",
		    recipe = "basic_materials:oil_extract",
	})

	minetest.register_craft({
		    type = "cooking",
		    output = "basic_materials:plastic_sheet",
		    recipe = "basic_materials:paraffin",
	})

	minetest.register_craft({
		    type = "fuel",
		    recipe = "basic_materials:oil_extract",
		    burntime = 30,
	})

	minetest.register_craft({
		    type = "fuel",
		    recipe = "basic_materials:paraffin",
		    burntime = 30,
	})

	minetest.register_craft({
		    type = "fuel",
		    recipe = "basic_materials:plastic_sheet",
		    burntime = 30,
	})
end
