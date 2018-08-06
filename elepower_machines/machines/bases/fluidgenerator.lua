
local function get_formspec_default(power, percent, buffer)
	return "size[8,8.5]"..
		default.gui_bg..
		default.gui_bg_img..
		default.gui_slots..
		ele.formspec.power_meter(power)..
		ele.formspec.fluid_bar(7, 0, buffer)..
		"image[3.5,1.5;1,1;default_furnace_fire_bg.png^[lowpart:"..
		(percent)..":default_furnace_fire_fg.png]"..
		"list[current_player;main;0,4.25;8,1;]"..
		"list[current_player;main;0,5.5;8,3;8]"..
		default.get_hotbar_bg(0, 4.25)
end

-- A generator that creates power using a fuel
function ele.register_fluid_generator(nodename, nodedef)
	local fuel  = nodedef.fuel
	local btime = nodedef.fuel_burn_time or 60

	local buffer_name = nil

	-- Autodetect fluid buffer and the fuel if necessary
	if not nodedef.fluid_buffers then return nil end
	for buf,data in pairs(nodedef.fluid_buffers) do
		buffer_name = buf

		if not fuel and data.accepts and type(data.accepts) == "table" then
			fuel = data.accepts[1]
		end

		break
	end

	-- Allow for custom formspec
	local get_formspec = get_formspec_default
	if nodedef.get_formspec then
		get_formspec = nodedef.get_formspec
		nodedef.get_formspec = nil
	end

	local defaults = {
		groups = {
			fluid_container = 1,
			ele_provider = 1,
			oddly_breakable_by_hand = 1,
		},
		tube = false,
		on_timer = function (pos, elapsed)
			local refresh  = false
			local meta     = minetest.get_meta(pos)
			local nodename = nodename

			local burn_time      = meta:get_int("burn_time")
			local burn_totaltime = meta:get_int("burn_totaltime")
			
			local capacity   = ele.helpers.get_node_property(meta, pos, "capacity")
			local generation = ele.helpers.get_node_property(meta, pos, "usage")
			local storage    = ele.helpers.get_node_property(meta, pos, "storage")

			-- Fluid buffer
			local flbuffer = fluid_lib.get_buffer_data(pos, buffer_name)
			local pow_buffer
			if not flbuffer or flbuffer.fluid == "" then return false end

			while true do
				-- If more to burn and the energy produced was used: produce some more
				if burn_time > 0 then
					if storage + generation > capacity then
						break
					end

					storage = storage + generation
					meta:set_int("storage", storage)

					burn_time = burn_time - 1
					meta:set_int("burn_time", burn_time)
				end

				pow_buffer = {capacity = capacity, storage = storage}

				-- Burn another bucket of lava
				if burn_time == 0 then
					local inv = meta:get_inventory()
					if flbuffer.amount >= 1000 then
						meta:set_int("burn_time", btime)
						meta:set_int("burn_totaltime", btime)

						-- Take lava
						flbuffer.amount = flbuffer.amount - 1000

						local active_node = nodename.."_active"
						ele.helpers.swap_node(pos, active_node)

						refresh = true
					else
						meta:set_string("formspec", get_formspec(pow_buffer, 0, flbuffer))
						meta:set_string("infotext", ("%s Idle\n%s\n%s"):format(nodedef.description,
							ele.capacity_text(capacity, storage), fluid_lib.buffer_to_string(flbuffer)))

						ele.helpers.swap_node(pos, nodename)
					end
				end
				if burn_totaltime == 0 then burn_totaltime = 1 end
				break
			end

			local percent = math.floor((burn_time / burn_totaltime) * 100)
			meta:set_string("formspec", get_formspec(pow_buffer, percent, flbuffer))
			meta:set_string("infotext", ("%s Active\n%s\n%s"):format(nodedef.description,
				ele.capacity_text(capacity, storage), fluid_lib.buffer_to_string(flbuffer)))

			meta:set_int(buffer_name .. "_fluid_storage", flbuffer.amount)

			return refresh
		end,
		on_construct = function (pos)
			local meta = minetest.get_meta(pos)

			local capacity = ele.helpers.get_node_property(meta, pos, "capacity")
			local storage  = ele.helpers.get_node_property(meta, pos, "storage")

			meta:set_string("formspec", get_formspec({capacity = capacity, storage = storage}, 0))
		end
	}

	nodedef.fuel = nil

	for key,val in pairs(defaults) do
		if not nodedef[key] then
			nodedef[key] = val
		end
	end
	
	ele.register_machine(nodename, nodedef)
end
