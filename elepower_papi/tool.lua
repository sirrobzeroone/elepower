
ele.tools = {}

-- Get a tool property
function ele.tools.get_tool_property(itemstack, param)
	local meta  = itemstack:get_meta()
	local value = meta:get_int(param)

	if not value or value == 0 then
		local itemdef = minetest.registered_items[itemstack:get_name()]
		local dparam  = itemdef["ele_" .. param]
		if dparam then
			value = dparam
		end
	end

	return value
end

-- Set tool capabilities based on wear
function ele.tools.groupcaps(itemstack)
	local wear    = itemstack:get_wear()
	local meta    = itemstack:get_meta()
	local itemdef = minetest.registered_items[itemstack:get_name()]

	if wear == 65535 then
		meta:set_tool_capabilities({})
	else
		meta:set_tool_capabilities(nil)
	end

	return itemstack
end

function ele.tools.update_tool_wear(itemstack)
	local capacity = ele.tools.get_tool_property(itemstack, "capacity")
	local storage  = ele.tools.get_tool_property(itemstack, "storage")

	local meta = itemstack:get_meta()
	local itemdef = minetest.registered_items[itemstack:get_name()]

	local percent  = storage / capacity
	local wear     = math.floor((1-percent) * 65535)

	meta:set_string("description", itemdef.description .. "\n" .. ele.capacity_text(capacity, storage))

	itemstack:set_wear(wear)
	itemstack = ele.tools.groupcaps(itemstack)

	return itemstack
end

function ele.register_tool(toolname, tooldef)
	if not tooldef.groups then
		tooldef.groups = {}
	end

	tooldef.groups["ele_tool"] = 1

	-- Start cleaning up the tooldef
	local defaults = {
		ele_capacity = 1600,
		ele_usage    = 64,
	}

	-- Ensure everything that's required is present
	for k,v in pairs(defaults) do
		if not tooldef[k] then
			tooldef[k] = v
		end
	end

	tooldef.after_use = function (itemstack, user, node, digparams)
		local meta    = itemstack:get_meta()
		local storage = ele.tools.get_tool_property(itemstack, "storage")

		if digparams.wear == 0 then
			return itemstack
		end

		storage = storage - math.floor(digparams.wear / 16)
		if storage < 0 then
			storage = 0
		end

		meta:set_int("storage", storage)
		itemstack = ele.tools.update_tool_wear(itemstack)

		return itemstack
	end

	minetest.register_tool(toolname, tooldef)
end
