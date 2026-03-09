-- MainScript.lua for KingV5
local Arguments = Arguments or {}
local Key = Arguments.Key or "unknown key"

-- Shared vape table
shared.vape = shared.vape or {}
local vape = shared.vape

-- Roblox services
local playersService = game:GetService("Players")
local lplr = playersService.LocalPlayer
local runService = game:GetService("RunService")

-- Auto-load all game modules
local function loadModule(path)
    if isfile(path) then
        local code = readfile(path)
        local func, err = loadstring(code)
        if func then
            func()
        else
            warn("Failed to load "..path..": "..tostring(err))
        end
    end
end

for _, file in pairs(listfiles("KingV5/games")) do
    if file:sub(-4) == ".lua" then
        loadModule(file)
    end
end

-- Export shared variables for modules
vape.LocalPlayer = lplr
vape.Players = playersService
vape.RunService = runService

print("KingV5 main script loaded successfully!")
