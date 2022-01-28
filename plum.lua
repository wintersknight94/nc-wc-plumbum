-- LUALOCALS < ---------------------------------------------------------
local minetest, nodecore, pairs
    = minetest, nodecore, pairs
-- LUALOCALS > ---------------------------------------------------------
local modname = minetest.get_current_modname()
------------------------------------------------------------------------
local rootname = modname.. ":root"
local treeroots = "nc_tree:root"
local rootdef = nodecore.underride({
	description = "Plum Roots",
	color = "magenta"
}, minetest.registered_items[treeroots] or {})
minetest.register_node(rootname, rootdef)
------------------------------------------------------------------------
local trunkname = modname.. ":tree"
local treetrunk = "nc_tree:tree"
local trunkdef = nodecore.underride({
	description = "Plum Tree",
	color = "magenta"
}, minetest.registered_items[treetrunk] or {})
minetest.register_node(trunkname, trunkdef)
------------------------------------------------------------------------
local leafname = modname.. ":leaves"
local treeleaf = "nc_tree:leaves"
local leafdef = nodecore.underride({
	description = "Plum Leaves",
	color = "magenta",
	groups = {leaf_decay = 0}
}, minetest.registered_items[treeleaf] or {})
minetest.register_node(leafname, leafdef)
------------------------------------------------------------------------
minetest.register_node(modname.. ":drupe", {
		description = "Drupe",
		drawtype = "plantlike",
		paramtype = "light",
		paramtype2 = "meshoptions",
		waving = 2,
--		visual_scale = 0.5,
		wield_scale = {x = 0.75, y = 0.75, z = 1.5},
--		collision_box = nodecore.fixedbox(-3/16, -0.5, -3/16, 3/16, 0, 3/16),
--		selection_box = nodecore.fixedbox(-3/16, -0.5, -3/16, 3/16, 0, 3/16),
		inventory_image = modname.. "_drupe.png",
		wield_image = modname.. "_drupe.png",
		tiles = {modname.. "_drupe.png^(nc_tree_eggcorn_planted.png^[transformFY)"},
--		color = "blueviolet",
		groups = {
			snappy = 1,
			plumby = 1,
			lux_absorb = 20
		},
		node_placement_prediction = "nc_items:stack",
		place_as_item = true,
		sounds = nodecore.sounds("nc_lode_annealed")
	})
------------------------------------------------------------------------
minetest.register_node(modname .. ":block", {
		description = "Plumbum Block",
		tiles = {"nc_lode_tempered.png^[brighten"},
		color = "blueviolet",
		groups = {
			cracky = 2,
			lux_absorb = 64,
			plumby = 1
		},
		sounds = nodecore.sounds("nc_lode_annealed")
	})
------------------------------------------------------------------------
minetest.register_node(modname .. ":glass", {
		description = "Plum Glass",
		drawtype = "glasslike_framed",
		tiles = {
			"nc_optics_glass_glare.png^nc_optics_glass_edges.png",
			"nc_optics_glass_glare.png"
		},
		color = "plum", 
		groups = {
			silica = 1,
			silica_clear = 1,
			cracky = 3,
			scaling_time = 300,
			lux_absorb = 40,
		},
		sunlight_propagates = true,
		paramtype = "light",
		sounds = nodecore.sounds("nc_optics_glassy")
	})
------------------------------------------------------------------------

