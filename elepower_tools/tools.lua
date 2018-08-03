
ele.register_tool("elepower_tools:hand_drill", {
	description = "Hand Drill",
	inventory_image = "eletools_hand_drill.png",
	wield_image = "eletools_hand_drill.png^[transformFX",
	tool_capabilities = {
		full_punch_interval = 0.2,
		max_drop_level = 1,
		groupcaps={
			cracky = {times={[1]=5, [2]=2, [3]=1}, maxlevel=4},
		},
		damage_groups = {fleshy=4},
	},
	ele_capacity = 8000
})
