
local function item_in_group(stack, grp)
	return minetest.get_item_group(stack:get_name(), grp) > 0
end

function elepm.register_storage(nodename, nodedef)
	local levels = nodedef.ele_levels or 8
	local level_overlay = nodedef.ele_overlay or "elepower_power_level_"
	if not nodedef.groups then
		nodedef.groups = {}
	end

	nodedef.groups["ele_machine"]  = 1
	nodedef.groups["ele_storage"]  = 1
	nodedef.groups["ele_provider"] = 1

	nodedef.on_timer = function (pos, elapsed)
		local meta    = minetest.get_meta(pos)
		local refresh = false

		local capacity = ele.helpers.get_node_property(meta, pos, "capacity")
		local storage  = ele.helpers.get_node_property(meta, pos, "storage")

		local percent = storage / capacity
		local level   = math.floor(percent * levels)
		local rounded = math.floor(percent * 100)

		ele.helpers.swap_node(pos, nodename .. "_" .. level)
		meta:set_string("formspec", ele.formspec.get_storage_formspec(rounded))
		meta:set_string("infotext", ("%s Active"):format(nodedef.description))

		local inv = meta:get_inventory()

		-- Powercell to item
		local itemcharge = inv:get_stack("out", 1)
		local output     = ele.helpers.get_node_property(meta, pos, "output")
		if itemcharge and not itemcharge:is_empty() and item_in_group(itemcharge, "ele_tool") then
			local crg   = ele.tools.get_tool_property(itemcharge, "storage")
			local cap   = ele.tools.get_tool_property(itemcharge, "capacity")
			local tmeta = itemcharge:get_meta()

			local append = 0

			if crg + output < cap then
				append = output
			else
				if crg <= cap then
					append = cap - crg
				end
			end

			if storage > append and append ~= 0 then
				crg = crg + append
				storage = storage - append
				refresh = true
			end

			tmeta:set_int("storage", crg)
			itemcharge = ele.tools.update_tool_wear(itemcharge)
			inv:set_stack("out", 1, itemcharge)
		end

		-- Item to powercell
		local itemdischarge = inv:get_stack("in", 1)
		local inrush        = ele.helpers.get_node_property(meta, pos, "inrush")
		if itemdischarge and not itemdischarge:is_empty() and 
				(item_in_group(itemdischarge, "ele_tool") or item_in_group(itemdischarge, "ele_machine")) then
			local crg   = ele.tools.get_tool_property(itemdischarge, "storage")
			local tmeta = itemdischarge:get_meta()

			local discharge = 0

			if crg >= inrush then
				discharge = inrush
			else
				discharge = inrush - crg
			end

			if storage + discharge > capacity then
				discharge = capacity - storage
			end

			if discharge <= crg and discharge ~= 0 then
				crg = crg - discharge
				storage = storage + discharge
				refresh = true
			end

			tmeta:set_int("storage", crg)
			itemdischarge = ele.tools.update_tool_wear(itemdischarge)
			inv:set_stack("in", 1, itemdischarge)
		end

		if refresh then
			meta:set_int("storage", storage)
		end

		return refresh
	end

	nodedef.on_construct = function (pos)
		local meta = minetest.get_meta(pos)
		local inv  = meta:get_inventory()
		inv:set_size("out", 1)
		inv:set_size("in", 1)
		meta:set_string("formspec", ele.formspec.get_storage_formspec(0))
	end

	for i = 0, levels do
		local cpdef = ele.helpers.table_copy(nodedef)

		-- Add overlay to the tile texture
		if cpdef.tiles and cpdef.tiles[6] and i > 0 then
			cpdef.tiles[6] = cpdef.tiles[6] .. "^" .. level_overlay .. i ..".png"
		end

		if i > 0 then
			cpdef.groups["not_in_creative_inventory"] = 1
		end

		ele.register_machine(nodename .. "_" .. i, cpdef)
	end
end
