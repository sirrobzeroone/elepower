-- Formspec helpers

ele.formspec = {}
ele.formspec.gui_switcher_icons = {
	[0] = "elepower_gui_check.png",
	"elepower_gui_cancel.png",
	"mesecons_wire_on.png^elepower_gui_mese_mask.png^\\[makealpha\\:255,0,0",
	"mesecons_wire_off.png^elepower_gui_mese_mask.png^\\[makealpha\\:255,0,0",
}

function ele.formspec.state_switcher(x, y, state)
	if not state then state = 0 end
	local icon = ele.formspec.gui_switcher_icons[state]
	local statedesc = ele.default.states[state]

	if statedesc then
		statedesc = statedesc.d
	else
		statedesc = ""
	end
	statedesc = statedesc .. "\nPress to toggle"

	return "image_button["..x..","..y..";1,1;"..icon..";cyclestate;]"..
		"tooltip[cyclestate;"..statedesc.."]"
end

function ele.formspec.create_bar(x, y, metric, color, small)
	if not metric or type(metric) ~= "number" or metric < 0 then metric = 0 end

	local width = 1
	local gauge = "image[0,0;1,2.8;elepower_gui_gauge.png]"

	-- Smaller width bar
	if small then
		width = 0.25
		gauge = ""
	end

	return "image["..x..","..y..";"..width..",2.8;elepower_gui_barbg.png"..
		"\\^[lowpart\\:"..metric.."\\:elepower_gui_bar.png\\\\^[multiply\\\\:"..color.."]"..
		gauge
end

function ele.formspec.power_meter(capacitor)
	if not capacitor then
		capacitor = { capacity = 8000, storage = 0, usage = 0 }
	end

	local pw_percent = math.floor(100 * capacitor.storage / capacitor.capacity)
	local usage = capacitor.usage
	if not usage then
		usage = 0
	end

	return ele.formspec.create_bar(0, 0, pw_percent, "#00a1ff") .. 
		"image[0.2,2.45;0.5,0.5;elepower_gui_icon_power_stored.png]"..
		"tooltip[0,0;1,2.9;"..
		minetest.colorize("#c60303", "Energy Storage\n")..
		minetest.colorize("#0399c6", ele.capacity_text(capacitor.capacity, capacitor.storage))..
		minetest.colorize("#565656", "\nPower Used / Generated: " .. usage .. " " .. ele.unit) .. "]"
end

-- Fluid bar for formspec
function ele.formspec.fluid_bar(x, y, fluid_buffer)
	local texture = "default_water.png"
	local metric  = 0
	local tooltip = ("tooltip[%f,%f;1,2.5;%s]"):format(x, y, "Empty Buffer")
	
	if fluid_buffer and fluid_buffer.fluid and fluid_buffer.fluid ~= "" and
		minetest.registered_nodes[fluid_buffer.fluid] ~= nil then
		texture = minetest.registered_nodes[fluid_buffer.fluid].tiles[1]
		if type(texture) == "table" then
			texture = texture.name
		end

		local fdesc = fluid_lib.cleanse_node_description(fluid_buffer.fluid)
		metric  = math.floor(100 * fluid_buffer.amount / fluid_buffer.capacity)
		tooltip = ("tooltip[%f,%f;1,2.5;%s\n%s / %s %s]"):format(x, y, fdesc, 
			ele.helpers.comma_value(fluid_buffer.amount), ele.helpers.comma_value(fluid_buffer.capacity), fluid_lib.unit)
	end

	return "image["..x..","..y..";1,2.8;elepower_gui_barbg.png"..
		   "\\^[lowpart\\:"..metric.."\\:"..texture.."\\\\^[resize\\\\:64x128]"..
		   "image["..x..","..y..";1,2.8;elepower_gui_gauge.png]"..
		   --"image[.."..(x+0.2)..","..(y+2.45)..";0.5,0.5;elepower_gui_icon_fluid_water.png]"..
		   tooltip
end
