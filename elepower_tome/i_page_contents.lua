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
--                 Contents Page                 --
---------------------------------------------------

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

	local content_lp_txt = "Elepower adds power to a game, "..
	                       "Power is referred to in units and these units "..
						   "are called EpU (Elepower Unit).\n"..
						   "New crafts are added to the game as well as new machines "..
						   "to enable these new crafts and make use of EpU/s.\n\n"..
						   "A big thank you to IcyDiamond the orginal creator of this mod.\n\n"

	local heading_lp = "hypertext[0.50,0.70;8.5,1.2;content_lp_h_tome;"..sty_h0s.."Elepower Tome"..sty_h0e.."]"
	local content_lp = "hypertext[0.75,1.8;8.0,5.5;content_lp_c_text;"..sty_h3s..content_lp_txt..sty_h3s.."]"
	local links_lp   = "hypertext[0.75,6.8;8.0,4.0;help;"..sty_h3s..
							 "<action name=getting_started>Getting Started</action>\n"..
							 "<action name=first_pcb_creation>First PCB Creation</action>\n"..
							 "<action name=upgrading_machines>Upgrading Machines</action>"..							 						
							 sty_h3e.."]"

	-- Contents page right page Content
	local heading_rp        = "hypertext[9.0,0.7;8.5,1.0;content_rp_h_cont;"..sty_h1s.."Contents"..sty_h1e.."]"			
	local heading_rp_craft  = "hypertext[9.0,1.5;8.5,1.0;content_rp_sh_crafts;"..sty_h2s.."Crafts"..sty_h2e.."]"
				
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
	
	local ac_off           = math.ceil((#all_crafts/2)*0.75)

	local craft_rp_txt     = "hypertext[09.0,2.0;4.5,"..ac_off..";craft_click;"..sty_h3s..left_col..sty_h3e.."]"..
							 "hypertext[13.5,2.0;4.5,"..ac_off..";craft_click;"..sty_h3s..rght_col..sty_h3e.."]"
	local heading_rp_mach  = "hypertext[09.0,"..(2+ac_off)..";8.5,1.0;content_rp_sh_mach;"..sty_h2s.."Machines"..sty_h2e.."]"					  

	local subhead_mach_gen = "hypertext[09.0,"..(2.7+ac_off)..";4.5,7.0;machine;"..sty_h3s..  -- left side column
							 "<action name=machine-ele_provider>Simple Generators</action>\n"..
							 "<action name=machine-ele_user>Simple Machines</action>\n"..
							 "<action name=machine-Wind_Turbine>Wind Turbine</action>\n"..							 
							 "<action name=machine-Fission_Reactor>Fission Reactor</action>\n"..
							 "<action name=machine-Fusion_Reactor>Fusion Reactor</action>"..						
							 sty_h3e.."]"..
							 "tooltip[9.0,"..(2.7+ac_off)..";4.5,0.6;Single Node\nPower Generators;"..eletome.tooltip_color.."]"..
							 "tooltip[9.0,"..(3.2+ac_off)..";4.5,0.6;Single Node\nMachines;"..eletome.tooltip_color.."]"..
							 
							 "hypertext[13.5,"..(2.7+ac_off)..";4.5,7.0;machine;"..sty_h3s.. -- right side column
							 "<action name=machine-ele_storage>Powercells</action>\n"..
							 "<action name=machine-Fluid_Pump>Fluid Pump</action>\n"..
							 "<action name=machine-Evaporation_Plant>Evaporation Plant</action>\n"..
							 "<action name=machine-Miner>Miner</action>\n"..							 
							 "<action name=machine-Transporter>Transporter</action>"..							 
							 sty_h3e.."]"
	
	-- Assemble contents page
	local eletome_cont = heading_lp..content_lp..links_lp..
						 heading_rp..heading_rp_craft..craft_rp_txt..
						 heading_rp_mach..subhead_mach_gen 

	return eletome_cont
end