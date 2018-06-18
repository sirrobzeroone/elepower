-- A Elepower Mod
-- Copyright 2018 Evert "Diamond" Prants <evert@lunasqu.ee>

local modpath = minetest.get_modpath(minetest.get_current_modname())

eletool = rawget(_G, "eletool") or {}
eletool.modpath = modpath

ele.register_tool("elepower_tools:test_tool", {
	description = "Powertool",
	inventory_image = "elepower_tool_ironpick.png",
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=1,
		groupcaps={
			cracky = {times={[1]=3.90, [2]=1.50, [3]=0.60}, maxlevel=2},
		},
		damage_groups = {fleshy=4},
	},
})
