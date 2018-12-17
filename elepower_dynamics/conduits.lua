
-- Electric power
ele.register_conduit("elepower_dynamics:conduit", {
	description = "Power Conduit",
	tiles = {"elepower_conduit.png"},
	groups = {oddly_breakable_by_hand = 1, cracky = 1}
})

-- Fluid
fluid_lib.register_transfer_node("elepower_dynamics:opaque_duct", {
	description = "Opaque Fluid Duct",
	tiles = {"elepower_opaque_duct.png"},
	duct_density = 1/5,
	groups = {oddly_breakable_by_hand = 1, cracky = 1}
})
