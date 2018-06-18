-- Formspec helper: Add power bar

ele.formspec = {}

function ele.formspec.power_meter(pw_percent)
	return "image[0,0;1,2.8;elepower_gui_barbg.png"..
		"^[lowpart:"..pw_percent..":elepower_gui_bar.png]"..
	   "image[0,0;1,2.8;elepower_gui_gauge.png]"
end
