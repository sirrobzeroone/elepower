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
--       Simple Machines/Node Instructions       --
---------------------------------------------------

local modname = minetest.get_current_modname()
local modpath = minetest.get_modpath(modname)

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

	local file_exists
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