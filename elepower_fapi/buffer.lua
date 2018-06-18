-- This API is compatible with fluidity.
local fluidmod = minetest.get_modpath("fluidity") ~= nil

local function node_data(pos)
	local node    = minetest.get_node(pos)
	local nodedef = minetest.registered_nodes[node.name]
	return node, nodedef
end

function elefluid.get_node_buffers(pos)
	local node, nodedef = node_data(pos)
	if not nodedef['fluid_buffers'] and not ele.helpers.get_item_group(node.name, "fluidity_tank") then
		return nil
	end

	if fluidmod and ele.helpers.get_item_group(node.name, "fluidity_tank") then
		return {fluidity = {}}
	end

	return nodedef['fluid_buffers']
end

function elefluid.get_buffer_data(pos, buffer)
	local node, nodedef = node_data(pos)
	local buffers = elefluid.get_node_buffers(pos)

	if not buffers[buffer] then
		return nil
	end

	local meta     = minetest.get_meta(pos)
	local fluid    = meta:get_string(buffer .. "_fluid")
	local amount   = meta:get_int(buffer .. "_fluid_storage")
	local capacity = buffers[buffer].capacity
	local accepts  = buffers[buffer].accepts

	-- Fluidity tanks compatibility
	if buffer == "fluidity" then
		local ffluid, fluidcount, fcapacity, fbasetank, fmod = fluidity.tanks.get_tank_at(pos)

		fluid    = ffluid
		amount   = fluidcount
		accepts  = true
		capacity = fcapacity
	end

	return {
		fluid    = fluid,
		amount   = amount,
		accepts  = accepts,
		capacity = capacity,
	}
end

function elefluid.buffer_accepts_fluid(pos, buffer, fluid)
	local bfdata = elefluid.get_buffer_data(pos, buffer)
	if not bfdata then return false end
	
	if bfdata.accepts == true or bfdata.accepts == fluid then
		return true
	end

	if bfdata.fluid ~= "" and bfdata.fluid ~= fluid then
		return false
	end

	if type(bfdata.accepts) ~= "table" then
		bfdata.accepts = { bfdata.accepts }
	end

	for _,pf in pairs(bfdata.accepts) do
		if pf == fluid then
			return true
		elseif pf:match("^group") and ele.helpers.get_item_group(fluid, pf:gsub("group:", "")) then
			return true
		end
	end

	return false
end

function elefluid.can_insert_into_buffer(pos, buffer, fluid, count)
	local bfdata = elefluid.get_buffer_data(pos, buffer)
	if not bfdata then return nil end
	if bfdata.fluid ~= fluid and bfdata.fluid ~= "" then return nil end

	local can_put = 0
	if bfdata.amount + count > bfdata.capacity then
		can_put = bfdata.capacity - bfdata.amount
	else
		can_put = count
	end

	return can_put
end

function elefluid.insert_into_buffer(pos, buffer, fluid, count)
	local bfdata = elefluid.get_buffer_data(pos, buffer)
	if not bfdata then return nil end
	if bfdata.fluid ~= fluid and bfdata.fluid ~= "" then return nil end

	local can_put = elefluid.can_insert_into_buffer(pos, buffer, fluid, count)

	if can_put == 0 then return count end

	if buffer == "fluidity" then
		return fluidity.tanks.fill_tank_at(pos, fluid, count, true)
	end

	local meta = minetest.get_meta(pos)
	meta:set_int(buffer .. "_fluid_storage", bfdata.amount + can_put)
	meta:set_string(buffer .. "_fluid", fluid)

	return 0
end

function elefluid.can_take_from_buffer(pos, buffer, count)
	local bfdata = elefluid.get_buffer_data(pos, buffer)
	if not bfdata then return nil end

	local amount = bfdata.amount
	local take_count = 0

	if amount < count then
		take_count = amount
	else
		take_count = count
	end

	return take_count
end

function elefluid.take_from_buffer(pos, buffer, count)
	local bfdata = elefluid.get_buffer_data(pos, buffer)
	if not bfdata then return nil end

	local fluid  = bfdata.fluid
	local amount = bfdata.amount

	local take_count = elefluid.can_take_from_buffer(pos, buffer, count)

	if buffer == "fluidity" then
		local fname, cf = fluidity.tanks.take_from_tank_at(pos, count, true)
		if cf then
			count = count - cf
		end
		return fname, count
	end

	local new_storage = amount - take_count
	if new_storage == 0 then
		fluid = ""
	end

	local meta = minetest.get_meta(pos)
	meta:set_int(buffer .. "_fluid_storage", new_storage)
	meta:set_string(buffer .. "_fluid", fluid)

	return bfdata.fluid, take_count
end
