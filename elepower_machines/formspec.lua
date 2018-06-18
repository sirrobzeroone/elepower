
-- Specialized formspec for crafters
function ele.formspec.get_crafter_formspec(craft_type, power, percent)
	local craftstats  = elepm.craft.types[craft_type]
	local input_size  = craftstats.inputs

	local bar = "image[4,1.5;1,1;gui_furnace_arrow_bg.png^[transformR270]"
	
	if percent ~= nil then
		bar = "image[4,1.5;1,1;gui_furnace_arrow_bg.png^[lowpart:"..
			  (percent)..":gui_furnace_arrow_fg.png^[transformR270]"
	end

	return "size[8,8.5]"..
		default.gui_bg..
		default.gui_bg_img..
		default.gui_slots..
		ele.formspec.power_meter(power)..
		"list[context;src;1.5,1.5;"..input_size..",1;]"..
		bar..
		"list[context;dst;5,1;2,2;]"..
		"list[current_player;main;0,4.25;8,1;]"..
		"list[current_player;main;0,5.5;8,3;8]"..
		"listring[current_player;main]"..
		"listring[context;src]"..
		"listring[current_player;main]"..
		"listring[context;dst]"..
		"listring[current_player;main]"..
		default.get_hotbar_bg(0, 4.25)
end

function ele.formspec.get_generator_formspec(power, percent)
	return "size[8,8.5]"..
		default.gui_bg..
		default.gui_bg_img..
		default.gui_slots..
		ele.formspec.power_meter(power)..
		"list[context;src;3,1.5;1,1;]"..
		"image[4,1.5;1,1;default_furnace_fire_bg.png^[lowpart:"..
		percent..":default_furnace_fire_fg.png]"..
		"list[current_player;main;0,4.25;8,1;]"..
		"list[current_player;main;0,5.5;8,3;8]"..
		"listring[current_player;main]"..
		"listring[context;src]"..
		"listring[current_player;main]"..
		default.get_hotbar_bg(0, 4.25)
end

function ele.formspec.get_storage_formspec(power)
	return "size[8,8.5]"..
		default.gui_bg..
		default.gui_bg_img..
		default.gui_slots..
		ele.formspec.power_meter(power)..
		"image[2,0.5;1,1;gui_furnace_arrow_bg.png^[transformR180]"..
		"list[context;out;2,1.5;1,1;]"..
		"image[5,0.5;1,1;gui_furnace_arrow_bg.png]"..
		"list[context;in;5,1.5;1,1;]"..
		"list[current_player;main;0,4.25;8,1;]"..
		"list[current_player;main;0,5.5;8,3;8]"..
		"listring[current_player;main]"..
		"listring[context;out]"..
		"listring[current_player;main]"..
		"listring[context;in]"..
		"listring[current_player;main]"..
		default.get_hotbar_bg(0, 4.25)
end
