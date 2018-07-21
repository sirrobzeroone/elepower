-- Nuclear fuel enrichment plant

local function get_formspec(power, heat, progress, water)
	return "size[8,8.5]"..
		default.gui_bg..
		default.gui_bg_img..
		default.gui_slots..
		ele.formspec.power_meter(power)..
		ele.formspec.create_bar(1, 0, heat, "#ffbb11", true)..
		"list[context;src;2,0.75;1,1;]"..
		"image[3.5,0.75;1,1;gui_furnace_arrow_bg.png^[lowpart:"..
		(progress)..":gui_furnace_arrow_fg.png^[transformR270]"..
		"list[context;dst;5,0.25;2,2;]"..
		ele.formspec.fluid_bar(7, 0, water)..
		"list[current_player;main;0,4.25;8,1;]"..
		"list[current_player;main;0,5.5;8,3;8]"..
		"image[7,3;1,1;elenuclear_radioactive.png]"..
		"listring[current_player;main]"..
		"listring[context;src]"..
		"listring[current_player;main]"..
		"listring[context;dst]"..
		"listring[current_player;main]"..
		default.get_hotbar_bg(0, 4.25)
end

local function enrichment_plant_timer (pos)
	local meta    = minetest.get_meta(pos)
	local refresh = false

	return refresh
end

ele.register_machine("elepower_nuclear:enrichment_plant", {
	description = "Enrichment Plant",
	tiles = {
		"elenuclear_machine_top.png",  "elenuclear_machine_top.png",  "elenuclear_machine_side.png",
		"elenuclear_machine_side.png", "elenuclear_machine_side.png", "elenuclear_enrichment_plant.png",
	},
	groups = {ele_user = 1, cracky = 3, fluid_container = 1},
	ele_capacity = 16000,
	ele_usage    = 288,
	ele_inrush   = 288,
	fluid_buffers = {
		water = {
			accepts   = {"default:water_source"},
			capacity  = 8000,
			drainable = false,
		}
	},
	on_construct = function (pos)
		local meta = minetest.get_meta(pos)
		local inv  = meta:get_inventory()

		inv:set_size("src", 1)
		inv:set_size("dst", 4)

		meta:set_string("formspec", get_formspec(0, 25, 0, nil))
	end,
	on_timer = enrichment_plant_timer,
})
