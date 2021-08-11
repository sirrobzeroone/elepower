
-- see elepower_papi >> external_nodes_items.lua for explanation
-- shorten table ref
local epi = ele.external.ing 
local ept = ele.external.tools

---------------
-- Overrides --
---------------

-- Remove iron_lump -> steel_ingot, because dynamics adds iron ingot
--minetest.clear_craft({type = "cooking", output = epi.steel_ingot})

-----------
-- Tools --
-----------
if ept.enable_iron_lead_tools == true then
-- Pickaxes

	minetest.register_craft({
		output = 'elepower_dynamics:pick_iron',
		recipe = {
			{'elepower_dynamics:iron_ingot', 'elepower_dynamics:iron_ingot', 'elepower_dynamics:iron_ingot'},
			{'',epi.group_stick, ''},
			{'',epi.group_stick, ''},
		}
	})

	minetest.register_craft({
		output = 'elepower_dynamics:pick_lead',
		recipe = {
			{'elepower_dynamics:lead_ingot', 'elepower_dynamics:lead_ingot', 'elepower_dynamics:lead_ingot'},
			{'',epi.group_stick, ''},
			{'',epi.group_stick, ''},
		}
	})

	-- Shovels

	minetest.register_craft({
		output = 'elepower_dynamics:shovel_iron',
		recipe = {
			{'elepower_dynamics:iron_ingot'},
			{epi.group_stick},
			{epi.group_stick},
		}
	})

	minetest.register_craft({
		output = 'elepower_dynamics:shovel_lead',
		recipe = {
			{'elepower_dynamics:lead_ingot'},
			{epi.group_stick},
			{epi.group_stick},
		}
	})

	-- Axes

	minetest.register_craft({
		output = 'elepower_dynamics:axe_iron',
		recipe = {
			{'elepower_dynamics:iron_ingot', 'elepower_dynamics:iron_ingot'},
			{'elepower_dynamics:iron_ingot',epi.group_stick},
			{'',epi.group_stick},
		}
	})

	minetest.register_craft({
		output = 'elepower_dynamics:axe_lead',
		recipe = {
			{'elepower_dynamics:lead_ingot', 'elepower_dynamics:lead_ingot'},
			{'elepower_dynamics:lead_ingot',epi.group_stick},
			{'',epi.group_stick},
		}
	})

	-- Swords

	minetest.register_craft({
		output = 'elepower_dynamics:sword_iron',
		recipe = {
			{'elepower_dynamics:iron_ingot'},
			{'elepower_dynamics:iron_ingot'},
			{epi.group_stick},
		}
	})

	minetest.register_craft({
		output = 'elepower_dynamics:sword_lead',
		recipe = {
			{'elepower_dynamics:lead_ingot'},
			{'elepower_dynamics:lead_ingot'},
			{epi.group_stick},
		}
	})
end

-- Bucket
minetest.register_craft({
	output = 'bucket:bucket_empty',
	recipe = {
		{'elepower_dynamics:iron_ingot', '', 'elepower_dynamics:iron_ingot'},
		{'', 'elepower_dynamics:iron_ingot', ''},
	}
})

-----------
-- Nodes --
-----------

minetest.register_craft({
	type   = "shapeless",
	output = "elepower_dynamics:particle_board",
	recipe = {
		"elepower_dynamics:wood_dust",
		"elepower_dynamics:wood_dust",
		"elepower_dynamics:wood_dust",
		"elepower_dynamics:wood_dust",
	}
})

-- Conduit
minetest.register_craft({
	output = "elepower_dynamics:conduit 8",
	recipe = {
		{"elepower_dynamics:lead_ingot",  "elepower_dynamics:lead_ingot",  "elepower_dynamics:lead_ingot"},
		{"basic_materials:copper_wire", "basic_materials:copper_wire", "basic_materials:copper_wire"},
		{"elepower_dynamics:lead_ingot",  "elepower_dynamics:lead_ingot",  "elepower_dynamics:lead_ingot"},
	},
	replacements = {
		{"basic_materials:copper_wire", "basic_materials:empty_spool"},
		{"basic_materials:copper_wire", "basic_materials:empty_spool"},
		{"basic_materials:copper_wire", "basic_materials:empty_spool"},
	}
})

minetest.register_craft({
	output = "elepower_dynamics:conduit_wall 1",
	recipe = {
		{""                            ,"elepower_dynamics:lead_plate",""},
		{"elepower_dynamics:lead_plate","elepower_dynamics:conduit"   ,"elepower_dynamics:lead_plate"},
		{""                            ,"elepower_dynamics:lead_plate",""}
	}
})

if ele.external.conduit_dirt_with_grass == true then
	minetest.register_craft({
		output = "elepower_dynamics:conduit_dirt_with_grass 1",
		recipe = {
			{"",epi.seed_wheat              ,""},
			{"","elepower_dynamics:conduit" ,""},
			{"",epi.dirt                    ,""}
		}
	})
end

if ele.external.conduit_dirt_with_dry_grass == true then
	minetest.register_craft({
		output = "elepower_dynamics:conduit_dirt_with_dry_grass 1",
		recipe = {
			{"",epi.wheat                  ,""},
			{"","elepower_dynamics:conduit",""},
			{"",epi.dirt                   ,""}
		}
	})
end

if ele.external.conduit_stone_block == true then
	minetest.register_craft({
		output = "elepower_dynamics:conduit_stone_block 1",
		recipe = {
			{""                       ,epi.slab_stone_block  ,""},
			{epi.slab_stone_block,"elepower_dynamics:conduit",epi.slab_stone_block},
			{""                       ,epi.slab_stone_block  ,""}
		}
	})
end

if ele.external.conduit_stone_block_desert == true then
	minetest.register_craft({
		output = "elepower_dynamics:conduit_stone_block_desert 1",
		recipe = {
			{""                       ,epi.slab_desert_stone_block  ,""},
			{epi.slab_desert_stone_block,"elepower_dynamics:conduit",epi.slab_desert_stone_block},
			{""                       ,epi.slab_desert_stone_block  ,""}
		}
	})
end



-- Opaque Fluid Duct
minetest.register_craft({
	output = "elepower_dynamics:opaque_duct 3",
	recipe = {
		{"elepower_dynamics:lead_ingot",  "elepower_dynamics:lead_ingot",  "elepower_dynamics:lead_ingot"},
		{"fluid_transfer:fluid_duct"   , "fluid_transfer:fluid_duct"    , "fluid_transfer:fluid_duct"},
		{"elepower_dynamics:lead_ingot",  "elepower_dynamics:lead_ingot",  "elepower_dynamics:lead_ingot"},
	}
})

-- Portable Tank
minetest.register_craft({
	output = "elepower_dynamics:portable_tank",
	recipe = {
		{epi.glass,"elepower_dynamics:fluid_duct",epi.glass},
		{epi.glass,epi.glass,epi.glass},
		{epi.bronze_ingot,epi.bronze_ingot,epi.bronze_ingot},
	}
})

-----------
-- Items --
-----------

minetest.register_craft({
	output = "elepower_dynamics:wound_copper_coil",
	recipe = {
		{""              ,epi.copper_ingot               , ""},
		{epi.copper_ingot, "elepower_dynamics:iron_ingot", epi.copper_ingot},
		{""              , epi.copper_ingot              , ""}
	}
})

minetest.register_craft({
	output = "elepower_dynamics:wound_copper_coil",
	recipe = {
		{""                           ,"basic_materials:copper_wire", ""},
		{"basic_materials:copper_wire","elepower_dynamics:iron_ingot", "basic_materials:copper_wire"},
		{""                           ,"basic_materials:copper_wire", ""}
	},
	replacements = {
		{"basic_materials:copper_wire", "basic_materials:empty_spool"},
		{"basic_materials:copper_wire", "basic_materials:empty_spool"},
		{"basic_materials:copper_wire", "basic_materials:empty_spool"},
		{"basic_materials:copper_wire", "basic_materials:empty_spool"},
	}
})

minetest.register_craft({
	output = "elepower_dynamics:wound_silver_coil",
	recipe = {
		{""              , epi.silver_ingot, ""},
		{epi.silver_ingot, "elepower_dynamics:zinc_ingot",epi.silver_ingot},
		{""              , epi.silver_ingot, ""}
	}
})

minetest.register_craft({
	output = "elepower_dynamics:wound_silver_coil",
	recipe = {
		{"", "basic_materials:silver_wire", ""},
		{"basic_materials:silver_wire", "elepower_dynamics:zinc_ingot", "basic_materials:silver_wire"},
		{"", "basic_materials:silver_wire", ""}
	},
	replacements = {
		{"basic_materials:silver_wire", "basic_materials:empty_spool"},
		{"basic_materials:silver_wire", "basic_materials:empty_spool"},
		{"basic_materials:silver_wire", "basic_materials:empty_spool"},
		{"basic_materials:silver_wire", "basic_materials:empty_spool"},
	}
})

minetest.register_craft({
	output = "elepower_dynamics:servo_valve 3",
	recipe = {
		{"", "elepower_dynamics:wound_copper_coil", ""},
		{"elepower_dynamics:fluid_duct", "elepower_dynamics:fluid_duct", "elepower_dynamics:fluid_duct"},
	}
})

minetest.register_craft({
	output = "elepower_dynamics:tree_tap",
	recipe = {
		{epi.steel_ingot, epi.steel_ingot, epi.steel_ingot},
		{"", "", epi.steel_ingot},
	}
})

minetest.register_craft({
	output = "elepower_dynamics:chip 6",
	recipe = {
		{"basic_materials:plastic_sheet", "basic_materials:plastic_sheet", "basic_materials:plastic_sheet"},
		{epi.mese_crystal_fragment,epi.group_color_black, epi.mese_crystal_fragment},
		{epi.copper_ingot, epi.silver_ingot, epi.copper_ingot},
	}
})

minetest.register_craft({
	output = "elepower_dynamics:capacitor 6",
	recipe = {
		{"basic_materials:plastic_sheet", "basic_materials:plastic_sheet", "basic_materials:plastic_sheet"},
		{epi.silver_ingot, epi.mese_crystal, epi.silver_ingot},
		{epi.copper_ingot, epi.group_color_violet, epi.copper_ingot},
	}
})

minetest.register_craft({
	output = "elepower_dynamics:pcb_blank 3",
	recipe = {
		{epi.copper_ingot,epi.copper_ingot, epi.copper_ingot},
		{epi.copper_ingot,epi.mese_crystal, epi.copper_ingot},
		{epi.gold_ingot  ,epi.gold_ingot, epi.gold_ingot},
	}
})

minetest.register_craft({
	output = "elepower_dynamics:pcb_blank",
	recipe = {
		{"", "elepower_dynamics:copper_plate", ""},
		{epi.mese_crystal_fragment, epi.mese_crystal_fragment, epi.mese_crystal_fragment},
		{"", "elepower_dynamics:gold_plate", ""},
	}
})

minetest.register_craft({
	type = "shapeless",
	output = "elepower_dynamics:acidic_compound",
	recipe = {
		"elepower_dynamics:copper_dust",
		"elepower_dynamics:copper_dust",
		"elepower_dynamics:copper_dust",
		"elepower_dynamics:copper_dust",
		epi.seed_wheat,
	}
})

minetest.register_craft({
	output = "elepower_dynamics:uv_bulb",
	recipe = {
		{epi.group_color_blue, epi.group_color_violet, epi.group_color_blue},
		{"", epi.mese_lamp, ""},
		{"", epi.glass, ""},
	}
})

-- Fluid Transfer Node
minetest.clear_craft({output = "fluid_transfer:fluid_transfer_pump"})
minetest.register_craft({
	output = "fluid_transfer:fluid_transfer_pump 3",
	recipe = {
		{epi.group_stone,  "elepower_dynamics:control_circuit",epi.group_stone},
		{"elepower_dynamics:electrum_gear", "elepower_dynamics:servo_valve", "elepower_dynamics:electrum_gear"},
		{epi.group_stone,  "elepower_dynamics:fluid_duct",  epi.group_stone},
	}
})

minetest.register_craft({
	output = "elepower_dynamics:battery 2",
	recipe = {
		{"elepower_dynamics:zinc_dust", "elepower_dynamics:graphite_rod", "elepower_dynamics:lead_dust"},
		{"elepower_dynamics:tin_plate", epi.mese_crystal_fragment, "elepower_dynamics:tin_plate"},
		{"elepower_dynamics:tin_plate", epi.mese_crystal_fragment, "elepower_dynamics:tin_plate"},
	}
})

minetest.register_craft({
	output = "elepower_dynamics:lcd_panel",
	recipe = {
		{epi.group_color_red, epi.group_color_green, epi.group_color_blue},
		{epi.silver_ingot, "elepower_dynamics:wound_copper_coil", epi.silver_ingot},
		{"", epi.mese_lamp, ""}
	}
})

minetest.register_craft({
	output = "elepower_dynamics:pv_cell",
	recipe = {
		{epi.glass, epi.glass, epi.glass},
		{epi.group_color_blue, "elepower_dynamics:silicon_wafer_doped", epi.group_color_blue},
		{epi.mese_crystal_fragment, "elepower_dynamics:wound_copper_coil", epi.mese_crystal_fragment}
	}
})

minetest.register_craft({
	output = "elepower_dynamics:integrated_circuit",
	recipe = {
		{"elepower_dynamics:chip", "elepower_dynamics:chip", "elepower_dynamics:chip"},
		{"elepower_dynamics:capacitor", "elepower_dynamics:pcb", "elepower_dynamics:capacitor"},
		{epi.copper_ingot, epi.mese_crystal, epi.copper_ingot},
	}
})

minetest.register_craft({
	output = "elepower_dynamics:tin_can 8",
	recipe = {
		{"elepower_dynamics:tin_plate", ""},
		{"", "elepower_dynamics:tin_plate"}
	}
})

minetest.register_craft({
	output = "elepower_dynamics:gas_container 8",
	recipe = {
		{"elepower_dynamics:steel_plate", "", "elepower_dynamics:steel_plate"},
		{"elepower_dynamics:steel_plate", "", "elepower_dynamics:steel_plate"},
		{""               ,"elepower_dynamics:steel_plate", ""}
	}
})

--------------
-- Smelting --
--------------

minetest.register_craft({
	type   = "cooking",
	output = "elepower_dynamics:iron_ingot",
	recipe = epi.iron_lump
})

minetest.register_craft({
	type   = "cooking",
	output = epi.steel_ingot,
	recipe = "elepower_dynamics:iron_ingot"
})

minetest.register_craft({
	type   = "cooking",
	output = "elepower_dynamics:lead_ingot",
	recipe = "elepower_dynamics:lead_lump"
})

minetest.register_craft({
	type   = "cooking",
	output = "elepower_dynamics:nickel_ingot",
	recipe = "elepower_dynamics:nickel_lump"
})

minetest.register_craft({
	type   = "cooking",
	output = "elepower_dynamics:zinc_ingot",
	recipe = "elepower_dynamics:zinc_lump"
})

minetest.register_craft({
	type     = "cooking",
	output   = "elepower_dynamics:viridisium_ingot",
	recipe   = "elepower_dynamics:viridisium_lump",
	cooktime = 10,
})

-----------
-- Gears --
-----------

local keywords = { "_ingot", "" }
for mat, data in pairs(elepd.registered_gears) do
	for _,keyword in ipairs(keywords) do
		local found     = ele.helpers.scan_item_list(mat .. keyword)
		local immebreak = false

		if mat == "wood" then
			found = epi.group_stick
			immebreak = true
		end

		if found then
			-- Gear recipe for material
			minetest.register_craft({
				recipe = {
					{ "",    found, "" },
					{ found, "",    found},
					{ "",    found, "" }
				},
				output = data.item
			})

			if immebreak then break end
		end
	end
end

-----------
-- Nodes --
-----------

local function blockcraft(mat)
	local ingot = "elepower_dynamics:" .. mat .. "_ingot"
	local block = "elepower_dynamics:" .. mat .. "_block"
	minetest.register_craft({
		type   = "shapeless",
		output = block,
		recipe = {
			ingot, ingot, ingot,
			ingot, ingot, ingot,
			ingot, ingot, ingot,
		}
	})

	minetest.register_craft({
		type   = "shapeless",
		output = ingot .. " 9",
		recipe = { block },
	})
end

blockcraft("viridisium")
blockcraft("nickel")
blockcraft("invar")
blockcraft("lead")
blockcraft("zinc")
