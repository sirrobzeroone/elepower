
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

minetest.register_node("elepower_dynamics:stone_with_nickel", {
	description = "Nickel Ore",
	tiles = {"default_stone.png^elepower_mineral_nickel.png"},
	groups = {cracky = 2},
	drop = 'elepower_dynamics:nickel_lump',
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("elepower_dynamics:particle_board", {
	description = "Particle Board",
	tiles = {"elepower_particle_board.png"},
	groups = {choppy = 2, wood = 1},
	drop = 'elepower_dynamics:wood_dust 4',
	sounds = default.node_sound_wood_defaults(),
})
