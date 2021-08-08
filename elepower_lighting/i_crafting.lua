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
--                Crafting Recipes                  --
------------------------------------------------------
local glass = "default:glass"
local glass_slab = "stairs:slab_glass"
local stick = "default:stick"
local steel_wire = "basic_materials:steel_wire"
local steel_strip = "basic_materials:steel_strip"
local plastic_strip = "basic_materials:plastic_strip"
local plastic_sheet = "basic_materials:plastic_sheet"
local mese_dust = "elepower_dynamics:mese_dust"
local dye_red = "dye:red"
local dye_green = "dye:green"
local dye_blue = "dye:blue"
local s_wood = "stairs:slab_wood"

minetest.register_craft( {
	output = "elepower_lighting:electrum_strip 12",
	recipe = {
		{ "", "elepower_dynamics:electrum_ingot", "" },
		{ "elepower_dynamics:electrum_ingot", "", "" },
	},
})

-- Override base recipes so lighting independent
minetest.clear_craft({output = "elepower_dynamics:uv_bulb"})
minetest.registered_craftitems["elepower_dynamics:uv_bulb"] = {} -- registered as node

minetest.register_craft({
	output = "elepower_dynamics:uv_bulb",
	recipe = {
			{ ""               ,"elepower_lighting:bulb_glass"                ,  ""    },
			{"group:color_blue","elepower_lighting:incandescent_bulb_element" ,"group:color_violet"},
			{ ""               ,steel_strip                                   ,  ""    }
			}
})

-- Compressing Recipes
local compressor_recipes = {
	{
		recipe = { "elepower_lighting:electrum_strip 1", dye_red.." 1" },
		output = "elepower_lighting:led_red",
		time   = 4,
	},
	{
		recipe = { "elepower_lighting:electrum_strip 1", dye_green.." 1" },
		output = "elepower_lighting:led_green",
		time   = 4,
	},
	{
		recipe = { "elepower_lighting:electrum_strip 1", dye_blue.." 1" },
		output = "elepower_lighting:led_blue",
		time   = 4,
	}
}

for _,i in pairs(compressor_recipes) do
	elepm.register_craft({
		type   = "compress",
		recipe = i.recipe,
		output = i.output,
		time   = i.time or 1
	})
end

-- Soldering Recipes

local soldering_recipes = {
	{
		recipe = { "elepower_dynamics:pcb", "elepower_dynamics:chip 4", "elepower_lighting:led_red"},
		output = "elepower_lighting:led_driver 4",
		time   = 8,
	},
		{
		recipe = {"elepower_lighting:led_light_panel", "elepower_dynamics:microcontroller", "elepower_lighting:led_cluster"},
		output = "elepower_lighting:led_light_panel_colored",
		time   = 12,
	}
	}
	
for _,i in pairs(soldering_recipes) do
	elepm.register_craft({
		type   = "solder",
		recipe = i.recipe,
		output = i.output,
		time   = i.time or 4
	})
end


-- Canning
local canning_recipes = {
						{
							recipe = {"elepower_dynamics:iron_plate", "elepower_dynamics:conduit"},
							output = "elepower_lighting:conduit_iron_thin",
							time   = 4,
						},
						{
							recipe = {"elepower_dynamics:iron_plate 2", "elepower_dynamics:conduit"},
							output = "elepower_lighting:conduit_iron_thick",
							time   = 4,
						},
						{
							recipe = {"elepower_dynamics:steel_plate", "elepower_dynamics:conduit"},
							output = "elepower_lighting:conduit_steel_thin",
							time   = 4,
						},
						{
							recipe = {"elepower_dynamics:steel_plate 2", "elepower_dynamics:conduit"},
							output = "elepower_lighting:conduit_steel_thick",
							time   = 4,
						},
						{
							recipe = {"elepower_dynamics:gold_plate", "elepower_dynamics:conduit"},
							output = "elepower_lighting:conduit_gold_thin",
							time   = 4,
						},
						{
							recipe = {"elepower_dynamics:gold_plate 2", "elepower_dynamics:conduit"},
							output = "elepower_lighting:conduit_gold_thick",
							time   = 4,
						},						
} 

for _,i in pairs(canning_recipes) do
	elepm.register_craft({
		type   = "can",
		recipe = i.recipe,
		output = i.output,
		time   = i.time or 4
	})
end

-- Wood Conduit
minetest.register_craft({
	output = "elepower_lighting:conduit_wood_thin",
	recipe = {
		{ ""  ,"",  "" },
		{ ""  ,"elepower_dynamics:conduit",  "" },
		{ ""  ,s_wood,  "" }
	}
})

minetest.register_craft({
	output = "elepower_lighting:conduit_wood_thick",
	recipe = {
		{ ""  ,s_wood,  "" },
		{ ""  ,"elepower_dynamics:conduit",  "" },
		{ ""  ,s_wood,  "" }
	}
})

-- Incandescent Bulb Glass
minetest.register_craft({
	output = "elepower_lighting:bulb_glass 10",
	recipe = {
		{ ""  ,glass,  "" },
		{glass,  "" ,glass},
		{glass,  "" ,glass}
	}
})

-- Incandescent Bulb Element
minetest.register_craft({
	output = "elepower_lighting:incandescent_bulb_element 5",
	recipe = {
		{ ""  ,  "" ,  ""      },
		{stick,  "" ,steel_wire},
		{ ""  ,  "" ,  ""      }
	}
})

-- Incandescent Light Bulb
minetest.register_craft({
	output = "elepower_lighting:bulb_incandescent",
	recipe = {
		{ ""  ,  "elepower_lighting:bulb_glass"                ,  ""    },
		{ ""  ,  "elepower_lighting:incandescent_bulb_element" ,  ""    },
		{ ""  ,   steel_strip                                  ,  ""    }
	}
})


-- CCF Bulb Glass
minetest.register_craft({
	output = "elepower_lighting:cf_bulb_glass 10",
	recipe = {
		{glass,glass,glass},
		{glass,  "" ,glass},
		{glass,  "" ,glass}
	}
})

-- CCF Light Bulb
minetest.register_craft({
	output = "elepower_lighting:bulb_cf",
	recipe = {
		{ "elepower_lighting:cf_bulb_glass",  ""       ,  "elepower_lighting:cf_bulb_glass"    },
		{ ""                                ,mese_dust  ,  ""                                    },
		{ ""                                ,steel_strip,  ""                                    }
	}
})

-- Fluro Light Bank Glass
minetest.register_craft({
	output = "elepower_lighting:fluro_tube_glass 6",
	recipe = {
		{glass,"",glass},
		{glass,"",glass},
		{glass,"",glass}
	}
})

-- Fluro Light Bank
minetest.register_craft({
	output = "elepower_lighting:fluro_light_bank",
	recipe = {
		{ "","elepower_lighting:fluro_tube_glass","elepower_lighting:fluro_tube_glass"  },
		{ "",mese_dust                           ,  mese_dust                           },
		{ "","elepower_dynamics:steel_plate"     , steel_strip                          }
	}
})

-- Light Emitting Diode cluster
minetest.register_craft({
	output = "elepower_lighting:led_cluster",
	recipe = {
		{ ""                         , glass_slab                  ,        ""                  },
		{ "elepower_lighting:led_red","elepower_lighting:led_green","elepower_lighting:led_blue"},
		{ ""                         , plastic_strip               ,        ""                  }
	}
})

-- LED Light Bulb
minetest.register_craft({
	output = "elepower_lighting:bulb_led",
	recipe = {
		{                ""             ,"elepower_lighting:bulb_glass",            ""                 },
		{"elepower_lighting:led_cluster","elepower_lighting:led_driver","elepower_lighting:led_cluster"},
		{                ""             ,       steel_strip            ,            ""                 }
	}
})

-- LED Light Panel 1x1
minetest.register_craft({
	output = "elepower_lighting:led_light_panel",
	recipe = {
		{                ""             ,        glass_slab            ,            ""                 },
		{"elepower_lighting:led_cluster","elepower_lighting:led_driver","elepower_lighting:led_cluster"},
		{                ""             ,       plastic_sheet            ,            ""               }
	}
})

-- LED Light Panel 1x3
minetest.register_craft({
	output = "elepower_lighting:led_1x3_light_panel",
	recipe = {
		{ "" ,"", "" },
		{"elepower_lighting:led_light_panel","elepower_lighting:led_light_panel","elepower_lighting:led_light_panel"},
		{ "" ,"", "" }
	}
})

-- LED Light Panel 2x3
minetest.register_craft({
	output = "elepower_lighting:led_2x3_light_panel",
	recipe = {
		{"elepower_lighting:led_light_panel","elepower_lighting:led_light_panel","elepower_lighting:led_light_panel"},
		{"elepower_lighting:led_light_panel","elepower_lighting:led_light_panel","elepower_lighting:led_light_panel"},
		{ "" ,"", "" }
	}
})

-- Lens
minetest.register_craft({
	output = "elepower_lighting:magnifying_lens 5",
	recipe = {
		{ ""        ,glass_slab , ""        },
		{glass_slab ,glass_slab ,glass_slab },
		{ ""        ,glass_slab , ""        }
	}
})

-- Flood Light - Incandescent
minetest.register_craft({
	output = "elepower_lighting:incandescent_floodlight_xp0_yp0",
	recipe = {
		{ ""                                ,"elepower_dynamics:steel_plate", "" },
		{"elepower_lighting:magnifying_lens","elepower_lighting:bulb_incandescent","elepower_lighting:bulb_incandescent"},
		{ ""                                ,"elepower_dynamics:steel_plate", "" }
	}
})

-- Flood Light - CCF
minetest.register_craft({
	output = "elepower_lighting:cf_floodlight_xp0_yp0",
	recipe = {
		{ ""                                ,"elepower_dynamics:steel_plate", "" },
		{"elepower_lighting:magnifying_lens","elepower_lighting:bulb_cf","elepower_lighting:bulb_cf"},
		{ ""                                ,"elepower_dynamics:steel_plate", "" }
	}
})

-- Flood Light - LED
minetest.register_craft({
	output = "elepower_lighting:led_floodlight_xp0_yp0",
	recipe = {
		{ ""                                ,"elepower_dynamics:steel_plate", "" },
		{"elepower_lighting:magnifying_lens","elepower_lighting:bulb_led","elepower_lighting:bulb_led"},
		{ ""                                ,"elepower_dynamics:steel_plate", "" }
	}
})