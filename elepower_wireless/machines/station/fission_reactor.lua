
local myname = "elepower_nuclear:fission_controller"

local function check(pos)
	local reactpos = vector.add(pos, {x = 0, y = -1, z = 0})
	local reactnode = minetest.get_node_or_nil(reactpos)

	local coolpos = vector.add(pos, {x = 0, y = -2, z = 0})
	local coolnode = minetest.get_node_or_nil(coolpos)

	if not reactnode or reactnode.name ~= "elepower_nuclear:fission_core" then
		return nil
	end

	if not coolnode or coolnode.name ~= "elepower_nuclear:reactor_fluid_port" then
		return nil
	end

	return {
		control_meta = minetest.get_meta(pos),
		core = reactpos,
		core_meta = minetest.get_meta(reactpos),
		coolant = coolpos,
		coolant_meta = minetest.get_meta(coolpos)
	}
end

local function get_controller_formspec(meta)
	local ctrls    = {}
	local rods     = 4
	local selected = meta:get_int("selected")

	for i = 1, rods do
		local setting = meta:get_int("c" .. i)
		local xoffset = ((i / rods) * 4) + 3.75
		local sel     = ""

		if i == selected then
			sel = " <- "
		end

		local fspc = ("label[%f,0;%s]"):format(xoffset - 1.25, setting .. " %" .. sel)

		fspc = fspc .. ele.formspec.create_bar(xoffset - 1, 0.5, 100 - setting, "#252625", true)

		table.insert(ctrls, fspc)
	end

	return table.concat( ctrls, "" )..
		"button[1,3.2;1.5,0.5;next;Next]"..
		"button[2.5,3.2;1.5,0.5;prev;Previous]"..
		"button[4.25,3.2;1.5,0.5;stop;SCRAM]"..
		"button[6,3.2;1.5,0.5;up;Raise]"..
		"button[7.5,3.2;1.5,0.5;down;Lower]"..
		"tooltip[next;Select the next control rod]"..
		"tooltip[prev;Select the previous control rod]"..
		"tooltip[stop;Drops all the rods into the reactor core, instantly stopping it]"..
		"tooltip[up;Raise selected control rod]"..
		"tooltip[down;Lower selected control rod]"
end

local function get_formspec(pos, power, station, station_meta)
	local width = 8
	local fspec = "list[context;card;1,0;1,1;]"
	local metas = check(pos)

	--local comps = station_meta:get_string("components")
	--local seeitems = comps:match("elepower_wireless:upgrade_item_transfer") ~= nil

	if metas then
		fspec = "list[context;card;2,0;1,1;]"
		width = 10

		-- Reactor Core

		local power = metas.core_meta:get_int("setting")
		local heat = metas.core_meta:get_int("heat")

		local status = "Activate by extracting the control rods"

		if heat > 80 then
			status = "!!! TEMPERATURE CRITICAL !!!"
		elseif heat > 90 then
			status = "!!! REACTOR CRITICAL !!!"
		elseif heat > 95 then
			status = "!!! REACTOR MELTDOWN IMMINENT !!!"
		elseif power > 0 then
			status = "Active reaction chain"
		end

		fspec = fspec..
			ele.formspec.create_bar(1, 0, power, "#ff0000", true)..
			ele.formspec.create_bar(1.5, 0, heat, "#ffdd11", true)..
			"tooltip[1,0;0.25,2.5;Power: "..power.."%]"..
			"tooltip[1.5,0;0.25,2.5;Heat: "..heat.."%]"..
			"label[1,3.75;".. status .."]"

		-- Rods
		fspec = fspec .. get_controller_formspec(metas.control_meta)

		-- Coolant port

		local cool = fluid_lib.get_buffer_data(metas.coolant, "cool")
		local hot  = fluid_lib.get_buffer_data(metas.coolant, "hot")

		fspec = fspec ..
			ele.formspec.fluid_bar(8, 0, cool)..
			ele.formspec.fluid_bar(9, 0, hot)

		--if seeitems then
		--	fspec = fspec ..
		--		"button[2,1;1,1;inv;Items]"
		--end
	end

	local centered = (width - 8) / 2
	return "size["..width..",8.5]"..
		default.gui_bg..
		default.gui_bg_img..
		default.gui_slots..
		ele.formspec.power_meter(power)..
		"list[current_player;main;"..centered..",4.25;8,1;]"..
		"list[current_player;main;"..centered..",5.5;8,3;8]"..
		fspec..
		"listring[current_player;main]"..
		"listring[context;card]"..
		"listring[current_player;main]"..
		default.get_hotbar_bg(centered, 4.25)
end

local function on_receive_fields(pos, fields, sender, station, station_meta)
	--if fields["inv"] then
	--	return
	--end

	return minetest.registered_nodes[myname].on_receive_fields(pos, myname, fields, sender)
end

elewi.register_handler(myname, {
	get_formspec = get_formspec,
	on_receive_fields = on_receive_fields
})
