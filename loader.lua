-- loader.lua for KingV5
-- Works with GitHub repo and auto-loads MainScript.lua

local Arguments = {
    Key = script_key or "unknown key",
    Developer = shared.VapeDeveloper or false
}

-- Ensure folders exist
local folders = {
    "KingV5",
    "KingV5/profiles",
    "KingV5/games",
    "KingV5/guis",
    "KingV5/libraries",
    "KingV5/assets"
}
for _, folder in pairs(folders) do
    if not isfolder(folder) then
        makefolder(folder)
    end
end

-- Function to download a file from GitHub
local function downloadFile(path, commit)
    commit = commit or "main"
    if not isfile(path) then
        local suc, res = pcall(function()
            local url = "https://raw.githubusercontent.com/KingV5/KingV5/"..commit.."/"..path:gsub("KingV5/", "")
            return game:HttpGet(url, true)
        end)
        if not suc or res == "404: Not Found" then
            error(res or "Failed to download "..path)
        end
        writefile(path, res)
    end
    return readfile(path)
end

-- Run your main script (rename your framework file to MainScript.lua)
return loadstring(downloadFile("KingV5/MainScript.lua"))(Arguments)
