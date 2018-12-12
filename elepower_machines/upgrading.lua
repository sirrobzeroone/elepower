
local metasets = {
	"capacity", "usage", "craft_speed", "inrush", "output"
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
		for comp, vars in pairs(nodedef.ele_upgrades) do
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
				elseif nodedef["ele_" .. c] ~= nil then
					-- Set updated value in metadata
					local default    = nodedef["ele_" .. c]
					local ulevel     = minetest.get_item_group(comps[comp], comp) - 1
					local multiplier = 1

					-- Capacitor value is multiplied
					if comp == "capacitor" then
						multiplier = math.pow(10, ulevel)
					end

					meta:set_int(c, math.abs(default + (default * ulevel * multiplier)))
				end
			end
		end
	end

	local t = minetest.get_node_timer(pos)
	if not t:is_started() then
		t:start(1.0)
	end
end
