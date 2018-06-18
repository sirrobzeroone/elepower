
----------------------
-- Ground materials --
----------------------

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
			dust = 1
		}
	})
end

-- Default dust list

elepd.register_gear("bronze", {
	description = "Bronze",
	color = "#fa7b26"
})

elepd.register_gear("copper", {
	description = "Copper",
	color = "#fcb15f"
})

elepd.register_gear("gold", {
	description = "Gold",
	color = "#ffff47"
})

elepd.register_gear("steel", {
	description = "Steel", 
	color = "#ffffff"
})

elepd.register_gear("tin", {
	description = "Tin", 
	color = "#c1c1c1"
})

elepd.register_gear("mithril", {
	description = "Mithril",
	color = "#8686df"
})

elepd.register_gear("silver", {
	description = "Silver",
	color = "#d7e2e8"
})

elepd.register_gear("lead", {
	description = "Lead",
	color = "#aeaedc"
})

elepd.register_gear("iron", {
	description = "Iron",
	color = "#dddddd"
})

elepd.register_gear("diamond", {
	description = "Diamond",
	color = "#02c1e8"
})

elepd.register_gear("energium", {
	description = "Energium",
	color = "#ff1111"
})

elepd.register_gear("wood", {
	description = "Wood",
	color = "#847454"
})
