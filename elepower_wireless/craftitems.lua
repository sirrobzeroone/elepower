
local function porter_teleport(itemstack, player, pointed_thing)
	local meta    = itemstack:get_meta()
	local storage = ele.tools.get_tool_property(itemstack, "storage")
	local pos     = minetest.string_to_pos(meta:get_string("receiver"))

	if not pos or pos == "" then return itemstack end

	local node = minetest.get_node_or_nil(pos)

	local plname = player:get_player_name()
	if not node or not ele.helpers.get_item_group(node.name, "matter_receiver") then
		minetest.chat_send_player(plname, "Destination Receiver is missing or unloaded!")
		return itemstack
	end

	local nmeta    = minetest.get_meta(pos)
	local nstorage = ele.helpers.get_node_property(nmeta, pos, "storage")
	local nusage   = ele.helpers.get_node_property(nmeta, pos, "usage")
	local top      = vector.add(pos, {x = 0, y = 1, z = 0})
	local topnode  = minetest.get_node_or_nil(top)

	if topnode and topnode.name ~= "air" then
		minetest.chat_send_player(plname, "Destination is obstructed!")
		return itemstack
	end

	if nstorage < nusage then
		minetest.chat_send_player(plname, "Receiver is out of power!")
		return itemstack
	end

	if storage < nusage then
		minetest.chat_send_player(plname, "Your Wireless Porter is out of power!")
		return itemstack
	end

	-- Teleport player
	player:set_pos(top)

	-- TODO: Sound

	nmeta:set_int("storage", nstorage - nusage)
	ele.helpers.start_timer(pos)

	-- Add wear
	meta:set_int("storage", storage - nusage)
	itemstack = ele.tools.update_tool_wear(itemstack)

	return itemstack
end

ele.register_tool("elepower_wireless:wireless_porter", {
	description      = "Wireless Porter",
	inventory_image  = "elewireless_wireless_porter.png",
	on_use           = porter_teleport,
	on_secondary_use = porter_teleport,
	on_place = function(itemstack, placer, pointed_thing)
		if not placer or placer:get_player_name() == "" then return itemstack end
		local player = placer:get_player_name()
		local pos    = pointed_thing.under

		if minetest.is_protected(pos, player) then 
			minetest.chat_send_player(player, "You are not allowed to teleport here!")
			return itemstack
		end

		local meta = itemstack:get_meta()
		local node = minetest.get_node_or_nil(pos)

		if not node or not ele.helpers.get_item_group(node.name, "matter_receiver") then
			minetest.chat_send_player(player, "Use on a Matter Receiver to bind teleport location!")
			return itemstack
		end

		local strpos = minetest.pos_to_string(pos)
		local curpos = minetest.string_to_pos(meta:get_string("receiver"))

		if curpos and vector.equals(curpos, pos) then
			minetest.chat_send_player(player, "Wireless Porter is already bound to this location!")
			return itemstack
		end

		meta:set_string("receiver", strpos)
		minetest.chat_send_player(player, ("Wireless Porter bound to receiver at %s!"):format(strpos))

		return itemstack
	end,
	ele_capacity = 1000,
})

minetest.register_craftitem("elepower_wireless:upgrade_item_transfer", {
	description = "Wireless Upgrade\nAllows for transmission of matter",
	groups = {wireless_chip = 2, ele_upgrade_component = 1},
	inventory_image = "elewireless_upgrade_item_transfer.png",
	ele_upgrade = {
		usage = {
			multiplier = 2
		}
	}
})
