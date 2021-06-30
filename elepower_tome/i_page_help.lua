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
--                How to use/Help                --
---------------------------------------------------

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
	
	local lp_heading  = "hypertext[0.5,0.7;8.5,0.95;lp_heading;"..sty_h0s..pg_heading..sty_h0e.."]"
	local lp_sub_head = "hypertext[0.5,1.4;8.5,0.9;lp_sub_heading;"..sty_h1s..pg_subhead..sty_h1e.."]"
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