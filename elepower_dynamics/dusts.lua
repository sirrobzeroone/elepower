
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

elepd.register_dust("bronze", {
	description = "Bronze",
	color = "#fa7b26"
})

elepd.register_dust("copper", {
	description = "Copper",
	color = "#fcb15f"
})

elepd.register_dust("gold", {
	description = "Gold",
	color = "#ffff47"
})

elepd.register_dust("steel", {
	description = "Steel", 
	color = "#ffffff"
})

elepd.register_dust("tin", {
	description = "Tin", 
	color = "#c1c1c1"
})

elepd.register_dust("mithril", {
	description = "Mithril",
	color = "#8686df"
})

elepd.register_dust("silver", {
	description = "Silver",
	color = "#d7e2e8"
})

elepd.register_dust("lead", {
	description = "Lead",
	color = "#aeaedc"
})

elepd.register_dust("iron", {
	description = "Iron",
	color = "#dddddd"
})

elepd.register_dust("coal", {
	description = "Coal",
	color = "#222222"
})

elepd.register_dust("diamond", {
	description = "Diamond",
	color = "#02c1e8"
})

elepd.register_dust("nickel", {
	description = "Nickel",
	color = "#d6d5ab"
})

elepd.register_dust("invar", {
	description = "Invar",
	color = "#9fa5b2"
})

elepd.register_dust("electrum", {
	description = "Electrum",
	color = "#ebeb90"
})

elepd.register_dust("viridisium", {
	description = "Viridisium",
	color = "#5b9751"
})

elepd.register_dust("wood", {
	description = "Sawdust",
	force_description = true,
	color = "#847454"
})
