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
--                   Craft Items                    --
------------------------------------------------------

minetest.register_craftitem("elepower_lighting:bulb_glass", {
	description = "Bulb Glass",
	inventory_image = "elepower_lighting_incandescent_bulb_glass.png",
	groups = {oddly_breakable_by_hand = 1}
})

minetest.register_craftitem("elepower_lighting:incandescent_bulb_element", {
	description = "Incandescent Bulb Element",
	inventory_image = "elepower_lighting_incandescent_bulb_element.png",
	groups = {oddly_breakable_by_hand = 1}
})

minetest.register_craftitem("elepower_lighting:cf_bulb_glass", {
	description = "CF Bulb Glass",
	inventory_image = "elepower_lighting_cf_bulb_glass.png",
	groups = {oddly_breakable_by_hand = 1}
})

minetest.register_craftitem("elepower_lighting:magnifying_lens", {
	description = "Magnifying Lens",
	inventory_image = "elepower_lighting_magnifying_lens.png",
	groups = {oddly_breakable_by_hand = 1}
})

minetest.register_craftitem("elepower_lighting:fluro_tube_glass", {
	description = "Fluro Tube Glass",
	inventory_image = "elepower_lighting_fluro_tube_glass.png",
	groups = {oddly_breakable_by_hand = 1}
})

minetest.register_craftitem("elepower_lighting:electrum_strip", {
	description = "Electrum Strip",
	inventory_image = "elepower_bm_strip.png^[multiply:#ebeb90",
	groups = {strip = 1}
})

minetest.register_craftitem("elepower_lighting:led_red", {
	description = "Red Light Emitting Diode",
	inventory_image = "elepower_lighting_light_emitting_diode_single.png^[multiply:#FF0000"..
	                  "^[lowpart:31:elepower_lighting_light_emitting_diode_single.png",
	groups = {oddly_breakable_by_hand = 1, led = 1}
})

minetest.register_craftitem("elepower_lighting:led_green", {
	description = "Green Light Emitting Diode",
	inventory_image = "elepower_lighting_light_emitting_diode_single.png^[multiply:#00FF00"..
	                  "^[lowpart:31:elepower_lighting_light_emitting_diode_single.png",
	groups = {oddly_breakable_by_hand = 1, led = 1}
})

minetest.register_craftitem("elepower_lighting:led_blue", {
	description = "Blue Light Emitting Diode",
	inventory_image = "elepower_lighting_light_emitting_diode_single.png^[multiply:#0000FF"..
	                  "^[lowpart:31:elepower_lighting_light_emitting_diode_single.png",
	groups = {oddly_breakable_by_hand = 1, led = 1}
})

minetest.register_craftitem("elepower_lighting:led_cluster", {
	description = "Light Emitting Diode Cluster",
	inventory_image = "elepower_lighting_light_emitting_diode_cluster.png",
	groups = {oddly_breakable_by_hand = 1, led = 1}
})

minetest.register_craftitem("elepower_lighting:led_driver", {
	description = "LED Driver Board",
	inventory_image = "elepower_lighting_light_emitting_diode_driver.png",
	groups = {oddly_breakable_by_hand = 1}
})
