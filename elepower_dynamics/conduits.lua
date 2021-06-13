
-- Electric power
ele.register_conduit("elepower_dynamics:conduit", {
	description = "Power Conduit",
	tiles = {"elepower_conduit.png"},
	use_texture_alpha = "clip",
	groups = {oddly_breakable_by_hand = 1, cracky = 1}
})
--[[
ele.register_conduit("elepower_dynamics:conduit_wall", {
	description = "Power Conduit Wall Pass Through",
	tiles = {"elepower_machine_side.png^elepower_power_port.png"},
	use_texture_alpha = "clip",
	ele_conductor_density = 4/8,
	groups = {oddly_breakable_by_hand = 1, cracky = 1}
})
--]]
-- Fluid
fluid_lib.register_transfer_node("elepower_dynamics:opaque_duct", {
	description = "Opaque Fluid Duct",
	tiles = {"elepower_opaque_duct.png"},
	use_texture_alpha = "clip",
	duct_density = 1/5,
	groups = {oddly_breakable_by_hand = 1, cracky = 1}
})
