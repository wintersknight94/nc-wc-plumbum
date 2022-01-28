-- LUALOCALS < ---------------------------------------------------------
local math, minetest, nodecore
    = math, minetest, nodecore
local math_random
    = math.random
-- LUALOCALS > ---------------------------------------------------------


local modname = minetest.get_current_modname()

----- ----- ----- ----- -----

local function anim(name, len)
	return {
		name = name,
		animation = {
			["type"] = "vertical_frames",
			aspect_w = 16,
			aspect_h = 16,
			length = 16
		}
	}
end

local moltdef = {
	description = "Molten Plumbum",
	drawtype = "liquid",
	tiles = {anim("nc_terrain_lava.png^[colorize:plum:100", 8)},
	special_tiles = {
		anim("nc_terrain_lava_flow.png^[colorize:plum:100", 8),
		anim("nc_terrain_lava_flow.png^[colorize:plum:100", 8)
	},
	paramtype = "light",
	liquid_viscosity = 9,
	liquid_renewable = false,
	liquid_range = 2,
	light_source = 8,
	walkable = false,
	buildable_to = false,
	drowning = 2,
	damage_per_second = 3,
	drop = "",
	groups = {
		igniter = 1,
		plumby = 1,
		plumbum_molten = 1,
		stack_as_node = 1,
		damage_touch = 1,
		damage_radiant = 5
	},
	stack_max = 1,
--	post_effect_color = {a = 140, r = 0, g = 225, b = 255},
	liquid_alternative_flowing = modname .. ":plumbum_hot_flowing",
	liquid_alternative_source = modname .. ":plumbum_hot_source",
	sounds = nodecore.sounds("nc_terrain_bubbly")
}

minetest.register_node(modname .. ":plumbum_hot_source",
	nodecore.underride({
			liquidtype = "source"
		}, moltdef))
minetest.register_node(modname .. ":plumbum_hot_flowing",
	nodecore.underride({
			liquidtype = "flowing",
			drawtype = "flowingliquid",
			paramtype2 = "flowingliquid"
		}, moltdef))

nodecore.register_ambiance({
		label = "adamant source ambiance",
		nodenames = {modname .. ":plumbum_hot_source"},
		neigbors = {"air"},
		interval = 1,
		chance = 10,
		sound_name = "nc_terrain_bubbly",
		sound_gain = 0.2
	})
nodecore.register_ambiance({
		label = "adamant flow ambiance",
		nodenames = {modname .. ":plumbum_hot_flowing"},
		neigbors = {"air"},
		interval = 1,
		chance = 10,
		sound_name = "nc_terrain_bubbly",
		sound_gain = 0.2
	})


local src = modname .. ":plumbum_hot_source"
local flow = modname .. ":plumbum_hot_flowing"

local function near(pos, crit)
	return #nodecore.find_nodes_around(pos, crit, {1, 1, 1}, {1, 0, 1}) > 0
end

nodecore.register_craft({
		label = "cool plumbum",
		action = "cook",
		priority = -1,
		duration = 240,
		cookfx = {smoke = true, hiss = true},
		check = function(pos)
			return not near(pos, {flow})
		end,
		indexkeys = {src},
		nodes = {
			{
				match = src,
				replace = modname .. ":block"
			}
		}
	})

nodecore.register_craft({
		label = "quench plumbum",
		action = "cook",
		cookfx = true,
		check = function(pos)
			return near(pos, {flow})
			and nodecore.quenched(pos)
		end,
		indexkeys = {src},
		nodes = {
			{
				match = src,
				replace = modname .. ":block"
			}
		}
	})

nodecore.register_cook_abm({nodenames = {src}})

nodecore.register_fluidwandering(
	"plumbum",
	{src},
	2,
	function(pos, _, gen)
		if gen < 16 or math_random(1, 2) == 1 then return end
		minetest.set_node(pos, {name = modname .. ":block"})
		nodecore.sound_play("nc_api_craft_hiss", {gain = 1, pos = pos})
		nodecore.smokefx(pos, 0.2, 80)
--		nodecore.fallcheck(pos)
		return true
	end
)
