
---------------------------
-- Fission-related items --
---------------------------

-- Uranium

minetest.register_craftitem("elepower_nuclear:uranium_lump", {
	description = "Uranium Lump",
	inventory_image = "elenuclear_uranium_lump.png"
})

minetest.register_craftitem("elepower_nuclear:uranium_ingot", {
	description = "Enriched Uranium Ingot",
	inventory_image = "elenuclear_uranium_ingot.png"
})

minetest.register_craftitem("elepower_nuclear:depleted_uranium_ingot", {
	description = "Depleted Uranium Ingot",
	inventory_image = "elenuclear_depleted_uranium_ingot.png"
})

-- Dusts

minetest.register_craftitem("elepower_nuclear:uranium_dust", {
	description = "Enriched Uranium Dust",
	inventory_image = "elenuclear_uranium_dust.png"
})

minetest.register_craftitem("elepower_nuclear:depleted_uranium_dust", {
	description = "Depleted Uranium Dust",
	inventory_image = "elenuclear_depleted_uranium_dust.png"
})

minetest.register_craftitem("elepower_nuclear:uranium_waste", {
	description = "Uranium Waste",
	inventory_image = "elenuclear_uranium_waste.png"
})

-- Fuel rods

minetest.register_craftitem("elepower_nuclear:fuel_rod_empty", {
	description = "Empty Fuel Rod",
	inventory_image = "elenuclear_fuel_rod_empty.png"
})

minetest.register_craftitem("elepower_nuclear:fuel_rod_fissile", {
	description = "Fissile Fuel Rod",
	inventory_image = "elenuclear_fuel_rod_fissile.png"
})

minetest.register_craftitem("elepower_nuclear:fuel_rod_depleted", {
	description = "Depleted Fuel Rod",
	inventory_image = "elenuclear_fuel_rod_depleted.png"
})

--------------------------
-- Fusion-related items --
--------------------------



-------------------------
-- Crafting components --
-------------------------

-- Graphite

minetest.register_craftitem("elepower_nuclear:graphite_rod", {
	description = "Graphite Rod",
	inventory_image = "elenuclear_graphite_rod.png"
})
