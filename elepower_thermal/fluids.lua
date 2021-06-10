
-- Brine

ele.helpers.register_liquid("brine", {
	description       = "Brine",
	drawtype          = "liquid",
	tiles             = {"elenuclear_brine.png"},
	special_tiles     = {"elenuclear_brine.png", "elenuclear_brine.png"},
	use_texture_alpha = "blend",
	liquid_viscosity  = 7,
	post_effect_color = {a = 200, r = 215, g = 221, b = 187},
	groups            = {brine = 3, saline = 1, liquid = 3, puts_out_fire = 1, cools_lava = 1},
})

if minetest.get_modpath("bucket") ~= nil then
	bucket.register_liquid("elepower_thermal:brine_source", "elepower_thermal:brine_flowing",
		"elepower_thermal:bucket_heavy_water", "#d7ddbb", "Brine Bucket")

	fluid_tanks.register_tank(":elepower_dynamics:portable_tank", {
		description = "Portable Tank",
		capacity    = 8000,
		accepts     = true,
		tiles       = {
			"elepower_tank_base.png", "elepower_tank_side.png", "elepower_tank_base.png^elepower_power_port.png",
		}
		
	})
end
