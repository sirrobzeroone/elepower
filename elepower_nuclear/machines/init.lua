
local mp = elenuclear.modpath .. "/machines/"

minetest.register_node("elepower_nuclear:machine_block", {
	description = "Radiation-shielded Lead Machine Chassis",
	tiles = {
		"elenuclear_machine_top.png", "elepower_lead_block.png", "elenuclear_machine_block.png",
		"elenuclear_machine_block.png", "elenuclear_machine_block.png", "elenuclear_machine_block.png",
	},
	groups = {cracky = 3},
})

dofile(mp.."enrichment_plant.lua")
