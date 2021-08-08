------------------------------------------------------
--        ___ _                                     --
--       | __| |___ _ __  _____ __ _____ _ _        --
--       | _|| / -_) '_ \/ _ \ V  V / -_) '_|       --
--       |___|_\___| .__/\___/\_/\_/\___|_|         --
--         _    _  |_| _   _   _                    --
--        | |  (_)__ _| |_| |_(_)_ _  __ _          --
--        | |__| / _` | ' \  _| | ' \/ _` |         --
--        |____|_\__, |_||_\__|_|_||_\__, |         --
--               |___/               |___/          --
------------------------------------------------------
--                   Functions                      --
------------------------------------------------------
-------------------------------------------
--          Floodlight Formspec          --
-------------------------------------------
local function get_formspec_flood(power,tilt,rotate)
	local rotate  = rotate or 0
	local tilt    = tilt or 0
	local per_rot = (math.abs(rotate)/45)*100
	local percent = (math.abs(tilt)/20)*100

	local final ="size[8,3]"..
	             ele.formspec.power_meter(power)..
				 -- rotate

				 "image[3.5,0.25;2.8,1;elepower_gui_barbg.png^[transformR90]"..
				 "image[4.43,2.4;0.5,0.5;elepower_lighting_flood_arrow_icon.png^[transformR90]"..
				 "tooltip[3.5,1.45;2.25,0.4;"..rotate.." Degrees;#30434c;#f9f9f9]"..
				 --"button[5.15,1.45;0.75,0.75;rot;+]"..
				 --"tooltip[5.15,1.45;0.75,0.75;+1 Degrees;#30434c;#f9f9f9]"..				 
				 --"button[4.35,1.45;0.75,0.75;rot;0]"..
				 --"tooltip[4.35,1.45;0.75,0.75;Reset;#30434c;#f9f9f9]"..
				 --"button[3.5,1.45;0.75,0.75;rot;-]"..
				 --"tooltip[3.5,1.45;0.75,0.75;-1 Degrees;#30434c;#f9f9f9]"..
				 --"image[3.5,0.25;2.8,1;elepower_lighting_flood_tilt_gauge.png^[transformR90]"..

				 "scrollbaroptions[min=-45;max=45;smallstep=1;largestep=5;arrows=show]"..
				 "scrollbar[3.5,1.45;2.25,0.45;horizontal;rot;"..rotate.."]"..

				 "scrollbaroptions[min=-20;max=20;smallstep=1;largestep=5;arrows=show]"..
				 "scrollbar[7.25,0;0.4,2.4;vertical;tilt;"..(tilt).."]"..
				 -- tilt
				 "image[6.25,0;1,2.8;elepower_gui_barbg.png]"..
				 "image[6.5,2.45;0.5,0.5;elepower_lighting_flood_arrow_icon.png]"..
				 "tooltip[7.25,0;1,2.6;"..(tilt).." Degrees;#30434c;#f9f9f9]"
				 --"button[7.25,0.05;0.75,0.75;tilt;+]"..
				 --"tooltip[7.25,0.05;0.75,0.75;+1 Degrees;#30434c;#f9f9f9]"..
				 --"button[7.25,.9;0.75,0.75;tilt;0]"..
				 --"tooltip[7.25,.9;0.75,0.75;Reset;#30434c;#f9f9f9]"..
				 --"button[7.25,1.75;0.75,0.75;tilt;-]"..
				 --"tooltip[7.25,1.75;0.75,0.75;-1 Degrees;#30434c;#f9f9f9]"
	
	if rotate > 0 then
		final = final.."image[4.62,0.25;1.4,1;elepower_gui_barbg.png^[lowpart:"..per_rot..":elepower_gui_bar.png^[transformR270]"
		
	elseif rotate < 0 then
		final = final.."image[3.5,0.25;1.4,1;elepower_gui_barbg.png^[lowpart:"..per_rot..":elepower_gui_bar.png^[transformR90]"
	end
	
	if tilt < 0 then
		final = final.."image[6.25,0;1,1.4;elepower_gui_barbg.png^[lowpart:"..percent..":elepower_gui_bar.png]"
		
	elseif tilt > 0 then
		final = final.."image[6.25,1.22;1,1.4;elepower_gui_barbg.png^[lowpart:"..percent..":elepower_gui_bar.png^[transformR180]"
		
	end
	
	final = final.."image[3.5,0.25;2.8,1;elepower_lighting_flood_rotate_gauge.png^[transformR90]"
	final = final.."image[6.25,0;1,2.8;elepower_lighting_flood_tilt_gauge.png]"
	
	return final
end

-- register flood on_recieve fields
function elepower_lighting.flood_on_recieve_fields(pos, formname, fields, player)
	
	local meta = minetest.get_meta(pos)
	
	if fields.quit then
		return
	end
	
	if fields.rot then
		local split = string.split(fields.rot, ":")
		local new_rot = tonumber(split[2])		
		meta:set_int("rotate",new_rot)
		
		if meta:get_int("on_off") == 1 then
			elepower_lighting.remove_flood_light_fill(pos)
			elepower_lighting.add_flood_light_fill(pos)
		end		
		
	end
	
	if fields.tilt then
		local split = string.split(fields.tilt, ":")
		local new_tilt = tonumber(split[2])
		meta:set_int("tilt", new_tilt)
		
		if meta:get_int("on_off") == 1 then
			elepower_lighting.remove_flood_light_fill(pos)
			elepower_lighting.add_flood_light_fill(pos)
		end		
	end
	--minetest.debug(dump(fields))	
end

-------------------------------------------
-- Converts node param2 into a primary   --
-- axis and the secondary axis, needed   --
-- to workout and place light_fill --
-------------------------------------------
function elepower_lighting.p2_to_axis(node_param2)	
	-- first_key = primary axis, num_key = param2, value = secondary axis/+-
	local p2_conv_table = {x = {[0]="z:+1",[2]="z:-1", [4]="y:-1", [6]="y:+1", [8]="y:+1",[10]="y:-1",[20]="z:+1",[22]="z:-1"}, 
						   y = {[5]="x:+1",[7]="x:-1", [9]="x:+1",[11]="x:-1",[12]="z:+1",[14]="z:-1",[16]="z:+1",[18]="z:-1"}, 
						   z = {[1]="x:+1",[3]="x:-1",[13]="y:-1",[15]="y:+1",[17]="y:+1",[19]="y:-1",[21]="x:-1",[23]="x:+1"}}	
	local light_strip_axis
	
		for xyz,all_p2 in pairs(p2_conv_table) do
			for p2,sec_axis in pairs(all_p2) do
				if node_param2 == p2 then
					local second_axis_v = string.split(sec_axis, ":")
					light_strip_axis = {[xyz] = 1,[second_axis_v[1].."s"] = tonumber(second_axis_v[2])}
					break
				end				
			end			
		end
	return light_strip_axis
end

---------------------------------------------
-- Simply adds or removes light_fill --
---------------------------------------------
function elepower_lighting.add_remove_light_fill(pos,light_strip_axis,light_shape,add_remove)
	local x = light_strip_axis.x or 0
	local y = light_strip_axis.y or 0
	local z = light_strip_axis.z or 0
	
	local xs = light_strip_axis.xs or 0
	local ys = light_strip_axis.ys or 0
	local zs = light_strip_axis.zs or 0
	local mt_add_remove = minetest.remove_node
	local node_name = "elepower_lighting:light_fill"
	local add_node
	
	-- used for adding/setting nodes
	if add_remove == 1 then
		mt_add_remove = minetest.set_node
		node_name = "air"
		add_node = {name = "elepower_lighting:light_fill"}
	end
	
	if light_shape == "3x1" then
		local pos_p = {x=pos.x+x, y=pos.y+y, z=pos.z+z}
		local pos_n = {x=pos.x-x, y=pos.y-y, z=pos.z-z}					
		
		local poses = {pos_p,pos_n}
		
		for k,p in pairs(poses) do
			if minetest.get_node(p).name == node_name then
				mt_add_remove(p,add_node)
			end	
		end
		
	elseif light_shape == "3x2" then
		local pos_p = {x=pos.x+x, y=pos.y+y, z=pos.z+z}
		local pos_n = {x=pos.x-x, y=pos.y-y, z=pos.z-z}					
		local pos_ps = {x=pos.x+x+xs, y=pos.y+y+ys, z=pos.z+z+zs}
		local pos_cs = {x=pos.x+xs, y=pos.y+ys, z=pos.z+zs}
		local pos_ns = {x=pos.x-x+xs, y=pos.y-y+ys, z=pos.z-z+zs}

		local poses = {pos_p,pos_n,pos_ps,pos_cs,pos_ns}

		for k,p in pairs(poses) do
			if minetest.get_node(p).name == node_name then
				mt_add_remove(p,add_node)
			end	
		end					
	end
end
---------------------------------------------
--      Add Flood Light Light nodes        --
---------------------------------------------
function elepower_lighting.add_flood_light_fill(pos)
	local meta   = minetest.get_meta(pos)
	local node_p2  = minetest.get_node(pos).param2
	local rel_x_y
	
	--1st axis = face dir, 2nd axis = relative vertical(tilt)
	local face_dir = {["z:+1"] = {[0]="y:+1",[12]="x:+1",[16]="x:-1",[20]="y:-1"},   -- North
			    	  ["x:+1"] = {[1]="y:+1", [5]="z:+1", [9]="z:-1",[23]="y:-1"},   -- East
					  ["z:-1"] = {[2]="y:+1",[14]="x:+1",[18]="x:-1",[22]="y:-1"},   -- South
					  ["x:-1"] = {[3]="y:+1", [7]="z:-1",[11]="z:-1",[21]="y:-1"},   -- West
					  ["y:+1"] = {[6]="z:+1", [8]="z:-1",[15]="x:+1",[17]="x:-1"},   -- Up
					  ["y:-1"] = {[4]="z:+1",[10]="z:-1",[13]="x:+1",[19]="x:-1"}}   -- Down 
	
	-- Rotation reference table
	local rot_dir = {[0] = {x = "x",x_v = "+1",y = "z",y_v = "+1", z="y"},
					 [1] = {x = "z",x_v = "-1",y = "x",y_v = "+1", z="y"},
					 [2] = {x = "x",x_v = "-1",y = "z",y_v = "-1", z="y"},
					 [3] = {x = "z",x_v = "+1",y = "x",y_v = "-1", z="y"},
					 
					 [4] = {x = "x",x_v = "+1",y = "y",y_v = "-1",z="z"},
					 [5] = {x = "y",x_v = "+1",y = "x",y_v = "+1",z="z"},
					 [6] = {x = "x",x_v = "-1",y = "y",y_v = "+1",z="z"},
					 [7] = {x = "y",x_v = "-1",y = "x",y_v = "-1",z="z"},
					 
					 [8] = {x = "x",x_v = "+1",y = "y",y_v = "+1",z="z"},
					 [9] = {x = "y",x_v = "-1",y = "x",y_v = "+1",z="z"},
					 [10] = {x = "x",x_v = "-1",y = "y",y_v = "-1",z="z"},
					 [11] = {x = "y",x_v = "+1",y = "x",y_v = "-1",z="z"},
					 
					 [12] = {x = "y",x_v = "-1",y = "z",y_v = "+1",z="x"},					 
					 [13] = {x = "z",x_v = "-1",y = "y",y_v = "-1",z="x"},
					 [14] = {x = "y",x_v = "+1",y = "z",y_v = "-1",z="x"},
					 [15] = {x = "z",x_v = "+1",y = "y",y_v = "+1",z="x"},
					 
					 [16] = {x = "y",x_v = "+1",y = "z",y_v = "+1",z="x"},
					 [17] = {x = "z",x_v = "-1",y = "y",y_v = "+1",z="x"},
					 [18] = {x = "y",x_v = "-1",y = "z",y_v = "-1",z="x"},
					 [19] = {x = "z",x_v = "+1",y = "y",y_v = "-1",z="x"},
					 
					 [20] = {x = "x",x_v = "+1",y = "z",y_v = "+1", z="y"},
					 [21] = {x = "z",x_v = "+1",y = "x",y_v = "-1", z="y"},
					 [22] = {x = "x",x_v = "-1",y = "z",y_v = "-1", z="y"},
					 [23] = {x = "z",x_v = "-1",y = "x",y_v = "+1", z="y"},
					}
	
	for axis,p2s in pairs(face_dir) do
		for p2,rel_vert in pairs(p2s) do
			if node_p2 == p2 then
				local sep_rel_x_axis = string.split(axis,":")
				local sep_rel_y_axis = string.split(rel_vert,":")
					  rel_x_y = {[sep_rel_x_axis[1].."x"] = sep_rel_x_axis[2], 
								   [sep_rel_y_axis[1].."y"] = sep_rel_y_axis[2],
								   [sep_rel_y_axis[1].."z"] = sep_rel_y_axis[4],
								    x =     sep_rel_x_axis[1],
								    x_val = sep_rel_x_axis[2],
								    y =     sep_rel_y_axis[1],
								    y_val = sep_rel_y_axis[2]
								}
					   rot_x_y = rot_dir[node_p2]
			end
		end
	end        

	local light_range = 30
	local tilt_angle = meta:get_int("tilt")
	local rot_angle = meta:get_int("rotate")
	local angle = 90 - rot_angle
	
	-- Start of Raycast Calculations --
	-- work out rotation find pt on circle - x = cx + r * cos(a) // y = cy + r * sin(a)
	-- eg x = rel-x-origin + (light_range*cos((90-rot_angle)*radians)
	local x_rel = pos[rot_x_y.x] + (math.floor((30*math.cos(angle*0.0174533))))*tonumber(rot_x_y.x_v)
	local y_rel = pos[rot_x_y.y] + (math.floor((30*math.sin(angle*0.0174533))))*tonumber(rot_x_y.y_v)
		
	local pos_rot = {[rot_x_y.x] = x_rel,[rot_x_y.y] = y_rel, [rot_x_y.z] = pos[rot_x_y.z]}

	-- work out gradient from angle (math.tan needs radians=degrees*0.0174533...)
	local grad = math.tan(tilt_angle*0.0174533)
	local y_end = math.floor(light_range*grad)

	local xx = (rel_x_y.xx or 0)*light_range
	local yx = (rel_x_y.yx or 0)*light_range
	local zx = (rel_x_y.zx or 0)*light_range

	local xy = (rel_x_y.xy or 0)*y_end 
	local yy = (rel_x_y.yy or 0)*y_end 
	local zy = (rel_x_y.zy or 0)*y_end 
	
	-- pos_s (start) simply add relative x  
	local pos_s = {x=pos.x+(xx/light_range),y=pos.y+(yx/light_range),z=pos.z+(zx/light_range)}
	-- pos_e (end) add both relative x and relative y
	local pos_e = {x=pos_rot.x+xx+xy,y=pos_rot.y+yx+yy,z=pos_rot.z+zx+zy}
	
	meta:set_string("flood_light_pos_s", minetest.serialize(pos_s))
	meta:set_string("flood_light_pos_e", minetest.serialize(pos_e))
	
	local ray = minetest.raycast(pos_s,pos_e,false,true)
	local ray_next = ray:next()	
	local end_pos	

	while ray_next do
		local name = minetest.get_node(ray_next.under).name
		local node_draw = minetest.registered_items[name].drawtype
		
		if node_draw ~= "plantlike" and
		   node_draw ~= "firelike" and 
		   node_draw ~= "raillike" and
		   node_draw ~= "torchlike" and
		   node_draw ~= "signlike" and
		   name ~= "elepower_lighting:light_fill" then
			
			local e_pos = ray_next.under
			meta:set_string("flood_light_end", minetest.serialize(e_pos))
			
			end_pos = {x=e_pos.x-(xx/light_range),y=e_pos.y-(yx/light_range),z=e_pos.z-(zx/light_range)}
			break
		end
		ray_next = ray:next()
	end	
	
	local tot = 30
		if end_pos then
			tot = math.abs(end_pos[rel_x_y.x] - pos[rel_x_y.x])
		end
		
	-- Start of light fill calculations 
	local flood_fill_pos = {}
		for i = 1,tot,1 do 
			local new_pos = table.copy(pos)
			
			-- calculate rotation position
			local x_rel = new_pos[rot_x_y.x] + ((math.floor((i*math.cos(angle*0.0174533))))*tonumber(rot_x_y.x_v)) + 1*tonumber(rot_x_y.x_v) -- last + removes offset from carrier "1"
			local y_rel = new_pos[rot_x_y.y] + (math.floor((i*math.sin(angle*0.0174533))))*tonumber(rot_x_y.y_v)
		
			local pos_rot = {[rot_x_y.x] = x_rel,[rot_x_y.y] = y_rel, [rot_x_y.z] = new_pos[rot_x_y.z]}
			
			-- adjust for tilt
			 pos_rot[rel_x_y.x] = (pos_rot[rel_x_y.x] + (1*rel_x_y.x_val))                  -- relative X axis
			 pos_rot[rel_x_y.y] = (pos_rot[rel_x_y.y] + math.ceil((i*rel_x_y.y_val)*grad))	-- relative Y axis				
			
			
			--new_pos.x = new_pos.x+(math.floor(0.85*i))			
			if minetest.get_node(pos_rot).name == "air" or 
			   minetest.get_node(pos_rot).name == "elepower_lighting:light_fill" then
				
				table.insert(flood_fill_pos,pos_rot) 
				minetest.set_node(pos_rot,{name = "elepower_lighting:light_fill"})
				--minetest.debug(rot_x_y.y..":".. rot_x_y.y_v)

			end							
		end	
		
		meta:set_string("flood_fill_pos", minetest.serialize(flood_fill_pos))
end
---------------------------------------------
--    Removes Flood Light Light nodes      --
---------------------------------------------
function elepower_lighting.remove_flood_light_fill(pos)
	local meta = minetest.get_meta(pos)
	local flood_fill_pos = minetest.deserialize(meta:get_string("flood_fill_pos"))
	
	if type(flood_fill_pos) == "table" then
		meta:set_string("flood_light_pos_s","")
		meta:set_string("flood_light_pos_e","")
		meta:set_string("flood_light_end","")
		for k,pos in pairs(flood_fill_pos) do
			if minetest.get_node(pos).name == "elepower_lighting:light_fill" then
				minetest.remove_node(pos)
			end
		end
	end	
end

-------------------------------------------
-- A rotate and place that allows lights --
--     to mount into wall sockets        --
-- thanks mt forums for below soln idea  --
-------------------------------------------
function elepower_lighting.rot_and_place(itemstack, placer, pointed_thing)
	local p0 = pointed_thing.under
	local p1 = pointed_thing.above
	local param2 = 0

	if placer then
		local placer_pos = placer:get_pos()
		if placer_pos then
			param2 = minetest.dir_to_facedir(vector.subtract(p1, placer_pos))
		end
		
		if p0.x<p1.x then     -- -X
			param2 = 12 + param2
			
		elseif p0.x>p1.x then -- +X
			param2 = 16 + param2
			
		elseif p0.z<p1.z then -- +Z
			param2 = 4 + param2
			
		elseif p0.z>p1.z then -- -Z
			param2 = 8	+ param2
			
		elseif p0.y<p1.y then -- +Y
			param2 = param2
			
		elseif p0.y>p1.y then -- -Y
			param2 = 20 + param2
		end
	end

	return minetest.item_place(itemstack, placer, pointed_thing, param2)
end

------------------------------------
-- Main Lighting timer, what uses --
-- EpU's and allows lights to be  --
--      switched on and off       --
------------------------------------
function elepower_lighting.light_timer(pos)
	local meta        = minetest.get_meta(pos)
	local on_off      = meta:get_int("on_off")
	local reg_name    = minetest.get_node(pos).name
	local node_p2     = minetest.get_node(pos).param2
	local name        = minetest.registered_items[minetest.get_node(pos).name].description
	local light_shape = minetest.registered_items[minetest.get_node(pos).name].ele_light_shape or nil	
	local capacity    = ele.helpers.get_node_property(meta, pos, "capacity")
	local storage     = ele.helpers.get_node_property(meta, pos, "storage")
	local usage       = ele.helpers.get_node_property(meta, pos, "usage")
	local pow_percent = {capacity = capacity, storage = storage, usage = usage}
	local light_strip_axis
	local flood_light_change = false
		
	if light_shape ~= "flood" then
		light_strip_axis = elepower_lighting.p2_to_axis(node_p2)
	
	elseif light_shape == "flood" then
	-- need an overide in the event a wall/tree etc is built infront of an "on" flood light beam
		local flood_light_end = minetest.deserialize(meta:get_string("flood_light_end"))
		local pos_s = minetest.deserialize(meta:get_string("flood_light_pos_s"))
		local pos_e = minetest.deserialize(meta:get_string("flood_light_pos_e"))
		local e_pos

			if light_shape == "flood" then
				
				-- change floodlight node for angled/tilted version
				local tilt = meta:get_int("tilt") or 0
				local rotate = meta:get_int("rotate") or 0
				local rpn = "p"
				local tpn = "p"
				local new_name
				
				if rotate < 0 then 
					if rotate < -10 then
						rpn = "n"
					end
					rotate = rotate*-1
				end
				
				if tilt < 0 then 
					if tilt < -5 then
						tpn = "n"
					end
					tilt = tilt*-1
				end
				
				if rotate > 10 then
					rotate = 45					
				else
					rotate = 0				
				end
				
				if tilt > 5 then
					tilt = 20
				else
					tilt = 0				
				end
								
				if not string.find(reg_name, "active") then
					new_name = "elepower_lighting:incandescent_floodlight_x"..rpn..rotate.."_y"..tpn..tilt				
				else
					new_name = "elepower_lighting:incandescent_floodlight_x"..rpn..rotate.."_y"..tpn..tilt.."_active"
				end
				
				if new_name ~= reg_name then
					ele.helpers.swap_node(pos, new_name)
				end
				
			end

		if pos_s then
			local ray = minetest.raycast(pos_s,pos_e,false,true)
			local ray_next = ray:next()	

			while ray_next do
				local name = minetest.get_node(ray_next.under).name
				local node_draw = minetest.registered_items[name].drawtype

				if node_draw ~= "plantlike" and
				   node_draw ~= "firelike" and 
				   node_draw ~= "raillike" and
				   node_draw ~= "torchlike" and
				   node_draw ~= "signlike" and
				   name ~= "elepower_lighting:light_fill" then
					
					e_pos = ray_next.under
					
					break
				end
				ray_next = ray:next()
			end	
			
			if minetest.serialize(e_pos) ~= minetest.serialize(flood_light_end) then
				flood_light_change = true
			end
		end		
	end

	if (storage >= usage and on_off == 1) then
		if not string.find(reg_name, "active") or flood_light_change == true then
					
			if flood_light_change == false then
				ele.helpers.swap_node(pos, reg_name.."_active")
				
			elseif flood_light_change == true then
				elepower_lighting.remove_flood_light_fill(pos)
			end
			
			if light_shape == "flood" then
				elepower_lighting.add_flood_light_fill(pos)
				
			elseif light_shape then
				elepower_lighting.add_remove_light_fill(pos,light_strip_axis,light_shape,1)
			end	

		end	
		
		pow_percent.storage = pow_percent.storage - usage
		storage = pow_percent.storage
		meta:set_int("storage", pow_percent.storage)
	else
		if string.find(reg_name, "active") then
			local name = string.sub(reg_name, 1, -8)
			
			ele.helpers.swap_node(pos, name)
			
			if light_shape then	
				if light_shape == "flood" then
					elepower_lighting.remove_flood_light_fill(pos)
					
				elseif light_shape then			
					elepower_lighting.add_remove_light_fill(pos,light_strip_axis,light_shape)
				end
			end		
		end	
	end

	meta:set_string("infotext", name .. "\n" .. ele.capacity_text(capacity, storage))

	if light_shape == "flood" then
		local tilt = meta:get_int("tilt") or 0
		local rotate = meta:get_int("rotate") or 0
		meta:set_string("formspec", get_formspec_flood(pow_percent,tilt,rotate))
	end

	return true
end

---------------------------------------------
-- Main  Colored Lighting timer, what uses --
-- EpU's and allows lights to be switched  -- 
--             on and off                  --
---------------------------------------------
elepower_lighting.colors = {{"#ff0500", "Red"},
							{"#ff3500", "Dark Orange"},
							{"#ff6300", "Orange"},
							{"#ff9100", "Light Orange"},
							{"#ffc000", "Golden"},
							{"#ffef00", "Yellow"},
							{"#e1ff00", "Lemon Lime"},
							{"#b3ff00", "Lime"},
							{"#84ff00", "Lawn Green"},
							{"#56ff00", "Bright Green"},
							{"#00ff36", "Green"},
							{"#00ff65", "Spring Green"},
							{"#00ff93", "Sea Green"},
							{"#00ffc2", "Aqua"},
							{"#00fff0", "Turquoise Blue"},
							{"#00dfff", "Sky Blue"},
							{"#00b1ff", "Vivid Blue"},
							{"#0082ff", "Azure"},
							{"#0053ff", "Blue"},
							{"#0024ff", "Blue Bonnet"},
							{"#0900ff", "Dark Blue"},
							{"#3800ff", "Blue Purple"},
							{"#6700ff", "Indigo"},
							{"#9500ff", "Violet"},
							{"#c400ff", "Orchid"},
							{"#f200ff", "Magenta"},
							{"#ff00dd", "Hot Pink"},
							{"#ff00af", "Shocking Pink"},
							{"#ff0080", "Pink"},
							{"#ff0051", "Apple Red"},
							{"#ffffff", "White"},
							{"#000000", "Black"}
						   }

local function get_formspec_panel_color(power,color_mode,color_sync)	
	local color_m = color_mode
	local color_s = color_sync
	
	if tonumber(color_m) then
		color_m = "Single Color-"..elepower_lighting.colors[(color_m/8)][2]
	
	else
		color_m = color_m:gsub("^%l", string.upper)
	end
	
	local final ="size[8,3]"..
	             "container[0,0.1]"..
				  ele.formspec.power_meter(power)..
				 "container_end[]"..
				 "label[1,-0.05;Current Selection: "..color_m.."]"..
				 "checkbox[6,-0.25;sync;Synchronize;"..color_s.."]"..
				 "image_button[1,0.4;2,0.75;elepower_lighting_gui_rainbow_button.png;r_color;Rainbow;false;true;elepower_lighting_gui_rainbow_button.png^[opacity:127]"..
				 "image_button[1,1.1;2,0.75;elepower_lighting_gui_strobe_button.png;r_color;Strobe;false;true;elepower_lighting_gui_strobe_button.png^[opacity:127]"..
				 "image_button[1,1.8;2,0.75;elepower_lighting_gui_blue_button.png;r_color;Blues;false;true;elepower_lighting_gui_blue_button.png^[opacity:127]"..
				 "image_button[1,2.5;2,0.75;elepower_lighting_gui_red_button.png;r_color;Reds;false;true;elepower_lighting_gui_red_button.png^[opacity:127]"
		
		for k,def in pairs(elepower_lighting.colors) do			
			
			local image_end = "elepower_lighting_gui_color_button.png^[multiply:"..
							  def[1]..";f_color;"..((k)*8)..
							  ";false;true;elepower_lighting_gui_color_button.png^[multiply:"..
							  def[1].."^[opacity:127]]"
							  
			final = final.."style[f_color;font_size=0;textcolor="..def[1].."]"
			if k <= 8 then
				final = final.."image_button["..(3.0+((k-1)*0.6))..",0.4;0.75,0.75;"..image_end
				final = final.."tooltip["..(3.0+((k-1)*0.6))..",0.4;0.55,0.65;"..def[2]..";#30434c;#f9f9f9]"

			elseif k > 8 and k < 17 then
				final = final.."image_button["..(3.0+((k-9)*0.6))..",1.1;0.75,0.75;"..image_end
				final = final.."tooltip["..(3.0+((k-9)*0.6))..",1.1;0.55,0.65;"..def[2]..";#30434c;#f9f9f9]"
				
			elseif k > 16 and k < 25 then 
				final = final.."image_button["..(3.0+((k-17)*0.6))..",1.8;0.75,0.75;"..image_end
				final = final.."tooltip["..(3.0+((k-17)*0.6))..",1.8;0.55,0.65;"..def[2]..";#30434c;#f9f9f9]"				
				
			else
				final = final.."image_button["..(3.0+((k-25)*0.6))..",2.5;0.75,0.75;"..image_end
				final = final.."tooltip["..(3.0+((k-25)*0.6))..",2.5;0.55,0.65;"..def[2]..";#30434c;#f9f9f9]"
			end
			
		end
	
	return final
end

-- register color on_recieve fields
function elepower_lighting.color_on_recieve_fields(pos, formname, fields, player)
	
	local meta = minetest.get_meta(pos)
	
	if fields.quit then
		return
	end
	
	if fields.r_color == "Rainbow" then
		meta:set_string("color_mode","rainbow")
		
	elseif fields.r_color == "Strobe" then
		meta:set_string("color_mode","strobe")
		
	elseif fields.r_color == "Blues" then
		meta:set_string("color_mode","blues")	

	elseif fields.r_color == "Reds" then
		meta:set_string("color_mode","reds")
	
	elseif fields.f_color then
		meta:set_string("color_mode",fields.f_color)
	
	elseif fields.sync then
		meta:set_string("color_sync",tostring(fields.sync))
		
	end
		
	--minetest.debug(dump(fields))	
end

function elepower_lighting.light_timer_colored(pos)
	local meta        = minetest.get_meta(pos)
	local on_off      = meta:get_int("on_off")
	local cycles      = meta:get_int("light_color_count")
	local color_mode  = meta:get_string("color_mode") or "rainbow"
	local color_sync  = meta:get_string("color_sync") or "false"
	local run_bwd     = meta:get_string("run_bwd") or "false"
	local node        = minetest.get_node(pos)
	local name        = minetest.registered_items[minetest.get_node(pos).name].description
	local reg_name    = minetest.get_node(pos).name
	local capacity    = ele.helpers.get_node_property(meta, pos, "capacity")
	local storage     = ele.helpers.get_node_property(meta, pos, "storage")
	local usage       = ele.helpers.get_node_property(meta, pos, "usage")
	local pow_percent = {capacity = capacity, storage = storage, usage = usage}
	local strobe_ok   = true
	local is_timer    = true

	
	if cycles == 5 then   --(1 second)
		if (storage >= usage and on_off == 1) then
			if not string.find(reg_name, "active") and color_mode ~= "strobe" then
				ele.helpers.swap_node(pos, reg_name.."_active")
				
			end	
						
			pow_percent.storage = pow_percent.storage - usage
			storage = pow_percent.storage
			meta:set_int("storage", pow_percent.storage)
		else
			if string.find(reg_name, "active") then
				local name = string.sub(reg_name, 1, -8)
				ele.helpers.swap_node(pos, name)
				strobe_ok = false
						
			end	
		end
		
		meta:set_string("formspec", get_formspec_panel_color(pow_percent,color_mode,color_sync))
		meta:set_string("infotext", name .. "\n" .. ele.capacity_text(capacity, storage))

		cycles = 0
	end
	
	node = minetest.get_node(pos)
	
	if string.find(node.name, "active") or strobe_ok then
			
		if color_mode == "rainbow" then
		
			if color_sync == "true" then
				local sync_total = 30
				local node_plain_p2 = node.param2 % 8
				
				col_seq = math.ceil(sync_total*((((elepower_lighting.timer/0.2))/sync_total)%1))
				node.param2 = node_plain_p2 + ((col_seq*8)-8)
				minetest.swap_node(pos, node)
				
			else
				node.param2 = node.param2+8
				
				if node.param2 >=240 then
					node.param2 = (node.param2 % 32)
				end
				
				minetest.swap_node(pos, node)
			end
			
		elseif color_mode == "blues" or color_mode == "reds"  then		
			local blues_seq_p2  = {120,128,136,144,152,160,168}
			local reds_seq_p2   = {200,208,216,224,232,0}
			local node_plain_p2 = node.param2 % 8
			local cur_color_p2  = math.floor(node.param2/8)*8
			local col_seq       = 1
			local change        = 1
			local col_seq_p2    = blues_seq_p2
			local sync_total    = #blues_seq_p2-1
			
			if color_mode == "reds" then
				col_seq_p2 = reds_seq_p2
				sync_total = #reds_seq_p2-1
			end
			
			if color_sync == "true" then			
				if math.floor(((elepower_lighting.timer/0.2)/sync_total)%2) == 0 then
					--minetest.debug("bwd: ".. (sync_total+1)-math.ceil(sync_total*((((elepower_lighting.timer/0.2))/sync_total)%1)))
					col_seq = (sync_total+1)-math.ceil(sync_total*((((elepower_lighting.timer/0.2))/sync_total)%1))
					change = 0
					meta:set_string("run_bwd", "true")
					
				else
					--minetest.debug("fwd: ".. 1+math.ceil(sync_total*((((elepower_lighting.timer/0.2))/sync_total)%1)))
					col_seq = 1+math.ceil(sync_total*((((elepower_lighting.timer/0.2))/sync_total)%1))
					change = 0
					meta:set_string("run_bwd", "false")
				end

			else
				for k,v in pairs(col_seq_p2 ) do
					if v == cur_color_p2 then
						col_seq = k
					end			
				end
						
				if (col_seq == #col_seq_p2  or run_bwd == "true") and col_seq ~= 1 then
					meta:set_string("run_bwd", "true")					
					change = -1
					
				elseif col_seq == 1 then
					meta:set_string("run_bwd", "false")
				end	
			end
			
			--minetest.debug(col_seq+change)
			node.param2 = col_seq_p2[col_seq+change] + node_plain_p2
			minetest.swap_node(pos, node)
		
		elseif color_mode == "strobe" then
			
			if color_sync == "true" then
				
				local col_seq = math.ceil(math.floor((elepower_lighting.timer/0.2)+0.5)%2)
				
				if col_seq == 1 then					
					if not string.find(reg_name, "active") then
						ele.helpers.swap_node(pos, reg_name.."_active")
					end
				
				else				
					if string.find(reg_name, "active") then
						local name = string.sub(reg_name, 1, -8)
						ele.helpers.swap_node(pos, name)
					end
				end
			
			else
			
				if string.find(reg_name, "active") then
					local name = string.sub(reg_name, 1, -8)
					ele.helpers.swap_node(pos, name)
				
				else
					ele.helpers.swap_node(pos, reg_name.."_active")
				end
			end
		
		elseif type(tonumber(color_mode)) == "number" then
		
			local node_plain_p2 = node.param2 % 8
			local cur_color_p2  = math.floor(node.param2/8)*8
			
			if color_mode-8 ~= cur_color_p2 then
				node.param2 = color_mode-8 + node_plain_p2
				minetest.swap_node(pos, node)			
			end
				
		else
			-- catch error state set to white
			local node_plain_p2 = node.param2 % 8
			node.param2 = node_plain_p2 + 240
			minetest.swap_node(pos, node)
		end
		
		
	end
	
	local timer = minetest.get_node_timer(pos)
	
	if timer:get_timeout() ~= 0.2 then	
		timer:start(0.2)
		is_timer = false
	end
		
	meta:set_int("light_color_count",cycles+1)	
	
		
	return is_timer
end

elepower_lighting.timer = 0
minetest.register_globalstep(function(dtime)
	-- note counter shouldn't cause an issue until uptime exceeds about 7million yrs
	elepower_lighting.timer = elepower_lighting.timer + dtime;
	
end)

-----------------------------------------
-- Lighting simple functions for basic --
--         node functionality          --
-----------------------------------------
-- set light on/off by punch
function elepower_lighting.light_punch(pos,player)
	local meta   = minetest.get_meta(pos)
	local on_off = meta:get_int("on_off") or 1

	if on_off == 1 then
		on_off = 0
		
	else
		on_off = 1
	end
	meta:set_int("on_off",on_off)
end

-- set lights to on when constructed
function elepower_lighting.light_construct(pos)
	local meta  = minetest.get_meta(pos)
	meta:set_int("on_off",1)
	
	local is_colored  = minetest.registered_items[minetest.get_node(pos).name].palette or nil
	
	if is_colored then
		meta:set_string("color_mode","rainbow")
		local timer = minetest.get_node_timer(pos)
		timer:start(0.2)
	end
	
end

-- Main place function
function elepower_lighting.light_place(itemstack, placer, pointed_thing)
	if pointed_thing.type ~= "node" then
		return itemstack
	end

	return elepower_lighting.rot_and_place(itemstack, placer, pointed_thing)
end

-- For lights more than 1x1 cleanup light_fill on destruction
function elepower_lighting.light_strip_cleanup(pos)

		local node_p2  = minetest.get_node(pos).param2
		local light_shape = minetest.registered_items[minetest.get_node(pos).name].ele_light_shape or nil			
		local light_strip_axis = elepower_lighting.p2_to_axis(node_p2)	
		
		if light_shape == "flood" then
			elepower_lighting.remove_flood_light_fill(pos)
			
		else
			elepower_lighting.add_remove_light_fill(pos,light_strip_axis,light_shape)
		end
		
	end