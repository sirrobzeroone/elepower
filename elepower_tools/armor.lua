
local materials = {iron = "elepower_dynamics:iron_ingot", carbon = "elepower_dynamics:carbon_sheet"}

-- Iron Armor
armor:register_armor("elepower_tools:helmet_iron", {
	description = "Iron Helmet",
	inventory_image = "elepower_armor_inv_helmet.png",
	texture = "elepower_armor_helmet.png",
	preview = "elepower_armor_helmet_preview.png",
	groups = {armor_head=1, armor_heal=0, armor_use=650,
		physics_speed=-0.001, physics_gravity=0.001},
	armor_groups = {fleshy=8},
	damage_groups = {cracky=2, snappy=3, choppy=2, crumbly=1, level=2},
})

armor:register_armor("elepower_tools:chestplate_iron", {
	description = "Iron Chestplate",
	inventory_image = "elepower_armor_inv_chestplate.png",
	texture = "elepower_armor_chestplate.png",
	preview = "elepower_armor_chestplate_preview.png",
	groups = {armor_torso=1, armor_heal=0, armor_use=650,
		physics_speed=-0.03, physics_gravity=0.03},
	armor_groups = {fleshy=13},
	damage_groups = {cracky=2, snappy=3, choppy=2, crumbly=1, level=2},
})

armor:register_armor("elepower_tools:leggings_iron", {
	description = "Iron Leggings",
	inventory_image = "elepower_armor_inv_leggings.png",
	texture = "elepower_armor_leggings.png",
	preview = "elepower_armor_leggings_preview.png",
	groups = {armor_legs=1, armor_heal=0, armor_use=650,
		physics_speed=-0.02, physics_gravity=0.02},
	armor_groups = {fleshy=13},
	damage_groups = {cracky=2, snappy=3, choppy=2, crumbly=1, level=2},
})

armor:register_armor("elepower_tools:boots_iron", {
	description = "Iron Boots",
	inventory_image = "elepower_armor_inv_boots.png",
	texture = "elepower_armor_boots.png",
	preview = "elepower_armor_boots_preview.png",
	groups = {armor_feet=1, armor_heal=0, armor_use=650,
		physics_speed=-0.001, physics_gravity=0.001},
	armor_groups = {fleshy=8},
	damage_groups = {cracky=2, snappy=3, choppy=2, crumbly=1, level=2},
})

-- Carbon Fiber Armor
armor:register_armor("elepower_tools:helmet_carbon", {
	description = "Carbon Fiber Helmet",
	inventory_image = "elepower_armor_inv_helmet_carbon.png",
	texture = "elepower_armor_helmet_carbon.png",
	preview = "elepower_armor_helmet_carbon_preview.png",
	groups = {armor_head=1, armor_heal=0, armor_use=2000,
		physics_speed=0.01, physics_gravity=0.01},
	armor_groups = {fleshy=9},
	damage_groups = {cracky=3, snappy=2, choppy=3, crumbly=2, level=1},
})

armor:register_armor("elepower_tools:chestplate_carbon", {
	description = "Carbon Fiber Chestplate",
	inventory_image = "elepower_armor_inv_chestplate_carbon.png",
	texture = "elepower_armor_chestplate_carbon.png",
	preview = "elepower_armor_chestplate_carbon_preview.png",
	groups = {armor_torso=1, armor_heal=0, armor_use=2000,
		physics_speed=0.03, physics_gravity=0.03},
	armor_groups = {fleshy=14},
	damage_groups = {cracky=3, snappy=2, choppy=3, crumbly=2, level=1},
})

armor:register_armor("elepower_tools:leggings_carbon", {
	description = "Carbon Fiber Leggings",
	inventory_image = "elepower_armor_inv_leggings_carbon.png",
	texture = "elepower_armor_leggings_carbon.png",
	preview = "elepower_armor_leggings_carbon_preview.png",
	groups = {armor_legs=1, armor_heal=0, armor_use=2000,
		physics_speed=0.02, physics_gravity=0.02},
	armor_groups = {fleshy=14},
	damage_groups = {cracky=3, snappy=2, choppy=3, crumbly=2, level=1},
})

armor:register_armor("elepower_tools:boots_carbon", {
	description = "Carbon Fiber Boots",
	inventory_image = "elepower_armor_inv_boots_carbon.png",
	texture = "elepower_armor_boots_carbon.png",
	preview = "elepower_armor_boots_carbon_preview.png",
	groups = {armor_feet=1, armor_heal=0, armor_use=2000,
		physics_speed=0.01, physics_gravity=0.01},
	armor_groups = {fleshy=9},
	damage_groups = {cracky=3, snappy=2, choppy=3, crumbly=2, level=1},
})

for k, v in pairs(materials) do
	minetest.register_craft({
		output = "elepower_tools:helmet_"..k,
		recipe = {
			{v, v, v},
			{v, "", v},
			{"", "", ""},
		},
	})
	minetest.register_craft({
		output = "elepower_tools:chestplate_"..k,
		recipe = {
			{v, "", v},
			{v, v, v},
			{v, v, v},
		},
	})
	minetest.register_craft({
		output = "elepower_tools:leggings_"..k,
		recipe = {
			{v, v, v},
			{v, "", v},
			{v, "", v},
		},
	})
	minetest.register_craft({
		output = "elepower_tools:boots_"..k,
		recipe = {
			{v, "", v},
			{v, "", v},
		},
	})
end

