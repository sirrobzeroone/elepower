
local function upgrade_formspec (upgrades, desc)
	local posY  = 0.5
	local fspec = ""

	for k in pairs(upgrades) do
		local scrib = elepm.upgrading.dict[k]
		if not scrib then
			scrib = k
		end

		fspec = fspec .. "label[1,"..(posY + 0.25)..";"..scrib.."]"
		fspec = fspec .. "list[detached:soldering;"..k..";7,"..posY..";1,1;]"
		posY  = posY + 1
	end

	return "size[8,8.5]"..
		default.gui_bg..
		default.gui_bg_img..
		default.gui_slots..
		"label[0,0;Modifying "..desc.."]"..
		fspec..
		"list[current_player;main;0,4.25;8,1;]"..
		"list[current_player;main;0,5.5;8,3;8]"..
		"listring[current_player;main]"..
		default.get_hotbar_bg(0, 4.25)
end

local function set_component_list (pos, list)
	local meta = minetest.get_meta(pos)
	local len = 0
	for _,v in pairs(list) do
		if v ~= nil then
			len = len + 1
		end
	end

	if len == 0 and meta:get_string("components") ~= "" then
		meta:set_string("components", "")
	else
		meta:set_string("components", minetest.serialize(list))
	end

	if elepm then
		elepm.handle_machine_upgrades(pos)
	end
end

local function machine_modify (pos, node, user)
	local nodedef = minetest.registered_nodes[node.name]

	if not nodedef.ele_upgrades then
		return minetest.chat_send_player(user:get_player_name(), "This machine cannot be modified.")
	end

	local meta  = minetest.get_meta(pos)
	local comps = meta:get_string("components")

	-- Prevent the node from being dug
	-- It is recommended to have this check in can_dig callback.
	meta:set_int("drop_lock", 1)

	-- Save the soldered machine as an attribute on the player
	local umeta = user:get_meta()
	umeta:set_string("soldering", minetest.pos_to_string(pos))

	-- Deserialize component list
	if comps ~= "" then
		comps = minetest.deserialize(comps)
	else
		comps = {}
	end

	-- Create detached inventory for upgrades
	local inv = minetest.create_detached_inventory("soldering", {
		allow_move = function (inv, from_list, from_index, to_list, to_index, count, player)
			return 0
		end,

		allow_put = function (inv, listname, index, stack, player)
			if minetest.get_item_group(stack:get_name(), "ele_upgrade_component") == 0 or
				minetest.get_item_group(stack:get_name(), listname) < 2 then
				return 0
			end

			return 1
		end,

		allow_take = function (inv, listname, index, stack, player)
			return stack:get_count()
		end,

		on_put = function (inv, listname, index, stack, player)
			comps[listname] = stack:get_name()
			set_component_list(pos, comps)
		end,

		on_take = function (inv, listname, index, stack, player)
			comps[listname] = nil
			set_component_list(pos, comps)
		end,
	}, user:get_player_name())

	-- Add lists
	for k in pairs(nodedef.ele_upgrades) do
		inv:set_size(k, 1)

		if comps[k] then
			inv:set_stack(k, 1, ItemStack(comps[k]))
		end
	end

	-- Open the formspec
	minetest.show_formspec(user:get_player_name(), "elepower_tools:soldering_iron",
		upgrade_formspec(nodedef.ele_upgrades, nodedef.description))
end

minetest.register_on_player_receive_fields(function (player, formname, fields)
	if formname ~= "elepower_tools:soldering_iron" or not player then return false end

	local umeta = player:get_meta()
	local pos = umeta:get_string("soldering")
	if not pos then return false end

	pos = minetest.string_to_pos(pos)
	local meta = minetest.get_meta(pos)

	if fields["quit"] then
		meta:set_int("drop_lock", 0)
		umeta:set_string("soldering", "")
	end

	return true
end)

minetest.register_on_leaveplayer(function (player)
	local umeta = player:get_meta()
	local soldering = umeta:get_string("soldering")
	if soldering == "" then return end
	local pos = minetest.string_to_pos(soldering)
	local meta = minetest.get_meta(pos)
	if meta:get_int("drop_lock") == 1 then
		meta:set_int("drop_lock", 0)
	end
	umeta:set_string("soldering", "")
end)

ele.register_tool("elepower_tools:soldering_iron", {
	description = "Soldering Iron\nUsed to replace components in machines",
	inventory_image = "eletools_soldering_iron.png",
	wield_image = "eletools_soldering_iron.png^[transformR270",
	ele_capacity = 8000,
	ele_usage    = 64,
	on_use = function (itemstack, user, pointed_thing)
		if not user or user:get_player_name() == "" then return itemstack end
		if pointed_thing and pointed_thing.type == "node" then
			local pos = pointed_thing.under
			local node = minetest.get_node_or_nil(pos)

			if not node or node.name == "air" or minetest.is_protected(pos, user:get_player_name()) then
				return itemstack
			end

			if ele.helpers.get_item_group(node.name, "ele_machine") then
				machine_modify(pos, node, user)
			end
		end

		return itemstack
	end
})
