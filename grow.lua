-- LUALOCALS < ---------------------------------------------------------
local minetest, nodecore, math
    = minetest, nodecore, math
-- LUALOCALS > ---------------------------------------------------------
local modname = minetest.get_current_modname()
------------------------------------------------------------------------
--minetest.register_on_dignode(
--    function(pos, oldnode, digger)
--        if(oldnode.name == "nc_lode:ore")then
--            if(math.random(100) >= 77)then
--            local space = minetest.find_node_near(pos,1,"air",false)
--        minetest.item_drop(ItemStack(modname .. ":drupe 1"),digger,space or pos)
--            else end
--        else end
--    end)
------------------------------------------------------------------------
minetest.register_decoration({
		deco_type = "schematic",
		place_on = {"group:stone"},
		sidelen = 16,
		noise_params = {
			offset = -0.008,
			scale = 0.016,
			spread = {x = 120, y = 120, z = 120},
			seed = 2,
			octaves = 3,
			persist = 0.66
		},
		y_min = -31000,
		y_max = -80,
		biomes = {"deep"},
		schematic = nodecore.plumtree_schematic,
		flags = "place_center_x, place_center_z, all_floors",
		rotation = "random",
		replacements = {}
	})
-----------------------------------------------------------------------

