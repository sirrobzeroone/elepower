
elepm.register_craft_type("grind", {
	description = "Grinding",
	overview    = "Grinding of solid materials occurs through mechanical"..
                  "forces that break up the structure of the material.".. 
				  "After grinding the state of the material is changed;"..
				  "the grain size and the grain shape will be smaller and finer.",
	icon        = "elepower_machine_side.png^elepower_grinder.png",
	inputs      = 1,
})

elepm.register_crafter("elepower_machines:pulverizer", {
	description = "Pulverizer",
	craft_type = "grind",
	ele_active_node = true,
	ele_usage = 32,
	tiles = {
		"elepower_machine_top.png", "elepower_machine_base.png", "elepower_machine_side.png",
		"elepower_machine_side.png", "elepower_machine_side.png", "elepower_machine_side.png^elepower_grinder.png",
	},
	ele_active_nodedef = {
		tiles = {
			"elepower_machine_top.png", "elepower_machine_base.png", "elepower_machine_side.png",
			"elepower_machine_side.png", "elepower_machine_side.png", "elepower_machine_side.png^elepower_grinder_active.png",
		},
	},
	groups = {oddly_breakable_by_hand = 1}
})
