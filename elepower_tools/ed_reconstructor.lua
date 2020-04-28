
local function get_formspec(power, state)
	return "size[8,8.5]"..
		default.gui_bg..
		default.gui_bg_img..
		default.gui_slots..
		ele.formspec.power_meter(power)..
		"list[context;tool;3.5,1.5;1,1;]"..
		ele.formspec.state_switcher(7, 0, state)..
		"list[current_player;main;0,4.25;8,1;]"..
		"list[current_player;main;0,5.5;8,3;8]"..
		"listring[current_player;main]"..
		"listring[context;tool]"..
		"listring[current_player;main]"..
		default.get_hotbar_bg(0, 4.25)
end

local function is_tool (istack)
	if not minetest.registered_tools[istack:get_name()] then
		return false
	end

	-- Do not accept (ele)power tools and unrepairable tools
	if minetest.get_item_group(istack:get_name(), "ele_tool") > 0 or
		minetest.get_item_group(istack:get_name(), "unrepairable") > 0 then
		return false
	end

	return true
end

local function ed_timer(pos)
	local refresh = false

	local meta = minetest.get_meta(pos)
	local inv  = meta:get_inventory()

	local capacity   = ele.helpers.get_node_property(meta, pos, "capacity")
	local usage      = ele.helpers.get_node_property(meta, pos, "usage")
	local storage    = ele.helpers.get_node_property(meta, pos, "storage")
	local pow_buffer = {capacity = capacity, storage = storage, usage = 0}

	local state  = meta:get_int("state")
	local status = "Idle"

	local speed = 1

	local is_enabled = ele.helpers.state_enabled(meta, pos, state)
	local tool = inv:get_stack("tool", 1)

	while true do
		if not is_enabled then
			status = "Off"
			break
		end

		if not tool or tool:is_empty() or not is_tool(tool) then
			status = "Invalid Input"
			break
		end

		if pow_buffer.storage < usage then
			status = "Out of Power!"
			break
		end

		local t_wear = tool:get_wear()
		if t_wear == 0 then
			break
		end

		status = "Active"
		pow_buffer.usage = usage
		pow_buffer.storage = pow_buffer.storage - usage
		t_wear = t_wear - 64 * speed
		refresh = true

		if t_wear < 0 then t_wear = 0 end
		tool:set_wear(t_wear)

		break
	end

	if refresh then
		inv:set_stack("tool", 1, tool)
	end

	meta:set_int("storage", pow_buffer.storage)

	meta:set_string("infotext", ("Energy Density Reconstructor %s\n%s"):format(status, ele.capacity_text(pow_buffer.capacity, pow_buffer.storage)))
	meta:set_string("formspec", get_formspec(pow_buffer, state))

	return refresh
end

local function allow_metadata_inventory_put(pos, listname, index, stack, player)
	if minetest.is_protected(pos, player:get_player_name()) then
		return 0
	end

	if not is_tool(stack) and listname == "tool" then
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

ele.register_machine("elepower_tools:ed_reconstructor", {
	description = "Energy Density Reconstructor\nRepairs tools using energy",
	tiles = {
		"elepower_machine_top.png", "elepower_machine_base.png", "elepower_machine_side.png",
		"elepower_machine_side.png", "elepower_machine_side.png", "elepower_machine_side.png^elepower_machine_ed_reconstructor.png",
	},
	groups = {cracky = 1, ele_user = 1},
	on_timer = ed_timer,
	ele_usage = 128,
	ele_inrush = 128,
	on_construct = function (pos)
		local meta = minetest.get_meta(pos)
		local inv  = meta:get_inventory()
		inv:set_size("tool", 1)
		meta:set_string("formspec", get_formspec())
	end,
	allow_metadata_inventory_put = allow_metadata_inventory_put,
	allow_metadata_inventory_move = allow_metadata_inventory_move,
	ele_upgrades = {
		capacitor = {"capacity"},
	},
})
