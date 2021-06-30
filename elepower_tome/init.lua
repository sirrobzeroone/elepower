---------------------------------------------------
--       ___ _                                   --
--      | __| |___ _ __  _____ __ _____ _ _      --
--      | _|| / -_) '_ \/ _ \ V  V / -_) '_|     --
--      |___|_\___| .__/\___/\_/\_/\___|_|       --
--                |_|                            --
--              _____                            --
--             |_   _|__ _ __  ___               --
--               | |/ _ \ '  \/ -_)              --
--               |_|\___/_|_|_\___|              --
---------------------------------------------------
--                                               --
---------------------------------------------------

-- Global variable for mod
eletome = rawget(_G, "eletome") or {}

-- path, modname and translation
local modname = minetest.get_current_modname()
local modpath = minetest.get_modpath(modname)
eletome.S = minetest.get_translator(modname)
local S = eletome.S

-- includes
dofile(modpath .. "/i_eletome_additional_info.lua")
dofile(modpath .. "/i_functions.lua")
dofile(modpath .. "/i_page_contents.lua")
dofile(modpath .. "/i_page_crafts.lua")
dofile(modpath .. "/i_page_machines.lua")
dofile(modpath .. "/i_page_instructions.lua")
dofile(modpath .. "/i_page_help.lua")

-- register our Tome/Book item
minetest.register_craftitem("elepower_tome:tome", {
	description = "Elepower Tome",
	inventory_image = "elepower_tome.png",
	groups = {book = 1, flammable = 3},
	on_use = function(itemstack, user, pointed_thing)

				 local eletome_bg = eletome.tome_bg
				 local eletome_contents = eletome.contents_page()
				 minetest.show_formspec(user:get_player_name(), "elepower_tome:tome", eletome_bg..eletome_contents)

			 end,
})


-- Give player elepower tome on initial logon
minetest.register_on_newplayer(function(player)
	player:get_inventory():add_item("main", "elepower_tome:tome")
end)

-- Player tome meta - setup back button meta
minetest.register_on_joinplayer(function(player)
	local pmeta = player:get_meta()
	local back = {}
	pmeta:set_string("elepower_tome_back", minetest.serialize(back))
end)

-- register our recieve field callback
minetest.register_on_player_receive_fields(function(player, formname, fields)

	if formname ~= "elepower_tome:tome" then
		return
	end

	-- Back Button
	local pmeta = player:get_meta()
	local back = minetest.deserialize(pmeta:get_string("elepower_tome_back"))
	local show_back = ""

	if fields.quit == "true" then
		back = {}
		pmeta:set_string("elepower_tome_back", minetest.serialize(back))

	elseif fields.back then
		local prev_page = #back-1

		if prev_page <= 0 then
			-- must be going back to contents
			fields = {}
			back = {}
			pmeta:set_string("elepower_tome_back", minetest.serialize(back))
			fields.content = "Content"
		else
			fields = back[prev_page]
			table.remove(back,#back)
			pmeta:set_string("elepower_tome_back", minetest.serialize(back))
		end
	else
		table.insert(back,fields)
		pmeta:set_string("elepower_tome_back", minetest.serialize(back))
	end

	if #back > 0 then
		show_back = eletome.back_button
	end

	-- Clicked contents button on any page.
	if fields.content then
		local eletome_bg = eletome.tome_bg..show_back
		local eletome_contents = eletome.contents_page()
		minetest.show_formspec(player:get_player_name(), "elepower_tome:tome", eletome_bg..eletome_contents)
	end

	-- Clicked a craft link on contents
	if fields.craft_click then
		local eletome_bg =  eletome.tome_bg..show_back
		local eletome_craft = eletome.craft_page(fields.craft_click)

		minetest.show_formspec(player:get_player_name(), "elepower_tome:tome", eletome_bg..eletome_craft)
	end

	-- Clicked craft bwd/fwd button on craft sub-page
	if fields.craft_bwd_fwd then
		local page_num = string.match(fields.craft_bwd_fwd , "%s(%w+)%s")
		-- eletome.craft_page() expects description in format "something:craft_description"
		local craft_value = "cd:"..fields.description

		local eletome_bg =  eletome.tome_bg..show_back
		local eletome_craft = eletome.craft_page(craft_value,page_num)

		minetest.show_formspec(player:get_player_name(), "elepower_tome:tome", eletome_bg..eletome_craft)
	end

	-- Clicked Machine page
	if fields.machine then
		local eletome_bg =  eletome.tome_bg..show_back
		local eletome_machine = eletome.machines(fields.machine)

		minetest.show_formspec(player:get_player_name(), "elepower_tome:tome", eletome_bg..eletome_machine)
	end

	-- Clicked Machine bwd/fwd button on Machine page
	if fields.mach_bwd_fwd then
		local page_num = string.match(fields.mach_bwd_fwd, "%s(%w+)%s")
		local mach_value = fields.description

		local eletome_bg =  eletome.tome_bg..show_back
		local eletome_machine = eletome.machines(mach_value,page_num)

		minetest.show_formspec(player:get_player_name(), "elepower_tome:tome", eletome_bg..eletome_machine)
	end

	-- Clicked Instructions page
	if fields.instructions then
		local eletome_bg =  eletome.tome_bg..show_back
		local eletome_instruct = eletome.instructions_page(fields.description)

		minetest.show_formspec(player:get_player_name(), "elepower_tome:tome", eletome_bg..eletome_instruct)
	end

	-- Clicked Large Image page
	if fields.large_image then
		local eletome_bg =  eletome.tome_bg..show_back
		local eletome_lrg_img = eletome.large_image_page(fields.description)

		minetest.show_formspec(player:get_player_name(), "elepower_tome:tome", eletome_bg..eletome_lrg_img)
	end

	-- Clicked Help page
	if fields.help then
		local eletome_bg =  eletome.tome_bg..show_back
		local eletome_how_use = eletome.how_use_page(fields.help)
		minetest.show_formspec(player:get_player_name(), "elepower_tome:tome", eletome_bg..eletome_how_use)
	end

	-- Clicked How to use page
	if fields.description == "action:machine-ele_user" then

		local how_use = false
		local node_name
		for k,v in pairs(eletome.ai.nodes) do
			 if fields[k] then
				if eletome.ai.nodes[k].how_use_1 then
					how_use = true
					node_name = k
				end
			 end

		end

		if how_use then
			local eletome_bg =  eletome.tome_bg..show_back
			local eletome_how_use = eletome.how_use_page(node_name)
			minetest.show_formspec(player:get_player_name(), "elepower_tome:tome", eletome_bg..eletome_how_use)
		end
	end

--minetest.debug(dump(fields))
end)

-------------------
-- Page Defaults --
-------------------

eletome.tome_bg = "formspec_version[4]size[18,11]"..
				  "bgcolor[#003782;true]"..           -- fails (my understanding limitation)
				  "box[0.0,0.0;18,11;#003782]"..      -- workaround the above
				  "box[0.5,0.5;8.5,10;#d1caaeFF]"..
				  "box[9.0,0.5;8.5,10;#d1caaeFF]"..
				  "style_type[button;bgcolor=#003782]"..
				  "style_type[button_exit;bgcolor=#003782]"..
				  "button[0,0;2.5,0.5;content;Content]"..
				  "style[fake_back;textcolor=#777777]"..
				  "button[2.5,0;2.5,0.5;fake_back;Back]"..
				  "style[fake_prev_page;textcolor=#777777]"..
				  "button[12.5,0;2.5,0.5;fake_prev_page;<<   Prev]"..
				  "style[fake_next_page;textcolor=#777777]"..
				  "button[15,0;2.5,0.5;fake_prev_page;Next   >>]"..
				  "button_exit[17.5,0;0.5,0.5;X;X]"

eletome.back_button = "style[back;textcolor=#ffffff]".."button[2.5,0;2.5,0.5;back;Back]"
eletome.font_color = "#1f1f1fFF"
eletome.y_space_line = 0.4
eletome.char_per_line = 60
eletome.tooltip_color = "#30434c;#f9f9f9"

-- Common style components - some end duplicates but kept for ease of reading/updating later
 -- s = start ie pre text
 -- e = end ie post text
-- Used for hypertext
eletome.common_styles = {
                         style_h0s  = "<style color="..eletome.font_color.." size=26><b><center>",
                         style_h0e  = "</center></b></style>",
                         style_h1s  = "<style color="..eletome.font_color.." size=20><b><center>",
                         style_h1e  = "</center></b></style>",
                         style_h2s  = "<style color="..eletome.font_color.." size=18><center>",
                         style_h2e  = "</center></style>",
                         style_h3s  = "<style color="..eletome.font_color.." size=14><center>",
                         style_h3e  = "</center></style>",  -- approximate default "label" size
                         style_h4s  = "<style color="..eletome.font_color.." size=12><center>",
                         style_h4e  = "</center></style>"
						}
