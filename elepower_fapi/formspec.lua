
-- Fluid bar for formspec
function ele.formspec.fluid_bar(x, y, fluid_buffer)
	local texture = "default_water.png"
	local metric  = 0

	if fluid_buffer and fluid_buffer.fluid and fluid_buffer.fluid ~= "" and
		minetest.registered_nodes[fluid_buffer.fluid] ~= nil then
		texture = minetest.registered_nodes[fluid_buffer.fluid].tiles[1]
		if type(texture) == "table" then
			texture = texture.name
		end
		metric  = math.floor(100 * fluid_buffer.amount / fluid_buffer.capacity)
	end

	return "image["..x..","..y..";1,2.8;elepower_gui_barbg.png"..
		   "\\^[lowpart\\:"..metric.."\\:"..texture.."\\\\^[resize\\\\:64x128]"..
		   "image["..x..","..y..";1,2.8;elepower_gui_gauge.png]"
end
