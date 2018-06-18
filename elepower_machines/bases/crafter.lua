-- This is a crafter type machine base.
-- It accepts a recipe type registered beforehand.

function elepm.register_crafter(nodename, nodedef)
	local craft_type = nodedef.craft_type
	if not craft_type or not elepm.craft.types[craft_type] then
		return nil
	end

	if not nodedef.groups then
		nodedef.groups = {}
	end

	nodedef.groups["ele_machine"] = 1
	nodedef.groups["ele_user"]    = 1

	nodedef.on_timer = function (pos, elapsed)
		local refresh = false
		local meta    = minetest.get_meta(pos)
		local inv     = meta:get_inventory()

		local machine_node  = nodename
		local machine_speed = nodedef.craft_speed or 1

		local capacity = ele.helpers.get_node_property(meta, pos, "capacity")

		while true do
			local result  = elepm.get_recipe(craft_type, inv:get_list("src"))
			local usage   = ele.helpers.get_node_property(meta, pos, "usage")
			local storage = ele.helpers.get_node_property(meta, pos, "storage")

			local pow_percent = math.floor((storage / capacity) * 100)

			local power_operation = false

			-- Determine if there is enough power for this action
			if result and storage >= usage then
				power_operation = true
			end

			if not result or not power_operation then
				ele.helpers.swap_node(pos, machine_node)
				
				if not result then
					meta:set_string("formspec", ele.formspec.get_crafter_formspec(craft_type, pow_percent))
					meta:set_int("src_time", 0)
					meta:set_string("infotext", ("%s Idle"):format(nodedef.description) ..
						"\n" .. ele.capacity_text(capacity, storage))
				else
					local pct = math.floor((ele.helpers.round(result.time * 10) / meta:get_int("src_time")) * 100)
					meta:set_string("formspec", ele.formspec.get_crafter_formspec(craft_type, pow_percent, pct))
					meta:set_string("infotext", ("%s Out of Power!"):format(nodedef.description) ..
						"\n" .. ele.capacity_text(capacity, storage))
				end

				break
			end

			refresh = true

			-- One step
			meta:set_int("storage", storage - usage)
			pow_percent = math.floor((storage / capacity) * 100)
			meta:set_int("src_time", meta:get_int("src_time") + ele.helpers.round(machine_speed * 10))
			meta:set_string("infotext", ("%s Active"):format(nodedef.description) ..
				"\n" .. ele.capacity_text(capacity, storage))

			if nodedef.ele_active_node then
				local active_node = nodename.."_active"
				if nodedef.ele_active_node ~= true then
					active_node = nodedef.ele_active_node
				end

				ele.helpers.swap_node(pos, active_node)
			end

			if meta:get_int("src_time") <= ele.helpers.round(result.time * 10) then
				local pct = math.floor((meta:get_int("src_time") / ele.helpers.round(result.time * 10)) * 100)
				meta:set_string("formspec", ele.formspec.get_crafter_formspec(craft_type, pow_percent, pct))
				break
			end

			local output = result.output
			if type(output) ~= "table" then output = { output } end
			local output_stacks = {}
			for _, o in ipairs(output) do
				table.insert(output_stacks, ItemStack(o))
			end

			local room_for_output = true
			inv:set_size("dst_tmp", inv:get_size("dst"))
			inv:set_list("dst_tmp", inv:get_list("dst"))

			for _, o in ipairs(output_stacks) do
				if not inv:room_for_item("dst_tmp", o) then
					room_for_output = false
					break
				end
				inv:add_item("dst_tmp", o)
			end

			if not room_for_output then
				ele.helpers.swap_node(pos, machine_node)
				meta:set_string("formspec", ele.formspec.get_crafter_formspec(craft_type, pow_percent))
				meta:set_int("src_time", ele.helpers.round(result.time*10))
				meta:set_string("infotext", ("%s Output Full!"):format(nodedef.description) ..
					"\n" .. ele.capacity_text(capacity, storage))
				break
			end

			meta:set_int("src_time", meta:get_int("src_time") - ele.helpers.round(result.time*10))
			inv:set_list("src", result.new_input)
			inv:set_list("dst", inv:get_list("dst_tmp"))
		end

		return refresh
	end

	local sizes = elepm.craft.types[craft_type]
	nodedef.on_construct = function (pos)
		local meta = minetest.get_meta(pos)
		local inv  = meta:get_inventory()
		inv:set_size("src", sizes.inputs)
		inv:set_size("dst", 4)

		local storage  = ele.helpers.get_node_property(meta, pos, "storage")
		local capacity = ele.helpers.get_node_property(meta, pos, "capacity")
		meta:set_string("formspec", ele.formspec.get_crafter_formspec(craft_type, capacity, storage))
	end

	ele.register_machine(nodename, nodedef)
end
