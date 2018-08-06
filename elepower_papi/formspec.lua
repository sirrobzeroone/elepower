-- Formspec helpers

ele.formspec = {}

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
		capacitor = { capacity = 8000, storage = 0 }
	end

	local pw_percent = math.floor(100 * capacitor.storage / capacitor.capacity)

	return ele.formspec.create_bar(0, 0, pw_percent, "#00a1ff") ..
		"tooltip[0,0;1,2.5;Power Buffer\n" .. ele.capacity_text(capacitor.capacity, capacitor.storage) .. "]"
end
