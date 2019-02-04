-- An Elepower Mod
-- Copyright 2018 Evert "Diamond" Prants <evert@lunasqu.ee>

local modpath = minetest.get_modpath(minetest.get_current_modname())

elethermal = rawget(_G, "elethermal") or {}
elethermal.modpath = modpath

dofile(modpath.."/machines/init.lua")
dofile(modpath.."/fluids.lua")
dofile(modpath.."/crafting.lua")
