
local CAPACITY = 8000

minetest.register_node("elepower_farming:tree_extractor", {
	description = "Tree Sap Extractor",
	groups = {fluid_container = 1, oddly_breakable_by_hand = 1, cracky = 1},
	tiles = {
		"elefarming_machine_base.png", "elefarming_machine_base.png", "elefarming_machine_side.png",
		"elefarming_machine_side.png", "elefarming_machine_side.png^elepower_power_port.png", 
		"elefarming_machine_tree_extractor.png",
	},
	fluid_buffers = {
		tree_sap = {
			capacity = CAPACITY
		}
	},
	on_construct = function ( pos )
		local meta = minetest.get_meta(pos)
		meta:set_string("tree_sap_fluid", "elepower_farming:tree_sap_source")
	end
})

minetest.register_abm({
	nodenames = {"elepower_farming:tree_extractor"},
	label = "elefluidSapAccumulator",
	interval   = 8,
	chance     = 1/6,
	action = function(pos, node, active_object_count, active_object_count_wider)
		local meta    = minetest.get_meta(pos)
		local tree_sap_c = meta:get_int("tree_sap_fluid_storage")
		if tree_sap_c == CAPACITY then return end

		local fpos  = ele.helpers.face_front(pos, node.param2)
		local fluid = 0
		local fnode = minetest.get_node_or_nil(fpos)
		if fnode and ele.helpers.get_item_group(fnode.name, "tree") then
			fluid = fluid + 100
		end

		if fluid == 0 then
			meta:set_string("infotext", "Place me in front of a tree!")
			return
		end

		local give = 0
		if tree_sap_c + fluid > CAPACITY then
			give = CAPACITY - tree_sap_c
		else
			give = fluid
		end

		tree_sap_c = tree_sap_c + give

		meta:set_int("tree_sap_fluid_storage", tree_sap_c)
		meta:set_string("infotext", ("Tree Sap: %d/%d %s"):format(tree_sap_c, CAPACITY, elefluid.unit))
	end
})
