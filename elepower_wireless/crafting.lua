
-- Receiver
minetest.register_craft({
	output = "elepower_wireless:matter_receiver",
	recipe = {
		{"elepower_dynamics:wound_silver_coil", "elepower_dynamics:soc", "elepower_dynamics:wound_silver_coil"},
		{"elepower_dynamics:electrum_gear", "default:steelblock", "elepower_dynamics:electrum_gear"},
		{"elepower_dynamics:xycrone_lump", "elepower_dynamics:viridisium_ingot", "elepower_dynamics:xycrone_lump"},
	}
})

-- Transmitter
minetest.register_craft({
	output = "elepower_wireless:matter_transmitter",
	recipe = {
		{"elepower_dynamics:wound_silver_coil", "elepower_dynamics:soc", "elepower_dynamics:wound_silver_coil"},
		{"elepower_dynamics:xycrone_lump", "default:steelblock", "elepower_dynamics:xycrone_lump"},
		{"elepower_dynamics:electrum_gear", "elepower_dynamics:viridisium_ingot", "elepower_dynamics:electrum_gear"},
	}
})

-- Dialler
minetest.register_craft({
	output = "elepower_wireless:dialler",
	recipe = {
		{"elepower_dynamics:wound_silver_coil", "elepower_dynamics:soc", "elepower_dynamics:wound_silver_coil"},
		{"elepower_dynamics:wound_copper_coil", "default:steelblock", "elepower_dynamics:wound_copper_coil"},
		{"elepower_dynamics:electrum_gear", "elepower_dynamics:viridisium_ingot", "elepower_dynamics:electrum_gear"},
	}
})

-- Wireless Porter
minetest.register_craft({
	output = "elepower_wireless:wireless_porter",
	recipe = {
		{"elepower_dynamics:wound_silver_coil", "elepower_dynamics:xycrone_lump", "elepower_dynamics:wound_silver_coil"},
		{"elepower_dynamics:xycrone_lump", "elepower_dynamics:copper_wire", "elepower_dynamics:xycrone_lump"},
		{"elepower_dynamics:wound_silver_coil", "elepower_dynamics:xycrone_lump", "elepower_dynamics:wound_silver_coil"},
	}
})
