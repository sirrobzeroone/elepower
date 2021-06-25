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
--            Additional Information             --
--------------------------------------------------- 

-- This is a store of custom text and data metrics used 
-- by the tome. In some cases some of these could be added
-- to the node/craft registrations but this would clutter
-- those even more and they are across multiple mods making
-- updates more difficult.

-- Main table for storing additional info
eletome.ai = {}

---------------------------------------------------------
-- General Info for Machine Pages (Simple and Complex) --
---------------------------------------------------------
-- note must be setup as 
-- eletome.ai.<page_heading_name>
-- Values
   -- eletome.ai.<page_heading_name>.img - <optional> Image sized 800/1000 x 600 sized image 
                                         --works best, appears at the bottom of the left page if set
										 
   --eletome.ai.<page_heading_name>.part - <optional> Used for Complex Machine pages - 
                                         -- This is a table list of the machine nodes that is used to
										 -- assemble the complex machine, node names should be entered
										 -- in the order you wish them to output on the right hand page. 
										 
   --eletome.ai.<page_heading_name>.over - <optional> text block that appears on the left page
                                         -- 500-600 characters works best but can enter more or less

   --eletome.ai.<page_heading_name>.sort_by - <optional> an optional field to sort all the nodes by, has to be
                                            -- a field avaliable on the node registrations for all nodes
											-- using "no_sort" will prevent any sorting from occuring

-- info for Generators page
eletome.ai.generators      = {}
eletome.ai.generators.img  = "power_network_simple_examples.png"
eletome.ai.generators.over = "Generators produce EpU/s by taking something from the natural "..
						     "environment and converting it to power that can be used by machines. "..
						     "There are both low and high tech solutions for producing power so choose "..
						     "a power generation method that best fits with what your current needs are "..
						     "and the resources you have avaliable.\n\n"..
						     "Generators produce power (EpU/s) every second, they then distribute this "..
						     "power across their network to all connected machines that require power.\n\n"..
						     "A single power network is a group of machines and conduits which is connected "..
						     "in one single un-broken group two examples of simple valid power networks "..
						     "is pictured below."

-- info for Powercells page
eletome.ai.powercells         = {}
eletome.ai.powercells.sort_by = "ele_output"
eletome.ai.powercells.over    = "Powercells will charge from the network when power is avaliable."..
						        "Once power supply on a network is 0 ie generators no longer "..
						        "producing EpUs. The powercell(s) will provide power only to active "..
						        "machines on the network. Powercells will provide the minimum EpUs "..
						        "to the machine ie the usage amount not the max amount the machine "..
						        "can recieve.\nFor example the Sawmill when active(being used) uses "..
						        "32 EpUs, however the Sawmill can accept upto 64 EpUs of power until "..
						        "fully charged. Powercell(s) will only provide the Sawmill with 32 "..
						        "EpUs of power if the Sawmill is active."

-- info for (Simple/Single node) Machine page
eletome.ai.machine         = {}

-- info for Fluid Pump page
eletome.ai.fluid_pump         = {}
eletome.ai.fluid_pump.sort_by = "no_sort"
eletome.ai.fluid_pump.img     = "elepower_tome_complex_water_pump.png"
eletome.ai.fluid_pump.part    = {"elepower_machines:pump",
							     "fluid_transfer:fluid_transfer_pump",
							     "elepower_machines:accumulator",
							     "elepower_machines:accumulator_heavy"}
eletome.ai.fluid_pump.over    = "The simplest fluid Pump is assembled from two components:"..
						        "the 'Pickup Pump Tank' and the 'Fluid Transfer Pump'\n"..
						        "The 'Pickup Pump Tank' must be placed above a body of fluid, "..
						        "and provided with power. The black end of the "..
						        "'Fluid Transfer Pump' must be placed up against the 'Pickup Pump Tank'.\n"..
						        "Once completed fluid ducting can then be used to run fluid to machines "..
						        "that require fluid - For example water to the Electrolyzer."

-- info for Miner page
eletome.ai.miner          = {}
eletome.ai.miner.sort_by  = "no_sort"
eletome.ai.miner.instruct = "y"
eletome.ai.miner.img      = "elepower_tome_complex_miner.png"
eletome.ai.miner.part     = {"elepower_mining:miner_controller",
							 "elepower_mining:miner_core",
							 "elepower_mining:miner_drill"}
eletome.ai.miner.over     = "The miner uses significant volumes of power and water to sift metals "..
						    "from the surronding electro-molecular environment. The miner then "..
						    "gathers the molecules together until enough are gathered for a lump "..
						    "of metal to materialise.\n"..
						    "Assembly requires an incoming water supply from a fluid pump, a power "..
						    "source providing at least 128 EpUs of power. 1-9 mining drills, 1 central core, "..
						    "1 miner controller and some lengths of fluid duct. Place the 1-9 mining drills "..
						    "down as 1x1 to 3x3 grid, place the central core ontop of the center drill and place "..
						    "the controller ontop of the central core. Join them all togther with fluid duct "..
						    "ensure one fluid duct is going into the side of the controller. Supply power "..
						    "and water to the miner and it will start functioning."
										
-- info for Evaporation Plant page
eletome.ai.evaporation_plant          = {}
eletome.ai.evaporation_plant.sort_by  = "no_sort"
eletome.ai.evaporation_plant.instruct = "y"
eletome.ai.evaporation_plant.img      = "elepower_tome_complex_thermal_evap.png"
eletome.ai.evaporation_plant.part     = {"elepower_thermal:evaporator_controller",
							            "elepower_thermal:evaporator_input",
							            "elepower_thermal:evaporator_output",
										"elepower_machines:heat_casing",
										"elepower_solar:solar_generator"}
eletome.ai.evaporation_plant.over     = "The Thermal Evaporation Plant is a machine which converts Water into Brine "..
									    "and Brine into liquid Lithium. It is powered via solar panels around the top "..
									    "edge.\n"..
									    "The plant consists of a Thermal Evaporation Plant Controller, Heat Casings, "..
									    "Thermal Evaporation Plant Inputs and Thermal Evaporation Plant Outputs. It "..
									    "is a 4x4 structure which can be built between 3 and 18 nodes high. The first "..
									    "layer is a solid 4x4 of Heat Casings. The controller must be placed on top of "..
									    "this floor of heat casings and on an outside edge. The center must be left "..
									    "hollow. On top of the top layer of heat casings you place Solar Generators "..
									    "this is in order to increase the heat inside the plant, More heat increases the "..
									    "production rate per second of the plant. The plant has a maximum temp of 1000 Kelvin.\n"..
									    "Note: If the controller fails to verify your structure (PUNCH the controller) or "..
									    "try placing it on a different side."

-- info for Transporter page
eletome.ai.transporter         = {}
eletome.ai.transporter.sort_by = "no_sort"
eletome.ai.transporter.part    = {"elepower_wireless:dialler",
							      "elepower_wireless:matter_transmitter",
							      "elepower_wireless:matter_receiver"}
eletome.ai.transporter.over    = "Once setup the Teleporter allows for instanaeous travel from the sending pad "..
								 "to the recieveing pad.\n"..
								 "To construct the teleporter simply place the transmission pad down were you would like "..
								 "to travel from and the reciever pad were you would like to travel too. Both ends will "..
								 "need to be provided with power to function. It is suggested "..
								 "you place a sending and recieving pad at both ends so you can teleport back and forth easily."

-- info for Wind Turbine page
eletome.ai.wind_turbine         = {}
eletome.ai.wind_turbine.sort_by = "no_sort"
eletome.ai.wind_turbine.part    = {"elepower_machines:wind_turbine",
								   "elepower_machines:wind_turbine_blade"
								  }
eletome.ai.wind_turbine.over    = "" 

-- info for Fission page
eletome.ai.fission_reactor         = {}
eletome.ai.fission_reactor.sort_by = "no_sort"
eletome.ai.fission_reactor.instruct= "y"
eletome.ai.fission_reactor.img     = "elepower_tome_complex_fission_reactor.png"
eletome.ai.fission_reactor.part    = {"elepower_nuclear:fission_controller",
							          "elepower_nuclear:fission_core",
							          "elepower_nuclear:reactor_fluid_port",
									  "elepower_nuclear:heat_exchanger",
									  "elepower_nuclear:enrichment_plant",
									  "elepower_nuclear:bucket_coolant",
									  }
eletome.ai.fission_reactor.over     = "The Nuclear (Fission) Reactor is a type of Nuclear Reactor in Elepower used for power generation. ".. 
									  "The reactor itself is composed of three nodes:\n"..
									  "Fission Control Module - Used for controlling the power of the reactor (top node)\n"..
									  "Fission Reactor Core - The core of the reactor (middle node)\n"..
									  "Reactor Fluid Port - Used to turn Cold Coolant into Hot Coolant (bottom node)\n"..
									  "The Reactor Core takes Fissile Fuel Rods and turns them into Depleted Fuel Rods after 2 hours (7200 seconds). ".. 
									  "The reactor assembly needs to have area of Water Source nodes surrounding it in order to keep "..
									  "the reactor cool (9x9x9 block of water). If the reactor heat reaches above 80%, it will start to melt down. The Control Rods "..
									  "can be raised or lowered to control the power output of the reactor core. Lowered control rods mean "..
									  "that the reactor is slowed down and raised mean that the reactor is accelerated.\nTo gather power from the reactor "..
									  "you will need to add a heat exchanger, water pump, steam turbine and at least 1 bucket of cold coolant as well ".. 
									  "as the fluid ducts and fluid transfer pumps to move the fluids and steam around.\n"..
									  "This reactor is inspired by the real world pressurized water reactor design.\n\n"
								  
-- info for Fusion page
eletome.ai.fusion_reactor         = {}
eletome.ai.fusion_reactor.sort_by = "no_sort"
eletome.ai.fusion_reactor.part    = {"elepower_nuclear:fusion_coil",
									 "elepower_nuclear:reactor_controller",
							         "elepower_nuclear:reactor_power",
									 "elepower_nuclear:reactor_fluid",
									 "elepower_nuclear:reactor_output",
									 "elepower_nuclear:solar_neutron_activator",
									 "elepower_machines:advanced_machine_block"}
eletome.ai.fusion_reactor.over     = ""

-- will also accept image names (png only), table keys
-- equate to craft grid eg [5] equals center node in 3x3 grid
--{[4] = "reg_node_name_1",[5] = "image_name_1.png", [6] = "reg_node_name_1"}

------------------------------------------------
-- Node/Image specific additional information --
------------------------------------------------
-- Used to supply additional information to specific
-- nodes or to images being used in recipes or summary block
--
-- Values (all optional) - use if unknown appears or customising
  -- lb_top_img = left page, left box, top image (.png) or registered node name
  -- lb_top_tt  = left page, left box, top tooltip 
  -- lb_mid_img = left page, left box, mid image
  -- lb_mid_tt  = left page, left box, mid tooltip
  -- lb_btm_img = left page, left box, btm image_name or number
  -- lb_btm_tt  = left page, left box, btm tooltip

  -- mb_title_txt = left page, middle box, topline title txt - good for custom craft or action
                  --only use when recipe dosen't have slots [1],[2] or [3].

  -- mb_recipe_items = left page, middle box; table keys
                    -- equate to craft grid eg [5] equals center node in 3x3 grid
                    -- Structure - {[4] = "reg_node_name_1",
					--              [5] = "image_name_1.png", 
					--              [6] = "reg_node_name_1"}
  
eletome.ai.nodes = {}

-- Generators Page
eletome.ai.nodes["elepower_machines:generator"]      = {lb_top_img = "default:coal_lump", 
														lb_top_tt = "Burnable Items",
														lb_btm_tt = " EpU generated\nper second"
													   }
eletome.ai.nodes["elepower_machines:lava_generator"] = {lb_top_img = "default:lava_source",
														lb_btm_tt = " EpU generated\nper 125 lava/second"
													   }
eletome.ai.nodes["elepower_machines:fuel_burner"]    = {lb_top_img = "elepower_farming:biofuel_source",
														lb_btm_tt = " EpU generated\nper 12.5 biofuel/second"
													   }
eletome.ai.nodes["elepower_solar:solar_generator"]   = {lb_top_img = "elepower_tome_sunlight.png",
														lb_top_tt ="Sunlight",
														lb_btm_tt = " EpU generated\nper second"
													   }
eletome.ai.nodes["elepower_machines:steam_turbine"]  = {lb_top_img = "elepower_tome_steam.png",
														 lb_top_tt ="Steam", 
														 lb_btm_tt = " EpU generated\nper 500 steam/second"
														 }		
eletome.ai.nodes["elepower_machines:wind_turbine"]   = {lb_top_img = "elepower_tome_wind.png",
														lb_top_tt ="Wind", 
														lb_btm_tt = " EpU generated\nper second"
														}

-- Powercells
eletome.ai.nodes["elepower_machines:power_cell_0"]            = {lb_top_img = "elepower_gui_icon_power_stored.png",
																 lb_top_tt = "Storage "..minetest.registered_nodes["elepower_machines:power_cell_0"].ele_capacity.." EpUs", 
																 lb_btm_tt = " EpU max output\nper second"
																}
eletome.ai.nodes["elepower_machines:hardened_power_cell_0"]   = {lb_top_img = "elepower_gui_icon_power_stored.png",
																 lb_top_tt = "Storage "..minetest.registered_nodes["elepower_machines:hardened_power_cell_0"].ele_capacity.." EpUs", 
																 lb_btm_tt = " EpU max output\nper second"
																}		  
eletome.ai.nodes["elepower_machines:reinforced_power_cell_0"] = {lb_top_img = "elepower_gui_icon_power_stored.png",
																 lb_top_tt = "Storage "..minetest.registered_nodes["elepower_machines:reinforced_power_cell_0"].ele_capacity.." EpUs",
																 lb_btm_tt = " EpU max output\nper second"
																 }
eletome.ai.nodes["elepower_machines:resonant_power_cell_0"]   = {lb_top_img = "elepower_gui_icon_power_stored.png",
																 lb_top_tt = "Storage "..minetest.registered_nodes["elepower_machines:resonant_power_cell_0"].ele_capacity.." EpUs", 
																 lb_btm_tt = " EpU max output\nper second"
																 }	
eletome.ai.nodes["elepower_machines:super_power_cell_0"]      = {lb_top_img = "elepower_gui_icon_power_stored.png",
																 lb_top_tt = "Storage "..minetest.registered_nodes["elepower_machines:super_power_cell_0"].ele_capacity.." EpUs", 
																 lb_btm_tt = " EpU max output\nper second"
																}	

-- (Simple) Machines Page
eletome.ai.nodes["elepower_machines:alloy_furnace"]      = {lb_top_img = "default_tin_ingot.png",
															lb_top_tt ="2 Materials\nto be Alloyed", 
															lb_btm_tt = " used per second"}	

-- Fluid Pump Page
eletome.ai.nodes["elepower_machines:pump"]              = {lb_top_img = "elepower_gui_icon_fluid_electrolyzer_in.png", lb_top_tt = "Fluid"}
eletome.ai.nodes["fluid_transfer:fluid_transfer_pump"]  = {lb_top_img = "elepower_gui_icon_fluid_electrolyzer_in.png", lb_top_tt = "Fluid"}
eletome.ai.nodes["elepower_machines:accumulator"]       = {lb_top_img = "elepower_gui_icon_fluid_water.png", lb_top_tt = "Water"}
eletome.ai.nodes["elepower_machines:accumulator_heavy"] = {lb_top_img = "elepower_gui_icon_fluid_water.png",
														   lb_top_tt = "Heavy Water",
														   mb_title_txt = "Right Click",
														   mb_recipe_items = {[4] = "elepower_machines:heavy_filter", 
																	          [5] = "elepower_tome_mouse_rght_click.png",
																		      [6] = "elepower_machines:accumulator"}
														  }

-- Evaporation Plant page
eletome.ai.nodes["elepower_thermal:evaporator_controller"] = {lb_top_img = "elepower_gui_icon_fluid_water_brine_lithium.png", lb_top_tt = " Water\n Brine\nLithium"}
eletome.ai.nodes["elepower_thermal:evaporator_input"]      = {lb_top_img = "elepower_gui_icon_fluid_water_brine.png", lb_top_tt = "Water\nBrine"}
eletome.ai.nodes["elepower_thermal:evaporator_output"]     = {lb_top_img = "elepower_gui_icon_fluid_brine_lithium.png", lb_top_tt = " Brine\nLithium"}
eletome.ai.nodes["elepower_machines:heat_casing"]          = {lb_top_img = "elepower_machines:heat_casing"}


-- Miner Page
eletome.ai.nodes["elepower_mining:miner_controller"]    = {lb_top_img ="elepower_gui_icon_fluid_water.png",lb_top_tt ="Requires\nWater"}
eletome.ai.nodes["elepower_mining:miner_core"]          = {lb_top_img ="elepower_gui_icon_fluid_water.png",lb_top_tt ="Requires\nWater"}
eletome.ai.nodes["elepower_mining:miner_drill"]         = {lb_top_img ="elepower_tome_icon_metal_lump.png",lb_top_tt ="Produces\n Metal lumps" ,lb_btm_img = "elepower_gui_icon_power_water.png", lb_btm_tt = "128 EpUs & 500 Water\n used per drill"}
