
-- Electric power
ele.register_conduit("elepower_dynamics:conduit", {
	description = "Power Conduit",
	tiles = {"elepower_conduit.png"},
	groups = {oddly_breakable_by_hand = 1, cracky = 1}
})

--[[ Fluids
elefluid.register_transfer_node("elepower_dynamics:fluid_transfer_node", {
	description = "Fluid Transfer Node",
	tiles = {"elepower_fluid_transporter_side.png", "elepower_fluid_transporter_side.png^[transformR180",
			 "elepower_fluid_transporter_side.png^[transformR270", "elepower_fluid_transporter_side.png^[transformFXR90",
			 "elepower_fluid_transporter_back.png", "elepower_fluid_transporter_front.png"},
	groups = {oddly_breakable_by_hand = 1, cracky = 1}
})--]]

elefluid.register_transfer_node("elepower_dynamics:fluid_transfer_node", {
	description = "Fluid Transfer Node",
	tiles = {"elepower_fluid_transporter.png"},
	drawtype = "mesh",
	mesh = "elepower_transport_node.obj",
	groups = {oddly_breakable_by_hand = 1, cracky = 1},
	paramtype = "light",
})

elefluid.register_transfer_duct("elepower_dynamics:fluid_duct", {
	description = "Fluid Duct",
	tiles = {"elepower_duct.png"},
	groups = {oddly_breakable_by_hand = 1, cracky = 1}
})
