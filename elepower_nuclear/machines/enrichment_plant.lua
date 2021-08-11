
-- see elepower_papi >> external_nodes_items.lua for explanation
-- shorten table ref
local epr = ele.external.ref

-- Nuclear fuel enrichment plant

local function get_formspec(craft_type, power, progress, pos)
	if not progress then progress = 0 end
	return "size[8,8.5]"..
		epr.gui_bg..
		epr.gui_bg_img..
		epr.gui_slots..
		ele.formspec.power_meter(power)..
		"list[context;src;2,0.75;1,1;]"..
		"image[3.5,0.75;1,1;elenuclear_gui_icon_bg.png^[lowpart:"..
		(progress)..":elenuclear_gui_icon_fg.png]"..
		--"image[3.5,0.75;1,1;elenuclear_gui_icon_bg.png^[lowpart:"..
		--(progress)..":elenuclear_gui_icon_fg.png]"..
		"list[context;dst;5,0.25;2,2;]"..
		"list[current_player;main;0,4.25;8,1;]"..
		"list[current_player;main;0,5.5;8,3;8]"..
		"image[7,3;1,1;elenuclear_radioactive.png]"..
		"listring[current_player;main]"..
		"listring[context;src]"..
		"listring[current_player;main]"..
		"listring[context;dst]"..
		"listring[current_player;main]"..
		epr.get_hotbar_bg(0, 4.25)
end

elepm.register_craft_type("enrichment", {
	description = "Enrichment",
	inputs      = 1,
	icon        = "elenuclear_enrichment_plant.png",
})

elepm.register_crafter("elepower_nuclear:enrichment_plant", {
	description = "Enrichment Plant",
	craft_type = "enrichment",
	tiles = {
		"elenuclear_machine_top.png",  "elepower_lead_block.png",  "elenuclear_machine_side.png",
		"elenuclear_machine_side.png", "elenuclear_machine_side.png", "elenuclear_enrichment_plant.png",
	},
	groups = {ele_user = 1, cracky = 3},
	ele_capacity = 8000,
	ele_usage    = 1000,
	ele_inrush   = 8000,
	get_formspec = get_formspec,
})
