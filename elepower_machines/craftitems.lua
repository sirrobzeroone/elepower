
minetest.register_craftitem("elepower_machines:compressor_piston", {
	description = "Compressor Piston",
	inventory_image = "elepower_compressor_piston.png"
})

minetest.register_craftitem("elepower_machines:turbine_blades", {
	description = "Turbine Blades",
	inventory_image = "elepower_turbine.png"
})

---------------
-- Upgrading --
---------------

-- Capacitors
minetest.register_craftitem("elepower_machines:hardened_capacitor", {
	description = "Hardened Capacitor\nTier 2 Capacitor",
	groups = {capacitor = 2, ele_upgrade_component = 1},
	inventory_image = "elepower_upgrade_hardened_capacitor.png"
})

minetest.register_craftitem("elepower_machines:reinforced_capacitor", {
	description = "Reinforced Capacitor\nIt will probably obliterate you if you touched it while charged\nTier 3 Capacitor",
	groups = {capacitor = 3, ele_upgrade_component = 1},
	inventory_image = "elepower_upgrade_reinforced_capacitor.png"
})

minetest.register_craftitem("elepower_machines:resonant_capacitor", {
	description = "Resonant Capacitor\nTier 4 Capacitor",
	groups = {capacitor = 4, ele_upgrade_component = 1},
	inventory_image = "elepower_upgrade_resonant_capacitor.png"
})

minetest.register_craftitem("elepower_machines:super_capacitor", {
	description = "Supercapacitor\nAmazing energy density in a small container! Wow!\nTier 5 Capacitor",
	groups = {capacitor = 5, ele_upgrade_component = 1},
	inventory_image = "elepower_upgrade_supercapacitor.png"
})
