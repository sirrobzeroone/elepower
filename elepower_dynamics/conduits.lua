
-- see elepower_papi >> external_nodes_items.lua for explanation
-- shorten table ref
local epg = ele.external.graphic
local eps = ele.external.sounds

-- Electric power
ele.register_conduit("elepower_dynamics:conduit", {
	description = "Power Conduit",
	tiles = {"elepower_conduit.png"},
	use_texture_alpha = "clip",
	groups = {oddly_breakable_by_hand = 1, cracky = 1}
})

ele.register_conduit("elepower_dynamics:conduit_wall", {
	description = "Power Conduit Wall Pass Through",
	tiles = {"elepower_conduit_wall.png"},
	use_texture_alpha = "clip",
	ele_conductor_density = 4/8,
	groups = {cracky = 1}
})


if ele.external.conduit_dirt_with_grass == true then
	ele.register_conduit("elepower_dynamics:conduit_dirt_with_grass", {
		description = "Power Conduit Grass Outlet",
		tiles = {epg.grass.."^elepower_conduit_node_socket.png",
				 epg.dirt,
				 epg.dirt.."^"..epg.grass_side
				},
		use_texture_alpha = "clip",
		ele_conductor_density = 4/8,
		groups = {crumbly = 3, soil = 1},
		sounds = eps.node_sound_dirt_c
	})
end

if ele.external.conduit_dirt_with_dry_grass == true then
	ele.register_conduit("elepower_dynamics:conduit_dirt_with_dry_grass", {
		description = "Power Conduit Dry Grass Outlet",
		tiles = {epg.grass_dry.."^elepower_conduit_node_socket.png",
				 epg.dirt,
				 epg.dirt.."^"..epg.grass_side_dry
				},
		use_texture_alpha = "clip",
		ele_conductor_density = 4/8,
		groups = {crumbly = 3, soil = 1},
		sounds = eps.node_sound_dirt_c
	})
end

if ele.external.conduit_stone_block == true then
	ele.register_conduit("elepower_dynamics:conduit_stone_block", {
		description = "Power Conduit Stone Block",
		tiles = {epg.stone_block.."^elepower_conduit_node_socket.png",
				 epg.stone_block.."^elepower_conduit_node_socket.png",
				 epg.stone_block.."^elepower_conduit_node_socket.png"
				},
		use_texture_alpha = "clip",
		ele_conductor_density = 4/8,
		groups = {cracky = 2, stone = 1},
		sounds = eps.node_sound_stone
	})
end

if ele.external.conduit_stone_block_desert == true then
	ele.register_conduit("elepower_dynamics:conduit_stone_block_desert", {
		description = "Power Conduit Desert Stone Block",
		tiles = {epg.desert_stone_block.."^elepower_conduit_node_socket.png",
				 epg.desert_stone_block.."^elepower_conduit_node_socket.png",
				 epg.desert_stone_block.."^elepower_conduit_node_socket.png"
				},
		use_texture_alpha = "clip",
		ele_conductor_density = 4/8,
		groups = {cracky = 2, stone = 1},
		sounds = eps.node_sound_stone
	})
end

-- Fluid
fluid_lib.register_transfer_node("elepower_dynamics:opaque_duct", {
	description = "Opaque Fluid Duct",
	tiles = {"elepower_opaque_duct.png"},
	use_texture_alpha = "clip",
	duct_density = 1/5,
	groups = {oddly_breakable_by_hand = 1, cracky = 1}
})
