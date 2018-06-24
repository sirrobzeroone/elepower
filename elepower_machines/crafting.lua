
--*****************--
-- MACHINE RECIPES --
--*****************--

--------------
-- Alloying --
--------------

local alloy_recipes = {
	{
		recipe = { "elepower_dynamics:iron_ingot", "elepower_dynamics:coal_dust 4" },
		output = "default:steel_ingot",
		time   = 6,
	},
	{
		recipe = { "default:copper_ingot 2", "default:tin_ingot" },
		output = "default:bronze_ingot 3",
	},
	{
		recipe = { "default:iron_ingot 3", "elepower_dynamics:nickel_ingot" },
		output = "elepower_dynamics:invar_ingot 4",
	},
	{
		recipe = { "default:gold_ingot 2", "elepower_dynamics:invar_ingot" },
		output = "elepower_dynamics:electrum_ingot 3",
	}
}

-- Register alloy furnace recipes
for _,i in pairs(alloy_recipes) do
	elepm.register_craft({
		type   = "alloy",
		recipe = i.recipe,
		output = i.output,
		time   = i.time or 4
	})
end

--------------
-- Grinding --
--------------

local keywords = { _ingot = 1, _lump = 2, _block = 9, block = 9 }
for mat, data in pairs(elepd.registered_dusts) do
	local kwfound = nil
	for keyword,count in pairs(keywords) do
		local found = ele.helpers.scan_item_list(mat .. keyword)
		if found then
			if keyword == "_ingot" and not kwfound then
				kwfound = found
			end

			-- Grind recipe for material
			elepm.register_craft({
				type   = "grind",
				recipe = { found },
				output = data.item .. " " .. count,
				time   = count + 4,
			})
		end
	end

	-- Add dust -> ingot smelting
	if kwfound then
		minetest.register_craft({
			type   = "cooking",
			recipe = data.item,
			output = kwfound
		})
	end
end

-------------
-- Sawmill --
-------------

-- Register all logs as sawable, if we can find a planks version
minetest.after(0.2, function ()
	local wood_nodes = {}
	for name in pairs(minetest.registered_nodes) do
		if ele.helpers.get_item_group(name, "wood") then
			wood_nodes[#wood_nodes + 1] = name
		end
	end

	-- Begin making associations
	-- Get crafting recipe for all woods
	local assoc = {}
	for _,wood in ipairs(wood_nodes) do
		local recipes = minetest.get_all_craft_recipes(wood)
		for _, recipe in ipairs(recipes) do
			if recipe.items and #recipe.items == 1 then
				assoc[recipe.items[1]] = wood
			end
		end
	end

	-- Register sawmill craft
	for tree, wood in pairs(assoc) do
		elepm.register_craft({
			type   = "saw",
			recipe = { tree },
			output = {wood .. " 6", "elepower_dynamics:wood_dust"},
			time   = 8,
		})
	end
end)

--******************--
-- CRAFTING RECIPES --
--******************--

-- Coal-fired Alloy Furnace
minetest.register_craft({
	output = "elepower_machines:coal_alloy_furnace",
	recipe = {
		{"default:brick", "default:brick", "default:brick"},
		{"default:furnace", "bucket:bucket_lava", "default:furnace"}
	},
	replacements = {
		{"bucket:bucket_lava", "bucket:bucket_empty"}
	}
})

-- Grindstone
minetest.register_craft({
	output = "elepower_machines:grindstone",
	recipe = {
		{"group:stone", "group:stone", "group:stone"},
		{"default:flint", "default:flint", "default:flint"},
		{"group:cobble", "group:cobble", "group:cobble"},
	},
	replacements = {
		{"bucket:bucket_lava", "bucket:bucket_empty"}
	}
})

-- Machine block
minetest.register_craft({
	output = "elepower_machines:machine_block",
	recipe = {
		{"elepower_dynamics:viridisium_ingot", "default:steel_ingot", "elepower_dynamics:viridisium_ingot"},
		{"default:steel_ingot", "default:mese_crystal", "default:steel_ingot"},
		{"elepower_dynamics:viridisium_ingot", "elepower_dynamics:tin_gear", "elepower_dynamics:viridisium_ingot"},
	}
})

-- Generator
minetest.register_craft({
	output = "elepower_machines:generator",
	recipe = {
		{"", "default:steel_ingot", ""},
		{"default:steel_ingot", "elepower_machines:machine_block", "default:steel_ingot"},
		{"elepower_dynamics:wound_copper_coil", "default:furnace", "elepower_dynamics:wound_copper_coil"}
	}
})

-- Alloy Furnace
minetest.register_craft({
	output = "elepower_machines:alloy_furnace",
	recipe = {
		{"", "elepower_dynamics:integrated_circuit", ""},
		{"default:brick", "elepower_machines:machine_block", "default:brick"},
		{
			"elepower_dynamics:wound_copper_coil",
			"elepower_machines:coal_alloy_furnace",
			"elepower_dynamics:wound_copper_coil"
		},
	}
})

-- Furnace
minetest.register_craft({
	output = "elepower_machines:furnace",
	recipe = {
		{"", "elepower_dynamics:integrated_circuit", ""},
		{"default:clay_brick", "elepower_machines:machine_block", "default:clay_brick"},
		{"elepower_dynamics:wound_copper_coil", "default:furnace", "elepower_dynamics:wound_copper_coil"},
	}
})

-- Pulverizer
minetest.register_craft({
	output = "elepower_machines:pulverizer",
	recipe = {
		{"", "elepower_dynamics:integrated_circuit", ""},
		{"default:flint", "elepower_machines:machine_block", "default:flint"},
		{"elepower_dynamics:wound_copper_coil", "elepower_dynamics:lead_gear", "elepower_dynamics:wound_copper_coil"},
	}
})

-- Sawmill
minetest.register_craft({
	output = "elepower_machines:sawmill",
	recipe = {
		{"", "elepower_dynamics:integrated_circuit", ""},
		{"elepower_dynamics:steel_gear", "elepower_machines:machine_block", "elepower_dynamics:steel_gear"},
		{"elepower_dynamics:lead_ingot", "elepower_dynamics:diamond_gear", "elepower_dynamics:lead_ingot"},
	}
})

-- Power Cell
minetest.register_craft({
	output = "elepower_machines:power_cell_0",
	recipe = {
		{"elepower_dynamics:lead_ingot", "elepower_dynamics:control_circuit", "elepower_dynamics:lead_ingot"},
		{"elepower_dynamics:wound_copper_coil", "elepower_machines:machine_block", "elepower_dynamics:wound_copper_coil"},
		{"elepower_dynamics:lead_ingot", "elepower_dynamics:diamond_gear", "elepower_dynamics:lead_ingot"},
	}
})

-- Water Accumulator
minetest.register_craft({
	output = "elepower_machines:accumulator",
	recipe = {
		{"", "elepower_dynamics:fluid_duct", ""},
		{"group:glass", "elepower_machines:machine_block", "group:glass"},
		{"elepower_dynamics:steel_gear", "elepower_dynamics:servo_valve", "elepower_dynamics:steel_gear"},
	}
})
