if minetest.get_modpath("basic_materials") == nil then

	--------------
	-- PLASTICS --
	--------------

	minetest.register_craftitem(":basic_materials:oil_extract", {
		    description = "Oil Extract",
		    inventory_image = "elepower_oil_extract.png",
	})

	minetest.register_craftitem(":basic_materials:paraffin", {
		    description = "Unprocessed Paraffin",
		    inventory_image = "elepower_paraffin.png",
	})

	minetest.register_alias("basic_materials:plastic_base", "basic_materials:paraffin")
	minetest.register_alias("homedecor:plastic_base", "basic_materials:paraffin")
	minetest.register_alias("homedecor:paraffin", "basic_materials:paraffin")
	minetest.register_alias("homedecor:plastic_sheeting", "basic_materials:plastic_sheet")
	minetest.register_alias("homedecor:oil_extract", "basic_materials:oil_extract")

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

	-----------------
	-- COPPER WIRE --
	-----------------

	minetest.register_craftitem(":basic_materials:copper_wire", {
		description = "Copper Wire",
		inventory_image = "elepower_copper_wire.png",
		groups = {copper = 1, wire = 1, component = 1}
	})

	minetest.register_craft({
		output = "basic_materials:copper_wire 8",
		recipe = {
			{"default:copper_ingot", "default:copper_ingot", "default:copper_ingot"},
			{"default:copper_ingot", "",                     "default:copper_ingot"},
			{"default:copper_ingot", "default:copper_ingot", "default:copper_ingot"}
		}
	})

	-----------
	-- MOTOR --
	-----------

	minetest.register_craftitem(":basic_materials:motor", {
		description = "Motor",
		inventory_image = "elepower_motor.png",
		groups = {motor = 1, component = 1}
	})

	minetest.register_craft({
		output = "basic_materials:motor 3",
		recipe = {
			{"default:steel_ingot", "elepower_dynamics:wound_copper_coil", "default:steel_ingot"},
			{"basic_materials:copper_wire", "elepower_dynamics:wound_copper_coil", "basic_materials:copper_wire"},
			{"default:steel_ingot", "elepower_dynamics:capacitor", "default:steel_ingot"},
		}
	})

	-------------
	-- SILICON --
	-------------

	minetest.register_craftitem(":basic_materials:silicon", {
		description = "Silicon",
		inventory_image = "elepower_silicon.png",
		groups = {silicon = 1, lump = 1}
	})

	-----------
	-- BRASS --
	-----------

	minetest.register_craftitem(":basic_materials:brass_ingot", {
		description = "Brass Ingot",
		inventory_image = "elepower_brass_ingot.png",
		groups = {brass = 1, ingot = 1}
	})
else
	minetest.clear_craft({output = "basic_materials:brass_ingot"})
end
