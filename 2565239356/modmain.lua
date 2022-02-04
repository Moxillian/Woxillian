PrefabFiles = {
	"woxillian",
	"woxillian_none",
	"wox_hat",
}

Assets = {
    Asset( "IMAGE", "images/saveslot_portraits/woxillian.tex" ),
    Asset( "ATLAS", "images/saveslot_portraits/woxillian.xml" ),

    Asset( "IMAGE", "images/selectscreen_portraits/woxillian.tex" ),
    Asset( "ATLAS", "images/selectscreen_portraits/woxillian.xml" ),
	
    Asset( "IMAGE", "images/selectscreen_portraits/woxillian_silho.tex" ),
    Asset( "ATLAS", "images/selectscreen_portraits/woxillian_silho.xml" ),

    Asset( "IMAGE", "bigportraits/woxillian.tex" ),
    Asset( "ATLAS", "bigportraits/woxillian.xml" ),
	
	Asset( "IMAGE", "images/map_icons/woxillian.tex" ),
	Asset( "ATLAS", "images/map_icons/woxillian.xml" ),
	
	Asset( "IMAGE", "images/avatars/avatar_woxillian.tex" ),
    Asset( "ATLAS", "images/avatars/avatar_woxillian.xml" ),
	
	Asset( "IMAGE", "images/avatars/avatar_ghost_woxillian.tex" ),
    Asset( "ATLAS", "images/avatars/avatar_ghost_woxillian.xml" ),
	
	Asset( "IMAGE", "images/avatars/self_inspect_woxillian.tex" ),
    Asset( "ATLAS", "images/avatars/self_inspect_woxillian.xml" ),
	
	Asset( "IMAGE", "images/names_woxillian.tex" ),
    Asset( "ATLAS", "images/names_woxillian.xml" ),
	
	Asset( "IMAGE", "images/names_gold_woxillian.tex" ),
    Asset( "ATLAS", "images/names_gold_woxillian.xml" ),
	
	Asset("ANIM", "anim/hat_mox.zip"),
	
    Asset( "IMAGE", "images/inventoryimages/wox_hat.tex" ),
    Asset( "ATLAS", "images/inventoryimages/wox_hat.xml" ),
}

AddMinimapAtlas("images/map_icons/woxillian.xml")

local require = GLOBAL.require
local STRINGS = GLOBAL.STRINGS
local Ingredient = GLOBAL.Ingredient
local RECIPETABS = GLOBAL.RECIPETABS
local ACTIONS = GLOBAL.ACTIONS
local Action = GLOBAL.Action
local TECH = GLOBAL.TECH

modimport("healthdrain")

-- The character select screen lines
STRINGS.CHARACTER_TITLES.woxillian = "The Funny Bunny"
STRINGS.CHARACTER_NAMES.woxillian = "Wox"
STRINGS.CHARACTER_DESCRIPTIONS.woxillian = "*It's definitely a furry.\n*Has his magic Top Hat,\n*That gives him what he desires.\n*Is a vegetarian."
STRINGS.CHARACTER_QUOTES.woxillian = "\"I'm not a furry.\""
STRINGS.CHARACTER_SURVIVABILITY.woxillian = "None"
--Wox's Top Hat. Probably didn't need to move it here, just making sure it doesn't crash.
STRINGS.NAMES.WOX_HAT = "Wox's Magic Hat"
STRINGS.RECIPE_DESC.WOX_HAT = "Gives you what you most desire!"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.WOX_HAT = ("It's got some magic inside!")
STRINGS.CHARACTERS.WILLOW.DESCRIBE.WOX_HAT = ("I hate magic!")
STRINGS.CHARACTERS.WICKERBOTTOM.DESCRIBE.WOX_HAT = ("I don't know where its contents are coming from.")
STRINGS.CHARACTERS.WAXWELL.DESCRIBE.WOX_HAT = ("I could perform my old act, if I feel like demeaning myself.")
STRINGS.CHARACTERS.WOODIE.DESCRIBE.WOX_HAT = ("Too dapper for my tastes.")
STRINGS.CHARACTERS.WOLFGANG.DESCRIBE.WOX_HAT = ("Where stuff come from?")
STRINGS.CHARACTERS.WENDY.DESCRIBE.WOX_HAT = ("Can you pull a cure for everlasting sadness from it?")
STRINGS.CHARACTERS.WX78.DESCRIBE.WOX_HAT = ("ILLOGICAL HAT SPACE")
--STRINGS.CHARACTERS.WES.DESCRIBE.WOX_HAT = (" ")
STRINGS.CHARACTERS.WINONA.DESCRIBE.WOX_HAT = ("Tell me when it starts making something useful.")
STRINGS.CHARACTERS.WORMWOOD.DESCRIBE.WOX_HAT = ("Mmm poop hat.")
STRINGS.CHARACTERS.WORTOX.DESCRIBE.WOX_HAT = ("I'm quite familiar with pocket dimensions.")
STRINGS.CHARACTERS.WURT.DESCRIBE.WOX_HAT = ("Stupid hat!")
STRINGS.CHARACTERS.WALTER.DESCRIBE.WOX_HAT = ("I appreciate the mystery, but it's not my style.")
STRINGS.CHARACTERS.WANDA.DESCRIBE.WOX_HAT = ("Radiates a feeling of distortion... Does he tangle with dimensions as well?")
-- Custom speech strings
STRINGS.CHARACTERS.WOXILLIAN = require "speech_woxillian"

-- The character's name as appears in-game 
STRINGS.NAMES.WOXILLIAN = "Wox"
STRINGS.SKIN_NAMES.woxillian_none = "Wox"

-- The skins shown in the cycle view window on the character select screen.
-- A good place to see what you can put in here is in skinutils.lua, in the function GetSkinModes
local skin_modes = {
    { 
        type = "ghost_skin",
        anim_bank = "ghost",
        idle_anim = "idle", 
        scale = 0.75, 
        offset = { 0, -25 } 
    },
}

-- Add mod character to mod character list. Also specify a gender. Possible genders are MALE, FEMALE, ROBOT, NEUTRAL, and PLURAL.
AddModCharacter("woxillian", "MALE", skin_modes)

-- Wox's Top Hat, hopefully I don't need to organize it too much.
STRINGS = GLOBAL.STRINGS
RECIPETABS = GLOBAL.RECIPETABS
Recipe = GLOBAL.Recipe
Ingredient = GLOBAL.Ingredient
TECH = GLOBAL.TECH

local sanitything = GLOBAL.Recipe("wox_hat", 
											{ 	Ingredient("tophat", 1),
												Ingredient("nightmarefuel", 10),
												Ingredient("manrabbit_tail", 10)},
											RECIPETABS.DRESS,
											TECH.NONE,
											nil,
											nil,
											nil,
											nil,
											"wox",
											"images/inventoryimages/wox_hat.xml", "wox_hat.tex")
		
GLOBAL.STRINGS.NAMES.WOX_HAT = "Wox's Magic Hat"
