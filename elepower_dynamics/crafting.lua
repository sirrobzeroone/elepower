
---------------
-- Overrides --
---------------

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
-- Items --
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
	output = "elepower_dynamics:lead_lump",
	recipe = "elepower_dynamics:lead_ingot"
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
