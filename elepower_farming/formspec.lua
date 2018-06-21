
elefarm.formspec = {}

local function bar(x,y,metric)
	return "image["..x..","..y..";0.25,2.8;elepower_gui_barbg.png"..
		"^[lowpart:"..metric..":elefarming_gui_bar.png]"
end

function elefarm.formspec.planter_formspec(timer, power)
	return "size[8,10]"..
		default.gui_bg..
		default.gui_bg_img..
		default.gui_slots..
		ele.formspec.power_meter(power)..
		bar(1, 0, 100-timer)..
		"list[context;layout;2.5,0;3,3;]"..
		"list[context;src;0,3.5;8,2;]"..
		"list[current_player;main;0,5.75;8,1;]"..
		"list[current_player;main;0,7;8,3;8]"..
		"listring[current_player;main]"..
		"listring[context;src]"..
		"listring[current_player;main]"..
		default.get_hotbar_bg(0, 5.75)
end

function elefarm.formspec.harvester_formspec(timer, power, sludge)
	return "size[8,8.5]"..
		default.gui_bg..
		default.gui_bg_img..
		default.gui_slots..
		ele.formspec.power_meter(power)..
		ele.formspec.fluid_bar(7, 0, sludge)..
		bar(1, 0, 100-timer)..
		"list[context;dst;1.5,0;5,3;]"..
		"list[current_player;main;0,4.25;8,1;]"..
		"list[current_player;main;0,5.5;8,3;8]"..
		"listring[context;dst]"..
		"listring[current_player;main]"..
		default.get_hotbar_bg(0, 4.25)
end

function elefarm.formspec.tree_processor(timer, power, fluid_buffer, water_buffer, output_buffer)
	return "size[8,8.5]"..
		default.gui_bg..
		default.gui_bg_img..
		default.gui_slots..
		ele.formspec.power_meter(power)..
		bar(1, 0, 100-timer)..
		ele.formspec.fluid_bar(2, 0, fluid_buffer)..
		ele.formspec.fluid_bar(3, 0, water_buffer)..
		ele.formspec.fluid_bar(7, 0, output_buffer)..
		"list[context;dst;5,1;1,1;]"..
		"list[current_player;main;0,4.25;8,1;]"..
		"list[current_player;main;0,5.5;8,3;8]"..
		"listring[context;dst]"..
		"listring[current_player;main]"..
		default.get_hotbar_bg(0, 4.25)
end
