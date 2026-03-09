-- MainScript.lua for KingV5
-- Framework for modules

local Arguments = Arguments or {}
local Key = Arguments.Key or "unknown key"

shared.vape = shared.vape or {}
local vape = shared.vape

vape.Libraries = vape.Libraries or {}
vape.Libraries.entity = vape.Libraries.entity or {}
vape.Libraries.targetinfo = vape.Libraries.targetinfo or {}
vape.Libraries.sessioninfo = vape.Libraries.sessioninfo or {}
vape.Libraries.uipallet = vape.Libraries.uipallet or {}
vape.Libraries.tween = vape.Libraries.tween or {}
vape.Libraries.color = vape.Libraries.color or {}
vape.Libraries.whitelist = vape.Libraries.whitelist or {}
vape.Libraries.prediction = vape.Libraries.prediction or {}
vape.Libraries.getfontsize = vape.Libraries.getfontsize or {}
vape.Libraries.getcustomasset = vape.Libraries.getcustomasset or getcustomasset

local store = {
    attackReach = 0,
    attackReachUpdate = tick(),
    inventory = {items={}, armor={}},
    hotbar = {},
    inventories = {},
    matchState = 0,
    tools = {}
}

local bedwars = {
    ItemMeta = {},
    ProjectileMeta = {}
}

local playersService = game:GetService("Players")
local lplr = playersService.LocalPlayer
local runService = game:GetService("RunService")
local collectionService = game:GetService("CollectionService")

local function loadModule(path)
    local code = readfile(path)
    return loadstring(code)()
end

local universalModule
if isfile("KingV5/games/universal.lua") then
    universalModule = loadModule("KingV5/games/universal.lua")
end

vape.store = store
vape.bedwars = bedwars
vape.LocalPlayer = lplr
vape.playersService = playersService
