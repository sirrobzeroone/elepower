
----------------------
-- Ground materials --
----------------------

elepd.registered_dusts = {}

function elepd.register_dust(mat, data)
	local mod      = minetest.get_current_modname()
	local itemname = mod..":"..mat.."_dust"

	data.item = itemname
	elepd.registered_dusts[mat] = data

	-- Make descriptions overridable
	local description = "Pulverized " .. data.description
	if data.force_description then
		description = data.description
	end

	minetest.register_craftitem(itemname, {
		description     = description,
		inventory_image = "elepower_dust.png^[multiply:" .. data.color,
		groups          = {
			["dust_" .. mat] = 1,
			dust = 1
		}
	})
end

-- Default dust list
local dusts = {
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
	{"zinc",       "Zinc",       "#598a9e"},
	{"wood",       "Sawdust",    "#847454", true}
}

for _,dust in ipairs(dusts) do
	elepd.register_dust(dust[1], {
		description       = dust[2],
		color             = dust[3],
		force_description = dust[4],
	})
end
