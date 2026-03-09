-- MainScript.lua for KingV5
-- Auto-loads all game modules (including universal.lua)

-- Explicit arguments
local Arguments = Arguments or {}
local Key = Arguments.Key or "unknown key"

-- Shared table for modules
shared.vape = shared.vape or {}
local vape = shared.vape

-- Libraries placeholders
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

-- Store system
local store = {
    attackReach = 0,
    attackReachUpdate = tick(),
    inventory = {items={}, armor={}},
    hotbar = {},
    inventories = {},
    matchState = 0,
    tools = {}
}

-- Bedwars metadata placeholders
local bedwars = {
    ItemMeta = {},
    ProjectileMeta = {}
}

-- Roblox services
local playersService = game:GetService("Players")
local lplr = playersService.LocalPlayer
local runService = game:GetService("RunService")
local collectionService = game:GetService("CollectionService")

-- Module loader function
local function loadModule(path)
    if not isfile(path) then return end
    local code = readfile(path)
    return loadstring(code)()
end

-- Auto-load all modules in games/ folder
for _, file in pairs(listfiles("KingV5/games")) do
    if file:sub(-4) == ".lua" then
        loadModule(file)
    end
end

-- Export shared variables for modules
vape.store = store
vape.bedwars = bedwars
vape.LocalPlayer = lplr
vape.playersService = playersService
