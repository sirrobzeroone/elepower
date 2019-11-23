-- An Elepower Mod
-- Copyright 2018 Evert "Diamond" Prants <evert@lunasqu.ee>

local modpath = minetest.get_modpath(minetest.get_current_modname())

elemining = rawget(_G, "elemining") or {}
elemining.modpath = modpath

-- Crafting
dofile(modpath .. "/craftitems.lua")
dofile(modpath .. "/crafting.lua")

-- Nodes
dofile(modpath .. "/miner.lua")
