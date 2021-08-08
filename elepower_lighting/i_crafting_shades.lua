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
--                 Crafting Shades                  --
------------------------------------------------------
local stick = "default:stick" 
local paper = "default:paper"
local paper_red = "elepower_lighting:paper_red"
local paper_blue = "elepower_lighting:paper_blue"

local colors = {["default:paper"] = "",["elepower_lighting:paper_red"] = "_red",["elepower_lighting:paper_blue"] = "_blue"}

for paper,color in pairs(colors) do
minetest.register_craft({
	output = "elepower_lighting:decor_shade"..color.."_1 2",
	recipe = {
			{stick,paper,stick},
			{paper,stick,paper},
			{stick,paper,stick}
	}
})

minetest.register_craft({
	output = "elepower_lighting:decor_shade"..color.."_2 2",
	recipe = {
			{stick,paper,stick},
			{stick,paper,stick},
			{stick,paper,stick}
	}
})

minetest.register_craft({
	output = "elepower_lighting:decor_shade"..color.."_3 2",
	recipe = {
			{stick,paper,stick},
			{stick,stick,stick},
			{stick,paper,stick}
	}
})

minetest.register_craft({
	output = "elepower_lighting:decor_shade"..color.."_4 2",
	recipe = {
			{stick,stick,stick},
			{stick,paper,stick},
			{stick,stick,stick}
	}
})

minetest.register_craft({
	output = "elepower_lighting:decor_shade"..color.."_5 2",
	recipe = {
			{paper,stick,paper},
			{stick,paper,stick},
			{paper,stick,paper}
	}
})

end