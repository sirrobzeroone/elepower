
elepm.register_craft_type("alloy", {
	description = "Alloying",
	overview    = "Alloys are created materials which are stronger than "..
                  "there base material components. These can be obtained "..
                  "by combining differing materials in the Alloying Furnace.".. 
                  "\nElepower provides a number of alloying recipes.",
	inputs      = 2,
	icon        = "elepower_machine_side.png^elepower_alloy_furnace.png",
})

elepm.register_crafter("elepower_machines:alloy_furnace", {
	description = "Alloy Furnace",
	craft_type = "alloy",
	ele_active_node = true,
	tiles = {
		"elepower_machine_top.png", "elepower_machine_base.png", "elepower_machine_side.png",
		"elepower_machine_side.png", "elepower_machine_side.png", "elepower_machine_side.png^elepower_alloy_furnace.png",
	},
	ele_active_nodedef = {
		tiles = {
			"elepower_machine_top.png", "elepower_machine_base.png", "elepower_machine_side.png",
			"elepower_machine_side.png", "elepower_machine_side.png", "elepower_machine_side.png^elepower_alloy_furnace_active.png",
		},
	},
	ele_icon_material_1 ="default_copper_ingot.png",
	ele_icon_material_2 ="default_tin_ingot.png",
	groups = {oddly_breakable_by_hand = 1}
})
