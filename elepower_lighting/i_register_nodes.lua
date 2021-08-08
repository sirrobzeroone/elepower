------------------------------------------------------
--        ___ _                                     --
--       | __| |___ _ __  _____ __ _____ _ _        --
--       | _|| / -_) '_ \/ _ \ V  V / -_) '_|       --
--       |___|_\___| .__/\___/\_/\_/\___|_|         --
--         _    _  |_| _   _   _                    --
--        | |  (_)__ _| |_| |_(_)_ _  __ _          --
--        | |__| / _` | ' \  _| | ' \/ _` |         --
--        |____|_\__, |_||_\__|_|_||_\__, |         --
--               |___/               |___/          --
------------------------------------------------------
--                  Register Nodes                  --
------------------------------------------------------
----------------
-- Light Fill --
----------------
minetest.register_node("elepower_lighting:light_fill", {
	description = "Light Fill",
	drawtype = "airlike",
	paramtype = "light",
	--tiles = {"elepower_lighting_light_fill.png"}, -- debugging
	sunlight_propagates = true,
	walkable = false,
	pointable = false,
	diggable = true,
	climbable = false,
	buildable_to = true,
	drop = "",
	is_ground_content = false,
	groups = {not_in_creative_inventory = 1},
	light_source = elepower_lighting.maxlight,
})
-------------
-- Conduit --
-------------
ele.register_conduit("elepower_lighting:conduit_iron_thin", {
	description = "Conduit Decorative Cast Iron Thin",
	tiles = {"elepower_lighting_conduit_iron_thin.png"},
	use_texture_alpha = "clip",
	ele_conductor_density = 1/8,
	groups = {cracky = 2}
})

ele.register_conduit("elepower_lighting:conduit_iron_thick", {
	description = "Conduit Decorative Cast Iron Thick",
	tiles = {"elepower_lighting_conduit_iron_thick.png"},
	use_texture_alpha = "clip",
	ele_conductor_density = 2/8,
	groups = {cracky = 2}
})

ele.register_conduit("elepower_lighting:conduit_steel_thin", {
	description = "Conduit Decorative Steel Thin",
	tiles = {"elepower_lighting_conduit_steel_thin.png"},
	use_texture_alpha = "clip",
	ele_conductor_density = 1/8,
	groups = {cracky = 2}
})

ele.register_conduit("elepower_lighting:conduit_steel_thick", {
	description = "Conduit Decorative Steel Thick",
	tiles = {"elepower_lighting_conduit_steel_thick.png"},
	use_texture_alpha = "clip",
	ele_conductor_density = 2/8,
	groups = {cracky = 2}
})

ele.register_conduit("elepower_lighting:conduit_gold_thin", {
	description = "Conduit Decorative Gold Thin",
	tiles = {"elepower_lighting_conduit_gold_thin.png"},
	use_texture_alpha = "clip",
	ele_conductor_density = 1/8,
	groups = {cracky = 1}
})

ele.register_conduit("elepower_lighting:conduit_gold_thick", {
	description = "Conduit Decorative Gold Thick",
	tiles = {"elepower_lighting_conduit_gold_thick.png"},
	use_texture_alpha = "clip",
	ele_conductor_density = 2/8,
	groups = {cracky = 1}
})

ele.register_conduit("elepower_lighting:conduit_wood_thin", {
	description = "Conduit Decorative Wood Thin",
	tiles = {"elepower_lighting_conduit_wood_thin.png"},
	use_texture_alpha = "clip",
	ele_conductor_density = 1/8,
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2}
})

ele.register_conduit("elepower_lighting:conduit_wood_thick", {
	description = "Conduit Decorative Wood Thick",
	tiles = {"elepower_lighting_conduit_wood_thick.png"},
	use_texture_alpha = "clip",
	ele_conductor_density = 2/8,
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2}
})

------------
-- Lights --
------------
ele.register_machine("elepower_lighting:bulb_incandescent", {
	description = "Bulb Incandescent",
	drawtype = "mesh",
	mesh = "incandescent_light_bulb.obj",	
	tiles = {"elepower_lighting_incandescent_light_off.png"},
	selection_box = {
					type = "fixed",
					fixed = {-0.25, -0.5, -0.25, 0.25, 0.1875, 0.25}
					},
	ele_active_node = true,
	ele_active_nodedef = {
							light_source = elepower_lighting.maxlight,
							tiles =  {"elepower_lighting_incandescent_light_on.png"}
			             },
	use_texture_alpha = "clip",
	paramtype = "light",
	sunlight_propagates = true,
	groups = {cracky = 1, ele_user = 1, ele_lighting = 1},
	ele_capacity = 32,
	ele_usage    = 4,
	ele_inrush   = 8,
	ele_no_automatic_ports = true,
	on_timer = elepower_lighting.light_timer,
	on_punch = elepower_lighting.light_punch,
	on_construct = elepower_lighting.light_construct,
	on_place = elepower_lighting.light_place
})

ele.register_machine(":elepower_dynamics:uv_bulb", {
	description = "UV Bulb Incandescent",
	drawtype = "mesh",
	mesh = "incandescent_light_bulb.obj",	
	tiles = {"elepower_lighting_incandescent_uv_light_off.png"},
	selection_box = {
					type = "fixed",
					fixed = {-0.25, -0.5, -0.25, 0.25, 0.1875, 0.25}
					},
	ele_active_node = true,
	ele_active_nodedef = {
							light_source = 7,
							tiles =  {"elepower_lighting_incandescent_uv_light_on.png"}
			             },
	use_texture_alpha = "clip",
	paramtype = "light",
	sunlight_propagates = true,
	groups = {cracky = 1, ele_user = 1, ele_lighting = 1},
	ele_capacity = 32,
	ele_usage    = 4,
	ele_inrush   = 8,
	ele_no_automatic_ports = true,
	on_timer = elepower_lighting.light_timer,
	on_punch = elepower_lighting.light_punch,
	on_construct = elepower_lighting.light_construct,
	on_place = elepower_lighting.light_place
})


ele.register_machine("elepower_lighting:bulb_cf", {
	description = "Bulb Compact Fluro",
	drawtype = "mesh",
	mesh = "cf_light_bulb.obj",	
	tiles = {"elepower_lighting_cf_light_off.png"},
	selection_box = {
					type = "fixed",
					fixed = {-0.25, -0.5, -0.25, 0.25, 0.3125, 0.25}
					},
	ele_active_node = true,
	ele_active_nodedef = {
							light_source = elepower_lighting.maxlight,
							tiles =  {"elepower_lighting_cf_light_on.png"}
			             },
	use_texture_alpha = "clip",
	paramtype = "light",
	sunlight_propagates = true,
	groups = {cracky = 1, ele_user = 1, ele_lighting = 1},
	ele_capacity = 64,
	ele_usage    = 2,
	ele_inrush   = 16,
	ele_no_automatic_ports = true,
	on_timer = elepower_lighting.light_timer,
	on_punch = elepower_lighting.light_punch,
	on_construct = elepower_lighting.light_construct,
	on_place = elepower_lighting.light_place
})

ele.register_machine("elepower_lighting:fluro_light_bank", {
	description = "Fluro Light Bank",
	drawtype = "mesh",
	mesh = "fluro_light_bank.obj",	
	tiles = {"elepower_lighting_fluro_light_bank_off.png"},
	inventory_image = "elepower_lighting_fluro_light_bank_inv.png",
	selection_box = {
					type = "fixed",
					fixed = {-1, -0.5, -0.375, 1, -0.125, 0.375}
					},
	collision_box = {
					type = "fixed",
					fixed = {-1, -0.5, -0.375, 1, -0.125, 0.375}
					},
	ele_active_node = true,
	ele_active_nodedef = {
							light_source = elepower_lighting.maxlight,
							tiles =  {"elepower_lighting_fluro_light_bank_on.png"}
			             },
	use_texture_alpha = "clip",
	paramtype = "light",
	sunlight_propagates = true,
	groups = {cracky = 1, ele_user = 1, ele_lighting = 1},
	ele_capacity = 64,
	ele_usage    = 3,
	ele_inrush   = 16,
	ele_light_shape = "3x1",
	ele_no_automatic_ports = true,
	on_timer = elepower_lighting.light_timer,
	on_punch = elepower_lighting.light_punch,
	on_construct = elepower_lighting.light_construct,
	on_place = elepower_lighting.light_place,
	on_destruct = elepower_lighting.light_strip_cleanup
})


ele.register_machine("elepower_lighting:bulb_led", {
	description = "Bulb Light-Emitting Diode",
	drawtype = "mesh",
	mesh = "incandescent_light_bulb.obj",	
	tiles = {"elepower_lighting_led_light_bulb_off.png"},
	selection_box = {
					type = "fixed",
					fixed = {-0.25, -0.5, -0.25, 0.25, 0.3125, 0.25}
					},
	ele_active_node = true,
	ele_active_nodedef = {
							light_source = elepower_lighting.maxlight,
							tiles =  {"elepower_lighting_led_light_bulb_on.png"}
			             },
	use_texture_alpha = "clip",
	paramtype = "light",
	sunlight_propagates = true,
	groups = {cracky = 1, ele_user = 1, ele_lighting = 1},
	ele_capacity = 96,
	ele_usage    = 1,
	ele_inrush   = 16,
	ele_no_automatic_ports = true,
	on_timer = elepower_lighting.light_timer,
	on_punch = elepower_lighting.light_punch,
	on_construct = elepower_lighting.light_construct,
	on_place = elepower_lighting.light_place
})


ele.register_machine("elepower_lighting:led_light_panel", {
	description = "LED Light Panel",
	drawtype = "mesh",
	mesh = "led_light_panel_1x1.obj",	
	tiles = {"elepower_lighting_led_light_off.png"},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5000, -0.5000, -0.5000, 0.5000, -0.2500, 0.5000}
		}
		},	
	collision_box = {
		type = "fixed",
		fixed = {
			{-0.5000, -0.5000, -0.5000, 0.5000, -0.2500, 0.5000}
		}
		},
	ele_active_node = true,
	ele_active_nodedef = {
							light_source = elepower_lighting.maxlight,
							tiles =  {"elepower_lighting_led_light_on.png"}
			             },
	use_texture_alpha = "clip",
	paramtype = "light",
	sunlight_propagates = true,
	groups = {cracky = 1, ele_user = 1, ele_lighting = 1},
	ele_capacity = 96,
	ele_usage    = 1,
	ele_inrush   = 16,
	ele_no_automatic_ports = true,
	on_timer = elepower_lighting.light_timer,
	on_punch = elepower_lighting.light_punch,
	on_construct = elepower_lighting.light_construct,
	on_place = elepower_lighting.light_place
})

ele.register_machine("elepower_lighting:led_light_panel_colored", {
    description = 'LED Light Panel Colored',
	drawtype = "mesh",
	mesh = "led_light_panel_1x1.obj",	
	tiles = {"elepower_lighting_led_light_off.png"},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5000, -0.5000, -0.5000, 0.5000, -0.2500, 0.5000}
		}
		},	
	collision_box = {
		type = "fixed",
		fixed = {
			{-0.5000, -0.5000, -0.5000, 0.5000, -0.2500, 0.5000}
		}
		},
    ele_active_node = true,
	ele_active_nodedef = {
							paramtype2 = 'colorwallmounted',
							palette = 'palette_32.png',
							light_source = elepower_lighting.maxlight,
							tiles =  {"elepower_lighting_led_light_on.png"}
			             },
    is_ground_content = false,
	paramtype = "light",
	sunlight_propagates = true,
    paramtype2 = 'wallmounted',
	groups = {cracky = 1, ele_user = 1, ele_lighting = 1},
	ele_capacity = 96,
	ele_usage    = 1,
	ele_inrush   = 16,
	ele_no_automatic_ports = true,
	on_timer = elepower_lighting.light_timer_colored,
	on_punch = elepower_lighting.light_punch,
	on_construct = elepower_lighting.light_construct,
	on_receive_fields = elepower_lighting.color_on_recieve_fields
	--on_place = elepower_lighting.light_place

})

ele.register_machine("elepower_lighting:led_1x3_light_panel", {
	description = "LED 1x3 Light Panel",
	drawtype = "mesh",
	mesh = "led_light_panel_1x3.obj",	
	tiles = {"elepower_lighting_led_light_1x3_off.png"},
	inventory_image = "elepower_lighting_led_light_1x3_inv.png",
	selection_box = {
		type = "fixed",
		fixed = {
			{-1.5000, -0.5000, -0.5000, 1.5000, -0.2500, 0.5000}
		}
		},	
	collision_box = {
		type = "fixed",
		fixed = {
			{-1.5000, -0.5000, -0.5000, 1.5000, -0.2500, 0.5000}
		}
		},
	ele_active_node = true,
	ele_active_nodedef = {
							light_source = elepower_lighting.maxlight,
							tiles =  {"elepower_lighting_led_light_1x3_on.png"}
			             },
	use_texture_alpha = "clip",
	paramtype = "light",
	sunlight_propagates = true,
	groups = {cracky = 1, ele_user = 1, ele_lighting = 1},
	ele_capacity = 288,
	ele_usage    = 1,
	ele_inrush   = 16,
	ele_light_shape = "3x1",
	ele_no_automatic_ports = true,
	on_timer = elepower_lighting.light_timer,
	on_punch = elepower_lighting.light_punch,
	on_construct = elepower_lighting.light_construct,
	on_place = elepower_lighting.light_place,
	on_destruct = elepower_lighting.light_strip_cleanup
})


ele.register_machine("elepower_lighting:led_2x3_light_panel", {
	description = "LED 2x3 Light Panel",
	drawtype = "mesh",
	mesh = "led_light_panel_2x3.obj",	
	tiles = {"elepower_lighting_led_light_2x3_off.png"},
	inventory_image = "elepower_lighting_led_light_2x3_inv.png",
	selection_box = {
		type = "fixed",
		fixed = {
			{-1.5000, -0.5000, -0.5000, 1.5000, -0.2500, 1.5000}
		}
		},	
	collision_box = {
		type = "fixed",
		fixed = {
			{-1.5000, -0.5000, -0.5000, 1.5000, -0.2500, 1.5000}
		}
		},
	ele_active_node = true,
	ele_active_nodedef = {
							light_source = elepower_lighting.maxlight,
							tiles =  {"elepower_lighting_led_light_2x3_on.png"}
			             },
	use_texture_alpha = "clip",
	paramtype = "light",
	sunlight_propagates = true,
	groups = {cracky = 1, ele_user = 1, ele_lighting = 1},
	ele_capacity = 576,
	ele_usage    = 1,
	ele_inrush   = 16,
	ele_light_shape = "3x2",
	ele_no_automatic_ports = true,
	on_timer = elepower_lighting.light_timer,
	on_punch = elepower_lighting.light_punch,
	on_construct = elepower_lighting.light_construct,
	on_place = elepower_lighting.light_place,
	on_destruct = elepower_lighting.light_strip_cleanup
})