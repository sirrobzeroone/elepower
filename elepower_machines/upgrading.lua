-- Convenience for i18n later on
elepm.upgrading = {
	dict = {
		machine_chip  = "Machine Chip",
		wireless_chip = "Wireless Chip",
		capacitor     = "Capacitor",
		pump_filter   = "Pump Filter",
	}
}

function elepm.handle_machine_upgrades (pos)
	local meta  = minetest.get_meta(pos)
	local comps = meta:get_string("components")

	local node    = minetest.get_node(pos)
	local nodedef = minetest.registered_nodes[node.name]

	-- Deserialize component list
	if comps ~= "" then
		comps = minetest.deserialize(comps)
	else
		comps = {}
	end

	if nodedef.ele_upgrades then
		for comp,vars in pairs(nodedef.ele_upgrades) do
			for _,c in pairs(vars) do
				if not comps[comp] then
					-- If we're resetting capacity, set storage to max initial capacity
					if c == "capacity" then
						local abscap = nodedef.ele_capacity
						local storage = meta:get_int("storage")
						if storage > abscap then
							storage = abscap
							meta:set_int("storage", storage)
						end
					end

					-- Set variable to zero in metadata
					if meta:get_int(c) ~= 0 then
						meta:set_int(c, 0)
					end
				else
					local compdef = minetest.registered_items[comps[comp]]
					local default = nodedef["ele_" .. c] or 1
					local ulevel  = minetest.get_item_group(comps[comp], comp) - 1

					-- Only upgrade if present
					if compdef and compdef.ele_upgrade and compdef.ele_upgrade[c] then
						local task  = compdef.ele_upgrade[c]
						local final = default
						
						if task.multiplier then
							final = final + (default * task.multiplier * ulevel)
						end
						
						if task.add then
							final = final + (task.add * ulevel)
						end

						if task.subtract then
							final = final - (task.subtract * ulevel)
						end

						if task.divider then
							final = final - (default * task.divider * ulevel)
						end

						if final <= 0 then final = 1 end

						meta:set_int(c, math.abs(math.floor(final)))
					end
				end
			end
		end
	end

	local t = minetest.get_node_timer(pos)
	if not t:is_started() then
		t:start(1.0)
	end
end
