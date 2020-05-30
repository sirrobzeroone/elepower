
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

local function random_ore()
	for ore, probability in pairs(ores) do
		if math.random(probability) == 1 then
			return ore
		end
	end
end

local function get_mining_results(drills)
	local results = {}
	local amount = math.random(0, drills)

	-- Run mining operations
	for i = 0, amount do
		local picked

		-- Run three tries trying to find a random ore
		for j = 0, 3 do
			picked = random_ore()
			if picked then
				break
			end
		end

		-- If a random ore was found, add it to results
		if picked then
			local count = math.random(1, 3)
			local stack = ItemStack(picked)
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
		ele.formspec.state_switcher(0, 2.5, state)..
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

		-- If the inventory is full and the miner mined something, stop the clock
		if added == 0 and #itms > 0 then
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
	groups = {
		fluid_container = 1,
		oddly_breakable_by_hand = 1,
		cracky = 1,
		tubedevice = 1,
		tubedevice_receiver = 0,
		ele_user = 1
	},
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
		"elepower_machine_top.png^elepower_power_port.png", "elepower_mining_apparatus_base.png",
		"elepower_machine_side.png^elepower_mining_apparatus_side.png",
		"elepower_machine_side.png^elepower_mining_apparatus_side.png",
		"elepower_machine_side.png^elepower_mining_apparatus_side.png", "elepower_machine_side.png^elepower_mining_apparatus_side.png",
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

-- The following code is borrowed from the gravelsieve mod by Joachim Stolberg, licensed under LGPLv2.1+
-- https://github.com/joe7575/techpack/blob/master/gravelsieve/

local PROBABILITY_FACTOR = 3
local ore_rarity = 1.16
local ore_max_elevation = 0
local ore_min_elevation = -30912
local y_spread = math.max(1 + ore_max_elevation - ore_min_elevation, 1)

local function harmonic_sum(a, b)
	return 1 / ((1 / a) + (1 / b))
end

local function calculate_probability(item)
	local ymax = math.min(item.y_max, ore_max_elevation)
	local ymin = math.max(item.y_min, ore_min_elevation)
	return (ore_rarity / PROBABILITY_FACTOR) *
			item.clust_scarcity / (item.clust_num_ores * ((ymax - ymin) / y_spread))
end

local function add_ores()
	for _,item in  pairs(minetest.registered_ores) do
		if minetest.registered_nodes[item.ore] then
			local drop = minetest.registered_nodes[item.ore].drop
			if type(drop) == "string"
			and drop ~= item.ore
			and drop ~= ""
			and item.ore_type == "scatter"
			and item.wherein == "default:stone"
			and item.clust_scarcity ~= nil and item.clust_scarcity > 0
			and item.clust_num_ores ~= nil and item.clust_num_ores > 0
			and item.y_max ~= nil and item.y_min ~= nil then
				local probability = calculate_probability(item)
				if probability > 0 then
					local cur_probability = ores[drop]
					if cur_probability then
						ores[drop] = harmonic_sum(cur_probability, probability)
					else
						ores[drop] = probability
					end
				end
			end
		end
	end
	local overall_probability = 0.0
	for name,probability in pairs(ores) do
		minetest.log("info", ("[elepower_mining] %-32s %.02f"):format(name, probability))
		overall_probability = overall_probability + 1.0/probability
	end
	minetest.log("info", ("[elepower_mining] Overall probability %f"):format(overall_probability))
end

minetest.after(1, add_ores)
