if minetest.get_modpath("basic_materials") == nil then

	--------------
	-- PLASTICS --
	--------------

	minetest.register_craftitem(":basic_materials:oil_extract", {
		    description = "Oil Extract",
		    inventory_image = "elepower_bm_oil_extract.png",
	})

	minetest.register_craftitem(":basic_materials:paraffin", {
		    description = "Unprocessed Paraffin",
		    inventory_image = "elepower_bm_paraffin.png",
	})

	minetest.register_alias("basic_materials:plastic_base", "basic_materials:paraffin")
	minetest.register_alias("homedecor:plastic_base", "basic_materials:paraffin")
	minetest.register_alias("homedecor:paraffin", "basic_materials:paraffin")
	minetest.register_alias("homedecor:oil_extract", "basic_materials:oil_extract")
	minetest.register_alias("homedecor:plastic_sheeting", "basic_materials:plastic_sheet")
	minetest.register_alias("homedecor:plastic_strips",   "basic_materials:plastic_strip")
	minetest.register_alias("homedecor:empty_spool",      "basic_materials:empty_spool")

	minetest.register_craftitem(":basic_materials:plastic_sheet", {
		    description = "Plastic Sheet",
		    inventory_image = "elepower_bm_plastic_sheet.png",
	})
	
	minetest.register_craftitem(":basic_materials:plastic_strip", {
		description = "Plastic Strips",
		groups = { strip = 1 },
		inventory_image = "elepower_bm_strip.png^[colorize:#ffffff:200",
	})
	
	minetest.register_craftitem(":basic_materials:empty_spool", {
		description = "Empty wire spool",
		inventory_image = "elepower_bm_empty_spool.png"
	})


	minetest.register_craft( {
		output = "basic_materials:plastic_strip 9",
		recipe = {
			{ "basic_materials:plastic_sheet", "basic_materials:plastic_sheet", "basic_materials:plastic_sheet" }
		},
	})
	
	minetest.register_craft( {
		output = "basic_materials:empty_spool 3",
		recipe = {
			{ "basic_materials:plastic_sheet", "basic_materials:plastic_sheet", "basic_materials:plastic_sheet" },
			{ ""                             , "basic_materials:plastic_sheet",                              "" },
			{ "basic_materials:plastic_sheet", "basic_materials:plastic_sheet", "basic_materials:plastic_sheet" }
		},
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
		inventory_image = "elepower_bm_copper_wire.png",
		groups = {copper = 1, wire = 1, component = 1}
	})

	minetest.register_craft( {
		output = "basic_materials:copper_wire 2",
		type = "shapeless",
		recipe = {
			"default:copper_ingot",
			"basic_materials:empty_spool",
			"basic_materials:empty_spool",
		},
	})

	-----------
	-- MOTOR --
	-----------

	minetest.register_craftitem(":basic_materials:motor", {
		description = "Motor",
		inventory_image = "elepower_bm_motor.png",
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
		inventory_image = "elepower_bm_silicon.png",
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

	-----------
	-- STEEL --
	-----------
	
	minetest.register_craftitem(":basic_materials:steel_strip", {
		description = "Steel Strip",
		groups = { strip = 1 },
		inventory_image = "elepower_bm_strip.png^[multiply:#ffffff"
	})
	
	minetest.register_craftitem(":basic_materials:steel_wire", {
		description = "Spool of steel wire",
		groups = { wire = 1 },
		inventory_image = "elepower_bm_steel_wire.png"
	})
	
	minetest.register_craft( {
		output = "basic_materials:steel_wire 2",
		type = "shapeless",
		recipe = {
			"default:steel_ingot",
			"basic_materials:empty_spool",
			"basic_materials:empty_spool",
		},
	})

	minetest.register_craft( {
		output = "basic_materials:steel_strip 12",
		recipe = {
			{ "", "default:steel_ingot", "" },
			{ "default:steel_ingot", "", "" },
		},
	})
	
else
	minetest.clear_craft({output = "basic_materials:brass_ingot"})	
	
	local steel_strip_def = table.copy(minetest.registered_items["basic_materials:steel_strip"])	
	steel_strip_def.inventory_image = "elepower_bm_strip.png^[multiply:#ffffff"
	minetest.register_craftitem(":basic_materials:steel_strip", steel_strip_def)
	
	local copper_strip_def = table.copy(minetest.registered_items["basic_materials:copper_strip"])	
	copper_strip_def.inventory_image = "elepower_bm_strip.png^[multiply:#fcb15f"
	minetest.register_craftitem(":basic_materials:copper_strip", copper_strip_def)
	
	local plastic_strip_def = table.copy(minetest.registered_items["basic_materials:plastic_strip"])	
	plastic_strip_def.inventory_image = "elepower_bm_strip.png^[colorize:#ffffff:200"
	minetest.register_craftitem(":basic_materials:plastic_strip", plastic_strip_def)
	
end
