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
--          Register Nodes - Flood Lights           --
------------------------------------------------------

local flood_light_angles = {
							xp0_yp0   = {groups = {cracky = 1, ele_user = 1, ele_lighting = 1}},
							xp0_yp20  = {groups = {cracky = 1, ele_user = 1, not_in_creative_inventory = 1}},
							xp0_yn20  = {groups = {cracky = 1, ele_user = 1, not_in_creative_inventory = 1}},
							xp45_yp0  = {groups = {cracky = 1, ele_user = 1, not_in_creative_inventory = 1}},
							xp45_yp20 = {groups = {cracky = 1, ele_user = 1, not_in_creative_inventory = 1}},
							xp45_yn20 = {groups = {cracky = 1, ele_user = 1, not_in_creative_inventory = 1}},
							xn45_yp0  = {groups = {cracky = 1, ele_user = 1, not_in_creative_inventory = 1}},
							xn45_yp20 = {groups = {cracky = 1, ele_user = 1, not_in_creative_inventory = 1}},
							xn45_yn20 = {groups = {cracky = 1, ele_user = 1, not_in_creative_inventory = 1}}
                           }

for angle,def in pairs(flood_light_angles) do
	ele.register_machine("elepower_lighting:incandescent_floodlight_"..angle, {
		description = "Flood Light Incandescent ",
		drawtype = "mesh",
		mesh = "flood_light_"..angle..".obj",	
		tiles = {"elepower_lighting_flood_light_off.png"},
		inventory_image = "elepower_lighting_flood_light_inv.png",
		selection_box = {
						type = "fixed",
						fixed = {-0.375, -0.5, -0.375, 0.375, 0.313, 0.5}
						},
		collision_box = {
						type = "fixed",
						fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}
						},
		ele_active_node = true,
		ele_active_nodedef = {
								tiles = {"elepower_lighting_flood_light_on.png"},
							 },
		use_texture_alpha = "clip",
		paramtype = "light",
		sunlight_propagates = true,
		drops = "elepower_lighting:incandescent_floodlight_xp0_yp0",
		groups = def.groups,
		ele_capacity = 64,
		ele_usage    = 8,
		ele_inrush   = 8,
		ele_light_shape = "flood",
		ele_no_automatic_ports = true,
		on_timer = elepower_lighting.light_timer,
		on_punch = elepower_lighting.light_punch,
		on_construct = elepower_lighting.light_construct,
		on_place = elepower_lighting.light_place,
		on_destruct = elepower_lighting.light_strip_cleanup,
		on_receive_fields = elepower_lighting.flood_on_recieve_fields
	})
end

for angle,def in pairs(flood_light_angles) do
	ele.register_machine("elepower_lighting:cf_floodlight_"..angle, {
		description = "Flood Light CF",
		drawtype = "mesh",
		mesh = "flood_light_"..angle..".obj",	
		tiles = {"elepower_lighting_flood_light_off.png"},
		inventory_image = "elepower_lighting_cf_flood_light_inv.png",
		selection_box = {
						type = "fixed",
						fixed = {-0.375, -0.5, -0.375, 0.375, 0.313, 0.5}
						},
		collision_box = {
						type = "fixed",
						fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}
						},
		ele_active_node = true,
		ele_active_nodedef = {
								tiles = {"elepower_lighting_cf_flood_light_on.png"},
							 },
		use_texture_alpha = "clip",
		paramtype = "light",
		sunlight_propagates = true,
		drops = "elepower_lighting:cf_floodlight_xp0_yp0",
		groups = def.groups,
		ele_capacity = 128,
		ele_usage    = 4,
		ele_inrush   = 16,
		ele_light_shape = "flood",
		ele_no_automatic_ports = true,
		on_timer = elepower_lighting.light_timer,
		on_punch = elepower_lighting.light_punch,
		on_construct = elepower_lighting.light_construct,
		on_place = elepower_lighting.light_place,
		on_destruct = elepower_lighting.light_strip_cleanup,
		on_receive_fields = elepower_lighting.flood_on_recieve_fields
	})
end

for angle,def in pairs(flood_light_angles) do
	ele.register_machine("elepower_lighting:led_floodlight_"..angle, {
		description = "Flood Light LED",
		drawtype = "mesh",
		mesh = "flood_light_"..angle..".obj",	
		tiles = {"elepower_lighting_flood_light_off.png"},
		inventory_image = "elepower_lighting_led_flood_light_inv.png",
		selection_box = {
						type = "fixed",
						fixed = {-0.375, -0.5, -0.375, 0.375, 0.313, 0.5}
						},
		collision_box = {
						type = "fixed",
						fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}
						},
		ele_active_node = true,
		ele_active_nodedef = {
								tiles = {"elepower_lighting_flood_light_on.png"},
							 },
		use_texture_alpha = "clip",
		paramtype = "light",
		sunlight_propagates = true,
		drops = "elepower_lighting:led_floodlight_xp0_yp0",
		groups = def.groups,
		ele_capacity = 192,
		ele_usage    = 2,
		ele_inrush   = 16,
		ele_light_shape = "flood",
		ele_no_automatic_ports = true,
		on_timer = elepower_lighting.light_timer,
		on_punch = elepower_lighting.light_punch,
		on_construct = elepower_lighting.light_construct,
		on_place = elepower_lighting.light_place,
		on_destruct = elepower_lighting.light_strip_cleanup,
		on_receive_fields = elepower_lighting.flood_on_recieve_fields
	})
end