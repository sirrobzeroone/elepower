
local iC = 1 -- Casing
local iR = 2 -- Controller
local iI = 3 -- Inputs
local iO = 4 -- Outputs
local iE = 5 -- Energy Inputs
local iX = 6 -- Center nodes

-- Width and Height of the structure
local structure_size = 15

-- This is the reactor structure (y 0 to 2)
local reactor_structure = {}

local controller_pos = {x = 7, z = 14}

-- Determine the validity of the structure from the position of the controller
local function determine_structure(pos, player)
	local node = minetest.get_node_or_nil(pos)
	if not node then return nil end

	local hsize  = math.floor(structure_size / 2)
	local hindex = {x = hsize, y = 1, z = structure_size}

	-- TODO: Determine build direction
	--local front = ele.helpers.face_front(pos, node.param2)

	-- Load appropriate map piece into memory for easier parsing
	local manip = minetest.get_voxel_manip()
	local e1, e2 = manip:read_from_map(vector.subtract(pos, hindex), vector.add(pos, hindex))
	local area = VoxelArea:new{MinEdge=e1, MaxEdge=e2}
	local data = manip:get_data()
	local success = true

	local inputs  = {}
	local outputs = {}
	local power   = {}

	for y = -1, 1 do
		if not success then break end

		local arr = reactor_structure[(y + 2)]

		for i = 1, #arr do
			local ntype = arr[i]
			local indx = i - 1

			if ntype ~= 0 then
				local z = math.floor(indx / structure_size)
				local x = math.floor(indx % structure_size)

				local relX = controller_pos.x - x
				local relZ = controller_pos.z - z

				local scan_pos = vector.add(pos, {x = relX, y = y, z = relZ})
				local index = area:indexp(scan_pos)
				if data[index] ~= ntype then
					minetest.chat_send_player(player, ('Incorrect node at %d,%d,%d; expected %s, found %s'):format(
						scan_pos.x,scan_pos.y,scan_pos.z,minetest.get_name_from_content_id(ntype),
						minetest.get_name_from_content_id(data[index])))
					success = false
					break
				end

				if ntype == iI then
					table.insert(inputs, scan_pos)
				elseif ntype == iO then
					table.insert(outputs, scan_pos)
				elseif ntype == iE then
					table.insert(power, scan_pos)
				end
			end
		end
	end

	if success then
		minetest.chat_send_player(player, "Multi-node structure complete!")
	end

	return success, inputs, outputs, power
end

-----------
-- Nodes --
-----------

minetest.register_node("elepower_nuclear:reactor_controller", {
	description = "Fusion Reactor Controller",
	tiles = {
		"elepower_advblock_combined.png", "elepower_advblock_combined.png", "elepower_advblock_combined.png",
		"elepower_advblock_combined.png", "elepower_advblock_combined.png", "elepower_advblock_combined.png^elenuclear_fusion_controller.png",
	},
	groups = {cracky = 2},
	on_punch = function (pos, node, puncher, pointed_thing)
		print(determine_structure(pos, puncher:get_player_name()))
		minetest.node_punch(pos, node, puncher, pointed_thing)
	end,
})

minetest.register_node("elepower_nuclear:reactor_power", {
	description = "Fusion Reactor Power Port (Input)",
	tiles = {
		"elepower_advblock_combined.png", "elepower_advblock_combined.png", "elepower_advblock_combined.png",
		"elepower_advblock_combined.png", "elepower_advblock_combined.png", "elepower_advblock_combined.png^elenuclear_power_port.png^elepower_power_port.png",
	},
	paramtype2 = "facedir",
	groups = {cracky = 2},
})

minetest.register_node("elepower_nuclear:reactor_fluid", {
	description = "Fusion Reactor Fluid Port (Input)",
	tiles = {
		"elepower_advblock_combined.png", "elepower_advblock_combined.png", "elepower_advblock_combined.png",
		"elepower_advblock_combined.png", "elepower_advblock_combined.png",
		"elepower_advblock_combined.png^elenuclear_fluid_port.png^elepower_power_port.png",
	},
	paramtype2 = "facedir",
	groups = {cracky = 2},
})

minetest.register_node("elepower_nuclear:reactor_output", {
	description = "Fusion Reactor Fluid Port (Output)",
	tiles = {
		"elepower_advblock_combined.png", "elepower_advblock_combined.png", "elepower_advblock_combined.png",
		"elepower_advblock_combined.png", "elepower_advblock_combined.png",
		"elepower_advblock_combined.png^elenuclear_fluid_port_out.png^elepower_power_port.png",
	},
	paramtype2 = "facedir",
	groups = {cracky = 2},
})

-- Define reactor structure with Content IDs

iC = minetest.get_content_id("elepower_machines:advanced_machine_block")
iR = minetest.get_content_id("elepower_nuclear:reactor_controller")
iI = minetest.get_content_id("elepower_nuclear:reactor_fluid")
iO = minetest.get_content_id("elepower_nuclear:reactor_output")
iE = minetest.get_content_id("elepower_nuclear:reactor_power")
iX = minetest.get_content_id("elepower_nuclear:fusion_coil")

reactor_structure = {
	{
		0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
		0,  0,  0,  0,  0,  0,  iC, iC, iC, 0,  0,  0,  0,  0,  0,
		0,  0,  0,  0,  iC, iC, 0,  0,  0,  iC, iC, 0,  0,  0,  0,
		0,  0,  0,  iC, 0,  0,  0,  0,  0,  0,  0,  iC, 0,  0,  0,
		0,  0,  iC, 0,  0,  0,  0,  0,  0,  0,  0,  0,  iC, 0,  0,
		0,  0,  iC, 0,  0,  0,  0,  0,  0,  0,  0,  0,  iC, 0,  0,
		0,  iC, 0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, iC,  0,
		0,  iI, 0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, iI,  0,
		0,  iC, 0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, iC,  0,
		0,  0,  iC, 0,  0,  0,  0,  0,  0,  0,  0,  0,  iC, 0,  0,
		0,  0,  iC, 0,  0,  0,  0,  0,  0,  0,  0,  0,  iC, 0,  0,
		0,  0,  0,  iC, 0,  0,  0,  0,  0,  0,  0,  iC, 0,  0,  0,
		0,  0,  0,  0,  iC, iC, 0,  0,  0,  iC, iC, 0,  0,  0,  0,
		0,  0,  0,  0,  0,  0,  iC, iC, iC, 0,  0,  0,  0,  0,  0,
		0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
	},
	{
		0,  0,  0,  0,  0,  0,  iC, iE, iC, 0,  0,  0,  0,  0,  0,
		0,  0,  0,  0,  iC, iC, iX, iX, iX, iC, iC, 0,  0,  0,  0,
		0,  0,  0,  iC, iX, iX, iC, iC, iC, iX, iX, iC, 0,  0,  0,
		0,  0,  iC, iX, iC, iC, 0,  0,  0,  iC, iC, iX, iC, 0,  0,
		0,  iC, iX, iC, 0,  0,  0,  0,  0,  0,  0,  iC, iX, iC, 0,
		0,  iC, iX, iC, 0,  0,  0,  0,  0,  0,  0,  iC, iX, iC, 0,
		iC, iX, iC, 0,  0,  0,  0,  0,  0,  0,  0,  0,  iC, iX, iC,
		iE, iX, iC, 0,  0,  0,  0,  0,  0,  0,  0,  0,  iC, iX, iE,
		iC, iX, iC, 0,  0,  0,  0,  0,  0,  0,  0,  0,  iC, iX, iC,
		0,  iC, iX, iC, 0,  0,  0,  0,  0,  0,  0,  iC, iX, iC, 0,
		0,  iC, iX, iC, 0,  0,  0,  0,  0,  0,  0,  iC, iX, iC, 0,
		0,  0,  iC, iX, iC, iC, 0,  0,  0,  iC, iC, iX, iC, 0,  0,
		0,  0,  0,  iC, iX, iX, iC, iC, iC, iX, iX, iC, 0,  0,  0,
		0,  0,  0,  0,  iC, iC, iX, iX, iX, iC, iC, 0,  0,  0,  0,
		0,  0,  0,  0,  0,  0,  iC, iR, iC, 0,  0,  0,  0,  0,  0,
	},
	{
		0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
		0,  0,  0,  0,  0,  0,  iC, iC, iC, 0,  0,  0,  0,  0,  0,
		0,  0,  0,  0,  iC, iC, 0,  0,  0,  iC, iC, 0,  0,  0,  0,
		0,  0,  0,  iC, 0,  0,  0,  0,  0,  0,  0,  iC, 0,  0,  0,
		0,  0,  iC, 0,  0,  0,  0,  0,  0,  0,  0,  0,  iC, 0,  0,
		0,  0,  iC, 0,  0,  0,  0,  0,  0,  0,  0,  0,  iC, 0,  0,
		0,  iC, 0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, iC,  0,
		0,  iO, 0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, iO,  0,
		0,  iC, 0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, iC,  0,
		0,  0,  iC, 0,  0,  0,  0,  0,  0,  0,  0,  0,  iC, 0,  0,
		0,  0,  iC, 0,  0,  0,  0,  0,  0,  0,  0,  0,  iC, 0,  0,
		0,  0,  0,  iC, 0,  0,  0,  0,  0,  0,  0,  iC, 0,  0,  0,
		0,  0,  0,  0,  iC, iC, 0,  0,  0,  iC, iC, 0,  0,  0,  0,
		0,  0,  0,  0,  0,  0,  iC, iC, iC, 0,  0,  0,  0,  0,  0,
		0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
	}
}
