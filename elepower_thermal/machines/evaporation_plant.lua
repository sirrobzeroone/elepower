-- Thermal Evaporation Plant
-- Used to extract salt from water
elethermal.cache = {}
local results = {
	{
		input = "default:water_source 1000",
		output = "elepower_thermal:brine_source 100",
		heat = 400
	},
	{
		input = "elepower_thermal:brine_source 1000",
		output = "elepower_dynamics:lithium_source 100",
		heat = 400
	}
}

-- Validate evaporator structure from controller position
local function validate_structure(pos, player)
	local inputs = {}
	local outputs = {}
	local all = {}
	local thermal = 0
	local height = 0
	local height_cancel = false

	local node = minetest.get_node(pos)
	local dir = minetest.facedir_to_dir(node.param2)

	for y = 0, 18 do
		if height_cancel then break end
		y = y - 4
		local i = 0
		for x = 0, 3 do
			x = x - 3
			for z = 0, 3 do
				z = z - 2
				local rx = x
				local rz = z
				if dir.z ~= 0 then
					rx = z * -dir.z
					rz = x * -dir.z
				else
					rx = rx * -dir.x
					rz = rz * -dir.x
				end

				local p = vector.add(pos, {x = rx, y = y, z = rz})
				local n = minetest.get_node(p)

				if n.name == "elepower_thermal:evaporator_controller" and not vector.equals(pos, p) then
					height = 0
					if player then minetest.chat_send_player(player, "Multiple controllers detected.") end
					break
				end

				if minetest.get_item_group(n.name, "ele_evaporator_node") > 0 then
					i = i + 1
				elseif minetest.get_item_group(n.name, "ele_solar_generator") > 0 then
					i = i + 1
					local m = minetest.get_meta(p)
					local generation = ele.helpers.get_node_property(m, p, "usage")
					thermal = thermal + generation
					height_cancel = true
				end

				if n.name == "elepower_thermal:evaporator_output" then
					table.insert(outputs, p)
				elseif n.name == "elepower_thermal:evaporator_input" then
					table.insert(inputs, p)
				end

				table.insert(all, p)
			end
		end

		if i == 16 or i == 12 then
			height = height + 1
		elseif height == 0 and y < 0 then
			-- Continue..
		else
			break
		end
	end

	if height <= 2 then
		if player then minetest.chat_send_player(player, "Invalid structure surrounding the controller.") end
		return nil
	end

	if player then minetest.chat_send_player(player, "Structure complete.") end
	local meta = minetest.get_meta(pos)
	meta:set_string("Thermal Evaporation Plant")

	elethermal.cache[minetest.pos_to_string(pos)] = {
		height = height,
		inputs = inputs,
		outputs = outputs,
		thermal = thermal,
		all = all
	}

	return height, inputs, outputs, thermal, all
end

local function get_port_controller(pos)
	for ctrl,t in pairs(elethermal.cache) do
		local ctrlpos = minetest.string_to_pos(ctrl)
		local found = false
		for _,p in pairs(t.all) do
			if vector.equals(p, pos) then
				found = true
				break
			end
		end
		if found then
			return ctrlpos, minetest.get_meta(ctrlpos)
		end
	end
	return nil
end

local function get_recipe(i1, heat)
	local result = nil

	for _, d in pairs(results) do
		local i1a = ItemStack(d.input)

		if i1a:get_name() == i1.fluid and heat > d.heat then
			result = d
			result.output = ItemStack(result.output)
			result.input = i1a
			break
		end
	end

	return result
end

local function controller_formspec (input, output, heat)
	local bar = "image[1.5,3.5;6,1;elethermal_gradient_bg.png^[transformR270]"
	if heat then
		bar = "image[1.5,3.5;6,1;elethermal_gradient_bg.png^[lowpart:"..
			  (100 * heat / 1000)..":elethermal_gradient.png^[transformR270]"
	end
	return "size[8,4.5]"..
		default.gui_bg..
		default.gui_bg_img..
		default.gui_slots..
		bar..
		"tooltip[1.5,3.5;6,1;Heat: "..heat.."K]"..
		ele.formspec.fluid_bar(0, 0, input)..
		ele.formspec.fluid_bar(7, 0, output)
end

local function break_structure(pos)
	local ctrl = get_port_controller(pos)
	if not ctrl then return end
	elethermal.cache[minetest.pos_to_string(ctrl)] = nil
	ele.helpers.start_timer(ctrl)
end

local function controller_timer (pos, elapsed)
	local meta = minetest.get_meta(pos)
	local refresh = true

	if not elethermal.cache[minetest.pos_to_string(pos)] and not validate_structure(pos) then
		meta:set_string("infotext", "Thermal Evaporation Plant Incomplete")
		meta:set_string("formspec", "")
		return false
	end

	local contpos = minetest.pos_to_string(pos)
	local th = elethermal.cache[contpos]

	local in_buffer  = fluid_lib.get_buffer_data(pos, "input")
	local out_buffer = fluid_lib.get_buffer_data(pos, "output")

	local heat = meta:get_int("heat")

	while true do
		local baseline = math.floor(minetest.get_heat(pos) + 273.15)
		local reach_heat = math.floor(th.thermal + (th.height * 10)) + baseline

		if heat < reach_heat then
			heat = heat + reach_heat / 10
		end

		if heat > reach_heat then
			heat = reach_heat
		end

		if heat < baseline then
			heat = baseline
		end

		if heat > 1000 then
			heat = 1000
		end

		local recipe = get_recipe(in_buffer, heat)

		if not recipe then
			break
		end

		local heat_perc = heat / (recipe.heat + baseline)
		if recipe.heat + baseline < heat then
			heat_perc = 100
		end

		local take_perc = math.floor(heat_perc * recipe.input:get_count())
		local outp_perc = math.floor(heat_perc * recipe.output:get_count())

		if in_buffer.amount < take_perc then
			refresh = false
			break
		end

		if out_buffer.amount + outp_perc > out_buffer.capacity then
			refresh = false
			break
		end

		if out_buffer.fluid ~= "" and out_buffer.fluid ~= recipe.output:get_name() then
			refresh = false
			break
		end

		out_buffer.fluid = recipe.output:get_name()
		out_buffer.amount = out_buffer.amount + outp_perc
		in_buffer.amount = in_buffer.amount - take_perc
		heat = heat - (recipe.heat - baseline)
		break
	end

	meta:set_int("heat", heat)

	meta:set_string("input_fluid", in_buffer.fluid)
	meta:set_int("input_fluid_storage", in_buffer.amount)

	meta:set_string("output_fluid", out_buffer.fluid)
	meta:set_int("output_fluid_storage", out_buffer.amount)

	meta:set_string("formspec", controller_formspec(in_buffer, out_buffer, heat))
	return refresh
end

minetest.register_node("elepower_thermal:evaporator_controller", {
	description = "Thermal Evaporation Plant Controller",
	tiles = {
		"elepower_heat_casing.png", "elepower_heat_casing.png", "elepower_heat_casing.png",
		"elepower_heat_casing.png", "elepower_heat_casing.png", "elepower_heat_casing.png^elenuclear_fusion_controller.png",
	},
	paramtype2 = "facedir",
	groups = {
		cracky = 3,
		ele_evaporator_node = 1,
	},
	fluid_buffers = {
		input = {
			capacity  = 8000,
			accepts   = {"elepower_thermal:brine_source", "default:water_source"},
			drainable = false,
		},
		output = {
			capacity  = 8000,
			accepts   = false,
			drainable = true,
		},
	},
	on_construct = function (pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("Thermal Evaporation Plant\nPunch to form structure")
	end,
	on_timer = controller_timer,
	on_punch = function (pos, node, puncher, pointed_thing)
		if validate_structure(pos, puncher:get_player_name()) then
			ele.helpers.start_timer(pos)
		end
		minetest.node_punch(pos, node, puncher, pointed_thing)
	end,
	on_destruct = break_structure,
})

minetest.register_node("elepower_thermal:evaporator_output", {
	description = "Thermal Evaporation Plant Output",
	tiles = {
		"elepower_heat_casing.png", "elepower_heat_casing.png", "elepower_heat_casing.png",
		"elepower_heat_casing.png", "elepower_heat_casing.png", "elepower_heat_casing.png^elenuclear_fluid_port_out.png^elepower_power_port.png",
	},
	paramtype2 = "facedir",
	groups = {
		cracky = 3,
		fluid_container = 1,
		ele_evaporator_node = 1,
	},
	fluid_buffers = {},
	node_io_can_put_liquid = function (pos, node, side)
		return false
	end,
	node_io_can_take_liquid = function (pos, node, side)
		local ctrl = get_port_controller(pos)
		if not ctrl then return false end
		return true
	end,
	node_io_accepts_millibuckets = function(pos, node, side) return true end,
	node_io_take_liquid = function(pos, node, side, taker, want_liquid, want_millibuckets)
		local ctrl, ctrl_meta = get_port_controller(pos)
		if not ctrl then return nil end

		local buffers = fluid_lib.get_node_buffers(ctrl)
		local buffer  = "output"
		local took    = 0
		local name    = ""

		local bfdata = fluid_lib.get_buffer_data(ctrl, buffer)
		local storage = bfdata.amount
		local fluid = bfdata.fluid
		if (fluid == want_liquid or want_liquid == "") and storage >= want_millibuckets then
			name, took = fluid_lib.take_from_buffer(ctrl, buffer, want_millibuckets)
		end

		ele.helpers.start_timer(ctrl)

		return {name = name, millibuckets = took}
	end,
	node_io_get_liquid_size = function (pos, node, side)
		return 1
	end,
	node_io_get_liquid_name = function(pos, node, side, index)
		local ctrl, ctrl_meta = get_port_controller(pos)
		if not ctrl then return "" end
		return ctrl_meta:get_string("output_fluid")
	end,
	node_io_get_liquid_stack = function(pos, node, side, index)
		local ctrl, ctrl_meta = get_port_controller(pos)
		if not ctrl then return ItemStack(nil) end

		return ItemStack(ctrl_meta:get_string("output_fluid") .. " " ..
			ctrl_meta:get_int("output_fluid_storage"))
	end,
	on_destruct = break_structure,
})

minetest.register_node("elepower_thermal:evaporator_input", {
	description = "Thermal Evaporation Plant Input",
	tiles = {
		"elepower_heat_casing.png", "elepower_heat_casing.png", "elepower_heat_casing.png",
		"elepower_heat_casing.png", "elepower_heat_casing.png", "elepower_heat_casing.png^elenuclear_fluid_port.png^elepower_power_port.png",
	},
	paramtype2 = "facedir",
	groups = {
		cracky = 3,
		fluid_container = 1,
		ele_evaporator_node = 1,
	},
	fluid_buffers = {},
	node_io_can_put_liquid = function (pos, node, side)
		return true
	end,
	node_io_can_take_liquid = function (pos, node, side)
		return false
	end,
	node_io_get_liquid_size = function (pos, node, side)
		return 1
	end,
	node_io_get_liquid_name = function(pos, node, side, index)
		local ctrl, ctrl_meta = get_port_controller(pos)
		if not ctrl then return "" end

		return ctrl_meta:get_string("input_fluid")
	end,
	node_io_get_liquid_stack = function(pos, node, side, index)
		local ctrl, ctrl_meta = get_port_controller(pos)
		if not ctrl then return ItemStack(nil) end

		return ItemStack(ctrl_meta:get_string("input_fluid") .. " " ..
			ctrl_meta:get_int("input_fluid_storage"))
	end,
	node_io_accepts_millibuckets = function(pos, node, side) return true end,
	node_io_put_liquid = function(pos, node, side, putter, liquid, millibuckets)
		local ctrl, ctrl_meta = get_port_controller(pos)
		if not ctrl then return millibuckets end
		if millibuckets == 0 then return 0 end
		local didnt_fit = fluid_lib.insert_into_buffer(ctrl, "input", liquid, millibuckets)

		ele.helpers.start_timer(ctrl)
		return didnt_fit
	end,
	node_io_room_for_liquid = function(pos, node, side, liquid, millibuckets)
		local ctrl, ctrl_meta = get_port_controller(pos)
		if not ctrl then return 0 end
		return fluid_lib.can_insert_into_buffer(ctrl, "input", liquid, millibuckets)
	end,
	on_destruct = break_structure,
})

minetest.override_item("elepower_machines:heat_casing", {
	on_destruct = break_structure,
})

minetest.register_lbm({
	label = "Enable Thermal Evaporators on load",
	name = "elepower_thermal:evaporator_controllers",
	nodenames = {"elepower_thermal:evaporator_controller"},
	run_at_every_load = true,
	action = ele.helpers.start_timer,
})
