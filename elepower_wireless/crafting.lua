
local easycrafting = minetest.settings:get("elepower_easy_crafting") == "true"
local ingot = "elepower_dynamics:viridisium_ingot"
if easycrafting then
	ingot = "elepower_dynamics:electrum_ingot"
end

-- Receiver
minetest.register_craft({
	output = "elepower_wireless:matter_receiver",
	recipe = {
		{"elepower_dynamics:wound_silver_coil", "elepower_dynamics:soc", "elepower_dynamics:wound_silver_coil"},
		{"elepower_dynamics:electrum_gear", "default:steelblock", "elepower_dynamics:electrum_gear"},
		{"elepower_dynamics:xycrone_lump", ingot, "elepower_dynamics:xycrone_lump"},
	}
})

-- Transmitter
minetest.register_craft({
	output = "elepower_wireless:matter_transmitter",
	recipe = {
		{"elepower_dynamics:wound_silver_coil", "elepower_dynamics:soc", "elepower_dynamics:wound_silver_coil"},
		{"elepower_dynamics:xycrone_lump", "default:steelblock", "elepower_dynamics:xycrone_lump"},
		{"elepower_dynamics:electrum_gear", ingot, "elepower_dynamics:electrum_gear"},
	}
})

-- Dialler
minetest.register_craft({
	output = "elepower_wireless:dialler",
	recipe = {
		{"elepower_dynamics:wound_silver_coil", "elepower_dynamics:soc", "elepower_dynamics:wound_silver_coil"},
		{"elepower_dynamics:wound_copper_coil", "default:steelblock", "elepower_dynamics:wound_copper_coil"},
		{"elepower_dynamics:electrum_gear", "elepower_dynamics:lcd_panel", "elepower_dynamics:electrum_gear"},
	}
})

-- Wireless Porter
minetest.register_craft({
	output = "elepower_wireless:wireless_porter",
	recipe = {
		{"elepower_dynamics:wound_silver_coil", "elepower_dynamics:xycrone_lump", "elepower_dynamics:wound_silver_coil"},
		{"elepower_dynamics:xycrone_lump", "basic_materials:copper_wire", "elepower_dynamics:xycrone_lump"},
		{"elepower_dynamics:wound_silver_coil", "elepower_dynamics:battery", "elepower_dynamics:wound_silver_coil"},
	},
	replacements = {
		{"basic_materials:copper_wire", "basic_materials:empty_spool"},
	}
})

-- Control Station
minetest.register_craft({
	output = "elepower_wireless:station",
	recipe = {
		{"elepower_dynamics:wound_copper_coil", "elepower_dynamics:soc", "elepower_dynamics:wound_copper_coil"},
		{"elepower_dynamics:viridisium_plate", "elepower_machines:machine_block", "elepower_dynamics:viridisium_plate"},
		{"elepower_dynamics:wound_copper_coil", "elepower_dynamics:lcd_panel", "elepower_dynamics:wound_copper_coil"},
	}
})

-- Control Station Chip
minetest.register_craft({
	output = "elepower_wireless:card",
	recipe = {
		{"elepower_dynamics:wound_copper_coil", "elepower_dynamics:chip", "elepower_dynamics:wound_copper_coil"},
		{"elepower_dynamics:wound_copper_coil", "basic_materials:plastic_sheet", "elepower_dynamics:wound_copper_coil"},
		{"basic_materials:plastic_sheet", "group:color_red", "basic_materials:plastic_sheet"},
	}
})

--[[
-- Tesseract Frame
minetest.register_craft({
	output = "elepower_wireless:tesseract_frame",
	recipe = {
		{"elepower_dynamics:lead_block", "elepower_dynamics:conduit", "elepower_dynamics:lead_block"},
		{"fluid_transfer:fluid_duct", "", "fluid_transfer:fluid_duct"},
		{"elepower_dynamics:lead_block", "elepower_dynamics:conduit", "elepower_dynamics:lead_block"},
	}
})

-- Tesseract
minetest.register_craft({
	output = "elepower_wireless:tesseract",
	recipe = {
		{"elepower_dynamics:induction_coil_advanced", "elepower_dynamics:soc", "elepower_dynamics:induction_coil_advanced"},
		{"elepower_dynamics:xycrone_lump", "elepower_wireless:tesseract_frame", "elepower_dynamics:xycrone_lump"},
		{"elepower_dynamics:viridisium_block", "elepower_dynamics:servo_valve", "elepower_dynamics:viridisium_block"},
	}
})
]]
