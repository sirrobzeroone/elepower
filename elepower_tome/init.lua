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

-- register our Tome item
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
	
	-- Clicked contents button any page.
	if fields.content then
		local eletome_bg = eletome.tome_bg
		local eletome_contents = eletome.contents_page()
		minetest.show_formspec(player:get_player_name(), "elepower_tome:tome", eletome_bg..eletome_contents)
	end
	 
	-- Clicked a craft link on contents
	if fields.content_rp_cl_craft_txt or fields.content_rp_cr_craft_txt then		
		
		local craft_value = fields.content_rp_cl_craft_txt or fields.content_rp_cr_craft_txt								
		local eletome_bg = eletome.tome_bg
		local eletome_craft = eletome.craft_page(craft_value)
		
		minetest.show_formspec(player:get_player_name(), "elepower_tome:tome", eletome_bg..eletome_craft)
	end	

	-- Clicked fwd/bwd button on craft sub-page
	if fields.craft_page_fwd or fields.craft_page_bwd then
	
		-- eletome.craft_page() expects description in format "something:craft_description"
		
		local craft_page_fwd = fields.craft_page_fwd or ""
		local craft_page_bwd = fields.craft_page_bwd or ""	
		
		local page_num = string.match(craft_page_fwd, "%s(%w)%s")
		
		if not page_num then
			local page_num = string.match(craft_page_bwd, "%s(%w)%s")
		end
		
		local craft_value = "cd:"..fields.craft_description
		local eletome_bg = eletome.tome_bg
		local eletome_craft = eletome.craft_page(craft_value,page_num)
		
		minetest.show_formspec(player:get_player_name(), "elepower_tome:tome", eletome_bg..eletome_craft)

	end
	
	--minetest.debug(dump(fields))
end)		
----------------
-- Tome Pages --
----------------

eletome.tome_bg = "formspec_version[4]size[18,11]"..
				  "bgcolor[#003782;true]"..           -- fails (my understanding limitation)
				  "box[0.0,0.0;18,11;#003782]"..      -- workaround the above							  
				  "box[0.5,0.5;8.5,10;#d1caaeFF]"..
				  "box[9.0,0.5;8.5,10;#d1caaeFF]"..
				  "button_exit[17.5,0;0.5,0.5;X;X]"..
				  --"label[3.5,10.75;Elepower Tome]"..
				  --"label[11.5,10.75;Elepower Tome]"..
				  "button[0,0;2,0.5;content;Content]"

-- Common style components - some end duplicates but kept for ease of reading/updating later
 -- s = start ie pre text
 -- e = end ie post text
eletome.font_color = "#1f1f1fFF"
eletome.y_space_line = 0.4
eletome.char_per_line = 60 

-- Used for hypertext 
eletome.common_styles = {
						 style_h0s  = "<style color="..eletome.font_color.." size=26><b><center>",
						 style_h0e  = "</center></b></style>",
						 style_h1s  = "<style color="..eletome.font_color.." size=20><b><center>",
						 style_h1e  = "</center></b></style>",
						 style_h2s  = "<style color="..eletome.font_color.." size=18><center>",
						 style_h2e  = "</center></style>",
						 style_h3s  = "<style color="..eletome.font_color.." size=16><center>",
						 style_h3e  = "</center></style>",  -- approximate default "label" size
						 style_h4s  = "<style color="..eletome.font_color.." size=12><center>",
						 style_h4e  = "</center></style>"
						 
						}

function eletome.contents_page()
	-- Contents page structured as 2 pages ie an open book 
	-- a single column on left page and 2 columns on right page

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

	-- Contents page left page Content

	local content_lp_txt = "Elepower adds power to a game, Power is referred to in units and these units are referred to as EpU (Elepower Unit).\nNew crafts are added to the game as well as machines to enable these new crafts and make use of EpU/s.\n\nA big thank you to IcyDiamond the orginal creator of this mod."

	local heading_lp = "hypertext[0.50,1.0;8.5,10;content_lp_h_tome;"..sty_h0s.."Elepower\nTome"..sty_h0e.."]"
	local content_lp = "hypertext[0.75,2.5;8.0,8;content_lp_c_text;"..sty_h3s..content_lp_txt..sty_h3s.."]"


	-- Contents page right page Content
	local heading_rp        = "hypertext[9.0,1.0;8.5,9.0;content_rp_h_cont;"..sty_h1s.."Contents"..sty_h1e.."]"			
	local heading_rp_craft  = "hypertext[9.0,1.5;8.5,7.5;content_rp_sh_crafts;"..sty_h2s.."Crafts"..sty_h2e.."]"
				
	local raw_all_crafts = table.copy(elepm.craft.types)
	local all_crafts     = {}
						   -- Gets the Human readable craft name
						   -- and sorts them alphabetically
						   for k,def in pairs(raw_all_crafts) do
								table.insert(all_crafts,def.description)
						   end
						   table.sort(all_crafts)
						   
						   -- Generate the craft_content section
						   -- 2 columns of h2 headings down the page
						   local left_col = ""
						   local rght_col = ""
						   for k,craft_name in pairs(all_crafts) do									
								if (k % 2 == 0) then  -- even key - backwards fix this left should be odd....
									left_col = left_col.."<action name="..craft_name..">"..craft_name.."</action>".."\n"
								else                  -- odd key
									rght_col = rght_col.."<action name="..craft_name..">"..craft_name.."</action>".."\n"
								end								   
						   end

	local craft_rp_txt     = "hypertext[09.0,2.0;4.5,7.0;content_rp_cl_craft_txt;"..sty_h3s..left_col..sty_h3e.."]"..
							 "hypertext[13.5,2.0;4.5,7.0;content_rp_cr_craft_txt;"..sty_h3s..rght_col..sty_h3e.."]"
	local heading_rp_mach  = "hypertext[09.0,4.5;8.5,6.5;content_rp_sh_mach;"..sty_h2s.."Machines"..sty_h2e.."]"					  

	local subhead_mach_gen = "hypertext[09.0,4.8;8.5,6.5;content_rp_sh_gen;"..sty_h3s.."Generators"..sty_h3e.."]"

							-- remove all "active" version of providers and 2nd half any descriptions with "\n"
							local i = 1
						    local lft_col = ""
						    local rht_col = ""
							local mach_sort = {}
							local mach_key  = {}
							for name, def in pairs(minetest.registered_nodes) do
								if def.groups["ele_provider"] then
									if not string.find(name, "active") then
										local description = def.description
										
										if string.find(description,"\n") then
											description = string.match(description,"(.+)\n")
										end
										table.insert(mach_sort,description)
										mach_key[description] = name
									end
								end
							end
							
							table.sort(mach_sort)
							
							for k,des in pairs(mach_sort) do								
								if (k % 2 == 0) then  -- even key 
									rht_col = rht_col.."<action name="..mach_key[des]..">"..des.."</action>".."\n"
								else                  -- odd key
									lft_col = lft_col.."<action name="..mach_key[des]..">"..des.."</action>".."\n"
								end	
							end
							
	local mach_rp_gen_txt  = "hypertext[09.0,5.2;4.5,7.0;content_rp_cl_mach_txt;"..sty_h4s..lft_col..sty_h4e.."]"..
							 "hypertext[13.5,5.2;4.5,7.0;content_rp_cr_mach_txt;"..sty_h4s..rht_col..sty_h4e.."]"
 
	
	-- Assemble contents page
	local eletome_cont = heading_lp..content_lp..
						 heading_rp..heading_rp_craft..craft_rp_txt
						 --heading_rp_mach..subhead_mach_gen..mach_rp_gen_txt

	return eletome_cont
end

function eletome.craft_page(craft_description,page_num)
	-- remove "action:" from string
	local craft_description = string.match(craft_description, ":(.*)")
		
	-- Convert craft_description back to craft
	local raw_all_crafts = table.copy(elepm.craft.types)
	local craft_click = {}
	local craft_type
	for craft_name,def in pairs(raw_all_crafts) do		
		if def.description == craft_description then
			craft_click[craft_name] = def
			craft_type = craft_name
		end	
	end

		if craft_click == "nil" then
			minetest.debug("error")
		end
	-- Craft page structured as 2 pages ie an open book 
	-- a single column on left page and single column 
	-- on the right page.	

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
	
	--------------------------
	-- Craft page left page --
	--------------------------
	local heading_lp      = "hypertext[0.5,1.0;8.5,9.0;craft_lp_h;"..sty_h0s..craft_description..sty_h0e.."]"
	local head_sub_lp_ov  = "hypertext[0.5,1.5;8.5,7.5;craft_lp_sh_ov;"..sty_h1s.."Overview"..sty_h1e.."]"
	local ov_lp_txt       = "hypertext[0.75,2.0;8.0,7.0;craft_lp_ov_text;"..sty_h3s..craft_click[craft_type].overview..sty_h3s.."]"
	
	-- calculate approximatly how many lines "overview" takes
	local length = string.len(craft_click[craft_type].overview)
	local cpl = eletome.char_per_line
	local num_lines = math.ceil(length/cpl)	
	local y_offset = num_lines*eletome.y_space_line
	
	-- Find machines that do craft
		local mach_names = {}
		
		for name,def in pairs(minetest.registered_nodes)do
			if def.craft_type == craft_type then
				if def.ele_active_node and string.find(name,"active") then -- only insert active version of machine
					table.insert(mach_names,{name,def.description})
				
				elseif not def.ele_active_node then
					table.insert(mach_names,{name,def.description})
				end
			end
		end

	local machines_lp = "style_type[item_image_button;bgimg=elepower_tome_bqimg1.png]"
	local y_m_row = 0      --multiple rows of machines
	for k,def in pairs(mach_names)do	
		if #mach_names == 1 then
			machines_lp = machines_lp.."item_image_button[4,"..(2.7+y_offset+y_m_row)..";1.25,1.25;"..def[1]..";"..def[2]..";]"..
						 "hypertext[0.5,"..(4+y_offset+y_m_row)..";8.4,1;craft_mach_lab;"..sty_h3s..def[2]..sty_h3s.."]"
		
		else
			if (k % 2 == 0) then  -- even key 
				machines_lp = machines_lp.."item_image_button[6,"..(2.7+y_offset+y_m_row)..";1.25,1.25;"..def[1]..";"..def[2]..";]"..
									 "hypertext[4.5,"..(4+y_offset+y_m_row)..";4.5,1;craft_mach_lab;"..sty_h3s..def[2]..sty_h3s.."]"
				y_m_row = y_m_row + 2.5
			else                  -- odd key
				machines_lp = machines_lp.."item_image_button[2,"..(2.7+y_offset+y_m_row)..";1.25,1.25;"..def[1]..";"..def[2]..";]"..
									 "hypertext[0.5,"..(4+y_offset+y_m_row)..";4.5,1;craft_mach_lab;"..sty_h3s..def[2]..sty_h3s.."]"
			end	
		end
	end
	---------------------------
	-- Craft page right page --
	---------------------------	
	local head_sub_rp_rec      = "hypertext[9.5,1.0;8.0,9.0;craft_lp_h;"..sty_h1s.."Recipes"..sty_h1e.."]"
	
	local craft_reg_path = elepm.craft[craft_type]
	local recipe_list = {}
	local recipe_list_rdy = {}

	
	if craft_type == "cooking" then
		-- restructure craft recipe inputs/outputs, so easier to output to formspec
		-- recipe_list = {
		--                {input={item1,num},{item2,num},output={item,num}},
		--                {input={item1,num},{item2,num},output={item1,num},{item2,num}} 
		--               }	
		
		for name,def in pairs(minetest.registered_items) do
			local recipe = minetest.get_all_craft_recipes(name)
			
			if recipe ~= nil then				
				for k,def in pairs(recipe) do
					if def.method == "cooking" and def.output ~= "" then					
						if string.find(def.items[1],"group") then
							def.items[1] = string.gsub(def.items[1],"group","default")
						end
						-- This structure matches below, double table nesting a bit redundant
						
						table.insert(recipe_list,{input = {{def.items[1],1}},output = {{def.output,1}}})					
					end
				end				
			end			
		end

	else	
		-- restructure craft recipe inputs/outputs, so easier to output to formspec
		-- recipe_list = {
		--                {input={item1,num},{item2,num},output={item,num}},
		--                {input={item1,num},{item2,num},output={item1,num},{item2,num}} 
		--               }
		
		for k,v in pairs(craft_reg_path) do
			local input = {}
			local output = {}
			
			if type(v.output) == "table" then -- very rarly table eg grinding-fuel_rod_depleted
				for k,v in pairs(v.output)do
					local t_out = string.split(v," ")
					table.insert(output,{t_out[1],tonumber(t_out[2]) or 1})
				end
				
			else
				local t_out = string.gsub(tostring(v.output),"ItemStack%(\"","")
				local t_out = string.gsub(t_out,"\"%)","")
				local t_out = string.split(t_out," ")
				table.insert(output,{t_out[1],tonumber(t_out[2]) or 1})
			end
		
			for k2,v2 in pairs(v.recipe)do	
				table.insert(input,{k2,v2}) 
			end

			table.insert(recipe_list,{input = input,output = output})
		end	
			--minetest.debug(dump(recipe_list))
	end
	
	-- build recipe list
	local y_off = 0
	local x_off = 0
	local col_cnt = 1
	local recipe_cnt = 1
	
	for k,def in pairs(recipe_list) do	
		local s_recipe ="style_type[label;font_size=-2;font=bold;textcolor=#FFF]"
		local in_len = #def.input
		local out_len = #def.output
		local columns = 2
		local col_gap = 0.75
		local in_cnt = 1
		
		if (in_len+out_len) == 2 then
			columns = 3 
		end
		
		if (in_len+out_len) == 3 then
			col_gap = 1.5 
		end

		
		for k,def in pairs(def.input) do
			
			s_recipe = s_recipe.."item_image_button["..(9.5 + x_off)..","..(1.5+y_off)..";0.6,0.6;"..def[1]..";"..def[1]..";]"
			s_recipe = s_recipe.."label["..(10 + x_off)..","..(1.99 + y_off)..";"..def[2].."]"
			x_off = x_off+0.7
			
			if in_cnt >= in_len then
				s_recipe = s_recipe.."image["..(9.5 + x_off)..","..(1.5+y_off)..";0.6,0.6;elepower_tome_equals.png]"
				x_off = x_off+0.7
			end
			in_cnt = in_cnt+1
		end
		
		for k,def in pairs(def.output)do
			s_recipe = s_recipe.."item_image_button["..(9.5 + x_off)..","..(1.5+y_off)..";0.6,0.6;"..def[1]..";"..def[1]..";]"
			s_recipe = s_recipe.."label["..(10 + x_off)..","..(1.99 + y_off)..";"..def[2].."]"
			x_off = x_off+0.7
		end
		
		if col_cnt >= columns then
			x_off = 0
			y_off = y_off + 0.7
			col_cnt = 1		
		else
			x_off = x_off+col_gap
			col_cnt = col_cnt + 1
		end
		table.insert(recipe_list_rdy,s_recipe)		
		recipe_list_rdy.columns = recipe_list_rdy.columns or columns
		recipe_cnt = recipe_cnt + 1
		
		--reset y_off(set) as these will be on page 2/3 etc
		if recipe_cnt > recipe_list_rdy.columns*12 then
			y_off = 0
		end

	end
	
	-- Split recipes across 2 or more pages if needed.
	local max_recipe_pp = 24 -- 2 columns
	local num_recipe = #recipe_list_rdy
	local pg_num = tonumber(page_num) or 1       
	local i = 1
	local recipe_rp = ""
	local fwd_page_name = "craft_page_fwd"
	local bwd_page_name = "craft_page_bwd"
	
	
	if recipe_list_rdy.columns == 3 then
		max_recipe_pp = 36
	end
	

	if pg_num > 1 then
		-- Check if we need another fwd button
		if pg_num*max_recipe_pp < num_recipe then
			recipe_rp = recipe_rp.."button[15,0;2.5,0.5;"..fwd_page_name..";Page "..(pg_num + 1).." >>]"
		end		
		-- Always need back button
		recipe_rp = recipe_rp.."button[12.5,0;2.5,0.5;"..bwd_page_name..";<< "..(pg_num - 1).." Page]"
		
	elseif num_recipe > max_recipe_pp then
		recipe_rp = recipe_rp.."button[15,0;2.5,0.5;"..fwd_page_name..";Page "..(pg_num + 1).." >>]"		 
	end
	
	-- Pass craft_description to player recieve fields when fwd/bwd pressed - not visible on formspec
		recipe_rp = recipe_rp.."field[10,12;1,0.5;craft_description;;"..craft_description.."]"
	
	local pg_offset = (pg_num-1)*max_recipe_pp
	i = i+pg_offset
	
	while i <= (max_recipe_pp + pg_offset) and i <= num_recipe do
		recipe_rp = recipe_rp..recipe_list_rdy[i]	
		i=i+1
	end	
	
	-------------------------
	-- Assemble craft page --
	-------------------------
	local eletome_craft = heading_lp..head_sub_lp_ov..ov_lp_txt..machines_lp..
						  head_sub_rp_rec..recipe_rp
	
	return eletome_craft

end








