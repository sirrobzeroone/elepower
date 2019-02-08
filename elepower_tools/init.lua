-- An Elepower Mod
-- Copyright 2018 Evert "Diamond" Prants <evert@lunasqu.ee>

local modpath = minetest.get_modpath(minetest.get_current_modname())

eletool = rawget(_G, "eletool") or {}
eletool.modpath = modpath

-- Simple tools
dofile(modpath .. "/tools.lua")

-- Complex tools
dofile(modpath .. "/soldering.lua")

-- Crafting
dofile(modpath .. "/craftitems.lua")
dofile(modpath .. "/crafting.lua")

-- Repair
dofile(modpath .. "/ed_reconstructor.lua")

-- Armor
if minetest.get_modpath("3d_armor") then
	dofile(modpath .. "/armor.lua")
end
