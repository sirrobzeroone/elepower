elewi.node_handlers = {}
local desc_cache = {}

local function default_on_receive_fields(name)
	local rcv = minetest.registered_nodes[name].on_receive_fields
	if not rcv then return function ( ... ) end end
	return function (pos, fields, sender)
		return rcv(pos, name, fields, sender)
	end
end

function elewi.register_handler(name, def)
	assert(minetest.registered_nodes[name])
	assert(def.get_formspec)

	if not def.on_receive_fields then
		def.on_receive_fields = default_on_receive_fields(name)
	end

	elewi.node_handlers[name] = def
end

local function get_desc(node)
	if desc_cache[node] then return desc_cache[node] end
	local n = minetest.registered_nodes[node]
	if not n then return "" end
	desc_cache[node] = ele.helpers.get_first_line(n.description)
	return desc_cache[node]
end

local function get_formspec(power)
	return "size[8,8.5]"..
		default.gui_bg..
		default.gui_bg_img..
		default.gui_slots..
		ele.formspec.power_meter(power)..
		"list[context;card;3.5,1;1,1;]"..
		"list[current_player;main;0,4.25;8,1;]"..
		"list[current_player;main;0,5.5;8,3;8]"..
		"listring[current_player;main]"..
		"listring[context;card]"..
		"listring[current_player;main]"..
		default.get_hotbar_bg(0, 4.25)
end

local function data_from_card(card)
	if card:is_empty() then return nil end

	local meta = card:get_meta()
	local pstr = meta:get_string("pos")
	local rpos = minetest.string_to_pos(pstr)
	local node = meta:get_string("node")
	if not rpos or node == "" then return nil end

	-- Check validity
	local nodeat = minetest.get_node_or_nil(rpos)
	if not nodeat or nodeat.name ~= node then return nil end

	return elewi.node_handlers[node], { pos = rpos, pos_str = pstr, node = node }
end

local function station_timer(pos, elapsed)
	local meta = minetest.get_meta(pos)
	local inv = meta:get_inventory()
	local card = inv:get_stack("card", 1)
	local fns, info = data_from_card(card)

	local capacity = ele.helpers.get_node_property(meta, pos, "capacity")
	local storage  = ele.helpers.get_node_property(meta, pos, "storage")
	local usage    = ele.helpers.get_node_property(meta, pos, "usage")

	local pow_buffer = {capacity = capacity, storage = storage, usage = usage}
	local status = "Idle"

	if not fns then
		pow_buffer.usage = 0
		meta:set_string("formspec", get_formspec(pow_buffer))
		meta:set_string("infotext", "Wireless Control Station Idle")
		return false
	end

	status = ("Monitoring %s at %s"):format(get_desc(info.node), info.pos_str)

	if storage < usage then
		pow_buffer.usage = 0
		status = status .. "\nOut of Power!"
		meta:set_string("formspec", get_formspec(pow_buffer))
	else
		storage = storage - usage
		meta:set_int("storage", storage)
		meta:set_string("formspec", fns.get_formspec(info.pos, pow_buffer, pos, meta))
	end

	meta:set_string("infotext", "Wireless Control Station\n"..status)

	return true
end

local function allow_metadata_inventory_put(pos, listname, index, stack, player)
	if minetest.is_protected(pos, player:get_player_name()) then
		return 0
	end

	if listname == "card" and stack:get_name() ~= "elepower_wireless:card" then
		return 0
	end

	return stack:get_count()
end

local function allow_metadata_inventory_move(pos, from_list, from_index, to_list, to_index, count, player)
	local meta = minetest.get_meta(pos)
	local inv = meta:get_inventory()
	local stack = inv:get_stack(from_list, from_index)
	return allow_metadata_inventory_put(pos, to_list, to_index, stack, player)
end

local function set_card(itemstack, placer, pointed_thing)
	local meta = itemstack:get_meta()
	if not placer or placer:get_player_name() == "" then return itemstack end
	local player = placer:get_player_name()
	if placer:get_player_control().sneak and pointed_thing.type == "nothing" then
		meta:set_string("node", "")
		meta:set_string("pos", "")
		meta:set_string("description",
			"Wireless Control Station Card\nSneak-Right-Click on a node to bind it")
		minetest.chat_send_player(player, "Cleared card.")
		return itemstack
	end

	if pointed_thing.type == "nothing" then return itemstack end
	if minetest.is_protected(pointed_thing.under, player) then
		minetest.chat_send_player(player, "You do not have permission to remotely control this node!")
		return itemstack
	end

	local node = minetest.get_node_or_nil(pointed_thing.under)
	if not node or elewi.node_handlers[node.name] == nil then return end

	local pstr = minetest.pos_to_string(pointed_thing.under)
	local ndesc = minetest.registered_nodes[node.name]
	local str = ("Bound to %s at %s"):format(ele.helpers.get_first_line(ndesc.description), pstr)

	meta:set_string("node", node.name)
	meta:set_string("pos", pstr)
	meta:set_string("description", "Wireless Control Station Card\n"..str)
	minetest.chat_send_player(player, str)

	return itemstack
end

minetest.register_craftitem("elepower_wireless:card", {
	description = "Wireless Control Station Card\nSneak-Right-Click on a node to bind it",
	inventory_image = "elewireless_station_card.png",
	wield_image = "elewireless_station_card.png",
	on_place = set_card,
	on_secondary_use = set_card,
	stack_max = 1,
})

ele.register_machine("elepower_wireless:station", {
	description = "Wireless Control Station",
	groups = {cracky = 1, ele_user = 1},
	tiles = {
		"elepower_machine_top.png", "elepower_machine_base.png", "elepower_machine_side.png",
		"elepower_machine_side.png", "elepower_machine_side.png", "elepower_machine_side.png^elewireless_station.png",
	},
	ele_capacity = 8000,
	ele_usage    = 8,
	ele_no_automatic_ports = true,
	on_timer = station_timer,
	on_construct = function (pos)
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		inv:set_size("card", 1)
		meta:set_string("formspec", get_formspec())
	end,
	on_receive_fields = function (pos, formname, fields, sender)
		if sender and sender ~= "" and minetest.is_protected(pos, sender:get_player_name()) then
			return
		end

		local meta    = minetest.get_meta(pos)
		local storage = ele.helpers.get_node_property(meta, pos, "storage")
		local usage   = ele.helpers.get_node_property(meta, pos, "usage")
		if storage < usage then return end

		local inv = meta:get_inventory()
		local card = inv:get_stack("card", 1)
		local fns, info = data_from_card(card)

		if not fns then return end

		return fns.on_receive_fields(info.pos, fields, sender, pos, meta)
	end,
	allow_metadata_inventory_put = allow_metadata_inventory_put,
	allow_metadata_inventory_move = allow_metadata_inventory_move,
	ele_upgrades = {
		wireless_chip = {"usage"},
	}
})

-- Include individual node support

local mp = minetest.get_modpath("elepower_wireless") .. "/machines/station/"
if minetest.get_modpath("elepower_nuclear") ~= nil then
	dofile(mp .. "fission_reactor.lua")
end
