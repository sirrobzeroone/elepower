
-----------
-- Gears --
-----------

elepd.registered_gears = {}

function elepd.register_gear(mat, data)
	local mod      = minetest.get_current_modname()
	local itemname = mod..":"..mat.."_gear"

	data.item = itemname
	elepd.registered_gears[mat] = data

	local description = data.description .. " Gear"

	minetest.register_craftitem(itemname, {
		description     = description,
		inventory_image = "elepower_gear.png^[multiply:" .. data.color,
		groups          = {
			["gear_" .. mat] = 1,
			gear = 1
		}
	})
end

-- Default gear list
local gears = {
	{"bronze",     "Bronze",     "#fa7b26"},
	{"copper",     "Copper",     "#fcb15f"},
	{"gold",       "Gold",       "#ffff47"},
	{"steel",      "Steel",      "#ffffff"},
	{"tin",        "Tin",        "#c1c1c1"},
	{"mithril",    "Mithril",    "#8686df"},
	{"silver",     "Silver",     "#d7e2e8"},
	{"lead",       "Lead",       "#aeaedc"},
	{"iron",       "Iron",       "#dddddd"},
	{"coal",       "Coal",       "#222222"},
	{"diamond",    "Diamond",    "#02c1e8"},
	{"nickel",     "Nickel",     "#d6d5ab"},
	{"invar",      "Invar",      "#9fa5b2"},
	{"electrum",   "Electrum",   "#ebeb90"},
	{"viridisium", "Viridisium", "#5b9751"},
}

for _,gear in ipairs(gears) do
	elepd.register_gear(gear[1], {
		description       = gear[2],
		color             = gear[3]
	})
end
