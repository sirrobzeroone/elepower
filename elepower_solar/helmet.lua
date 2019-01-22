
-- Solar helmet
armor:register_armor("elepower_solar:helmet", {
	description = "Solar Helmet",
	inventory_image = "elepower_armor_inv_helmet_solar.png",
	texture = "elepower_armor_helmet_solar.png",
	preview = "elepower_armor_helmet_solar_preview.png",
	groups = {armor_head=1, armor_heal=0, armor_use=2000,
		physics_speed=0.01, physics_gravity=0.01},
	armor_groups = {fleshy=9},
	damage_groups = {cracky=3, snappy=2, choppy=3, crumbly=2, level=1},
})
