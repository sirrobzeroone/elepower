-- Nodes other than machines.

minetest.register_node("elepower_machines:machine_block", {
	description = "Machine Block\nSafe for decoration",
	tiles       = {"elepower_machine_top.png", "elepower_machine_base.png", "elepower_machine_side.png"},
	groups      = {oddly_breakable_by_hand = 1, cracky = 1},
})
