local have_ui = minetest.get_modpath("unified_inventory")
local have_cg = minetest.get_modpath("craftguide") and craftguide and craftguide.register_craft

elepm.craft = {}
elepm.craft.types = {}

local function item_string( ... )
	-- body
end

function elepm.register_craft_type(name, def)
	elepm.craft.types[name] = {
		inputs      = def.inputs or 2,
		description = def.description or name,
		overview    = def.overview or name,
		time        = def.time or 0,
		gui_name    = def.gui_name,
	}

	elepm.craft[name] = {}

	
	-- Don't register cooking or fuel types externally.
	if name == "cooking" or name == "fuel" then return end

	if have_ui and unified_inventory.register_craft_type then
		unified_inventory.register_craft_type(name, {
			description = def.description or name,
			icon  = def.icon or "elepower_machine_side.png",
			width = def.inputs or 2,
			height = 1,
		})
	end

	if have_cg then
		craftguide.register_craft_type(name, {
			description = def.description,
			icon  = def.icon or "elepower_machine_side.png",
		})
	end
end

function elepm.register_craft(craftdef)
	if not craftdef.type or not elepm.craft.types[craftdef.type] then
		return nil
	end

	if craftdef.type == "cooking" or craftdef.type == "fuel" then
		minetest.register_craft(craftdef)
		return
	end

	local inputs   = craftdef.recipe
	local outputs  = craftdef.output
	local ctype    = craftdef.type
	local ctypedef = elepm.craft.types[ctype]
	local time     = (craftdef.time or craftdef.cooktime or 5) + (ctypedef.time or 0)
	
	local craftrecipe = {}
	
 -- Recipe inputs are stored as hybridization of standard furnace and regular crafting
 -- Table is structured as example
 -- input{{[default:tin_ingot]=1},{[default:tin_ingot]=1}}
 -- to contrast "cooking" recipes are stored as
 -- input{[default:iron_ore]=1}
 -- to contrast normal craft recipes are stored as and always assume x1:
 -- input:{
 --       {item,item,item},
 --       {item,item,item},
 --       {item,item,item}
 --       }
 
	for _,input in ipairs(inputs) do
		local stack = ItemStack(input)
		if stack and not stack:is_empty() then
			table.insert(craftrecipe,{[stack:get_name()] = stack:get_count()})
		end
	end
	
	local craftresult = {}
	if type(outputs) == "table" then
		for _,output in ipairs(outputs) do
			local stack = ItemStack(output)
			if stack and not stack:is_empty() then
				craftresult[#craftresult + 1] = stack:to_string()
			end
		end
	else
		craftresult = ItemStack(outputs)
	end

	local recipe = {
		recipe = craftrecipe,
		output = craftresult,
		time   = time
	}
	
	table.insert(elepm.craft[ctype], recipe)
	
	if have_ui or have_cg then
		local spec = {}
		local items = {}

		for _, def in pairs(recipe.recipe) do
			for item,count in pairs(def) do
				local stack = ItemStack(item)
				stack:set_count(count)
				spec[#spec+1] = stack
				items[#items+1] = stack:to_string()
			end
		end

		if type(recipe.output) == "table" then
			for _,itm in pairs(recipe.output) do
				local itmst = ItemStack(itm)
				if have_ui then
					unified_inventory.register_craft({
						type = craftdef.type,
						output = itmst,
						items = spec,
						width = ctypedef.inputs,
					})
				end

				if have_cg then					
					craftguide.register_craft({
						type = craftdef.type,
						output = itmst:to_string(),
						items = items,
						width = ctypedef.inputs,
					})
				end
			end
			return
		end

		if have_ui then
			unified_inventory.register_craft({
				type = craftdef.type,
				output = recipe.output,
				items = spec,
				width = ctypedef.inputs,
			})
		end

		if have_cg then
			craftguide.register_craft({
				type   = craftdef.type,
				output = recipe.output:to_string(),
				items  = items,
				width  = ctypedef.inputs,
			})
		end
	end
end

local no_recipe = {
	time = 0,
	new_input = {},
	output = {}
}

function elepm.get_recipe(type, inputs)

	if not elepm.craft[type] or not inputs then
		return no_recipe
	end
	
	-- Minetest's cooking builtin type
	if type == "cooking" then
		local result, new_input = minetest.get_craft_result({
			method = "cooking",
			width = 1,
			items = inputs
		})

		if not result or result.time == 0 then
			return no_recipe
		else
			return {
				time = result.time,
				new_input = new_input.items,
				output = result.item
			}
		end
	end

	-- Custom types
	local result = no_recipe
	local recipe_match = false
	local new_input   = {}
	local sp_recipe
	local count
	
	for rec_num,recipe in pairs(elepm.craft[type]) do
		sp_recipe = 0
		count = 0 

		for item_num, items in pairs(recipe.recipe) do -- items = {value4 = 1}			
			for pos,input in pairs(inputs) do
				local in_name = input:get_name()
				if items[in_name] and                        -- is input_name in recipe
				   items[in_name] <= input:get_count() and   -- do we have enough materials in input
				   pos == item_num then                      -- are we in correct pos/slot
				   
				 sp_recipe = rec_num
				 count = count + 1        
				end
			end
		end

		if count == #inputs then 
			recipe_match = true 
			break 
		end		
	end
	
	if recipe_match == true then

		for item_num,items in pairs(elepm.craft[type][sp_recipe]["recipe"]) do		
			
			for name,num in pairs(items) do           
				
				local istack = ItemStack(name)
				istack:set_count(inputs[item_num]:get_count() - num)
				new_input[#new_input + 1] = istack
				
			end
		end
		
		result = elepm.craft[type][sp_recipe]  -- includes recipe,time,output
		result.new_input = new_input
	else
		 --minetest.debug("no match")          -- useful for debugging
	end

	return result
end

-- Cooking craft type built-in.
elepm.register_craft_type("cooking", {
	description = "Cooking",
	overview    = "Cooking is more than just the prepartion of food "..
               	  "it provides access to the prepartion of ores to metals "..
				  "and the creation of glass and glass objects.",
	inputs      = 1,
})
