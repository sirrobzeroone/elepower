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


-- Give player elepower tome on initaial logon
minetest.register_on_newplayer(function(player)
	player:get_inventory():add_item("main", "elepower_tome:tome")
end)

-- register our recieve field callback
minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname ~= "elepower_tome:tome" then
		return
	end
	
	-- Clicked contents button on any page.
	if fields.content then
		local eletome_bg = eletome.tome_bg
		local eletome_contents = eletome.contents_page()
		minetest.show_formspec(player:get_player_name(), "elepower_tome:tome", eletome_bg..eletome_contents)
	end
	 
	-- Clicked a craft link on contents
	if fields.craft_click then								
		local eletome_bg = eletome.tome_bg
		local eletome_craft = eletome.craft_page(fields.craft_click)
		
		minetest.show_formspec(player:get_player_name(), "elepower_tome:tome", eletome_bg..eletome_craft)
	end	

	-- Clicked craft bwd/fwd button on craft sub-page
	if fields.craft_bwd_fwd then				
		local page_num = string.match(fields.craft_bwd_fwd , "%s(%w+)%s")
		-- eletome.craft_page() expects description in format "something:craft_description"
		local craft_value = "cd:"..fields.description
		
		local eletome_bg = eletome.tome_bg
		local eletome_craft = eletome.craft_page(craft_value,page_num)
		
		minetest.show_formspec(player:get_player_name(), "elepower_tome:tome", eletome_bg..eletome_craft)
	end
	
	-- Clicked Machine page
	if fields.machine then		
		local eletome_bg = eletome.tome_bg
		local eletome_machine = eletome.machines(fields.machine)
				
		minetest.show_formspec(player:get_player_name(), "elepower_tome:tome", eletome_bg..eletome_machine)
	end	

	-- Clicked Machine bwd/fwd button on Machine page
	if fields.mach_bwd_fwd then	
		local page_num = string.match(fields.mach_bwd_fwd, "%s(%w+)%s")
		local mach_value = fields.description
		
		local eletome_bg = eletome.tome_bg
		local eletome_machine = eletome.machines(mach_value,page_num)
		
		minetest.show_formspec(player:get_player_name(), "elepower_tome:tome", eletome_bg..eletome_machine)
	end

	-- Clicked Instructions page
	if fields.instructions then
		local eletome_bg = eletome.tome_bg
		local eletome_instruct = eletome.instructions_page(fields.description)
		
		minetest.show_formspec(player:get_player_name(), "elepower_tome:tome", eletome_bg..eletome_instruct)		
	end

	-- Clicked Large Image page
	if fields.large_image then
		local eletome_bg = eletome.tome_bg
		local eletome_lrg_img = eletome.large_image_page(fields.description)
		
		minetest.show_formspec(player:get_player_name(), "elepower_tome:tome", eletome_bg..eletome_lrg_img)		
	end

	-- Clicked Help page
	if fields.help then
		local eletome_bg = eletome.tome_bg
		local eletome_how_use = eletome.how_use_page(fields.help)
		minetest.show_formspec(player:get_player_name(), "elepower_tome:tome", eletome_bg..eletome_how_use)	
	end

	-- Clicked How to use page
	if fields.description == "action:machine-ele_user" then
		
		local how_use = false
		local node_name
		for k,v in pairs(eletome.ai.nodes) do
			 if fields[k] then
				if eletome.ai.nodes[k].how_use then
					how_use = true
					node_name = k
				end
			 end
		
		end
		
		if how_use then
			local eletome_bg = eletome.tome_bg
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
						
function eletome.instructions_page(machine)
	-- instructions page structured as 2 pages ie an open book 
	-- a single column on left page and single column on the right
    -- machine structure; description = "action:machine-Miner"
	
		-- remove "description = action:machine-" from string
	local machine_name = string.match(machine, "-(.*)")
	
		-- remove "_"
	local mach_name = string.gsub(machine_name,"_", " ")
	
	
	-- Assign Common styles to local vars
	local sty_h0s  = eletome.common_styles.style_h0s
	local sty_h0e  = eletome.common_styles.style_h0e
	local sty_h1s  = eletome.common_styles.style_h1s
	local sty_h1e  = eletome.common_styles.style_h1e
	local sty_h2s  = eletome.common_styles.style_h2s
	local sty_h2e  = eletome.common_styles.style_h2e			
	local sty_h3s  = eletome.common_styles.style_h3s 
	local sty_h3e  = eletome.common_styles.style_h3e
	local sty_h4s  = eletome.common_styles.style_h4s
	local sty_h4e  = eletome.common_styles.style_h4e

	function file_exists(img_name)
	   local file=io.open(img_name,"r")
	   if file~=nil then 
			io.close(file) 
			return true 
	   else 
			return false 
	   end
	end

	---------------
	-- left page --
	---------------
	local lp_heading  = "hypertext[0.5,0.7;8.5,1.1;lp_heading;"..sty_h0s..mach_name..sty_h0e.."]"
	local lp_sub_head = "hypertext[0.5,1.4;8.5,1.0;lp_sub_heading;"..sty_h1s.."Instructions"..sty_h1e.."]"	
	local lp_content  = ""
	local rp_content  = ""
	local li = 1 
	local ri = 4	
		
	while li <= 3 do	
		local img_path = modpath.."/textures/eletome_instructions_"..machine_name:lower().."_".. li ..".png"
		local file_check = file_exists(img_path)
		
		if file_check then
			if (li % 2 == 0) then -- even
				lp_content = lp_content.."image[4.5,"..(2.0+(2.5*(li-1)))..";4,3;eletome_instructions_"..machine_name:lower().."_".. li ..".png]"
			else
				lp_content = lp_content.."image[1.00,"..(2.0+(2.5*(li-1)))..";4,3;eletome_instructions_"..machine_name:lower().."_".. li ..".png]"
			end			
		else
			break		
		end
		
		li=li+1
	end
	
	----------------
	-- right page --
	----------------	
	while ri <= 7 do
		local img_path = modpath.."/textures/eletome_instructions_"..machine_name:lower().."_".. ri ..".png"
		local file_check = file_exists(img_path)
		
		if file_check then
			if (ri % 2 ~= 0) then -- odd
				rp_content = rp_content.."image[13,"..(0.26+(2.4*(ri-4)))..";4,3;eletome_instructions_"..machine_name:lower().."_".. ri ..".png]"
			else
				rp_content = rp_content.."image[9.5,"..(0.26+(2.4*(ri-4)))..";4,3;eletome_instructions_"..machine_name:lower().."_".. ri ..".png]"
			end			
		else
			break		
		end
		
		ri=ri+1
	end


	-------------------
	-- Assemble page --
	-------------------
	local eletome_inst = lp_heading..lp_sub_head..lp_content..rp_content

	return eletome_inst
end


function eletome.large_image_page(machine)
	-- Page to view the complex machine image large size
	
		-- remove "description = action:machine-" from string
	local machine_name = string.match(machine, "-(.*)")
			
		-- remove "_"
	local mach_name = string.gsub(machine_name,"_", " ")
	
		-- Assign Common styles to local vars
	local sty_h0s  = eletome.common_styles.style_h0s
	local sty_h0e  = eletome.common_styles.style_h0e 
	
	local heading  = "hypertext[0.5,0.7;17.5,1.1;lp_heading;"..sty_h0s..mach_name..sty_h0e.."]"
	local image    ="style_type[image_button;bgimg=elepower_tome_bgimg_1.png]"..
							"image_button[2.33,0.5;13.33,10;"..eletome.ai[machine_name:lower()].img..";instructions;]"..
					        "tooltip[2.33,0.5;13.33,10;Click for detailed\ninstructions;"..eletome.tooltip_color.."]"
	

	-- Pass page reference value to player recieve fields when fwd/bwd pressed - not visible on formspec
	heading  = heading .."field[10,12;1,0.5;description;;action:machine-"..machine_name.."]"
	
	local eletome_lrg_img = image..heading
	
	return eletome_lrg_img
end

function eletome.how_use_page(name_value)
	-- Page to view how to use a node/getting started
--"action:getting_started"
--"elepower_machines:electrolyzer" = ""	

	local t_split = string.split(name_value,":")
	local is_help = false
	
	if t_split[1] == "action" then
		is_help = true
	end

	-- get page heading and sub-heading
	local pg_heading
	local pg_subhead
	
	if is_help then
		pg_heading = string.gsub(t_split[2],"_", " ")
		-- change all 1st letters to upper - 
		-- https://stackoverflow.com/questions/20284515/capitalize-first-letter-of-every-word-in-lua
		pg_heading =  string.gsub(" "..pg_heading, "%W%l", string.upper):sub(2)
		pg_subhead = "Help"
		name_value = t_split[2]
	else
		pg_heading = minetest.registered_nodes[name_value].description
		pg_subhead = "How to use"
	end
	
	-- Assign Common styles to local vars
	local sty_h0s  = eletome.common_styles.style_h0s
	local sty_h0e  = eletome.common_styles.style_h0e
	local sty_h1s  = eletome.common_styles.style_h1s
	local sty_h1e  = eletome.common_styles.style_h1e
	local sty_h2s  = eletome.common_styles.style_h2s
	local sty_h2e  = eletome.common_styles.style_h2e			
	local sty_h3s  = eletome.common_styles.style_h3s 
	local sty_h3e  = eletome.common_styles.style_h3e
	local sty_h4s  = eletome.common_styles.style_h4s
	local sty_h4e  = eletome.common_styles.style_h4e

	-- Additional Info Table
	local add_info = eletome.ai.nodes

	---------------
	-- left page --
	---------------
	local left_image  = add_info[name_value].hu_img_1 or "elepower_tome_empty.png"
	local lp_offset   = 0
	
	if left_image == "elepower_tome_empty.png" then
		lp_offset   = 3.75
	end
	
	if type(left_image) == "table" then
		left_image = add_info[name_value].hu_img_1[1]		
	else
		left_image = "image[2.25,6.6;5,3.75;"..left_image.."]"
	end
	
	local lp_heading  = "hypertext[0.5,0.7;8.5,1.1;lp_heading;"..sty_h0s..pg_heading..sty_h0e.."]"
	local lp_sub_head = "hypertext[0.5,1.4;8.5,1.0;lp_sub_heading;"..sty_h1s..pg_subhead..sty_h1e.."]"
	local lp_image    = left_image
	local lp_text     = "hypertext[0.75,2.1;8.0,"..(4.5+lp_offset)..";use_txt;"..sty_h4s..(add_info[name_value].how_use_1 or "")..sty_h4e.."]"
	----------------
	-- Right page --
	----------------
	local right_image = add_info[name_value].hu_img_2 or "elepower_tome_empty.png"
	local right_txt = add_info[name_value].how_use_2 or ""
	local rp_txt_offset   = 0
	local rp_img_offset   = 0
	
	if right_image == "elepower_tome_empty.png" then
	rp_txt_offset   = 3.75
	end

	if right_txt == "" or right_txt == nil then
		rp_img_offset   = -6.1	
	end
	
	if type(right_image) == "table" then
		right_image = "container[9.25,"..(6.6+rp_img_offset).."]"..add_info[name_value].hu_img_2[1].."container_end[]"		
	else
		right_image = "image[10.75,"..(6.6+rp_img_offset)..";5,3.75;"..right_image.."]"
	end	
	
	local rp_text     = "hypertext[9.25,1.4;8.0,"..(4.5+rp_txt_offset)..";use_txt;"..sty_h4s..right_txt..sty_h4e.."]"
	local rp_image    = right_image
	
	local eletome_how_use = lp_heading..lp_sub_head..lp_image..lp_text..rp_text ..rp_image
	
	return eletome_how_use
end