------------------------------------------------------------ 
--              ___ _                                     --
--             | __| |___ _ __  _____ __ _____ _ _        --
--             | _|| / -_) '_ \/ _ \ V  V / -_) '_|       --
--             |___|_\___| .__/\___/\_/\_/\___|_|         --
--              ___     _|_|                  _           --
--             | __|_ _| |_ ___ _ _ _ _  __ _| |          --
--             | _|\ \ /  _/ -_) '_| ' \/ _` | |          --
--             |___/_\_\\__\___|_| |_||_\__,_|_|          --
------------------------------------------------------------
--    These are all the nodes and items used by elepower  --
--       which are not contained in this mod. These       --
--     names/references can be updated to more easily     --
--     integrate elepower with non-minetest game, game.   --
------------------------------------------------------------
------------
-- Tables --
------------
ele.external = {}
ele.external.ref = {}
ele.external.ing = {}
ele.external.tools = {}
ele.external.armor = {}
ele.external.sounds = {}
ele.external.graphic = {}

-----------
-- Index --
-----------
--- settings to update............line 34
--- elepower_papi.................line 171
--- elepower_dynamics.............line 192
--- elepower_machines.............line 315
--- elepower_tools................line 576
--- elepower_farming..............line 627
--- elepower_solar................line 732
--- elepower_thermal..............line 768
--- elepower_mining...............line 801
--- elepower_nuclear..............line 829
--- elepower_wireless.............line 917
--- elepower_lighting.............line 991
--- elepower_tome.................line 1048

------------------------------------------------------------
--         _   _ _   ___      _   _   _                   --
--        /_\ | | | / __| ___| |_| |_(_)_ _  __ _ ___     --
--       / _ \| | | \__ \/ -_)  _|  _| | ' \/ _` (_-<     --
--      /_/ \_\_|_| |___/\___|\__|\__|_|_||_\__, /__/     --
--                                          |___/         --
------------------------------------------------------------
--     Update these refs to new values/names to remove    -- 
--               elepower reliance on default             --
------------------------------------------------------------
-------------
-- General --
-------------
ele.external.tools.enable_iron_lead_tools    = true   -- split in two
ele.external.armor.enable_iron_armor         = true
ele.external.armor.enable_carbon_fiber_armor = true

ele.external.conduit_dirt_with_grass      = true
ele.external.conduit_dirt_with_dry_grass  = true
ele.external.conduit_stone_block          = true
ele.external.conduit_stone_block_desert   = true

----------------
-- References -- 
----------------
ele.external.ref.gui_bg        = default.gui_bg
ele.external.ref.gui_bg_img    = default.gui_bg_img
ele.external.ref.gui_slots     = default.gui_slots
ele.external.ref.get_hotbar_bg = default.get_hotbar_bg
ele.external.ref.water_source  = "default:water_source"  -- convert to ing
ele.external.ref.stone         = "default:stone"         -- convert to ing

-------------------------------------------------
-- Ingredients or node item references in code --
-------------------------------------------------
ele.external.ing.group_stick        = "group:stick"
ele.external.ing.group_stone        = "group:stone"
ele.external.ing.group_color_red    = "group:color_red"
ele.external.ing.group_color_green  = "group:color_green"
ele.external.ing.group_color_blue   = "group:color_blue"
ele.external.ing.group_color_black  = "group:color_black"
ele.external.ing.group_color_violet = "group:color_violet"
ele.external.ing.group_wood         = "group:wood"

ele.external.ing.dirt          = "default:dirt"       -- only used by conduit_dirt_with_grass/dry_grass
ele.external.ing.wheat         = "farming:wheat"      -- only used by conduit_dirt_with_dry_grass
ele.external.ing.glass         = "default:glass"
ele.external.ing.seed_wheat    = "farming:seed_wheat" -- essential to acidic compound
ele.external.ing.iron_lump     = "default:iron_lump"
ele.external.ing.coal_lump     = "default:coal_lump"
ele.external.ing.copper_ingot  = "default:copper_ingot"
ele.external.ing.silver_ingot  = "moreores:silver_ingot"
ele.external.ing.gold_ingot    = "default:gold_ingot"
ele.external.ing.tin_ingot     = "default:tin_ingot"
ele.external.ing.bronze_ingot  = "default:bronze_ingot"
ele.external.ing.steel_ingot   = "default:steel_ingot"
ele.external.ing.mithril_ingot = "moreores:mithril_ingot"
ele.external.ing.steel_block   = "default:steelblock"
ele.external.ing.diamond_block = "default:diamondblock"
ele.external.ing.mese          = "default:mese"
ele.external.ing.mese_crystal  = "default:mese_crystal"
ele.external.ing.mese_crystal_fragment = "default:mese_crystal_fragment"
ele.external.ing.mese_lamp     = "default:meselamp"
ele.external.ing.flour         = "farming:flour"
ele.external.ing.sand          = "default:sand"
ele.external.ing.desert_sand   = "default:desert_sand"
ele.external.ing.cobble        = "default:cobble"
ele.external.ing.gravel        = "default:gravel"
ele.external.ing.brick         = "default:brick" 
ele.external.ing.flint         = "default:flint"
ele.external.ing.clay_brick    = "default:clay_brick"
ele.external.ing.obsidian      = "default:obsidian"
ele.external.ing.lava_source   = "default:lava_source"
ele.external.ing.hoe_steel     = "farming:hoe_steel"
ele.external.ing.axe_steel     = "default:axe_steel"
ele.external.ing.tree          = "default:tree"
ele.external.ing.leaves        = "default:leaves"
ele.external.ing.apple         = "default:apple"
ele.external.ing.jungle_tree   = "default:jungletree"
ele.external.ing.jungle_leaves = "default:jungleleaves"
ele.external.ing.pine_tree     = "default:pine_tree"
ele.external.ing.pine_needles  = "default:pine_needles"
ele.external.ing.acacia_tree   = "default:acacia_tree"
ele.external.ing.acacia_leaves = "default:acacia_leaves"
ele.external.ing.aspen_tree    = "default:aspen_tree"
ele.external.ing.aspen_leaves  = "default:aspen_leaves"
ele.external.ing.slab_wood     = "stairs:slab_wood"
ele.external.ing.stick         = "default:stick"
ele.external.ing.paper         = "default:paper"             -- elepower_lighting decorative shades only 
ele.external.ing.farming_soil  = "farming:soil"
ele.external.ing.farming_soil_wet = "farming:soil_wet"
ele.external.ing.slab_glass    = "stairs:slab_glass"
ele.external.ing.dye_red       = "dye:red"
ele.external.ing.dye_green     = "dye:green"
ele.external.ing.dye_blue      = "dye:blue"
ele.external.ing.furnace       = "default:furnace"
ele.external.ing.obsidian_glass = "default:obsidian_glass"
ele.external.ing.slab_stone_block = "stairs:slab_stone_block"
ele.external.ing.blueberry_bush_leaves = "default:blueberry_bush_leaves"
ele.external.ing.slab_desert_stone_block = "stairs:slab_desert_stone_block"

------------
-- Sounds --
------------
ele.external.sounds.node_sound_stone = default.node_sound_stone_defaults()
ele.external.sounds.node_sound_water = default.node_sound_water_defaults()
ele.external.sounds.node_sound_stone = default.node_sound_stone_defaults()
ele.external.sounds.node_sound_wood  = default.node_sound_wood_defaults()
ele.external.sounds.node_sound_glass = default.node_sound_glass_defaults()
ele.external.sounds.node_sound_metal = default.node_sound_metal_defaults()
ele.external.sounds.tool_breaks      = "default_tool_breaks"
ele.external.sounds.dig_crumbly      = "default_dig_crumbly"
ele.external.sounds.node_sound_dirt_c = default.node_sound_dirt_defaults(
										{
											footstep = {name = "default_grass_footstep", gain = 0.25}
										})
---------------------
-- Graphics/Images --
---------------------
ele.external.graphic.water               = "default_water.png"
ele.external.graphic.grass               = "default_grass.png"
ele.external.graphic.dirt                = "default_dirt.png"
ele.external.graphic.grass_side          = "default_grass_side.png"
ele.external.graphic.grass_dry           = "default_dry_grass.png"
ele.external.graphic.grass_side_dry      = "default_dry_grass_side.png"
ele.external.graphic.stone_block         = "default_stone_block.png"
ele.external.graphic.desert_stone_block  = "default_desert_stone_block.png"
ele.external.graphic.stone               = "default_stone.png"
ele.external.graphic.wood                = "default_wood.png"
ele.external.graphic.obsidian_glass      = "default_obsidian_glass.png"
ele.external.graphic.furnace_fire_bg     = "default_furnace_fire_bg.png"
ele.external.graphic.furnace_fire_fg     = "default_furnace_fire_fg.png"
ele.external.graphic.gui_furnace_arrow_bg = "gui_furnace_arrow_bg.png"
ele.external.graphic.gui_furnace_arrow_fg = "gui_furnace_arrow_fg.png"



------------------------------------------------------------
--  ___ _                                ___           _  --
-- | __| |___ _ __  _____ __ _____ _ _  | _ \__ _ _ __(_) --
-- | _|| / -_) '_ \/ _ \ V  V / -_) '_| |  _/ _` | '_ \ | --
-- |___|_\___| .__/\___/\_/\_/\___|_|   |_| \__,_| .__/_| --
--           |_|                                 |_|      --
------------------------------------------------------------
--     Other mods nodes/items used by elepower_papi       --
------------------------------------------------------------
------------------
-- formspec.lua --
------------------
-- uses graphic.water

-----------------
-- helpers.lua --
-----------------
-- uses sounds.node_sound_water

-- rest NIL

------------------------------------------------------------
--            ___ _                                       --
--           | __| |___ _ __  _____ __ _____ _ _          --
--           | _|| / -_) '_ \/ _ \ V  V / -_) '_|         --
--           |___|_\___| .__/\___/\_/\_/\___|_|           --
--            ___      |_|              _                 --
--           |   \ _  _ _ _  __ _ _ __ (_)__ ___          --
--           | |) | || | ' \/ _` | '  \| / _(_-<          --
--           |___/ \_, |_||_\__,_|_|_|_|_\__/__/          --
--                 |__/                                   --
------------------------------------------------------------
--   Other mods nodes/items used by elepower_dynamics     --
------------------------------------------------------------
--------------------
-- components.lua --
--------------------
-- NIL

------------------
-- conduits.lua --
------------------
-- if any are false also disables craft recipe
-- uses conduit_dirt_with_grass
-- uses conduit_dirt_with_dry_grass
-- uses conduit_stone_block
-- uses conduit_stone_block_desert
-- uses tools.enable_iron_lead_tools
-- uses graphic.grass
-- uses graphic.dirt
-- uses graphic.grass_side
-- uses graphic.grass_dry
-- uses graphic.grass_side_dry
-- uses graphic.stone_block
-- uses graphic.desert_stone_block
-- uses sounds.node_sound_dirt_c
-- uses .sounds.node_sound_stone

------------------
-- crafting.lua --
------------------
-- uses ing.group_stick
-- uses ing.group_stone
-- uses ing.group_color_red
-- uses ing.group_color_green
-- uses ing.group_color_blue
-- uses ing.group_color_black
-- uses ing.group_color_violet
-- uses ing.dirt
-- uses ing.wheat
-- uses ing.slab_stone_block
-- uses ing.slab_desert_stone_block
-- uses ing.glass
-- uses ing.seed_wheat
-- uses ing.iron_lump
-- uses ing.coal_lump
-- uses ing.copper_ingot
-- uses ing.silver_ingot
-- uses ing.gold_ingot
-- uses ing.tin_ingot
-- uses ing.bronze_ingot
-- uses ing.steel_ingot
-- uses ing.mithril_ingot
-- uses ing.mese_crystal
-- uses ing.mese_crystal_fragment
-- uses ing.mese_lamp

-- uses tools.enable_iron_lead_tools

--------------------
-- craftitems.lua --
--------------------
-- uses ref.water_source
-- uses ing.steel_ingot

----------------
-- fluids.lua --
----------------
-- uses ref.water_source

-----------------------
-- gas_container.lua --
-----------------------
-- NIL

----------------
-- nodes.lua --
---------------
-- uses graphic.stone
-- uses graphic.obsidian_glass
-- uses sounds.node_sound_stone
-- uses sounds.node_sound_wood
-- uses sounds.node_sound_glass
-- uses sounds.node_sound_metal

---------------
-- tanks.lua --
---------------

-- NIL

---------------
-- tools.lua --
---------------
-- not registered if "ele.external.tools.enable_iron_lead_tools = false"
-- uses sounds.tool_breaks


------------------
-- worldgen.lua --
------------------
-- uses ref.stone

----------------------
-- subfolder compat --
----------------------
-------------------------
-- basic_materials.lua --
-------------------------
-- uses ing.copper_ingot
-- uses ing.silver_ingot
-- uses ing.steel_ingot
-- uses ing.mese_crystal_fragment

------------------------------------------------------------
--            ___ _                                       --
--           | __| |___ _ __  _____ __ _____ _ _          --
--           | _|| / -_) '_ \/ _ \ V  V / -_) '_|         --
--           |___|_\___| .__/\___/\_/\_/\___|_|           --
--            __  __   |_|   _    _                       --
--           |  \/  |__ _ __| |_ (_)_ _  ___ ___          --
--           | |\/| / _` / _| ' \| | ' \/ -_|_-<          --
--           |_|  |_\__,_\__|_||_|_|_||_\___/__/          --
------------------------------------------------------------
--   Other mods nodes/items used by elepower_machines     -- 
------------------------------------------------------------
---------------
-- craft.lua --
---------------
-- NIL


------------------
-- crafting.lua --
------------------
-- uses ing.steel_ingot
-- uses ing.copper_ingot
-- uses ing.tin_ingot
-- uses ing.bronze_ingot
-- uses ing.gold_ingot
-- uses ing.silver_ingot
-- uses ing.coal_lump
-- uses ing.wheat
-- uses ing.mese_crystal
-- uses ing.mese_crystal_fragment
-- uses ing.group_stick
-- uses ing.group_stone
-- uses ing.glass
-- uses ing.obsidian_glass
-- uses ing.flour
-- uses ing.sand
-- uses ing.desert_sand
-- uses ing.cobble
-- uses ing.gravel
-- uses ing.mese
-- uses ing.group_wood
-- uses ing.brick
-- uses ing.flint
-- uses ing.clay_brick
-- uses ing.steel_block

--------------------
-- craftitems.lua --
--------------------
-- NIL

---------------
-- nodes.lua --
---------------
-- NIL

-------------------
-- upgrading.lua --
-------------------
-- NIL

------------------------
-- subfolder machines --
------------------------
---------------------
-- accumulator.lua --
---------------------
-- uses ref.water_source

---------------------
-- alloy_furnace.lua --
---------------------
-- NIL

---------------------
-- bucketer.lua --
---------------------
-- uses ref.gui_bg
-- uses ref.gui_bg_img
-- uses ref.gui_slots
-- uses ref.get_hotbar_bg

-------------------------
-- canning_machine.lua --
-------------------------
-- NIL

----------------------------
-- coal_alloy_furnace.lua --
----------------------------
-- uses ref.gui_bg
-- uses ref.gui_bg_img
-- uses ref.gui_slots
-- uses ref.get_hotbar_bg
-- uses graphic.furnace_fire_bg
-- uses graphic.furnace_fire_fg
-- uses graphic.gui_furnace_arrow_bg
-- uses graphic.gui_furnace_arrow_fg

-------------------------
-- compressor.lua --
-------------------------
-- NIL

----------------------
-- electrolyzer.lua --
----------------------
-- uses ref.water_source
-- uses ref.gui_bg
-- uses ref.gui_bg_img
-- uses ref.gui_slots
-- uses ref.get_hotbar_bg

--------------------
-- evaporator.lua --
--------------------
-- uses ref.gui_bg
-- uses ref.gui_bg_img
-- uses ref.gui_slots
-- uses ref.get_hotbar_bg
-- uses graphic.gui_furnace_arrow_bg

---------------------
-- fuel_burner.lua --
---------------------
-- NIL

-----------------
-- furnace.lua --
-----------------
-- NIL

-------------------
-- generator.lua --
-------------------
-- NIL

--------------------
-- grindstone.lua --
--------------------
-- uses ref.gui_bg
-- uses ref.gui_bg_img
-- uses ref.gui_slots
-- uses ref.get_hotbar_bg
-- uses graphic.gui_furnace_arrow_fg
-- uses graphic.gui_furnace_arrow_bg
-- uses graphic.wood

---------------------
-- lava_cooler.lua --
---------------------
-- uses ing.cobble
-- uses ref.stone
-- uses ref.water_source
-- uses ref.gui_bg
-- uses ref.gui_bg_img
-- uses ref.gui_slots
-- uses ref.get_hotbar_bg
-- uses graphic.gui_furnace_arrow_fg
-- uses graphic.gui_furnace_arrow_bg
-- uses ing.obsidian
-- uses ing.lava_source

------------------------
-- lava_generator.lua --
------------------------
-- uses ing.lava_source

-------------------
-- pcb_plant.lua --
-------------------
-- uses ref.gui_bg
-- uses ref.gui_bg_img
-- uses ref.gui_slots
-- uses ref.get_hotbar_bg
-- uses graphic.gui_furnace_arrow_fg
-- uses graphic.gui_furnace_arrow_bg

--------------------
-- pulverizer.lua --
--------------------
-- NIL

--------------
-- pump.lua --
--------------
-- uses ref.water_source
-- uses ref.gui_bg
-- uses ref.gui_bg_img
-- uses ref.gui_slots
-- uses ref.get_hotbar_bg

-----------------
-- sawmill.lua --
-----------------
-- NIL

------------------
-- solderer.lua --
------------------
-- NIL

-----------------------
-- steam_turbine.lua --
-----------------------
-- uses ref.gui_bg
-- uses ref.gui_bg_img
-- uses ref.gui_slots
-- uses ref.get_hotbar_bg

-----------------
-- storage.lua --
-----------------

----------------------
-- wind_turbine.lua --
----------------------
-- uses ref.gui_bg
-- uses ref.gui_bg_img
-- uses ref.gui_slots
-- uses ref.get_hotbar_bg
-- uses graphic.wood

---------------------
-- subfolder bases --
---------------------
-----------------
-- crafter.lua --
-----------------
-- uses ref.gui_bg
-- uses ref.gui_bg_img
-- uses ref.gui_slots
-- uses ref.get_hotbar_bg

-------------------------
-- fluid_generator.lua --
-------------------------
-- uses ref.gui_bg
-- uses ref.gui_bg_img
-- uses ref.gui_slots
-- uses ref.get_hotbar_bg
-- uses graphic.gui_furnace_arrow_fg
-- uses graphic.gui_furnace_arrow_bg

-------------------
-- generator.lua --
-------------------
-- uses ref.gui_bg
-- uses ref.gui_bg_img
-- uses ref.gui_slots
-- uses ref.get_hotbar_bg

-----------------
-- storage.lua --
-----------------
-- uses ref.gui_bg
-- uses ref.gui_bg_img
-- uses ref.gui_slots
-- uses ref.get_hotbar_bg

---------------------------------------------------------------
--  ___ _                                _____         _     --  
-- | __| |___ _ __  _____ __ _____ _ _  |_   _|__  ___| |___ --
-- | _|| / -_) '_ \/ _ \ V  V / -_) '_|   | |/ _ \/ _ \ (_-< --
-- |___|_\___| .__/\___/\_/\_/\___|_|     |_|\___/\___/_/__/ --
--           |_|                                             --
---------------------------------------------------------------
--      Other mods nodes/items used by elepower_tools        -- 
---------------------------------------------------------------
---------------
-- armor.lua --
---------------
-- uses armor.enable_iron_armor
-- uses armor.enable_carbon_fiber_armor


------------------
-- crafting.lua --
------------------
--[[ Uses
		ing.steel_ingot
		ing.mese
--]]
-- uses ing.diamond_block

--------------------
-- craftitems.lua --
--------------------
-- NIL

--------------------------
-- ed_reconstructor.lua --
--------------------------
-- uses ref.gui_bg
-- uses ref.gui_bg_img
-- uses ref.gui_slots
-- uses ref.get_hotbar_bg

-------------------
-- soldering.lua --
-------------------
-- uses ref.gui_bg
-- uses ref.gui_bg_img
-- uses ref.gui_slots
-- uses ref.get_hotbar_bg

---------------
-- tools.lua --
---------------
-- NIL

------------------------------------------------------------
--            ___ _                                       --
--           | __| |___ _ __  _____ __ _____ _ _          --
--           | _|| / -_) '_ \/ _ \ V  V / -_) '_|         --
--           |___|_\___| .__/\___/\_/\_/\___|_|           --
--            ___      |_|      _                         --
--           | __|_ _ _ _ _ __ (_)_ _  __ _               --
--           | _/ _` | '_| '  \| | ' \/ _` |              --
--           |_|\__,_|_| |_|_|_|_|_||_\__, |              --
--                                    |___/               --
------------------------------------------------------------
--    Other mods nodes/items used by elepower_farming     -- 
------------------------------------------------------------
------------------
-- crafting.lua --
------------------
-- uses ing.glass
-- uses ing.mese_crystal
-- uses ing.hoe_steel
-- uses ing.axe_steel

--------------------
-- craftitems.lua --
--------------------
-- NIL

----------------
-- fluids.lua --
----------------
-- NIL

---------------
-- nodes.lua --
---------------
-- NIL

--------------------
-- treecutter.lua --
--------------------
-- uses ing.tree
-- uses ing.leaves
-- uses ing.apple
-- uses ing.jungle_tree
-- uses ing.jungle_leaves
-- uses ing.pine_tree
-- uses ing.pine_needles
-- uses ing.acacia_tree
-- uses ing.acacia_leaves
-- uses ing.aspen_tree
-- uses ing.aspen_leaves

-- treecutter optionally supports mods farming_plus, ethereal and moretrees

------------------------
-- subfolder machines --
------------------------
-------------------
-- composter.lua --
-------------------
-- uses ref.gui_bg
-- uses ref.gui_bg_img
-- uses ref.gui_slots
-- uses ref.get_hotbar_bg

-------------------
-- harvester.lua --
-------------------
-- uses ref.gui_bg
-- uses ref.gui_bg_img
-- uses ref.gui_slots
-- uses ref.get_hotbar_bg

-----------------
-- planter.lua --
-----------------
-- uses sounds.dig_crumbly
-- uses ing.farming_soil
-- uses ing.farming_soil_wet

-----------------
-- spawner.lua --
-----------------
-- uses ref.gui_bg
-- uses ref.gui_bg_img
-- uses ref.gui_slots
-- uses ref.get_hotbar_bg

------------------------
-- tree_extractor.lua --
------------------------
-- uses ing.tree
-- uses ing.jungle_tree
-- uses ing.pine_tree
-- uses ing.acacia_tree
-- uses ing.aspen_tree

------------------------
-- tree_processor.lua --
------------------------
-- uses ref.gui_bg
-- uses ref.gui_bg_img
-- uses ref.gui_slots
-- uses ref.get_hotbar_bg
-- uses ref.water_source

------------------------------------------------------------
--           ___ _                                        --
--          | __| |___ _ __  _____ __ _____ _ _           --
--          | _|| / -_) '_ \/ _ \ V  V / -_) '_|          --
--          |___|_\___| .__/\___/\_/\_/\___|_|            --
--                 ___|_|   _                             --
--                / __| ___| |__ _ _ _                    --
--                \__ \/ _ \ / _` | '_|                   --
--                |___/\___/_\__,_|_|                     --
------------------------------------------------------------
--      Other mods nodes/items used by elepower_solar     -- 
------------------------------------------------------------  
------------------
-- crafting.lua --
------------------
-- uses ing.glass
-- uses ing.steel_ingot

-------------------
-- generator.lua --
-------------------
-- uses ref.gui_bg
-- uses ref.gui_bg_img
-- uses ref.gui_slots
-- uses ref.get_hotbar_bg

----------------
-- helmet.lua --
----------------
--NIL

------------------
-- register.lua --
------------------
--NIL

------------------------------------------------------------
--            ___ _                                       --
--           | __| |___ _ __  _____ __ _____ _ _          --
--           | _|| / -_) '_ \/ _ \ V  V / -_) '_|         --
--           |___|_\___| .__/\___/\_/\_/\___|_|           --
--             _____ _ |_|                   _            --
--            |_   _| |_  ___ _ _ _ __  __ _| |           --
--              | | | ' \/ -_) '_| '  \/ _` | |           --
--              |_| |_||_\___|_| |_|_|_\__,_|_|           --
------------------------------------------------------------
--    Other mods nodes/items used by elepower_thermal     -- 
------------------------------------------------------------ 
------------------
-- crafting.lua --
------------------
-- NIL

----------------
-- fluids.lua --
----------------
-- NIL

------------------------
-- subfolder machines --
------------------------
---------------------------
-- evaporation_plant.lua --
---------------------------
-- uses ref.water_source
-- uses ref.gui_bg
-- uses ref.gui_bg_img
-- uses ref.gui_slots

------------------------------------------------------------
--          ___ _                                         --
--         | __| |___ _ __  _____ __ _____ _ _            --
--         | _|| / -_) '_ \/ _ \ V  V / -_) '_|           --
--         |___|_\___| .__/\___/\_/\_/\___|_|             --
--              __  _|_|      _                           --
 --            |  \/  (_)_ _ (_)_ _  __ _                 --  
--             | |\/| | | ' \| | ' \/ _` |                --  
--             |_|  |_|_|_||_|_|_||_\__, |                --  
--                                  |___/                 --
------------------------------------------------------------
--     Other mods nodes/items used by elepower_mining     -- 
------------------------------------------------------------ 
------------------
-- crafting.lua --
------------------
-- uses ing.steel_block

---------------
-- miner.lua --
---------------
-- uses ref.water_source
-- uses ref.stone
-- uses ref.gui_bg
-- uses ref.gui_bg_img
-- uses ref.gui_slots
-- uses ref.get_hotbar_bg

------------------------------------------------------------
--           ___ _                                        --
--          | __| |___ _ __  _____ __ _____ _ _           --
--          | _|| / -_) '_ \/ _ \ V  V / -_) '_|          --
--          |___|_\___| .__/\___/\_/\_/\___|_|            --
--              _  _  |_|    _                            --
--             | \| |_  _ __| |___ __ _ _ _               --
--             | .` | || / _| / -_) _` | '_|              --
--             |_|\_|\_,_\__|_\___\__,_|_|                --
------------------------------------------------------------
--     Other mods nodes/items used by elepower_nuclear    -- 
------------------------------------------------------------
------------------
-- crafting.lua --
------------------
-- uses ing.steel_block
-- uses ing.silver_ingot

--------------------
-- craftitems.lua --
--------------------
-- NIL

----------------
-- fluids.lua --
----------------
-- NIL

---------------
-- nodes.lua --
---------------
-- uses graphic.stone
-- uses sounds.node_sound_stone

------------------
-- worldgen.lua --
------------------
-- uses ref.stone

------------------------
-- subfolder machines --
------------------------

-------------------------
--enrichment_plant.lua --
-------------------------
-- uses ref.gui_bg
-- uses ref.gui_bg_img
-- uses ref.gui_slots
-- uses ref.get_hotbar_bg

-------------------------
-- fission_reactor.lua --
-------------------------
-- uses ing.lava_source
-- uses ref.water_source
-- uses ref.gui_bg
-- uses ref.gui_bg_img
-- uses ref.gui_slots
-- uses ref.get_hotbar_bg

------------------------
-- fusion_reactor.lua --
------------------------
-- uses ref.gui_bg
-- uses ref.gui_bg_img
-- uses ref.gui_slots

------------------------
-- heat_exchanger.lua --
------------------------
-- uses ref.water_source
-- uses ref.gui_bg
-- uses ref.gui_bg_img
-- uses ref.gui_slots
-- uses ref.get_hotbar_bg
-- uses graphic.gui_furnace_arrow_bg

---------------------------------
-- solar_neutron_activator.lua --
---------------------------------
-- uses ref.gui_bg
-- uses ref.gui_bg_img
-- uses ref.gui_slots
-- uses ref.get_hotbar_bg
-- uses graphic.gui_furnace_arrow_bg
-- uses graphic.gui_furnace_arrow_fg

------------------------------------------------------------
--            ___ _                                       --
--           | __| |___ _ __  _____ __ _____ _ _          --
--           | _|| / -_) '_ \/ _ \ V  V / -_) '_|         --
--           |___|_\___| .__/\___/\_/\_/\___|_|           --
--             __      |_|         _                      --
--             \ \    / (_)_ _ ___| |___ ______           --
--              \ \/\/ /| | '_/ -_) / -_|_-<_-<           --
--               \_/\_/ |_|_| \___|_\___/__/__/           --                       
------------------------------------------------------------
--    Other mods nodes/items used by elepower_wireless    -- 
------------------------------------------------------------
------------------
-- crafting.lua --
------------------
-- uses ing.steel_block

--------------------
-- craftitems.lua --
--------------------
-- NIL

------------------------
-- subfolder machines --
------------------------
-----------------
-- dialler.lua --
-----------------
-- uses ref.gui_bg
-- uses ref.gui_bg_img
-- uses ref.gui_slots
-- uses ref.get_hotbar_bg

-------------------------
-- matter_receiver.lua --
-------------------------
-- uses ref.gui_bg
-- uses ref.gui_bg_img
-- uses ref.gui_slots
-- uses ref.get_hotbar_bg

----------------------------
-- matter_transmitter.lua --
----------------------------
-- uses ref.gui_bg
-- uses ref.gui_bg_img
-- uses ref.gui_slots
-- uses ref.get_hotbar_bg

-----------------
-- station.lua --
-----------------
-- uses ref.gui_bg
-- uses ref.gui_bg_img
-- uses ref.gui_slots
-- uses ref.get_hotbar_bg

-------------------
-- tesseract.lua --
-------------------
-- NIL

-----------------------
-- subfolder station --
-----------------------

-------------------------
-- fission_reactor.lua --
-------------------------
-- uses ref.gui_bg
-- uses ref.gui_bg_img
-- uses ref.gui_slots
-- uses ref.get_hotbar_bg

------------------------------------------------------------
--             ___ _                                      --
--            | __| |___ _ __  _____ __ _____ _ _         --
--            | _|| / -_) '_ \/ _ \ V  V / -_) '_|        --
--            |___|_\___| .__/\___/\_/\_/\___|_|          --
--              _  (_)  |_| _   _   _                     --
--             | |  (_)__ _| |_| |_(_)_ _  __ _           --
--             | |__| / _` | ' \  _| | ' \/ _` |          --
--             |____|_\__, |_||_\__|_|_||_\__, |          --
--                    |___/               |___/           --
------------------------------------------------------------
--    Other mods nodes/items used by elepower_lighting    -- 
------------------------------------------------------------
--------------------
-- i_crafting.lua --
--------------------
-- uses ing.glass
-- uses ing.slab_glass
-- uses ing.slab_wood
-- uses ing.stick
-- uses ing.dye_red
-- uses ing.dye_green
-- uses ing.dye_blue

---------------------------
-- i_crafting_shades.lua --
---------------------------
-- uses ing.glass
-- uses ing.dye_red
-- uses ing.dye_blue
-- uses ing.paper

----------------------
-- i_craftitems.lua --
----------------------
--NIL

---------------------
-- i_functions.lua --
---------------------
--NIL

---------------------------------
-- i_register_flood_lights.lua --
---------------------------------
--NIL

--------------------------
-- i_register_nodes.lua --
--------------------------
--NIL

---------------------------------
-- i_register_nodes_shades.lua --
---------------------------------
--NIL

------------------------------------------------------------
--            ___ _                                       --
--           | __| |___ _ __  _____ __ _____ _ _          --
--           | _|| / -_) '_ \/ _ \ V  V / -_) '_|         --
--           |___|_\___| .__/\___/\_/\_/\___|_|           --
--                     |_|                                --
--                    _____                               --
--                   |_   _|__ _ __  ___                  --
--                     | |/ _ \ '  \/ -_)                 --   
--                     |_|\___/_|_|_\___|                 --
------------------------------------------------------------
--      Other mods nodes/items used by elepower_tome      -- 
------------------------------------------------------------
-----------------------------------
-- i_eletome_additional_info.lua --
-----------------------------------
-- uses ing.copper_ingot
-- uses ing.steel_ingot
-- uses ing.gold_ingot
-- uses ing.tin_ingot
-- uses ing.mese_crystal_fragment
-- uses ing.mese_crystal
-- uses ing.coal_lump
-- uses ing.sand
-- uses ing.glass
-- uses ing.lava_source
-- uses ref.stone
-- uses ref,water_source
-- uses ing.blueberry_bush_leaves
-- uses ing.furnace

---------------------
-- i_functions.lua --
---------------------
--NIL

-------------------------
-- i_page_contents.lua --
-------------------------
--NIL

-----------------------
-- i_page_crafts.lua --
-----------------------
--NIL

---------------------
-- i_page_help.lua --
---------------------
--NIL

-----------------------------
-- i_page_instructions.lua --
-----------------------------
--NIL

-------------------------
-- i_page_machines.lua --
-------------------------
--NIL