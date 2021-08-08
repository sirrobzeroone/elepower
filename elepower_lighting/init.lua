------------------------------------------------------
--        ___ _                                     --
--       | __| |___ _ __  _____ __ _____ _ _        --
--       | _|| / -_) '_ \/ _ \ V  V / -_) '_|       --
--       |___|_\___| .__/\___/\_/\_/\___|_|         --
--         _    _  |_| _   _   _                    --
--        | |  (_)__ _| |_| |_(_)_ _  __ _          --
--        | |__| / _` | ' \  _| | ' \/ _` |         --
--        |____|_\__, |_||_\__|_|_||_\__, |         --
--               |___/               |___/          --
------------------------------------------------------
--                                                  --
------------------------------------------------------
-- Global variable for mod
elepower_lighting = {}
elepower_lighting.maxlight = 14

-- path, modname and translation
local modname = minetest.get_current_modname()
local modpath = minetest.get_modpath(modname)
elepower_lighting.S = minetest.get_translator(modname)
local S = elepower_lighting.S

-- includes
dofile(modpath .. "/i_functions.lua")
dofile(modpath .. "/i_register_nodes.lua")
dofile(modpath .. "/i_register_nodes_shades.lua")
dofile(modpath .. "/i_register_flood_lights.lua")
dofile(modpath .. "/i_craftitems.lua")
dofile(modpath .. "/i_crafting.lua")
dofile(modpath .. "/i_crafting_shades.lua")