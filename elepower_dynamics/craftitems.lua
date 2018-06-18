
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

---------------
-- Overrides --
---------------
