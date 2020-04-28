
-------------------
-- Power Storage --
-------------------

elepm.register_storage("elepower_machines:power_cell", {
	description = "Power Cell",
	ele_capacity = 16000,
	ele_inrush = 128,
	ele_output = 128,
	tiles = {
		"elepower_machine_top.png", "elepower_machine_base.png", "elepower_machine_side.png",
		"elepower_machine_side.png", "elepower_machine_side.png", "elepower_machine_side.png^elepower_power_cell.png",
	},
	groups = {oddly_breakable_by_hand = 1}
})

elepm.register_storage("elepower_machines:hardened_power_cell", {
	description = "Hardened Power Cell",
	ele_capacity = 64000,
	ele_inrush = 640,
	ele_output = 640,
	tiles = {
		"elepower_machine_top.png^elepower_overlay_hardened.png",
		"elepower_machine_base.png^elepower_overlay_hardened.png",
		"elepower_machine_side.png^elepower_overlay_hardened.png",
		"elepower_machine_side.png^elepower_overlay_hardened.png",
		"elepower_machine_side.png^elepower_overlay_hardened.png",
		"elepower_machine_side.png^elepower_power_cell.png^elepower_overlay_hardened.png",
	},
	groups = {oddly_breakable_by_hand = 1}
})

elepm.register_storage("elepower_machines:reinforced_power_cell", {
	description = "Reinforced Power Cell",
	ele_capacity = 128000,
	ele_inrush = 1024,
	ele_output = 1024,
	tiles = {
		"elepower_machine_top.png^elepower_overlay_reinforced.png",
		"elepower_machine_base.png^elepower_overlay_reinforced.png",
		"elepower_machine_side.png^elepower_overlay_reinforced.png",
		"elepower_machine_side.png^elepower_overlay_reinforced.png",
		"elepower_machine_side.png^elepower_overlay_reinforced.png",
		"elepower_machine_side.png^elepower_power_cell.png^elepower_overlay_reinforced.png",
	},
	groups = {oddly_breakable_by_hand = 1}
})

elepm.register_storage("elepower_machines:resonant_power_cell", {
	description = "Resonant Power Cell",
	ele_capacity = 640000,
	ele_inrush = 2048,
	ele_output = 2048,
	tiles = {
		"elepower_machine_top.png^elepower_overlay_resonant.png",
		"elepower_machine_base.png^elepower_overlay_resonant.png",
		"elepower_machine_side.png^elepower_overlay_resonant.png",
		"elepower_machine_side.png^elepower_overlay_resonant.png",
		"elepower_machine_side.png^elepower_overlay_resonant.png",
		"elepower_machine_side.png^elepower_power_cell.png^elepower_overlay_resonant.png",
	},
	groups = {oddly_breakable_by_hand = 1}
})

elepm.register_storage("elepower_machines:super_power_cell", {
	description = "Supercapacitor Cell",
	ele_capacity = 1280000,
	ele_inrush = 4096,
	ele_output = 4096,
	tiles = {
		"elepower_machine_top.png^elepower_overlay_super.png",
		"elepower_machine_base.png^elepower_overlay_super.png",
		"elepower_machine_side.png^elepower_overlay_super.png",
		"elepower_machine_side.png^elepower_overlay_super.png",
		"elepower_machine_side.png^elepower_overlay_super.png",
		"elepower_machine_side.png^elepower_power_cell.png^elepower_overlay_super.png",
	},
	groups = {oddly_breakable_by_hand = 1}
})
