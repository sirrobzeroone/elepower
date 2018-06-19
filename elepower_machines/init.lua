-- Elepower Mod
-- Copyright 2018 Evert "Diamond" Prants <evert@lunasqu.ee>

local modpath = minetest.get_modpath(minetest.get_current_modname())

elepm = rawget(_G, "elepm") or {}
elepm.modpath = modpath

dofile(modpath.."/craft.lua")
dofile(modpath.."/formspec.lua")
dofile(modpath.."/bases/init.lua")
dofile(modpath.."/nodes.lua")
dofile(modpath.."/special/init.lua")
dofile(modpath.."/register.lua")
