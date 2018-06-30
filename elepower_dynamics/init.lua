-- A Elepower Mod
-- Copyright 2018 Evert "Diamond" Prants <evert@lunasqu.ee>

local modpath = minetest.get_modpath(minetest.get_current_modname())

elepd = rawget(_G, "elepd") or {}
elepd.modpath = modpath

dofile(modpath.."/conduits.lua")
dofile(modpath.."/craftitems.lua")
dofile(modpath.."/compat/init.lua")
dofile(modpath.."/tools.lua")
dofile(modpath.."/nodes.lua")
dofile(modpath.."/liquids.lua")
dofile(modpath.."/tanks.lua")
dofile(modpath.."/dusts.lua")
dofile(modpath.."/gears.lua")
dofile(modpath.."/worldgen.lua")
dofile(modpath.."/crafting.lua")
