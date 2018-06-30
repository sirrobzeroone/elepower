
elepm.register_craft_type("assembly", {
	description = "Assembly",
	inputs      = 9,
})

elepm.register_crafter("elepower_machines:assembler", {
	description = "Assembler",
	craft_type = "assembly",
	tiles = {
		"elepower_machine_top.png", "elepower_machine_base.png", "elepower_machine_side.png",
		"elepower_machine_side.png", "elepower_machine_side.png", "elepower_machine_side.png",
	},
	groups = {oddly_breakable_by_hand = 1},
	ele_capacity = 64000,
	ele_usage = 124
})
