
----------------
-- Craftitems --
----------------

-- Ingots

minetest.register_craftitem("elepower_dynamics:lead_ingot", {
	description = "Lead Ingot",
	inventory_image = "elepower_lead_ingot.png",
	groups = {lead = 1, ingot = 1}
})

minetest.register_craftitem("elepower_dynamics:iron_ingot", {
	description = "Iron Ingot",
	inventory_image = "elepower_iron_ingot.png",
	groups = {iron = 1, ingot = 1}
})

-- Lumps

minetest.register_craftitem("elepower_dynamics:lead_lump", {
	description = "Lead Lump",
	inventory_image = "elepower_lead_lump.png",
	groups = {lead = 1, lump = 1}
})

-- Other

minetest.register_craftitem("elepower_dynamics:carbon_fiber", {
	description = "Carbon Fibers",
	inventory_image = "elepower_carbon_fiber.png",
	groups = {carbon_fiber = 1}
})

minetest.register_craftitem("elepower_dynamics:carbon_sheet", {
	description = "Carbon Fiber Sheet",
	inventory_image = "elepower_carbon_fiber_sheet.png",
	groups = {carbon_fiber_sheet = 1, sheet = 1}
})

minetest.register_craftitem("elepower_dynamics:wound_copper_coil", {
	description = "Wound Copper Coil",
	inventory_image = "elepower_copper_coil.png",
	groups = {copper = 1, coil = 1, component = 1}
})

minetest.register_craftitem("elepower_dynamics:copper_wire", {
	description = "Copper Wire",
	inventory_image = "elepower_copper_wire.png",
	groups = {copper = 1, wire = 1, component = 1}
})

minetest.register_craftitem("elepower_dynamics:servo_valve", {
	description = "Servo Valve",
	inventory_image = "elepower_servo_valve.png",
	groups = {servo_valve = 1, component = 1}
})

minetest.register_craftitem("elepower_dynamics:tree_tap", {
	description = "Steel Treetap",
	inventory_image = "elepower_tree_tap.png",
	groups = {treetap = 1, component = 1}
})

---------------
-- Overrides --
---------------
