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
--            Register Nodes Shades                 --
------------------------------------------------------

local light_shades_signlike = {
                      "Light Shade Timber Cross",
					  "Light Shade Timber Stripe",
					  "Light Shade Timber Decorative Stripe",
					  "Light Shade Timber Round",
					  "Light Shade Timber Small Round"				  
					 }

for num,name in pairs(light_shades_signlike) do
	
	minetest.register_node("elepower_lighting:decor_shade_"..num, {
	description = name,
	drawtype = "signlike",
	tiles = {"elepower_lighting_decor_surrond_"..num..".png"},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.57, -0.5, -0.57, 0.57, -0.43, 0.57}
		}
		},
	collision_box = {
		type = "fixed",
		fixed = {
			{-0.56, -0.5, -0.56, 0.56, -0.44, 0.56}
		}
		},		
	visual_scale = 1.13,
	paramtype2 = "wallmounted",
	sunlight_propagates = true,
	groups = {snappy = 3}
})

end

for num,name in pairs(light_shades_signlike) do
	
	minetest.register_node("elepower_lighting:decor_shade_red_"..num, {
	description = name.." Red",
	drawtype = "signlike",
	tiles = {"elepower_lighting_decor_surrond_red_"..num..".png"},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.57, -0.5, -0.57, 0.57, -0.43, 0.57}
		}
		},
	collision_box = {
		type = "fixed",
		fixed = {
			{-0.56, -0.5, -0.56, 0.56, -0.44, 0.56}
		}
		},		
	visual_scale = 1.13,
	paramtype2 = "wallmounted",
	sunlight_propagates = true,
	groups = {snappy = 3}
})

end

for num,name in pairs(light_shades_signlike) do
	
	minetest.register_node("elepower_lighting:decor_shade_blue_"..num, {
	description = name.." Blue",
	drawtype = "signlike",
	tiles = {"elepower_lighting_decor_surrond_blue_"..num..".png"},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.57, -0.5, -0.57, 0.57, -0.43, 0.57}
		}
		},
	collision_box = {
		type = "fixed",
		fixed = {
			{-0.56, -0.5, -0.56, 0.56, -0.44, 0.56}
		}
		},		
	visual_scale = 1.13,
	paramtype2 = "wallmounted",
	sunlight_propagates = true,
	groups = {snappy = 3}
})

end

minetest.register_craftitem("elepower_lighting:paper_red", {
	description = "Red Paper",
	inventory_image = "elepower_lighting_paper_red.png",
	groups = {flammable = 3}
})

minetest.register_craftitem("elepower_lighting:paper_blue", {
	description = "Blue Paper",
	inventory_image = "elepower_lighting_paper_blue.png",
	groups = {flammable = 3}
})

minetest.register_craft({
	type = "fuel",
	recipe = "elepower_lighting:paper_red",
	burntime = 1,
})

minetest.register_craft({
	type = "fuel",
	recipe = "elepower_lighting:paper_blue",
	burntime = 1,
})
