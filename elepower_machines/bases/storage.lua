
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
		local meta = minetest.get_meta(pos)

		local capacity = ele.helpers.get_node_property(meta, pos, "capacity")
		local storage  = ele.helpers.get_node_property(meta, pos, "storage")

		local percent = storage / capacity
		local level   = math.floor(percent * levels)
		local rounded = math.floor(percent * 100)

		ele.helpers.swap_node(pos, nodename .. "_" .. level)
		meta:set_string("formspec", ele.formspec.get_storage_formspec(rounded))
		meta:set_string("infotext", ("%s Active"):format(nodedef.description))

		return false
	end

	nodedef.on_construct = function (pos)
		local meta = minetest.get_meta(pos)
		local inv  = meta:get_inventory()
		inv:set_size("src", 1)
		inv:set_size("dst", 1)
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
