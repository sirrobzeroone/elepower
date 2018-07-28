
local function get_formspec_default(power, percent)
	return "size[8,8.5]"..
		default.gui_bg..
		default.gui_bg_img..
		default.gui_slots..
		ele.formspec.power_meter(power)..
		"list[context;src;3,1.5;1,1;]"..
		"image[4,1.5;1,1;default_furnace_fire_bg.png^[lowpart:"..
		percent..":default_furnace_fire_fg.png]"..
		"list[current_player;main;0,4.25;8,1;]"..
		"list[current_player;main;0,5.5;8,3;8]"..
		"listring[current_player;main]"..
		"listring[context;src]"..
		"listring[current_player;main]"..
		default.get_hotbar_bg(0, 4.25)
end

function elepm.register_fuel_generator(nodename, nodedef)
	if not nodedef.groups then
		nodedef.groups = {}
	end

	nodedef.groups["ele_machine"]  = 1
	nodedef.groups["ele_provider"] = 1
	nodedef.groups["tubedevice"]   = 1
	nodedef.groups["tubedevice_receiver"] = 1

	-- Allow for custom formspec
	local get_formspec = get_formspec_default
	if nodedef.get_formspec then
		get_formspec = nodedef.get_formspec
		nodedef.get_formspec = nil
	end

	nodedef.on_timer = function (pos, elapsed)
		local meta = minetest.get_meta(pos)

		local burn_time      = meta:get_int("burn_time")
		local burn_totaltime = meta:get_int("burn_totaltime")
		
		local capacity   = ele.helpers.get_node_property(meta, pos, "capacity")
		local generation = ele.helpers.get_node_property(meta, pos, "usage")
		local storage    = ele.helpers.get_node_property(meta, pos, "storage")

		-- If more to burn and the energy produced was used: produce some more
		if burn_time > 0 then
			if storage + generation > capacity then
				return false
			end

			meta:set_int("storage", storage + generation)

			burn_time = burn_time - 1
			meta:set_int("burn_time", burn_time)
		end

		local pow_percent = math.floor((storage / capacity) * 100)

		-- Burn another piece of fuel
		if burn_time == 0 then
			local inv = meta:get_inventory()
			if not inv:is_empty("src") then 
				local fuellist        = inv:get_list("src")
				local fuel, afterfuel = minetest.get_craft_result({method = "fuel", width = 1, items = fuellist})

				if not fuel or fuel.time == 0 then
					ele.helpers.swap_node(pos, nodename)
					return false
				end

				meta:set_int("burn_time", fuel.time)
				meta:set_int("burn_totaltime", fuel.time)
				inv:set_stack("src", 1, afterfuel.items[1])

				if nodedef.ele_active_node then
					local active_node = nodename.."_active"
					if nodedef.ele_active_node ~= true then
						active_node = nodedef.ele_active_node
					end

					ele.helpers.swap_node(pos, active_node)
				end
			else
				meta:set_string("formspec", get_formspec(pow_percent, 0))
				meta:set_string("infotext", ("%s Idle"):format(nodedef.description) ..
					"\n" .. ele.capacity_text(capacity, storage))
				ele.helpers.swap_node(pos, nodename)
				return false
			end
		end
		if burn_totaltime == 0 then burn_totaltime = 1 end

		local percent = math.floor((burn_time / burn_totaltime) * 100)
		meta:set_string("formspec", get_formspec(pow_percent, percent))
		meta:set_string("infotext", ("%s Active"):format(nodedef.description) ..
			"\n" .. ele.capacity_text(capacity, storage))

		return true
	end

	nodedef.on_construct = function (pos)
		local meta = minetest.get_meta(pos)
		local inv  = meta:get_inventory()
		inv:set_size("src", 1)

		local capacity = ele.helpers.get_node_property(meta, pos, "capacity")
		local storage  = ele.helpers.get_node_property(meta, pos, "storage")

		meta:set_string("formspec", get_formspec(math.floor((storage / capacity) * 100), 0))
	end

	ele.register_machine(nodename, nodedef)
end
