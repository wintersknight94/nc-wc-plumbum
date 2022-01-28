-- LUALOCALS < ---------------------------------------------------------
local minetest, nodecore, pairs
    = minetest, nodecore, pairs
-- LUALOCALS > ---------------------------------------------------------

local modname = minetest.get_current_modname()
local src = "nc_optics:glass_hot_source"
local flow = "nc_optics:glass_hot_flowing"

local function near(pos, crit)
	return #nodecore.find_nodes_around(pos, crit, {1, 1, 1}, {1, 0, 1}) > 0
end


nodecore.register_lode_anvil_recipe(-1, function(temper)
		return {
			label = "anvil making plumbum block",
			priority = -1,
			action = "pummel",
			toolgroups = {thumpy = 3},
			indexkeys = {modname .. ":drupe"},
			nodes = {
				{
					match = {name = modname .. ":drupe", count = 8},
					replace = "air"
				}
			},
			items = {
				modname .. ":block"
			}
		}
	end)

nodecore.register_craft({
		label = "melt plumbum",
		action = "cook",
		touchgroups = {
			coolant = 0,
			flame = 3
		},
		duration = 20,
		cookfx = true,
		indexkeys = {"group:plumby"},
		nodes = {
			{
				match = modname .. ":block",
				replace = modname .. ":plumbum_hot_source"
			}
		},
		after = function(pos)
			nodecore.dnt_set(pos, "fluidwander_glass")
		end
	})

nodecore.register_cook_abm({
		nodenames = {"group:plumby"},
		neighbors = {"group:flame"},
		neighbors_invert = true
	})

nodecore.register_craft({
		label = "cool plum glass",
		action = "cook",
		duration = 120,
		priority = 1,
		cookfx = {smoke = true, hiss = true},
		check = function(pos)
			return not near(pos, {flow})
		end,
		indexkeys = {src},
		nodes = {
			{
				match = src,
				replace = modname .. ":glass"
			},
			{
				y = -1,
				match = {groups = {plumbum_molten = true}}
			}
		}
	})

