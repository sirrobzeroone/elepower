
------------
-- Plates --
------------

elepd.registered_plates = {}

function elepd.register_plate(mat, data)
	local mod      = minetest.get_current_modname()
	local itemname = mod..":"..mat.."_plate"

	data.item = itemname
	elepd.registered_plates[mat] = data

	-- Make descriptions overridable
	local description = data.description .. " Plate"
	if data.force_description then
		description = data.description
	end

	minetest.register_craftitem(itemname, {
		description     = description,
		inventory_image = "elepower_plate.png^[multiply:" .. data.color,
		groups          = {
			["plate_" .. mat] = 1,
			plate = 1
		}
	})
end

-- Default plate list
local plates = {
	{"bronze",     "Bronze",     "#fa7b26"},
	{"copper",     "Copper",     "#fcb15f"},
	{"gold",       "Gold",       "#ffff47"},
	{"steel",      "Steel",      "#ffffff"},
	{"tin",        "Tin",        "#c1c1c1"},
	{"mithril",    "Mithril",    "#8686df"},
	{"silver",     "Silver",     "#d7e2e8"},
	{"lead",       "Lead",       "#aeaedc"},
	{"iron",       "Iron",       "#dddddd"},
	{"diamond",    "Diamond",    "#02c1e8"},
	{"nickel",     "Nickel",     "#d6d5ab"},
	{"invar",      "Invar",      "#9fa5b2"},
	{"electrum",   "Electrum",   "#ebeb90"},
	{"viridisium", "Viridisium", "#5b9751"},
	{"zinc",       "Zinc",       "#598a9e"},
}

for _,plate in ipairs(plates) do
	elepd.register_plate(plate[1], {
		description       = plate[2],
		color             = plate[3],
		force_description = plate[4],
	})
end
