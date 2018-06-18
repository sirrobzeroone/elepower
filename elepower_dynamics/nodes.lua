
---------------
-- Overrides --
---------------

-----------
-- Nodes --
-----------

minetest.register_node("elepower_dynamics:stone_with_lead", {
	description = "Lead Ore",
	tiles = {"default_stone.png^elepower_mineral_lead.png"},
	groups = {cracky = 2},
	drop = 'elepower_dynamics:lead_lump',
	sounds = default.node_sound_stone_defaults(),
})
