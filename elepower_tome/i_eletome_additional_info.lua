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
eletome.ai.machine.over    = "These are the simpliest machines in elepower consisting of single node "..
						     "that performs a single/simple function.\n"..
							 "The machines can often interface with other machines using fluid ducts to "..
							 "help automate the inputs/outputs of certain machines. Where a machine "..
							 "maybe more complex a small 'I' will be present on the large image, indicating "..
							 "there is a subpage with additional information for that machine. for example "..
							 "the Automatic Planter at the bottom of the opposite page."

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
								   "elepower_machines:wind_turbine_blade",
								   "elepower_machines:wind_turbine_blades"
								  }
eletome.ai.wind_turbine.over    = "The wind turbine produces power from the wind. The minimum height a wind turbine will produce "..
								  "power is at y 10. The wind turbine will produce a small amount of power without blades, "..
								  "however with blades the wind turbine will produce 4x as much power.\n"..
								  "The higher the wind turbine is placed the more power it will produce to a maximum output of 100 EpUs."
eletome.ai.wind_turbine.img  = "elepower_tome_complex_wind_turbine.png"

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
 --below only used on help pages
  -- how_use_1 = left page text 
  -- hu_img_1  = <optional> image below text, can be a png file name string or a table with a single
		       --entry containing a container and formspec ("container[2.25,6.6]"..<formspec>.."container_end[]")
			   -- note x can be adjusted but y cant be changed without causing possible overlap with txt
  -- how_use_t2 and hu_img_2 = as above but right page			   
  
eletome.ai.nodes = {}

-- Help Pages
eletome.ai.nodes["getting_started"]    = {how_use_1 = "This is a getting started guide for Elepower. "..
													"The first step is to create your first power generator. "..
													"The coal-fired generator is a good starting generator "..
													"as it will produce power from anything that is burnable."..
													"You will need 3 Steel Ingots, 2 Wound copper coils, "..
													"1 Furnace and 1 Machine block to create a coal-fired generator. "..
													"To craft all those you will need a Total of: "..
													"174 leaves, 17 Copper Ingots, 8 Stone blocks, 9 Steel Ingots, "..
													"3 sand, 2 Iron ingots, 2 Silver Ingots and 2 Mese Crystal Fragments\n",
										 hu_img_1 = {"container[1.0,6.6]"..
													-- line 1
													"style_type[item_image_button;bgimg=elepower_tome_bgimg_2.png]"..
													"item_image_button[0.375,0.25;1,1;default:blueberry_bush_leaves;leaves;]"..
													"tooltip[leaves;Any Leaves;#30434c;#f9f9f9]"..
													"style[num;font_size=-2;font=bold;textcolor=#FFF]"..
													"hypertext[0.375,0.9;1,1;num;<style size=12><right><b>174</b></right></style>]"..
													"image[1.5,0.375;0.75,0.75;elepower_tome_icon_crafting.png]"..
													"tooltip[1.5,0.375;0.75,0.75;Crafting;#30434c;#f9f9f9]"..
													"item_image_button[2.375,0.25;1,1;basic_materials:oil_extract;basic_materials:oil_extract;]"..
													"hypertext[2.375,0.9;1,1;num;<style size=12><right><b>58</b></right></style>]"..
													"image[3.5,0.375;0.75,0.75;elepower_tome_icon_cooking.png]"..
													"tooltip[3.5,0.375;0.75,0.75;Cooking;#30434c;#f9f9f9]"..
													"item_image_button[4.375,0.25;1,1;basic_materials:paraffin;basic_materials:paraffin;]"..
													"hypertext[4.375,0.9;1,1;num;<style size=12><right><b>58</b></right></style>]"..
													"image[5.5,0.375;0.75,0.75;elepower_tome_icon_cooking.png]"..
													"tooltip[5.5,0.375;0.75,0.75;Cooking;#30434c;#f9f9f9]"..
													"item_image_button[6.375,0.25;1,1;basic_materials:plastic_sheet;basic_materials:plastic_sheet;]"..
													"hypertext[6.375,0.9;1,1;num;<style size=12><right><b>58</b></right></style>]"..
													-- line 2
													"item_image_button[0.75,1.5;1,1;basic_materials:plastic_sheet;basic_materials:plastic_sheet;]"..
													"hypertext[0.75,2.15;1,1;num;<style size=12><right><b>56</b></right></style>]"..
													"image[1.875,1.625;0.75,0.75;elepower_tome_icon_crafting.png]"..
													"tooltip[1.875,1.625;0.75,0.75;Crafting;#30434c;#f9f9f9]"..
													"item_image_button[2.75,1.5;1,1;basic_materials:empty_spool;basic_materials:empty_spool;]"..
													"hypertext[2.75,2.15;1,1;num;<style size=12><right><b>24</b></right></style>]"..
													"item_image_button[3.875,1.5;1,1;default:copper_ingot;default:copper_ingot;]"..
													"hypertext[3.875,2.15;1,1;num;<style size=12><right><b>12</b></right></style>]"..
													"image[5,1.625;0.75,0.75;elepower_tome_icon_crafting.png]"..
													"tooltip[5,1.625;0.75,0.75;Crafting;#30434c;#f9f9f9]"..
													"item_image_button[5.875,1.5;1,1;basic_materials:copper_wire;basic_materials:copper_wire;]"..
													"hypertext[5.875,2.15;1,1;num;<style size=12><right><b>12</b></right></style>]"..
													-- line 3 -- bug single digits vanish randomly
													"item_image_button[0.25,2.75;1,1;basic_materials:copper_wire;basic_materials:copper_wire;]"..
													"hypertext[0.25,3.4;1,1;num;<style size=12><right><b>02</b></right></style>]"..
													"item_image_button[1.375,2.75;1,1;default:mese_crystal_fragment;default:mese_crystal_fragment;]"..
													"hypertext[1.375,3.4;1,1;num;<style size=12><right><b>02</b></right></style>]"..
													"item_image_button[2.5,2.75;1,1;basic_materials:plastic_sheet;basic_materials:plastic_sheet;]"..
													"hypertext[2.5,3.4;1,1;num2;<style size=12><right><b>02</b></right></style>]"..
													"item_image_button[3.625,2.75;1,1;default:steel_ingot;default:steel_ingot;]"..
													"hypertext[3.625,3.4;1,1;num;<style size=12><right><b>02</b></right></style>]"..
													"item_image_button[4.75,2.75;1,1;default:copper_ingot;default:copper_ingot;]"..
													"hypertext[4.75,3.4;1,1;num;<style size=12><right><b>01</b></right></style>]"..
													"image[5.875,2.875;0.75,0.75;elepower_tome_icon_crafting.png]"..
													"tooltip[5.875,2.875;0.75,0.75;Crafting;#30434c;#f9f9f9]"..
													"item_image_button[6.75,2.75;1,1;basic_materials:motor;basic_materials:motor;]"..
													"hypertext[6.75,3.4;1,1;num;<style size=12><right><b>02</b></right></style>]"..
													"container_end[]"},
										 hu_img_2 = {"container[0,0]"..
											        "style_type[item_image_button;bgimg=elepower_tome_bgimg_2.png]"..
													--line 1
													"container[2.5,0]"..
													"item_image_button[0.375,0.25;1,1;default:stone;default:stone;]"..
													"hypertext[0.375,0.9;1,1;num;<style size=12><right><b>08</b></right></style>]"..
													"image[1.5,0.375;0.75,0.75;elepower_tome_icon_crafting.png]"..
													"tooltip[1.5,0.25;0.75,0.75;Crafting;#30434c;#f9f9f9]"..
													"item_image_button[2.375,0.25;1,1;default:furnace;default:furnace;]"..
													"hypertext[2.375,0.9;1,1;num;<style size=12><right><b>01</b></right></style>]"..
													"container_end[]"..
													-- line 2
													"container[2.5,1.25]"..													
													"item_image_button[0.375,0.25;1,1;default:sand;default:sand;]"..
													"hypertext[0.375,0.9;1,1;num;<style size=12><right><b>03</b></right></style>]"..
													"image[1.5,0.375;0.75,0.75;elepower_tome_icon_cooking.png]"..
													"tooltip[1.5,0.25;0.75,0.75;Cooking;#30434c;#f9f9f9]"..
													"item_image_button[2.375,0.25;1,1;default:glass;default:glass;]"..
													"hypertext[2.375,0.9;1,1;num;<style size=12><right><b>03</b></right></style>]"..													
													"container_end[]"..
													-- line 3
													"container[1.875,2.5]"..
													"item_image_button[0.375,0.25;1,1;basic_materials:copper_wire;basic_materials:copper_wire;]"..
													"hypertext[0.375,0.9;1,1;num;<style size=12><right><b>08</b></right></style>]"..
													"item_image_button[1.5,0.25;1,1;elepower_dynamics:iron_ingot;elepower_dynamics:iron_ingot;]"..
													"hypertext[1.5,0.9;1,1;num;<style size=12><right><b>02</b></right></style>]"..
													"image[2.625,0.375;0.75,0.75;elepower_tome_icon_crafting.png]"..
													"tooltip[2.625,0.375;0.75,0.75;Crafting;#30434c;#f9f9f9]"..
													"item_image_button[3.5,0.25;1,1;elepower_dynamics:wound_copper_coil;elepower_dynamics:wound_copper_coil;]"..
													"hypertext[3.5,0.9;1,1;num;<style size=12><right><b>02</b></right></style>]"..
													"container_end[]"..
													-- line 4
													"container[0.875,3.75]"..													
													"item_image_button[0.375,0.25;1,1;default:copper_ingot;default:copper_ingot;]"..
													"hypertext[0.375,0.9;1,1;num;<style size=12><right><b>04</b></right></style>]"..
													"item_image_button[1.5,0.25;1,1;moreores:silver_ingot;moreores:silver_ingot;]"..
													"hypertext[1.5,0.9;1,1;num;<style size=12><right><b>02</b></right></style>]"..
													"image[2.625,0.375;0.75,0.75;elepower_tome_icon_alloying.png]"..
													"tooltip[2.625,0.375;0.75,0.75;Alloying;#30434c;#f9f9f9]"..
													"item_image_button[3.5,0.25;1,1;basic_materials:brass_ingot;basic_materials:brass_ingot;]"..
													"hypertext[3.5,0.9;1,1;num;<style size=12><right><b>04</b></right></style>]"..
													"image[4.625,0.375;0.75,0.75;elepower_tome_icon_crafting.png]"..
													"tooltip[4.625,0.25;0.75,0.75;Crafting;#30434c;#f9f9f9]"..
													"item_image_button[5.5,0.25;1,1;elepower_dynamics:brass_gear;elepower_dynamics:brass_gear;]"..
													"hypertext[5.5,0.9;1,1;num;<style size=12><right><b>01</b></right></style>]"..
													"container_end[]"..
													-- line 5
													"container[0.75,5]"..
													"item_image_button[0.375,0.25;1,1;default:steel_ingot;default:steel_ingot;]"..
													"hypertext[0.375,0.9;1,1;num;<style size=12><right><b>04</b></right></style>]"..
													"item_image_button[1.5,0.25;1,1;default:glass;default:glass;]"..
													"hypertext[1.5,0.9;1,1;num;<style size=12><right><b>03</b></right></style>]"..
													"item_image_button[2.625,0.25;1,1;elepower_dynamics:brass_gear;elepower_dynamics:brass_gear;]"..
													"hypertext[2.625,0.9;1,1;num;<style size=12><right><b>01</b></right></style>]"..													
													"item_image_button[3.75,0.25;1,1;basic_materials:motor;basic_materials:motor;]"..
													"hypertext[3.75,0.9;1,1;num;<style size=12><right><b>01</b></right></style>]"..																										
													"image[4.875,0.375;0.75,0.75;elepower_tome_icon_crafting.png]"..
													"tooltip[4.875,0.25;0.75,0.75;Crafting;#30434c;#f9f9f9]"..
													"item_image_button[5.75,0.25;1,1;elepower_machines:machine_block;elepower_machines:machine_block;]"..
													"hypertext[5.875,0.9;1,1;num;<style size=12><right><b>01</b></right></style>]"..													
													"container_end[]"..
													-- line 6
													"container[0.75,6.25]"..
													"item_image_button[0.375,0.25;1,1;default:steel_ingot;default:steel_ingot;]"..
													"hypertext[0.375,0.9;1,1;num;<style size=12><right><b>03</b></right></style>]"..
													"item_image_button[1.5,0.25;1,1;elepower_dynamics:wound_copper_coil;elepower_dynamics:wound_copper_coil;]"..
													"hypertext[1.5,0.9;1,1;num;<style size=12><right><b>02</b></right></style>]"..
													"item_image_button[2.625,0.25;1,1;default:furnace;default:furnace;]"..
													"hypertext[2.625,0.9;1,1;num;<style size=12><right><b>01</b></right></style>]"..													
													"item_image_button[3.75,0.25;1,1;elepower_machines:machine_block;elepower_machines:machine_block;]"..
													"hypertext[3.75,0.9;1,1;num;<style size=12><right><b>01</b></right></style>]"..																										
													"image[4.875,0.375;0.75,0.75;elepower_tome_icon_crafting.png]"..
													"tooltip[4.875,0.25;0.75,0.75;Crafting;#30434c;#f9f9f9]"..
													"item_image_button[5.75,0.25;1,1;elepower_machines:generator;elepower_machines:generator;]"..
													"hypertext[5.875,0.9;1,1;num;<style size=12><right><b>01</b></right></style>]"..													
													"container_end[]"..	
													-- line 7
													"container[0.5,7.75]"..
													"hypertext[0,0;7.5,2;end;<style color=#1f1f1f size=13><left>"..
													"Now you have your generator built, place it down and then place the machines you wish to power "..
													"next to it.\n Later on you'll need to join machines to power generators using power conduit."..
													"</left></style>]"..
													"container_end[]"..														
													"container_end[]"
													}
										  }

eletome.ai.nodes["first_pcb_creation"] = {how_use_1 = "More advanced machines require a Printed Circuit Board(PCB) to craft them. "..
														   "Early on you will need to manually craft your PCB's until you have access to a "..
														   "Printed Circuit Board Plant.\n"..
														   "You need two main components to create a PCB, etching acid and "..
														   "Printed Circuit Board (PCB) Blank. To create these two items you will need: "..
														   "9 copper ingots, 3 gold ingots 1 mese crystal, 1 wheat seed and "..
														   "single water source block placed.\nOnce you have turned the water "..
														   "into etching acid you can use it to turn 10 PCB blanks into 10 PCBs, you can also "..
														   "pickup the etching acid with a bucket and store it.",
											  hu_img_2 =   {"container[0,0]"..
															"style_type[item_image_button;bgimg=elepower_tome_bgimg_2.png]"..
															--line 1
															"container[0.5,0]"..
															"item_image_button[0.375,0.25;1,1;default:copper_ingot;default:copper_ingot;]"..
															"hypertext[0.375,0.9;1,1;num;<style size=12><right><b>04</b></right></style>]"..
															"image[1.5,0.375;0.75,0.75;elepower_tome_icon_grinding.png]"..
															"tooltip[1.5,0.25;0.75,0.75;Grinding;#30434c;#f9f9f9]"..
															"item_image_button[2.375,0.25;1,1;elepower_dynamics:copper_dust;elepower_dynamics:copper_dust;]"..
															"hypertext[2.375,0.9;1,1;num;<style size=12><right><b>04</b></right></style>]"..
															"item_image_button[3.5,0.25;1,1;farming:seed_wheat;farming:seed_wheat;]"..
															"hypertext[3.5,0.9;1,1;num;<style size=12><right><b>01</b></right></style>]"..
															"image[4.625,0.375;0.75,0.75;elepower_tome_icon_crafting.png]"..
															"tooltip[4.625,0.375;0.75,0.75;Crafting;#30434c;#f9f9f9]"..
															"item_image_button[5.5,0.25;1,1;elepower_dynamics:acidic_compound;elepower_dynamics:acidic_compound;]"..
															"hypertext[5.5,0.9;1,1;num;<style size=12><right><b>01</b></right></style>]"..           
															"container_end[]"..
															-- line 2
															"container[1.25,1.25]"..                                                                                                                                                                                   
															"item_image_button[0.375,0.25;1,1;elepower_dynamics:acidic_compound;elepower_dynamics:acidic_compound;]"..
															"hypertext[0.375,0.9;1,1;num;<style size=12><right><b>01</b></right></style>]"..
															"image[1.5,0.375;0.75,0.75;elepower_tome_mouse_rght_click.png]"..
															"tooltip[1.5,0.25;0.75,0.75;Right Click;#30434c;#f9f9f9]"..
															"item_image_button[2.375,0.25;1,1;default:water_source;default:water_source;]"..
															"hypertext[2.375,0.9;1,1;num;<style size=12><right><b>01</b></right></style>]"..
															"image[3.5,0.375;0.75,0.75;elepower_tome_icon_output.png]"..
															"tooltip[3.5,0.25;0.75,0.75;Turns Into;#30434c;#f9f9f9]"..
															"item_image_button[4.325,0.25;1,1;elepower_dynamics:etching_acid_source;elepower_dynamics:etching_acid_source;]"..
															"hypertext[4.325,0.9;1,1;num;<style size=12><right><b>01</b></right></style>]"..           
															"container_end[]"..
															-- line 3
															"container[1.125,2.5]"..
															"item_image_button[0.375,0.25;1,1;default:copper_ingot;default:copper_ingot;]"..
															"hypertext[0.375,0.9;1,1;num;<style size=12><right><b>05</b></right></style>]"..
															"item_image_button[1.5,0.25;1,1;default:gold_ingot;default:gold_ingot;]"..
															"hypertext[1.5,0.9;1,1;num;<style size=12><right><b>03</b></right></style>]"..
															"item_image_button[2.625,0.25;1,1;default:mese_crystal;default:mese_crystal;]"..
															"hypertext[2.625,0.9;1,1;num;<style size=12><right><b>01</b></right></style>]"..																																						
															"image[3.75,0.375;0.75,0.75;elepower_tome_icon_crafting.png]"..
															"tooltip[3.75,0.25;0.75,0.75;Crafting;#30434c;#f9f9f9]"..
															"item_image_button[4.625,0.25;1,1;elepower_dynamics:pcb_blank;elepower_dynamics:pcb_blank;]"..
															"hypertext[4.625,0.9;1,1;num;<style size=12><right><b>03</b></right></style>]"..																											
															"container_end[]"..
															-- line 4
															"container[1.25,3.75]"..
															"item_image_button[0.375,0.25;1,1;elepower_dynamics:pcb_blank;elepower_dynamics:pcb_blank;]"..
															"hypertext[0.375,0.9;1,1;num;<style size=12><right><b>01</b></right></style>]"..
															"image[1.5,0.375;0.75,0.75;elepower_tome_mouse_rght_click.png]"..
															"tooltip[1.5,0.25;0.75,0.75;Right Click;#30434c;#f9f9f9]"..
															"item_image_button[2.375,0.25;1,1;elepower_dynamics:etching_acid_source;elepower_dynamics:etching_acid_source;]"..
															"hypertext[2.375,0.9;1,1;num;<style size=12><right><b>01</b></right></style>]"..
															"image[3.5,0.375;0.75,0.75;elepower_tome_icon_output.png]"..
															"tooltip[3.5,0.25;0.75,0.75;Turns Into;#30434c;#f9f9f9]"..
															"item_image_button[4.325,0.25;1,1;elepower_dynamics:pcb;elepower_dynamics:pcb;]"..
															"hypertext[4.325,0.9;1,1;num;<style size=12><right><b>01</b></right></style>]"..															
															"container_end[]"..															
															"container_end[]"

											               }
											  }

eletome.ai.nodes["upgrading_machines"] = { how_use_1 = "Some machines can be upgraded to improve their power storage capacity, "..
													   "production speed or to make them more power efficient. To upgrade machines "..
													   "you need to craft a soldering iron so you can fit new parts to the machine.\n "..
													   "To craft a soldering iron you will need: 126 leaves, 8 silver ingots, 8 tin ingots, "..
													   "5 coal lumps, 4 zinc ingots, 2 lead ingots, 2 mese crystal fragments and 1 steel ingot. "..
													   "Detailed crafting instructions are on the right page.\nOnce you have your Soldering Iron "..
													   "simply hold the the tool and then left click on any machine and if it is "..
													   "upgradable you will be able to add components.",
										   hu_img_2  = {"container[0,0]"..
														"style_type[item_image_button;bgimg=elepower_tome_bgimg_2.png]"..													
														-- line 1
														"container[0.15,-0.1]"..
														"item_image_button[0.375,0.25;1,1;default:blueberry_bush_leaves;leaves;]"..
														"tooltip[leaves;Any Leaves;#30434c;#f9f9f9]"..
														"style[num;font_size=-2;font=bold;textcolor=#FFF]"..
														"hypertext[0.375,0.9;1,1;num;<style size=12><right><b>126</b></right></style>]"..
														"image[1.5,0.375;0.75,0.75;elepower_tome_icon_crafting.png]"..
														"tooltip[1.5,0.375;0.75,0.75;Crafting;#30434c;#f9f9f9]"..
														"item_image_button[2.375,0.25;1,1;basic_materials:oil_extract;basic_materials:oil_extract;]"..
														"hypertext[2.375,0.9;1,1;num;<style size=12><right><b>42</b></right></style>]"..
														"image[3.5,0.375;0.75,0.75;elepower_tome_icon_cooking.png]"..
														"tooltip[3.5,0.375;0.75,0.75;Cooking;#30434c;#f9f9f9]"..
														"item_image_button[4.375,0.25;1,1;basic_materials:paraffin;basic_materials:paraffin;]"..
														"hypertext[4.375,0.9;1,1;num;<style size=12><right><b>42</b></right></style>]"..
														"image[5.5,0.375;0.75,0.75;elepower_tome_icon_cooking.png]"..
														"tooltip[5.5,0.375;0.75,0.75;Cooking;#30434c;#f9f9f9]"..
														"item_image_button[6.375,0.25;1,1;basic_materials:plastic_sheet;basic_materials:plastic_sheet;]"..
														"hypertext[6.375,0.9;1,1;num;<style size=12><right><b>42</b></right></style>]"..
														"image[0,1.36;7.75,0.05;elepower_tome_bgimg_sep.png]"..
														"container_end[]"..	
														-- line 2
														"container[0.75,1.15]"..                                                                                                                                                                                   
														"item_image_button[0.375,0.25;1,1;basic_materials:plastic_sheet;basic_materials:plastic_sheet;]"..
														"hypertext[0.375,0.9;1,1;num;<style size=12><right><b>42</b></right></style>]"..
														"image[1.5,0.375;0.75,0.75;elepower_tome_icon_crafting.png]"..
														"tooltip[1.5,0.375;0.75,0.75;Crafting;#30434c;#f9f9f9]"..
														"item_image_button[2.375,0.25;1,1;basic_materials:empty_spool;basic_materials:empty_spool;]"..
														"hypertext[2.375,0.9;1,1;num;<style size=12><right><b>16</b></right></style>]"..
														"item_image_button[3.5,0.25;1,1;moreores:silver_ingot;moreores:silver_ingot;]"..
														"hypertext[3.5,0.9;1,1;num;<style size=12><right><b>08</b></right></style>]"..
														"image[4.625,0.375;0.75,0.75;elepower_tome_icon_crafting.png]"..
														"tooltip[4.625,0.375;0.75,0.75;Crafting;#30434c;#f9f9f9]"..
														"item_image_button[5.5,0.25;1,1;basic_materials:silver_wire;basic_materials:silver_wire;]"..
														"hypertext[5.5,0.9;1,1;num;<style size=12><right><b>08</b></right></style>]"..
														"image[-0.65,1.36;7.75,0.05;elepower_tome_bgimg_sep.png]"..														
														"container_end[]"..
													-- line 3
														"container[1.75,2.4]"..
														"item_image_button[0.375,0.25;1,1;basic_materials:silver_wire;basic_materials:silver_wire;]"..
														"hypertext[0.375,0.9;1,1;num;<style size=12><right><b>08</b></right></style>]"..
														"item_image_button[1.5,0.25;1,1;elepower_dynamics:zinc_ingot;elepower_dynamics:zinc_ingot;]"..
														"hypertext[1.5,0.9;1,1;num;<style size=12><right><b>02</b></right></style>]"..
														"image[2.625,0.375;0.75,0.75;elepower_tome_icon_crafting.png]"..
														"tooltip[2.625,0.375;0.75,0.75;Crafting;#30434c;#f9f9f9]"..
														"item_image_button[3.5,0.25;1,1;elepower_dynamics:wound_silver_coil;elepower_dynamics:wound_silver_coil;]"..
														"hypertext[3.5,0.9;1,1;num;<style size=12><right><b>02</b></right></style>]"..
														"image[-1.65,1.36;7.75,0.05;elepower_tome_bgimg_sep.png]"..	
														"container_end[]"..	
													-- line 4
														"container[-0.4,3.65]"..
														"item_image_button[0.375,0.25;1,1;default:coal_lump;default:coal_lump;]"..
														"hypertext[0.375,0.9;1,1;num;<style size=12><right><b>04</b></right></style>]"..
														"image[1.5,0.375;0.75,0.75;elepower_tome_icon_grinding.png]"..
														"tooltip[1.5,0.25;0.75,0.75;Grinding;#30434c;#f9f9f9]"..
														"item_image_button[2.375,0.25;1,1;elepower_dynamics:coal_dust;elepower_dynamics:coal_dust;]"..
														"hypertext[2.375,0.9;1,1;num;<style size=12><right><b>04</b></right></style>]"..
														"item_image_button[3.5,0.25;1,1;default:coal_lump;default:coal_lump;]"..
														"hypertext[3.5,0.9;1,1;num;<style size=12><right><b>01</b></right></style>]"..
														"image[4.625,0.375;0.75,0.75;elepower_tome_icon_alloying.png]"..
														"tooltip[4.625,0.375;0.75,0.75;Alloying;#30434c;#f9f9f9]"..
														"item_image_button[5.5,0.25;1,1;elepower_dynamics:graphite_ingot;elepower_dynamics:graphite_ingot;]"..
														"hypertext[5.5,0.9;1,1;num;<style size=12><right><b>01</b></right></style>]"..
														"image[6.625,0.375;0.75,0.75;elepower_tome_icon_grinding.png]"..
														"tooltip[6.625,0.25;0.75,0.75;Grinding;#30434c;#f9f9f9]"..
														"item_image_button[7.5,0.25;1,1;elepower_dynamics:graphite_rod;elepower_dynamics:graphite_rod;]"..
														"hypertext[7.5,0.9;1,1;num;<style size=12><right><b>03</b></right></style>]"..
														"image[0.55,1.36;7.75,0.05;elepower_tome_bgimg_sep.png]"..
														"container_end[]"..	
													-- line 5
														"container[2.25,4.9]"..
														"item_image_button[0.375,0.25;1,1;default:tin_ingot;default:tin_ingot;]"..
														"hypertext[0.375,0.9;1,1;num;<style size=12><right><b>08</b></right></style>]"..
														"image[1.5,0.375;0.75,0.75;elepower_tome_icon_compressing.png]"..
														"tooltip[1.5,0.375;0.75,0.75;Compressing;#30434c;#f9f9f9]"..
														"item_image_button[2.375,0.25;1,1;elepower_dynamics:tin_plate;elepower_dynamics:tin_plate;]"..
														"hypertext[2.375,0.9;1,1;num;<style size=12><right><b>04</b></right></style>]"..
														"image[-2.15,1.36;7.75,0.05;elepower_tome_bgimg_sep.png]"..														
														"container_end[]"..
													-- line 6
														"container[0.25,6.15]"..
														"item_image_button[0.375,0.25;1,1;elepower_dynamics:zinc_ingot;elepower_dynamics:zinc_ingot;]"..
														"hypertext[0.375,0.9;1,1;num;<style size=12><right><b>02</b></right></style>]"..
														"image[1.5,0.375;0.75,0.75;elepower_tome_icon_grinding.png]"..
														"tooltip[1.5,0.375;0.75,0.75;Grinding;#30434c;#f9f9f9]"..
														"item_image_button[2.375,0.25;1,1;elepower_dynamics:zinc_dust;elepower_dynamics:zinc_dust;]"..
														"hypertext[2.375,0.9;1,1;num;<style size=12><right><b>01</b></right></style>]"..
														"item_image_button[4.375,0.25;1,1;elepower_dynamics:lead_ingot;elepower_dynamics:lead_ingot;]"..
														"hypertext[4.375,0.9;1,1;num;<style size=12><right><b>02</b></right></style>]"..
														"image[5.5,0.375;0.75,0.75;elepower_tome_icon_grinding.png]"..
														"tooltip[5.5,0.375;0.75,0.75;Grinding;#30434c;#f9f9f9]"..
														"item_image_button[6.375,0.25;1,1;elepower_dynamics:lead_dust;elepower_dynamics:lead_dust;]"..
														"hypertext[6.375,0.9;1,1;num;<style size=12><right><b>01</b></right></style>]"..
														"image[-0.15,1.36;7.75,0.05;elepower_tome_bgimg_sep.png]"..															
														"container_end[]"..
													-- line 7
														"container[0,7.4]"..
														"item_image_button[0.25,0.25;1,1;elepower_dynamics:tin_plate;elepower_dynamics:tin_plate;]"..
														"hypertext[0.25,0.9;1,1;num;<style size=12><right><b>04</b></right></style>]"..
														"item_image_button[1.375,0.25;1,1;default:mese_crystal_fragment;default:mese_crystal_fragment;]"..
														"hypertext[1.375,0.9;1,1;num;<style size=12><right><b>02</b></right></style>]"..
														"item_image_button[2.5,0.25;1,1;elepower_dynamics:graphite_rod;elepower_dynamics:graphite_rod;]"..
														"hypertext[2.5,0.9;1,1;num;<style size=12><right><b>01</b></right></style>]"..
														"item_image_button[3.625,0.25;1,1;elepower_dynamics:zinc_dust;elepower_dynamics:zinc_dust;]"..
														"hypertext[3.625,0.9;1,1;num;<style size=12><right><b>01</b></right></style>]"..
														"item_image_button[4.75,0.25;1,1;elepower_dynamics:lead_dust;elepower_dynamics:lead_dust;]"..
														"hypertext[4.75,0.9;1,1;num;<style size=12><right><b>01</b></right></style>]"..
														"image[5.875,0.375;0.75,0.75;elepower_tome_icon_crafting.png]"..
														"tooltip[5.875,0.375;0.75,0.75;Crafting;#30434c;#f9f9f9]"..
														"item_image_button[6.75,0.25;1,1;elepower_dynamics:battery;elepower_dynamics:battery;]"..
														"hypertext[6.75,0.9;1,1;num;<style size=12><right><b>02</b></right></style>]"..
														"image[0.1,1.36;7.75,0.05;elepower_tome_bgimg_sep.png]"..	
														"container_end[]"..	
													-- line 8
														"container[1,8.65]"..
														"item_image_button[0.375,0.25;1,1;default:steel_ingot;default:steel_ingot;]"..
														"hypertext[0.375,0.9;1,1;num;<style size=12><right><b>01</b></right></style>]"..
														"item_image_button[1.5,0.25;1,1;elepower_dynamics:wound_silver_coil;elepower_dynamics:wound_silver_coil;]"..
														"hypertext[1.5,0.9;1,1;num;<style size=12><right><b>02</b></right></style>]"..
														"item_image_button[2.625,0.25;1,1;elepower_dynamics:battery;elepower_dynamics:battery;]"..
														"hypertext[2.625,0.9;1,1;num;<style size=12><right><b>01</b></right></style>]"..																																						
														"image[3.75,0.375;0.75,0.75;elepower_tome_icon_crafting.png]"..
														"tooltip[3.75,0.25;0.75,0.75;Crafting;#30434c;#f9f9f9]"..
														"item_image_button[4.625,0.25;1,1;elepower_tools:soldering_iron;elepower_tools:soldering_iron;]"..
														"hypertext[4.625,0.9;1,1;num;<style size=12><right><b>01</b></right></style>]"..
														"container_end[]"..														
														"container_end[]"}

									     }

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
															lb_btm_tt = " used per second",
															}	

eletome.ai.nodes["elepower_machines:electrolyzer"]      = {lb_top_img = "elepower_gui_icon_fluid_electrolyzer_in.png", lb_top_tt  = "Fluids",
														   how_use_1 = "The Electrolyzer is used to create gases out of certain fluids. The electrolyzer can accept three "..
																	 "fluids/liquids, although not at the same time - water, heavy water and biomass. The electrolyzer will "..
																	 "at the cost of 128 EpUs a second break each down into different gases, see table below\n ",
														   how_use_2 = "To extract gas from the electrolyzer you will need a fluid pump, bucketeer and an empty gas canister. "..
																	 "The electrolyzer can only output to a single bucketeer so you will need to empty one gas completely before "..
																	 "you will be able to bottle the second gas (always oxygen).",
														   hu_img_1   = "elepower_tome_electrolyzer_outputs.png",
														   hu_img_2   = "elepower_tome_electrolyzer_assemble.png"
														  }
														  
eletome.ai.nodes["elepower_farming:harvester"]      = {lb_top_img = "farming_wheat.png",lb_top_tt  = "Crops\n   or\nTrees"}


eletome.ai.nodes["elepower_farming:planter"]      = {lb_top_img = "farming_wheat_seed.png",
													 lb_top_tt  = "Seeds or Seedlings",
													 how_use_1  = "The automatic planter is used to keep a maximum 9x9 field planted with crops. The planter needs to be placed 1 node "..
															      "below the ground surface, however it is waterproof and functions perfectly with a node of water above it.\n "..
																  "The planter, plants from the most north westerly 3x3 block of nodes (top left corner) to the most south easterly "..
																  "3x3 block of nodes (bottom right corner).",
													 how_use_2  = "The planter has a special interface to allow it to plant. The upper 3x3 grid represents a maximum area of 9x9 around the "..
																  "planter ie each grid segment represents a 3x3 area of nodes. The bottom 2 rows of 8 is the planters avaliable inventory of ".. 
																  "items. There must be items of the type specified in the planting grid avaliable in the inventory area for the planter to be "..
																  "able to plant, so keep the planters inventory well stocked with seeds or seedlings.",
													 hu_img_1   = "elepower_tome_complex_auto_planter.png",
													 hu_img_2   = "elepower_tome_complex_auto_planter_2.png"
													}

eletome.ai.nodes["elepower_machines:canning_machine"] = {lb_top_img = "elepower_tome_icon_canning.png",lb_top_tt  = "Canning"}

eletome.ai.nodes["elepower_machines:compressor"]      = {lb_top_img = "elepower_tome_icon_compressing.png",lb_top_tt  = "Compressing"}

eletome.ai.nodes["elepower_machines:evaporator"]      = {lb_top_img = "elepower_gui_icon_fluid_water.png",lb_top_tt  = "Fluids"}

eletome.ai.nodes["elepower_machines:lava_cooler"]     = {lb_top_img = "elepower_gui_icon_fluid_water_lava.png",lb_top_tt  = "Water\n and\nLava"}

eletome.ai.nodes["elepower_machines:furnace"]         = {lb_top_img = "elepower_tome_icon_cooking.png",lb_top_tt  = "Cooking"}

eletome.ai.nodes["elepower_machines:pcb_plant"]       = {lb_top_img = "elepower_pcb.png",lb_top_tt  = "Creates PCB's"}

eletome.ai.nodes["elepower_machines:pulverizer"]      = {lb_top_img = "elepower_tome_icon_grinding.png",lb_top_tt  = "Grinding"}

eletome.ai.nodes["elepower_machines:sawmill"]         = {lb_top_img = "elepower_sawmill.png",lb_top_tt  = "Sawing"}

eletome.ai.nodes["elepower_machines:solderer"]        = {lb_top_img = "elepower_upgrade_efficiency_2.png",lb_top_tt  = "       Creates\n Machine Upgrades"}

eletome.ai.nodes["elepower_farming:tree_processor"]   = {lb_top_img = "elepower_gui_icon_fluid_water.png",lb_top_tt  = "Processes\n Tree Sap"}

-- Wind Turbine
eletome.ai.nodes["elepower_machines:wind_turbine"]    = {lb_top_img = "elepower_tome_wind.png",
														   lb_top_tt = "Wind",
														   lb_btm_img = "100",
														   lb_btm_tt = " Epu Max\n   Potential\n  Production"}

eletome.ai.nodes["elepower_machines:wind_turbine_blade"]  = {lb_top_img = "", lb_top_tt = "", lb_btm_img = "", lb_btm_tt =""}
eletome.ai.nodes["elepower_machines:wind_turbine_blades"] = {lb_top_img = "", lb_top_tt = "", lb_btm_img = "", lb_btm_tt =""}


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
