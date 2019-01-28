
minetest.register_craftitem("elepower_machines:compressor_piston", {
	description = "Compressor Piston",
	inventory_image = "elepower_compressor_piston.png"
})

minetest.register_craftitem("elepower_machines:turbine_blades", {
	description = "Turbine Blades",
	inventory_image = "elepower_turbine.png"
})

-- Pump Tube Roll
minetest.register_craftitem("elepower_machines:opaque_duct_roll", {
	description = "Retractable Opaque Fluid Duct\nA Pump uses this to reach fluids.",
	inventory_image = "elepower_opaque_duct.png",
})

---------------
-- Upgrading --
---------------

-- Capacitors

minetest.register_craftitem("elepower_machines:hardened_capacitor", {
	description = "Hardened Capacitor\nTier 2 Capacitor",
	groups = {capacitor = 2, ele_upgrade_component = 1},
	inventory_image = "elepower_upgrade_hardened_capacitor.png",
	ele_upgrade = {
		capacity = {
			multiplier = 1,
		},
	},
})

minetest.register_craftitem("elepower_machines:reinforced_capacitor", {
	description = "Reinforced Capacitor\nIt will probably obliterate you if you touched it while charged\nTier 3 Capacitor",
	groups = {capacitor = 3, ele_upgrade_component = 1},
	inventory_image = "elepower_upgrade_reinforced_capacitor.png",
	ele_upgrade = {
		capacity = {
			multiplier = 1,
		},
	},
})

minetest.register_craftitem("elepower_machines:resonant_capacitor", {
	description = "Resonant Capacitor\nTier 4 Capacitor",
	groups = {capacitor = 4, ele_upgrade_component = 1},
	inventory_image = "elepower_upgrade_resonant_capacitor.png",
	ele_upgrade = {
		capacity = {
			multiplier = 10,
		},
	},
})

minetest.register_craftitem("elepower_machines:super_capacitor", {
	description = "Supercapacitor\nAmazing energy density in a small container! Wow!\nTier 5 Capacitor",
	groups = {capacitor = 5, ele_upgrade_component = 1},
	inventory_image = "elepower_upgrade_supercapacitor.png",
	ele_upgrade = {
		capacity = {
			multiplier = 100,
		},
	},
})

-- Machine chips

minetest.register_craftitem("elepower_machines:upgrade_speed", {
	description = "Speed Upgrade\nCrafting Speed +1\nPower Usage +50%",
	groups = {machine_chip = 2, ele_upgrade_component = 1},
	inventory_image = "elepower_upgrade_speed.png",
	ele_upgrade = {
		craft_speed = {
			add = 1
		},
		usage = {
			multiplier = 0.5
		},
		inrush = {
			multiplier = 0.5
		}
	}
})

minetest.register_craftitem("elepower_machines:upgrade_efficiency", {
	description = "Efficiency Upgrade\nReduces power usage by 25%",
	groups = {machine_chip = 2, ele_upgrade_component = 1},
	inventory_image = "elepower_upgrade_efficiency.png",
	ele_upgrade = {
		usage = {
			divider = 0.25
		}
	}
})

minetest.register_craftitem("elepower_machines:upgrade_efficiency_2", {
	description = "Efficiency Upgrade\nReduces power usage by 50%",
	groups = {machine_chip = 2, ele_upgrade_component = 1},
	inventory_image = "elepower_upgrade_efficiency_2.png",
	ele_upgrade = {
		usage = {
			divider = 0.50
		}
	}
})

-- Accumulator filter

minetest.register_craftitem("elepower_machines:heavy_filter", {
	description = "Liquid Weight Filter\nMakes water pumps pump only Heavy Water\nRight-Click to apply to Water Accumulator",
	groups = {accumulator_filter = 1, pump_filter = 2, ele_upgrade_component = 1},
	inventory_image = "elepower_accumulator_filter.png",
	on_place = function (itemstack, placer, pointed_thing)
		if not placer or not placer:is_player() then return itemstack end
		local pos = pointed_thing.under
		if pointed_thing.type ~= "node" or minetest.is_protected(pos, placer:get_player_name()) then return itemstack end

		local node = minetest.get_node(pos)
		if node.name ~= "elepower_machines:accumulator" then return itemstack end

		minetest.swap_node(pos, {name = "elepower_machines:accumulator_heavy"})

		local meta = minetest.get_meta(pos)
		meta:set_int("water_fluid_storage", 0)
		meta:set_string("water_fluid", "elepower_nuclear:heavy_water_source")

		itemstack:take_item(1)
		return itemstack
	end
})

-- Wind turbine

minetest.register_craftitem("elepower_machines:wind_turbine_blade", {
	description = "Wind Turbine Blade (Wooden)",
	inventory_image = "elepower_wind_turbine_blade.png",
})
