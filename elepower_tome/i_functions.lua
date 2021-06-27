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
--                   Functions                   --
--------------------------------------------------- 

----------------------------------
--  Determine if a text string  --
--   is for an image or not     --
----------------------------------
function eletome.is_image(text)
   local value = false
   if type(text) == "string" then 
	   if string.find(text,".png") then
		 value = true 
	   end
   end
return value 
end

-----------------------------------------------------------
-- The below gets all the nodes in a group, additionally --
-- it filters out any "_active" versions of the node and --
--    removes any numerical versions of the node > 0     --
--    additionally it removes any node that is not a     --
--         standalone machine as a single node           --
--          two returns mach_key and mach_sort           --
-----------------------------------------------------------
function eletome.get_nodes_in_group(group_name)
	local mach_key = {}
	local mach_sort = {}
	
	for name, def in pairs(minetest.registered_nodes) do
		if def.groups[group_name] then
			-- have to remove registered nodes with same name but 
			-- different number versions eg powercells, also remove
			-- "active" versions
			
			if not string.find(name, "active") and tonumber((string.match(name,"%d+"))or 0) == 0 then
				local description = def.description
				
				if string.find(description,"\n") then
					description = string.match(description,"(.+)\n")
				end
				
				if group_name == "ele_user" and not def.groups["ele_storage"] then
					-- Simple one node machines are found in machine and farming mods, remove pump - complex.
					if name ~= "elepower_machines:pump" and string.find(name,"machines:") or string.find(name,"farming:") then
						table.insert(mach_sort,description)
						mach_key[description] = name
					end

				else
					table.insert(mach_sort,description)
					mach_key[description] = name
				end
			end
		end
	end
	return mach_key, mach_sort
end

-----------------------------------------------------
-- table sorting function which will sort nodes by --
--    any field avaliable on node registration     --
--      Output is mach_sort and mach_key           --
-----------------------------------------------------
function eletome.sort_by(sort_by,mach_sort,mach_key)
			local key = {}
			local sort = {}
			
			-- create new key table using sort_by with
			-- field to sort_by and node.description
			for des,name in pairs(mach_key)do
				table.insert(sort,minetest.registered_nodes[name][sort_by])
				key[minetest.registered_nodes[name][sort_by]] = des			
			end
			
			-- standard table sort
			table.sort(sort)
			
			-- rebuild mach_sort
			mach_sort = {}
			for k,v in pairs(sort) do
				mach_sort[k] = key[v]
			end			
	return mach_sort,mach_key
end
--------------------------------------------------------------
-- Returns content of page, content of page + bwd_fwd nav   --
-- or content of specific page num with bwd/fwd nav buttons --
--------------------------------------------------------------
	-- Assumed Input Formats
	---- page_ref     = string - name of main page/how main page identified
	---- itemlist     = structured table of values pre-formated in formspec format
	----                this includes correct x/y positions for pgs 2/3 etc 
	----                itemlist = {"formspec for item_1","formspec for item_2", etc}
	---- max_items_pp = How many items from itemlist to put on each page
	---- page_num     = Int of the page number user going too 
	---- button_name  = This is the buttons "field" name eg "mach_bwd_fwd"
	----                used in on_recieve to identify what formspec to return

function eletome.p_nav_bwd_fwd(page_ref,item_list,max_items_pp,page_num,button_name)
	local recipe_pg = ""
	local num_recipe = #item_list
	local i = 1

	if page_num > 1 then
		-- Check if we need another fwd button
		if page_num*max_items_pp < num_recipe then
			recipe_pg  = recipe_pg .."button[15,0;2.5,0.5;"..button_name..";Page "..(page_num + 1).." >>]"
		end		
		-- Always need back button
		recipe_pg  = recipe_pg .."button[12.5,0;2.5,0.5;"..button_name..";<< "..(page_num - 1).." Page]"
		
	elseif num_recipe > max_items_pp then
		recipe_pg  = recipe_pg .."button[15,0;2.5,0.5;"..button_name..";Page "..(page_num + 1).." >>]"		
	end	
	
	-- Pass page reference value to player recieve fields when fwd/bwd pressed - not visible on formspec
	recipe_pg  = recipe_pg .."field[10,12;1,0.5;description;;"..page_ref.."]"
	
	-- used to add a num/offset so we get correct recipes on pg 1/2/etc
	local pg_offset = (page_num-1)*max_items_pp
	i = i+pg_offset
	
	-- Create the final output
	while i <= (max_items_pp + pg_offset) and i <= num_recipe do
		recipe_pg  = recipe_pg ..item_list[i]	
		i=i+1
	end	
	
	return recipe_pg
end

--------------------------------------------------------------------------------
-- Returns a table of items which make up the craft recipe for the registered --
-- node in elepower note max grid recipe is 3x1 output assigned to keys 4/5/6 -- 
-- Structured as:                                                             --
-- recipe_output = {items = {[4] = "item 1", [5] = "item 2", [6] = "item 3"}, --
--                    num = {[4  = 2       , [5] = 1       , [6] = 6       }, --
--                  craft_name = "elepower craft name" eg can,                --
--                  craft_des  = "elepower craft description" eg canning   }  --
--------------------------------------------------------------------------------

function eletome.get_craft_recipe(reg_node_name)
	local recipe_output = {}
		  recipe_output.items = {}
		  recipe_output.num = {}
	local i = 1	  
	local all_crafts = table.copy(elepm.craft.types)

	for craft_name,craft_def in pairs(all_crafts) do		
		for k,reg_craft_def in pairs(elepm.craft[craft_name]) do
		
			local itemstring = reg_craft_def.output
			local stack = ItemStack(itemstring)
				  stack = stack:to_table()
							  
			if stack then	  						
				if stack.name == reg_node_name then
					-- get inputs for craft
					local craft_in = craft_def.inputs
					local pos = {4,5,6}
											
					if craft_in == 1 then
						pos = {5}
						
					elseif craft_in == 2 then
						pos = {5,6}
					end
					
					recipe_output.craft_name = craft_name
					recipe_output.craft_des = craft_def.description
					
					for k,v in pairs(reg_craft_def.recipe) do
						recipe_output.items[pos[i]] = k
						recipe_output.num[pos[i]] = v
						i=i+1						
					end						
				end
			else
				-- some not in stack format (saw - catch later)			
			end
		end
	end
	return recipe_output
end


------------------------------------------------------------------
--  Generates the visual craft output grid recipe for the node  --
--    nominally this is either a 3x3 grid (std MT Recipe or a   --
--          1x3,1x2,1x1 grid for elepower craft recipes.        --
--    Takes into account customisation from additional info     --
--   Input list of items for node recipe as a numeric key table -- 
--    keys 1-9 - note keys can be missing but can't exceed 9    --
--   basically accepts output from "eletome.get_craft_recipe"   --
-- Outputs:                                                     --
--         formspec formated grid of ingredients                --
--         Current  y offset - y_off                            --
------------------------------------------------------------------   
function eletome.gen_craft_grid(recipe,y_off,no_items)
	local x_cnt = 1
	local x_off = 0
	local dis_recipe = ""
	local sty_h3s  = eletome.common_styles.style_h3s
	local sty_h3e  = eletome.common_styles.style_h3e
	
	while x_cnt <= 9 do		
		-- catch for node with un-handled/non-exsitant recipe
		if no_items == 1 then
			-- output nothing as no recipe
		
		-- recipe item or image output
		elseif recipe.items[x_cnt] then				
			
			-- handle when recipe includes groups
			if string.find(recipe.items[x_cnt],"group") then
				local grp_name = string.gsub(recipe.items[x_cnt],"group:","")
				local node_name
				for name,def in pairs(minetest.registered_nodes) do 
					if def.groups[grp_name] and not def.groups["wall"] then
						node_name = name
						break
					end
				end
				dis_recipe = dis_recipe.."item_image_button["..(12+x_off)..","..(1+y_off)..";0.75,0.75;"..node_name..";"..node_name..";G]"..
						   "tooltip["..node_name..";"..recipe.items[x_cnt]..";"..eletome.tooltip_color.."]"
			
			-- handle a custom png image
			elseif string.find(recipe.items[x_cnt],".png") then
				dis_recipe = dis_recipe.."image["..(12+x_off)..","..(1+y_off)..";0.75,0.75;"..recipe.items[x_cnt].."]"
				dis_recipe = dis_recipe.."tooltip["..(12+x_off)..","..(1+y_off)..";0.75,0.75;"..recipe.craft_des..";"..eletome.tooltip_color.."]"
			else	
				dis_recipe = dis_recipe.."item_image_button["..(12+x_off)..","..(1+y_off)..";0.75,0.75;"..recipe.items[x_cnt]..";"..recipe.items[x_cnt]..";]"
			end
		
		-- Special case to insert elepower craft name in grid pos[1] or
		-- Custom additional info "craft name" eg "Right Click"
		elseif recipe.craft_name and x_cnt == 1 then
			-- only provide a link if a elepower craft name
			if elepm.craft[recipe.craft_name] then
				dis_recipe = dis_recipe.."hypertext["..(11.5+x_off)..","..(1.2+y_off)..
					   ";2.5,1;craft_click;"..sty_h3s.."<action name="..recipe.craft_des..">"..recipe.craft_des.."</action>"..sty_h3e.."]"				
			else
				dis_recipe = dis_recipe.."hypertext["..(11.5+x_off)..","..(1.2+y_off)..
					   ";2.5,1;craft_click;"..sty_h3s..recipe.craft_des..sty_h3e.."]"
			end
		
		-- Custom craft but no ingredient/need for craft slot 
		elseif recipe.craft_name then
			-- output nothing as no slot on custom craft
			
		-- Normal MT craft output empty craft slot.
		else
			dis_recipe = dis_recipe.."image["..(12+x_off)..","..(1+y_off)..";0.75,0.75;elepower_tome_bgimg_2.png]"
		end
		
		-- counters and offsets
		if x_cnt == 3 or x_cnt == 6 then
			x_off = 0
			y_off = y_off + 0.8
		else
			x_off = x_off + 0.8
		end
		x_cnt = x_cnt+1
	end
	
	return dis_recipe, y_off

end



