local assets =
{
	Asset( "ANIM", "anim/woxillian.zip" ),
	Asset( "ANIM", "anim/ghost_woxillian_build.zip" ),
}

local skins =
{
	normal_skin = "woxillian",
	ghost_skin = "ghost_woxillian_build",
}

return CreatePrefabSkin("woxillian_none",
{
	base_prefab = "woxillian",
	type = "base",
	assets = assets,
	skins = skins, 
	skin_tags = {"WOXILLIAN", "CHARACTER", "BASE"},
	build_name_override = "woxillian",
	rarity = "Character",
})