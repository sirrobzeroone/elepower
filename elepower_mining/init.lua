-- An Elepower Mod
-- Copyright 2018 Evert "Diamond" Prants <evert@lunasqu.ee>

local modpath = minetest.get_modpath(minetest.get_current_modname())

elemining = rawget(_G, "elemining") or {}
elemining.modpath = modpath

-- Nodes
dofile(modpath .. "/miner.lua")

-- Crafting
dofile(modpath .. "/crafting.lua")
