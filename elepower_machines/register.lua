
--------------
-- Alloying --
--------------

elepm.register_craft_type("alloy", {
	description = "Alloying",
	inputs      = 2,
})

elepm.register_craft({
	type   = "alloy",
	recipe = { "elepower_dynamics:iron_ingot", "elepower_dynamics:coal_dust 4" },
	output = "default:steel_ingot",
	time   = 6,
})

elepm.register_crafter("elepower_machines:alloy_furnace", {
	description = "Alloy Furnace",
	craft_type = "alloy",
	ele_active_node = true,
	tiles = {
		"elepower_machine_top.png", "elepower_machine_base.png", "elepower_machine_side.png",
		"elepower_machine_side.png", "elepower_machine_side.png", "elepower_alloy_furnace.png",
	},
	ele_active_nodedef = {
		tiles = {
			"elepower_machine_top.png", "elepower_machine_base.png", "elepower_machine_side.png",
			"elepower_machine_side.png", "elepower_machine_side.png", "elepower_alloy_furnace_active.png",
		},
	},
	groups = {oddly_breakable_by_hand = 1}
})

--------------
-- Grinding --
--------------

elepm.register_craft_type("grind", {
	description = "Grinding",
	inputs      = 1,
})

-- Look for item name regardless of mod
local function scan_item_list(item_name)
	local found = nil

	for name in pairs(minetest.registered_items) do
		local nomod = name:gsub("(%w+):", "")
		if nomod == item_name then
			found = name
			break
		end
	end

	return found
end

local keywords = { _ingot = 1, _lump = 2, _block = 9, block = 9 }
for mat, data in pairs(elepd.registered_dusts) do
	local kwfound = nil
	for keyword,count in pairs(keywords) do
		local found = scan_item_list(mat .. keyword)
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

elepm.register_crafter("elepower_machines:pulverizer", {
	description = "Pulverizer",
	craft_type = "grind",
	ele_active_node = true,
	ele_usage = 32,
	tiles = {
		"elepower_machine_top.png", "elepower_machine_base.png", "elepower_machine_side.png",
		"elepower_machine_side.png", "elepower_machine_side.png", "elepower_grinder.png",
	},
	ele_active_nodedef = {
		tiles = {
			"elepower_machine_top.png", "elepower_machine_base.png", "elepower_machine_side.png",
			"elepower_machine_side.png", "elepower_machine_side.png", "elepower_grinder_active.png",
		},
	},
	groups = {oddly_breakable_by_hand = 1}
})

-------------
-- Furnace --
-------------

elepm.register_crafter("elepower_machines:furnace", {
	description = "Powered Furnace",
	craft_type = "cooking",
	ele_active_node = true,
	ele_usage = 32,
	tiles = {
		"elepower_machine_top.png", "elepower_machine_base.png", "elepower_machine_side.png",
		"elepower_machine_side.png", "elepower_machine_side.png", "elepower_furnace.png",
	},
	ele_active_nodedef = {
		tiles = {
			"elepower_machine_top.png", "elepower_machine_base.png", "elepower_machine_side.png",
			"elepower_machine_side.png", "elepower_machine_side.png", "elepower_furnace_active.png",
		},
	},
	groups = {oddly_breakable_by_hand = 1}
})

-------------
-- Sawmill --
-------------

elepm.register_craft_type("saw", {
	description = "Sawmilling",
	inputs      = 1,
})

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
			output = wood .. " 6",
			time   = 8,
		})
	end
end)

elepm.register_crafter("elepower_machines:sawmill", {
	description = "Sawmill",
	craft_type = "saw",
	ele_usage = 32,
	tiles = {
		"elepower_machine_top.png", "elepower_machine_base.png", "elepower_machine_side.png",
		"elepower_machine_side.png", "elepower_machine_side.png", "elepower_sawmill.png",
	},
	groups = {oddly_breakable_by_hand = 1}
})

----------------------
-- Power Generation --
----------------------

elepm.register_fuel_generator("elepower_machines:generator", {
	description = "Coal-fired Generator",
	ele_active_node = true,
	ele_capacity = 6400,
	tiles = {
		"elepower_machine_top.png", "elepower_machine_base.png", "elepower_machine_side.png",
		"elepower_machine_side.png", "elepower_machine_side.png", "elepower_generator.png",
	},
	ele_active_nodedef = {
		tiles = {
			"elepower_machine_top.png", "elepower_machine_base.png", "elepower_machine_side.png",
			"elepower_machine_side.png", "elepower_machine_side.png", "elepower_generator_active.png",
		}
	},
	groups = {oddly_breakable_by_hand = 1}
})

-------------------
-- Power Storage --
-------------------

elepm.register_storage("elepower_machines:power_cell", {
	description = "Power Cell",
	ele_capacity = 16000,
	tiles = {
		"elepower_machine_top.png", "elepower_machine_base.png", "elepower_machine_side.png",
		"elepower_machine_side.png", "elepower_machine_side.png", "elepower_power_cell.png",
	},
	groups = {oddly_breakable_by_hand = 1}
})
