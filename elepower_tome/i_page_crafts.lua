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
--                  Crafts Page                  --
---------------------------------------------------

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
	local heading_lp      = "hypertext[0.5,0.7;8.5,1.1;craft_lp_h;"..sty_h0s..craft_description..sty_h0e.."]"
	local head_sub_lp_ov  = "hypertext[0.5,1.4;8.5,1.0;craft_lp_sh_ov;"..sty_h1s.."Overview"..sty_h1e.."]"
	local ov_lp_txt       = "hypertext[0.75,2.1;8.0,5.5;craft_lp_ov_text;"..sty_h3s..craft_click[craft_type].overview..sty_h3s.."]"
	
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

	local machines_lp = "style_type[item_image_button;bgimg=elepower_tome_bgimg_2.png]"
	local y_m_row = 0      --multiple rows of machines
	for k,def in pairs(mach_names)do	
		if #mach_names == 1 then
			machines_lp = machines_lp.."item_image_button[4,"..(5.6+y_offset+y_m_row)..";1.25,1.25;"..def[1]..";"..def[2]..";]"..
						 "hypertext[0.5,"..(7+y_offset+y_m_row)..";8.4,1;craft_mach_lab;"..sty_h3s..def[2]..sty_h3s.."]"
		
		else
			if (k % 2 == 0) then  -- even key 
				machines_lp = machines_lp.."item_image_button[6,"..(5.6+y_offset+y_m_row)..";1.25,1.25;"..def[1]..";"..def[2]..";]"..
									 "hypertext[4.5,"..(7+y_offset+y_m_row)..";4.5,1;craft_mach_lab;"..sty_h3s..def[2]..sty_h3s.."]"
				y_m_row = y_m_row + 2.5
			else                  -- odd key
				machines_lp = machines_lp.."item_image_button[2,"..(5.6+y_offset+y_m_row)..";1.25,1.25;"..def[1]..";"..def[2]..";]"..
									 "hypertext[0.5,"..(7+y_offset+y_m_row)..";4.5,1;craft_mach_lab;"..sty_h3s..def[2]..sty_h3s.."]"
			end	
		end
	end
	---------------------------
	-- Craft page right page --
	---------------------------	
	local head_sub_rp_rec      = "hypertext[9.5,0.7;8.5,1.0;craft_lp_h;"..sty_h1s.."Recipes"..sty_h1e.."]"
	
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
			recipe_cnt = 1
		end

	end
	
	-- Split recipes across 2 or more pages if needed.
	local max_recipe_pp = 24 -- 2 columns
	local pg_num = tonumber(page_num) or 1       
	local i = 1
	
	if recipe_list_rdy.columns == 3 then
		max_recipe_pp = 36
	end
	
	local recipe_rp = eletome.p_nav_bwd_fwd(craft_description,recipe_list_rdy,max_recipe_pp,pg_num,"craft_bwd_fwd")
	
	-------------------------
	-- Assemble craft page --
	-------------------------
	local eletome_craft = heading_lp..head_sub_lp_ov..ov_lp_txt..machines_lp..
						  head_sub_rp_rec..recipe_rp
	
	return eletome_craft

end