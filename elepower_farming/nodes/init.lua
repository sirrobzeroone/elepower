
minetest.register_node("elepower_farming:device_frame", {
	description = "Plastic Device Frame\nSafe for decoration",
	tiles = {
		"elefarming_machine_base.png", "elefarming_machine_base.png", "elefarming_machine_side.png",
		"elefarming_machine_side.png", "elefarming_machine_side.png", "elefarming_machine_side.png",
	},
	groups = {oddly_breakable_by_hand = 1, cracky = 1}
})

dofile(elefarm.modpath.."/nodes/fluids.lua")
dofile(elefarm.modpath.."/nodes/planter.lua")
dofile(elefarm.modpath.."/nodes/harvester.lua")
dofile(elefarm.modpath.."/nodes/tree_extractor.lua")
dofile(elefarm.modpath.."/nodes/tree_processor.lua")
