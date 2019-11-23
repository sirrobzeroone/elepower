
local structures = {}
local ores = {}
local TIMER = 10

local function determine_structure(controller, player)
	local below1 = vector.add(controller, {x=0,y=-1,z=0})
	local below2 = vector.add(below1, {x=0,y=-1,z=0})

	local miners = 0
	local nodes = {}

	local cpos = minetest.pos_to_string(controller)

	if ele.helpers.node_compare(below1, "elepower_mining:miner_core") and 
			ele.helpers.node_compare(below2, "elepower_mining:miner_drill") then
		table.insert(nodes, below1)
		table.insert(nodes, below2)
		miners = 1
	end

	if miners == 0 then
		if structures[cpos] then
			structures[cpos] = nil
		end
		return false
	end

	for x = -1, 1 do
		for z = -1, 1 do
			if not (x == 0 and z == 0) then
				local duct = vector.add(controller, {x=x,y=-1,z=z})
				local appr = vector.add(duct, {x=0,y=-1,z=0})
				if ele.helpers.node_compare(appr, "elepower_mining:miner_drill") and
					ele.helpers.node_compare(duct, "group:fluid_transport") then
					table.insert(nodes, duct)
					table.insert(nodes, appr)
					miners = miners + 1
				end
			end
		end
	end

	structures[cpos] = {
		miners = miners,
		nodes = nodes
	}

	if player then
		minetest.chat_send_player(player, string.format("Miner structure complete (detected %d drills)!", miners))
	end

	local t = minetest.get_node_timer(controller)
	if not t:is_started() then
		t:start(1.0)
	end

	return true, miners, nodes
end

local function get_mining_results(drills)
	local results = {}
	local amount = math.random(0, 1 * drills)

	for i = 0, amount do
		local picked = math.random(1, #ores)
		local count = math.random(1, 3)
		local drops = minetest.get_node_drops(ores[picked], "elepower_tools:hand_drill")
		for _,stack in pairs(drops) do
			stack = ItemStack(stack)
			stack:set_count(count)
			table.insert(results, stack)
		end		
	end

	return results
end

local function get_formspec(timer, power, buffer, state)
	if not timer then
		timer = 0
	end

	return "size[8,8.5]"..
		default.gui_bg..
		default.gui_bg_img..
		default.gui_slots..
		ele.formspec.power_meter(power)..
		ele.formspec.state_switcher(0, 0, state)..
		ele.formspec.fluid_bar(7, 0, buffer)..
		ele.formspec.create_bar(1, 0, 100 - timer, "#00ff11", true)..
		"list[context;dst;1.5,0;5,3;]"..
		"list[current_player;main;0,4.25;8,1;]"..
		"list[current_player;main;0,5.5;8,3;8]"..
		"listring[current_player;main]"..
		"listring[context;dst]"..
		"listring[current_player;main]"..
		default.get_hotbar_bg(0, 4.25)
end

local function on_timer(pos, elapsed)
	local refresh = false
	local meta    = minetest.get_meta(pos)
	local inv     = meta:get_inventory()

	local buffer = fluid_lib.get_buffer_data(pos, "water")
	local state  = meta:get_int("state")
	local work   = meta:get_int("work")

	local is_enabled = ele.helpers.state_enabled(meta, pos, state)
	local capacity   = ele.helpers.get_node_property(meta, pos, "capacity")
	local usage      = ele.helpers.get_node_property(meta, pos, "usage")
	local storage    = ele.helpers.get_node_property(meta, pos, "storage")

	local pow_buffer = {capacity = capacity, storage = storage, usage = 0}
	local active     = "with Invalid structure - Punch to redetect"
	local miners     = 0

	local pts = minetest.pos_to_string(pos)
	while true do
		if not structures[pts] then break end

		active = "Idle"
		miners = structures[pts].miners

		usage = usage * miners

		if storage < usage then
			active = "Out of Power!"
			break
		end

		active = string.format("Mining with %d miners", miners)
		pow_buffer.usage = usage

		local coolant = 500 * miners
		if buffer.amount < coolant then
			active = "Out of Water!"
			break
		end

		if work < TIMER then
			work = work + 1
			pow_buffer.storage = pow_buffer.storage - usage
			buffer.amount = buffer.amount - coolant
			break
		end

		-- Get some lumps
		local added = 0
		local itms = get_mining_results(miners)
		for _,stack in pairs(itms) do
			if inv:room_for_item("dst", stack) then
				inv:add_item("dst", stack)
				added = added + 1
			end
		end

		if added == 0 then
			active = "Inventory full!"
			refresh = false
			break
		end

		pow_buffer.storage = pow_buffer.storage - usage
		buffer.amount = buffer.amount - coolant
		work = 0
		refresh = true
		break
	end

	local wp = math.floor(work / TIMER * 100)

	meta:set_string("infotext", ("Miner %s\n%s"):format(active,
		ele.capacity_text(capacity, storage)))
	meta:set_string("formspec", get_formspec(wp, pow_buffer, buffer, state))
	meta:set_int("storage", pow_buffer.storage)
	meta:set_int("water_fluid_storage", buffer.amount)
	meta:set_string("water_fluid", "default:water_source")
	meta:set_int("work", work)

	return refresh
end

local function recalc_on_break(pos)
	for core,data in pairs(structures) do
		local cp = minetest.string_to_pos(core)
		local match = false
		for _,ipos in pairs(data.nodes) do
			if vector.equals(pos, ipos) then
				match = true
				determine_structure(cp)
				break
			end
		end
		if match then break end
	end
end

ele.register_machine("elepower_mining:miner_controller", {
	description = "Miner Controller\nMachine Component",
	tiles = {
		"elepower_machine_top.png^elepower_power_port.png", "elepower_machine_base.png^elepower_power_port.png",
		"elepower_machine_side.png^elepower_power_port.png",
		"elepower_machine_side.png^elepower_power_port.png", "elepower_machine_side.png^elepower_power_port.png",
		"elepower_machine_side.png^elenuclear_fusion_controller.png",
	},
	fluid_buffers = {
		water = {
			capacity  = 16000,
			accepts   = {"default:water_source"},
			drainable = false,
		},
	},
	ele_capacity = 320000,
	ele_inrush   = 1200,
	ele_usage    = 128,
	paramtype2 = "facedir",
	groups = {fluid_container = 1, oddly_breakable_by_hand = 1, cracky = 1, tube = 1, ele_user = 1},
	on_construct = function (pos)
		local meta = minetest.get_meta(pos)
		local inv  = meta:get_inventory()

		inv:set_size("dst", 5*3)

		meta:set_string("formspec", get_formspec())
	end,
	on_timer = on_timer,
	on_punch = function (pos, node, puncher, pointed_thing)
		determine_structure(pos, puncher:get_player_name())
		minetest.node_punch(pos, node, puncher, pointed_thing)
	end,
})

minetest.register_node("elepower_mining:miner_core", {
	description = "Miner Core\nMachine Component",
	tiles = {
		"elepower_mining_core.png^elepower_power_port.png", "elepower_mining_core.png^elepower_power_port.png",
		"elepower_mining_core.png^elepower_power_port.png",
		"elepower_mining_core.png^elepower_power_port.png", "elepower_mining_core.png^elepower_power_port.png",
		"elepower_mining_core.png^elepower_power_port.png",
	},
	groups = {fluid_container = 1, oddly_breakable_by_hand = 1, cracky = 1},
	after_dig_node = recalc_on_break,
})

minetest.register_node("elepower_mining:miner_drill", {
	description = "Miner Drill\nMachine Component",
	tiles = {
		"elepower_machine_top.png^elepower_power_port.png", "elepower_mining_apparatus_base.png", "elepower_mining_apparatus_side.png",
		"elepower_mining_apparatus_side.png", "elepower_mining_apparatus_side.png", "elepower_mining_apparatus_side.png",
	},
	groups = {fluid_container = 1, oddly_breakable_by_hand = 1, cracky = 1},
	after_dig_node = recalc_on_break,
})

minetest.register_lbm({
	label = "Enable Miners on load",
	name = "elepower_mining:load_miner_controllers",
	nodenames = {"elepower_mining:miner_controller"},
	run_at_every_load = true,
	action = function (pos)
		determine_structure(pos)
	end,
})

minetest.after(1, function ()
	for _,def in pairs(minetest.registered_ores) do
		table.insert(ores, def.ore)
	end
end)
