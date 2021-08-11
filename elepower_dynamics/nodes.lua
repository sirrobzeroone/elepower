
-- see elepower_papi >> external_nodes_items.lua for explanation
-- shorten table ref
local epg = ele.external.graphic 
local eps = ele.external.sounds

---------------
-- Overrides --
---------------

minetest.register_alias_force("elepower_dynamics:fluid_transfer_node", "fluid_transfer:fluid_transfer_pump")
minetest.register_alias_force("elepower_dynamics:fluid_duct", "fluid_transfer:fluid_duct")

-----------
-- Nodes --
-----------

-- Ores

minetest.register_node("elepower_dynamics:stone_with_lead", {
	description = "Lead Ore",
	tiles = {epg.stone.."^elepower_mineral_lead.png"},
	groups = {cracky = 2},
	drop = 'elepower_dynamics:lead_lump',
	sounds = eps.node_sound_stone,
})

minetest.register_node("elepower_dynamics:stone_with_nickel", {
	description = "Nickel Ore",
	tiles = {epg.stone.."^elepower_mineral_nickel.png"},
	groups = {cracky = 2},
	drop = 'elepower_dynamics:nickel_lump',
	sounds = eps.node_sound_stone,
})

minetest.register_node("elepower_dynamics:stone_with_viridisium", {
	description = "Viridisium Ore",
	tiles = {epg.stone.."^elepower_mineral_viridisium.png"},
	groups = {cracky = 3},
	drop = 'elepower_dynamics:viridisium_lump',
	sounds = eps.node_sound_stone,
})

minetest.register_node("elepower_dynamics:stone_with_zinc", {
	description = "Zinc Ore",
	tiles = {epg.stone.."^elepower_mineral_zinc.png"},
	groups = {cracky = 3},
	drop = 'elepower_dynamics:zinc_lump',
	sounds = eps.node_sound_stone,
})

-- Other

minetest.register_node("elepower_dynamics:particle_board", {
	description = "Particle Board",
	tiles = {"elepower_particle_board.png"},
	groups = {choppy = 2, wood = 1},
	drop = 'elepower_dynamics:wood_dust 4',
	sounds = eps.node_sound_wood,
})

minetest.register_node("elepower_dynamics:hardened_glass", {
	description = "Hardened Obsidian Glass\nDoes not let light through",
	drawtype = "glasslike_framed_optional",
	tiles = {epg.obsidian_glass, "elepower_hard_glass_detail.png"},
	paramtype2 = "glasslikeliquidlevel",
	is_ground_content = false,
	sunlight_propagates = false,
	use_texture_alpha = "clip",
	sounds = eps.node_sound_glass,
	groups = {cracky = 3},
})

-- Blocks

minetest.register_node("elepower_dynamics:viridisium_block", {
	description = "Viridisium Block",
	tiles = {"elepower_viridisium_block.png"},
	is_ground_content = false,
	groups = {cracky = 1, level = 2},
	sounds = eps.node_sound_metal,
})

minetest.register_node("elepower_dynamics:lead_block", {
	description = "Lead Block",
	tiles = {"elepower_lead_block.png"},
	is_ground_content = false,
	groups = {cracky = 1, level = 2},
	sounds = eps.node_sound_metal,
})

minetest.register_node("elepower_dynamics:invar_block", {
	description = "Invar Block",
	tiles = {"elepower_invar_block.png"},
	is_ground_content = false,
	groups = {cracky = 1, level = 3},
	sounds = eps.node_sound_metal,
})

minetest.register_node("elepower_dynamics:nickel_block", {
	description = "Nickel Block",
	tiles = {"elepower_nickel_block.png"},
	is_ground_content = false,
	groups = {cracky = 1, level = 3},
	sounds = eps.node_sound_metal,
})

minetest.register_node("elepower_dynamics:zinc_block", {
	description = "Zinc Block",
	tiles = {"elepower_zinc_block.png"},
	is_ground_content = false,
	groups = {cracky = 1, level = 3},
	sounds = eps.node_sound_metal,
})
