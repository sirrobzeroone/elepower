
local b_enabled = minetest.get_modpath("bucket") ~= nil

local function find_fluid(itemname)
	for _,data in ipairs(bucket.liquids) do
		if data.itemname and data.itemname == itemname then
			return data.source
		end
	end
	return nil
end

function elefluid.add_bucket_handler(nodedef)
	if not b_enabled then return nodedef end

	local orig = nodedef.on_rightclick
	nodedef.on_rightclick = function (pos, node, clicker, itemstack, pointed_thing)
		local bucket_name = itemstack:get_name()
		local action = false

		if bucket_name == "bucket:bucket_empty" then 
			local buffers = elefluid.get_node_buffers(pos)
			for buffer in pairs(buffers) do
				if elefluid.can_take_from_buffer(pos, buffer, 1000) == 1000 then
					local fluid = elefluid.take_from_buffer(pos, buffer, 1000)
					if bucket.liquids[fluid] then
						itemstack = ItemStack(bucket.liquids[fluid].itemname)
						action = true
					end
					break
				end
			end
		elseif find_fluid(bucket_name) then
			local fluid   = find_fluid(bucket)
			local buffers = elefluid.get_node_buffers(pos)
			for buffer in pairs(buffers) do
				if elefluid.can_insert_into_buffer(pos, buffer, fluid, 1000) == 1000 then
					elefluid.insert_into_buffer(pos, buffer, fluid, 1000)
					itemstack = ItemStack("bucket:bucket_empty")
					action = true
					break
				end
			end
		end

		-- Really stupid workaround so that the formspec closes after a bucket action was committed
		if action and not orig and clicker then
			minetest.close_formspec(clicker:get_player_name(), "")
		end

		if orig then
			return orig(pos, node, clicker, itemstack, pointed_thing)
		end

		return itemstack
	end

	return nodedef
end
