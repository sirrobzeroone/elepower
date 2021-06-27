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
--            Machines/Node Crafters             --
---------------------------------------------------

function eletome.machines(machine,page_num)
	-- remove "action:" from string
	local raw_mach_input = string.match(machine, ":(.*)")
	
	-- split on "-" to remove "machine"
	local machine_split = string.split(raw_mach_input,"-")
	local machine_name = machine_split[2]
	local mach_group
	
	if machine_name == "ele_provider" then
		machine_name = "Generators"
		mach_group = "ele_provider"
	elseif machine_name == "ele_storage" then
		machine_name = "Powercells"
		mach_group = "ele_storage"
	elseif machine_name == "ele_user" then
		machine_name = "Machine"
		mach_group = "ele_user" 
	end
	
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
	
	-- Additional Info Table
	local add_info = eletome.ai
	
	local sort_by         = add_info[machine_name:lower()].sort_by or nil
	local instructions    = add_info[machine_name:lower()].instruct or nil
	-----------------------
	-- Machine left page --
	-----------------------
	local heading_lp      = "hypertext[0.5,0.70;8.5,1.1;ass_mach_lp_h;"..sty_h0s..mach_name..sty_h0e.."]"
	local head_sub_lp_ov  = "hypertext[0.5,1.4;8.5,1.0;mach_lp_sh_ov;"..sty_h1s.."Overview"..sty_h1e.."]"	
	local lp_txt_space    = 0
	local ov_lp_img       = add_info[machine_name:lower()].img or ""
		if ov_lp_img ~= "" then
			if instructions then
				ov_lp_img = "style_type[image_button;bgimg=elepower_tome_bgimg_1.png]"..
							"image_button[2.25,6.6;5,3.75;"..add_info[machine_name:lower()].img..";instructions;]"..
					        "tooltip[2.25,6.6;5,3.75;Click for detailed\ninstructions;"..eletome.tooltip_color.."]"..
							"hypertext[0.5,10.1;8,0.5;large_image;"..sty_h4s..
							 "<action name=machine-"..machine_name..">Larger Image</action>"..						
							 sty_h4e.."]"
			else
				ov_lp_img = "image[2.25,6.6;5,3.75;"..add_info[machine_name:lower()].img.."]"
			end
		else
			lp_txt_space    = 3.75
		end	
	local ov_lp_txt       = "hypertext[0.75,2.1;8.0,"..(4.5+lp_txt_space)..";mach_lp_ov_text;"..sty_h4s..(add_info[machine_name:lower()].over or "")..sty_h4e.."]"

	------------------------
	-- Machine right page --
	------------------------
	
	-- Get list of nodes
	local mach_nodes
	local mach_sort = {}
	local mach_key = {}
	
	if mach_group then
		mach_key, mach_sort = eletome.get_nodes_in_group(mach_group)
		
	else
		local mach_nodes = add_info[machine_name:lower()].part or {}
		
		for k,node_name in pairs(mach_nodes) do
			table.insert(mach_sort,minetest.registered_items[node_name].description)
			mach_key[minetest.registered_items[node_name].description] = node_name
		end
	end
	
	-- Sort the table
	if sort_by ~= nil then
		if sort_by ~= "no_sort" then		
			-- Sort values by any field avliable in node registration
			mach_sort, mach_key = eletome.sort_by(sort_by,mach_sort,mach_key)
		end
	else
		-- default sort is by node.description which can work in
		-- unexpected ways due to translation wrapper. 
		table.sort(mach_sort)
	end
			
	local y_off = 0
	local recipe_cnt = 1
	local machine_list_rdy = {}

	-- Recipe output for each node that makes up machine
	for k,name_des in pairs(mach_sort) do
		local name_reg = mach_key[name_des]
		local m_recipe = "style_type[item_image_button;bgimg=elepower_tome_bgimg_2.png]"
		local recipe = minetest.get_craft_recipe(name_reg)
		local x_cnt = 1		
		local x_off = 0
		local no_items = 0
		
		-- additional info variables
		local lb_top_img = "unknown"
		local lb_top_tt
		local lb_mid_img
		local lb_mid_tt
		local lb_btm_img = tostring(minetest.registered_items[name_reg].ele_usage or 0)
			if mach_name == "Powercells" then
				lb_btm_img = minetest.registered_items[name_reg].ele_output or 0
			end
		local lb_btm_tt  = " EpUs per second"
		local mb_title_txt
		local mb_recipe_items
		local how_use

		-- Check for custom values in additional info and set
		if add_info.nodes[name_reg] then
			lb_top_img = add_info.nodes[name_reg].lb_top_img or "unknown"
			lb_top_tt  = add_info.nodes[name_reg].lb_top_tt or nil
			lb_mid_img = add_info.nodes[name_reg].lb_mid_img or nil
			lb_mid_tt  = add_info.nodes[name_reg].lb_mid_tt or nil
			
			-- don't overwrite this value if additional info value dosent exist
			-- ie retain ele_usage for node
			if add_info.nodes[name_reg].lb_btm_img then
				lb_btm_img = add_info.nodes[name_reg].lb_btm_img
			end
			
			lb_btm_tt  = add_info.nodes[name_reg].lb_btm_tt or " EpUs per second"
			mb_title_txt = add_info.nodes[name_reg].mb_title_txt or nil
			mb_recipe_items = add_info.nodes[name_reg].mb_recipe_items or nil
			how_use	= add_info.nodes[name_reg].how_use_1 or nil 
		end
		
		-- catch empty recipe.items and check new crafts
		-- and if not there set flag to not crash.
		if not recipe.items then
			
			-- check elepower crafts
			recipe  = eletome.get_craft_recipe(name_reg)				
			
			-- final catch to prevent crash
			if not recipe.craft_name then			
				
				-- check for additional information
				if mb_recipe_items then				
					recipe.items = mb_recipe_items
					recipe.craft_name = mb_title_txt
					recipe.craft_des = mb_title_txt											
				else
					no_items = 1
				end
			end				
		end		
		
		-- Layout output per node is 3 large squares 
		   -- 1st square input summary /power usage summary (background)
		   -- 2nd square is items to craft                  (nil-background)
		   -- 3rd square large image of node                (background)
				
           --  	       1st		 2nd	   3rd
  		   --		--------- --------- ---------
  		   --		|  |_|  | |__|_|__| ||     ||
  		   --		|  |_|  | |__|_|__| ||     ||
  		   --	    |  |_|  | |__|_|__| ||_____||
  		   --		--------- --------- ---------
		
		-- background box's 1 and 3 and large node image
		m_recipe = m_recipe.."image["..(9.25)..","..(1+y_off)..";2.4,2.4;elepower_tome_bgimg_2.png]"
		m_recipe = m_recipe.."image["..(14.75)..","..(1+y_off)..";2.4,2.4;elepower_tome_bgimg_2.png]"
		
		--3rd square item
		m_recipe = m_recipe.."item_image_button["..(14.85)..","..(1+y_off+0.1)..";2.2,2.2;"..mach_key[name_des]..";"..mach_key[name_des]..";]"
		
		if how_use then
			m_recipe = m_recipe.."image["..(14.80)..","..(1+y_off+0.05)..";0.4,0.4;elepower_gui_icon_info.png]"
			m_recipe = m_recipe.."tooltip["..(14.80)..","..(1+y_off+0.05)..";0.4,0.4; Click for\nHow to use;"..eletome.tooltip_color.."]"
			
		end
		
		-- 1st square items
		
		-- Top Item
		-- display reg craftitem or image
		if eletome.is_image(lb_top_img) then
			m_recipe = m_recipe.."image["..(10.15)..","..(1+y_off)..";0.75,0.75;"..lb_top_img.."]"			
			
			if lb_top_tt then			
				m_recipe = m_recipe.."tooltip["..(10.15)..","..(1+y_off)..";0.75,0.75;"..lb_top_tt..";"..eletome.tooltip_color.."]"	
			end
		else
			m_recipe = m_recipe.."item_image_button["..(10.15)..","..(1+y_off)..";0.75,0.75;"..lb_top_img..";"..lb_top_img..";]"
			if lb_top_tt then			
				m_recipe = m_recipe.."tooltip["..lb_top_img..";"..lb_top_tt..";"..eletome.tooltip_color.."]"
			end
		end
		
		-- Middle Item
		-- display node created or image 
		if eletome.is_image(lb_mid_img) then
			m_recipe = m_recipe.."image["..(10.10)..","..(1+y_off+0.9)..";0.85,0.85;"..lb_mid_img.."]"			
			
			if lb_mid_tt then			
				m_recipe = m_recipe.."tooltip["..(10.10)..","..(1+y_off+0.9)..";0.85,0.85;"..lb_mid_tt..";"..eletome.tooltip_color.."]"	
			end
		else
			m_recipe = m_recipe.."item_image_button["..(10.10)..","..(1+y_off+0.9)..";0.85,0.85;"..name_reg..";"..name_reg..";]"
			if lb_mid_tt then			
				m_recipe = m_recipe.."tooltip["..name_reg..";"..lb_mid_tt..";"..eletome.tooltip_color.."]"
			end
		end
		
		-- Bottom Item 
		-- Change power output value from num-text to equivalent
		-- image value - images scale nicer than txt here 
		local i = 1
		local x_of = 0
		
		if eletome.is_image(lb_btm_img) then
			m_recipe = m_recipe.."image["..(10.25+x_of)..","..(1+y_off+1.8)..";0.55,0.55;"..lb_btm_img.."]"
			m_recipe = m_recipe.."tooltip["..(10.25+x_of)..","..(1+y_off+1.8)..";0.55,0.55;"..lb_btm_tt..";"..eletome.tooltip_color.."]"
		else		
			local st_len = string.len(lb_btm_img)

			if st_len <= 4 and tonumber(lb_btm_img) then
				-- depending on txt length we have to offset 
				-- img char start more left 
				-- @ current img size 4 is max supported
				if st_len == 2 then
					x_of = -0.3
				elseif st_len == 3 then
					x_of = -0.6
				elseif st_len == 4 then
					x_of = -0.9			
				end
		
				while i <= st_len do
					local num = string.sub(tostring(lb_btm_img), i, i) or "0"
					m_recipe = m_recipe.."image["..(10.25+x_of)..","..(1+y_off+1.9)..";0.45,0.45;elepower_tome_num_"..num..".png]"
					x_of = x_of+0.35
					i=i+1
				end
				
				m_recipe = m_recipe.."image["..(10.3+x_of)..","..(1+y_off+2.025)..";0.65,0.65;elepower_tome_num_epu.png]"
				m_recipe = m_recipe.."tooltip["..(10.25+x_of+(-0.3*(st_len+1)))..","..(1+y_off+1.9)..";1.5,0.65;"..lb_btm_img..lb_btm_tt..";"..eletome.tooltip_color.."]"
				
			else
				minetest.log("info", "elepower_tome: "..lb_btm_img.." entered value must be 1-4 digits or a string ending in .png")

			end
		
		end	
		
	-- 2nd square items	
	-- Generate the recipe grid view - Middle box	
		local dis_rec,y_add = eletome.gen_craft_grid(recipe,y_off,no_items)
		
		m_recipe = m_recipe..dis_rec
		y_off = y_add
		
		y_off = y_off+1.7
	
	-- Insert record into table and increment counters	
		table.insert(machine_list_rdy,m_recipe)	
		recipe_cnt = recipe_cnt + 1
	
		--reset y_off(set) as these will be on page 2/3 etc
		if recipe_cnt > 3 then
			y_off = 0
			recipe_cnt = 1
		end
	
	end
		
	-- Split machines across 2 or more pages if needed.	
	local max_recipe_pp = 3
	local pg_num = tonumber(page_num) or 1       
	local recipe_rp = ""
	
	local recipe_rp = eletome.p_nav_bwd_fwd(machine,machine_list_rdy,max_recipe_pp,pg_num,"mach_bwd_fwd")	

	---------------------------
	-- Assemble Machine page --
	---------------------------
	local eletome_complex = heading_lp..head_sub_lp_ov..ov_lp_txt..ov_lp_img..recipe_rp
	return eletome_complex

	
end