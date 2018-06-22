
---------------
-- Overrides --
---------------

-- Remove iron_lump -> steel_ingot, because dynamics adds iron ingot
minetest.clear_craft({type = "cooking", output = "default:steel_ingot"})

-----------
-- Tools --
-----------

-- Pickaxes

minetest.register_craft({
	output = 'elepower_dynamics:pick_iron',
	recipe = {
		{'elepower_dynamics:iron_ingot', 'elepower_dynamics:iron_ingot', 'elepower_dynamics:iron_ingot'},
		{'', 'group:stick', ''},
		{'', 'group:stick', ''},
	}
})

minetest.register_craft({
	output = 'elepower_dynamics:pick_lead',
	recipe = {
		{'elepower_dynamics:lead_ingot', 'elepower_dynamics:lead_ingot', 'elepower_dynamics:lead_ingot'},
		{'', 'group:stick', ''},
		{'', 'group:stick', ''},
	}
})

-- Shovels

minetest.register_craft({
	output = 'elepower_dynamics:shovel_iron',
	recipe = {
		{'elepower_dynamics:iron_ingot'},
		{'group:stick'},
		{'group:stick'},
	}
})

minetest.register_craft({
	output = 'elepower_dynamics:shovel_lead',
	recipe = {
		{'elepower_dynamics:lead_ingot'},
		{'group:stick'},
		{'group:stick'},
	}
})

-- Axes

minetest.register_craft({
	output = 'elepower_dynamics:axe_iron',
	recipe = {
		{'elepower_dynamics:iron_ingot', 'elepower_dynamics:iron_ingot'},
		{'elepower_dynamics:iron_ingot', 'group:stick'},
		{'', 'group:stick'},
	}
})

minetest.register_craft({
	output = 'elepower_dynamics:axe_lead',
	recipe = {
		{'elepower_dynamics:lead_ingot', 'elepower_dynamics:lead_ingot'},
		{'elepower_dynamics:lead_ingot', 'group:stick'},
		{'', 'group:stick'},
	}
})

-- Swords

minetest.register_craft({
	output = 'elepower_dynamics:sword_iron',
	recipe = {
		{'elepower_dynamics:iron_ingot'},
		{'elepower_dynamics:iron_ingot'},
		{'group:stick'},
	}
})

minetest.register_craft({
	output = 'elepower_dynamics:sword_lead',
	recipe = {
		{'elepower_dynamics:lead_ingot'},
		{'elepower_dynamics:lead_ingot'},
		{'group:stick'},
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
	output = "elepower_dynamics:conduit 6",
	recipe = {
		{"elepower_dynamics:lead_ingot",  "elepower_dynamics:lead_ingot",  "elepower_dynamics:lead_ingot"},
		{"elepower_dynamics:copper_wire", "elepower_dynamics:copper_wire", "elepower_dynamics:copper_wire"},
		{"elepower_dynamics:lead_ingot",  "elepower_dynamics:lead_ingot",  "elepower_dynamics:lead_ingot"},
	}
})

-- Duct
minetest.register_craft({
	output = "elepower_dynamics:fluid_duct 6",
	recipe = {
		{"group:glass",  "group:glass",  "group:glass"},
		{"elepower_dynamics:lead_ingot", "elepower_dynamics:lead_ingot", "elepower_dynamics:lead_ingot"},
		{"group:glass",  "group:glass",  "group:glass"},
	}
})

-- Fluid Transfer Node
minetest.register_craft({
	output = "elepower_dynamics:fluid_transfer_node",
	recipe = {
		{"group:stone",  "elepower_dynamics:fluid_duct",  "group:stone"},
		{"elepower_dynamics:steel_gear", "elepower_dynamics:servo_valve", "elepower_dynamics:steel_gear"},
		{"group:stone",  "elepower_dynamics:fluid_duct",  "group:stone"},
	}
})

-- Portable Tank
minetest.register_craft({
	output = "elepower_dynamics:portable_tank",
	recipe = {
		{"group:glass", "elepower_dynamics:fluid_duct", "group:glass"},
		{"group:glass", "group:glass", "group:glass"},
		{"default:bronze_ingot",  "default:bronze_ingot", "default:bronze_ingot"},
	}
})

-----------
-- Items --
-----------

minetest.register_craft({
	output = "elepower_dynamics:wound_copper_coil",
	recipe = {
		{"", "default:copper_ingot", ""},
		{"default:copper_ingot", "elepower_dynamics:iron_ingot", "default:copper_ingot"},
		{"", "default:copper_ingot", ""}
	}
})

minetest.register_craft({
	output = "elepower_dynamics:copper_wire",
	recipe = {
		{"default:copper_ingot", "default:copper_ingot", "default:copper_ingot"},
		{"default:copper_ingot", "",                     "default:copper_ingot"},
		{"default:copper_ingot", "default:copper_ingot", "default:copper_ingot"}
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
		{"default:steel_ingot", "default:steel_ingot", "default:steel_ingot"},
		{"", "", "default:steel_ingot"},
	}
})

--------------
-- Smelting --
--------------

minetest.register_craft({
	type   = "cooking",
	output = "elepower_dynamics:iron_ingot",
	recipe = "default:iron_lump"
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
	type     = "cooking",
	output   = "default:steel_ingot",
	recipe   = "elepower_dynamics:iron_ingot",
	cooktime = 20
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
			found = "group:stick"
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
