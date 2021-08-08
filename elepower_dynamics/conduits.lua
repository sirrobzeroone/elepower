
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

ele.register_conduit("elepower_dynamics:conduit_dirt_with_grass", {
	description = "Power Conduit Grass Outlet",
	tiles = {"default_grass.png^elepower_conduit_node_socket.png",
	         "default_dirt.png",
			 "default_dirt.png^default_grass_side.png"
			},
	use_texture_alpha = "clip",
	ele_conductor_density = 4/8,
	groups = {crumbly = 3, soil = 1},
	sounds = default.node_sound_dirt_defaults({
			footstep = {name = "default_grass_footstep", gain = 0.25}
	})
})

ele.register_conduit("elepower_dynamics:conduit_dirt_with_dry_grass", {
	description = "Power Conduit Dry Grass Outlet",
	tiles = {"default_dry_grass.png^elepower_conduit_node_socket.png",
	         "default_dirt.png",
			 "default_dirt.png^default_dry_grass_side.png"
			},
	use_texture_alpha = "clip",
	ele_conductor_density = 4/8,
	groups = {crumbly = 3, soil = 1},
	sounds = default.node_sound_dirt_defaults({
			footstep = {name = "default_grass_footstep", gain = 0.25}
	})
})

ele.register_conduit("elepower_dynamics:conduit_stone_block", {
	description = "Power Conduit Stone Block",
	tiles = {"default_stone_block.png^elepower_conduit_node_socket.png",
	         "default_stone_block.png^elepower_conduit_node_socket.png",
			 "default_stone_block.png^elepower_conduit_node_socket.png"
			},
	use_texture_alpha = "clip",
	ele_conductor_density = 4/8,
	groups = {cracky = 2, stone = 1},
	sounds = default.node_sound_stone_defaults(),
})

ele.register_conduit("elepower_dynamics:conduit_stone_block_desert", {
	description = "Power Conduit Desert Stone Block",
	tiles = {"default_desert_stone_block.png^elepower_conduit_node_socket.png",
	         "default_desert_stone_block.png^elepower_conduit_node_socket.png",
			 "default_desert_stone_block.png^elepower_conduit_node_socket.png"
			},
	use_texture_alpha = "clip",
	ele_conductor_density = 4/8,
	groups = {cracky = 2, stone = 1},
	sounds = default.node_sound_stone_defaults(),
})

-- Fluid
fluid_lib.register_transfer_node("elepower_dynamics:opaque_duct", {
	description = "Opaque Fluid Duct",
	tiles = {"elepower_opaque_duct.png"},
	use_texture_alpha = "clip",
	duct_density = 1/5,
	groups = {oddly_breakable_by_hand = 1, cracky = 1}
})
