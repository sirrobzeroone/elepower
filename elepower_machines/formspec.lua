
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

function elepm.get_coal_alloy_furnace_formspec(fuel_percent, item_percent)
	return "size[8,8.5]"..
		default.gui_bg..
		default.gui_bg_img..
		default.gui_slots..
		"list[context;src;2,0.5;2,1;]"..
		"list[context;fuel;2.5,2.5;1,1;]"..
		"image[2.5,1.5;1,1;default_furnace_fire_bg.png^[lowpart:"..
		(100-fuel_percent)..":default_furnace_fire_fg.png]"..
		"image[4,1.5;1,1;gui_furnace_arrow_bg.png^[lowpart:"..
		(item_percent)..":gui_furnace_arrow_fg.png^[transformR270]"..
		"list[context;dst;5,0.96;2,2;]"..
		"list[current_player;main;0,4.25;8,1;]"..
		"list[current_player;main;0,5.5;8,3;8]"..
		"listring[context;dst]"..
		"listring[current_player;main]"..
		"listring[context;src]"..
		"listring[current_player;main]"..
		"listring[context;fuel]"..
		"listring[current_player;main]"..
		default.get_hotbar_bg(0, 4.25)
end

function elepm.get_grindstone_formspec(item_percent)
	return "size[8,8.5]"..
		default.gui_bg..
		default.gui_bg_img..
		default.gui_slots..
		"list[context;src;1.6,1;1,1;]"..
		"image[3.5,1;1,1;gui_furnace_arrow_bg.png^[lowpart:"..
		(item_percent)..":gui_furnace_arrow_fg.png^[transformR270]"..
		"list[context;dst;4.5,1;2,1;]"..
		"list[current_player;main;0,4.25;8,1;]"..
		"list[current_player;main;0,5.5;8,3;8]"..
		"listring[context;dst]"..
		"listring[current_player;main]"..
		"listring[context;src]"..
		"listring[current_player;main]"..
		default.get_hotbar_bg(0, 4.25)
end

function elepm.get_lava_cooler_formspec(item_percent, coolant_buffer, hot_buffer, power, recipes, recipe)
	local rclist = {}

	local x = 2.5
	for j in pairs(recipes) do
		if j == recipe then
			rclist[#rclist + 1] = "item_image["..x..",0;1,1;"..j.."]"
		else
			rclist[#rclist + 1] = "item_image_button[".. x ..",0;1,1;"..j..";"..j..";]"
		end
		x = x + 1
	end

	return "size[8,8.5]"..
		default.gui_bg..
		default.gui_bg_img..
		default.gui_slots..
		ele.formspec.power_meter(power)..
		ele.formspec.fluid_bar(1, 0, coolant_buffer)..
		ele.formspec.fluid_bar(7, 0, hot_buffer)..
		"list[context;dst;3.5,1.5;1,1;]"..
		"image[2.5,1.5;1,1;gui_furnace_arrow_bg.png^[lowpart:"..
		(item_percent)..":gui_furnace_arrow_fg.png^[transformR270]"..
		"image[4.5,1.5;1,1;gui_furnace_arrow_bg.png^[lowpart:"..
		(item_percent)..":gui_furnace_arrow_fg.png^[transformFXR90]"..
		table.concat(rclist, "")..
		"list[current_player;main;0,4.25;8,1;]"..
		"list[current_player;main;0,5.5;8,3;8]"..
		"listring[current_player;main]"..
		"listring[context;dst]"..
		"listring[current_player;main]"..
		default.get_hotbar_bg(0, 4.25)
end
