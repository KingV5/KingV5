-- loader.lua for KingV5
-- downloads and runs universal.lua

-- helper to check if file exists
local function isfile(file)
	local suc, res = pcall(function() return readfile(file) end)
	return suc and res ~= nil and res ~= ""
end

-- helper to create folders
local function ensure(folder)
	if not isfolder(folder) then
		makefolder(folder)
	end
end

-- helper to download file from GitHub and save locally
local function downloadFile(path)
	local url = "https://raw.githubusercontent.com/KingV5/KingV5/main/"..path
	local data

	if not isfile(path) then
		local suc, res = pcall(function() return game:HttpGet(url, true) end)
		if not suc or res == "404: Not Found" then
			error("Failed to download "..path)
		end
		data = res
		writefile(path, data)
	else
		data = readfile(path)
	end

	return data
end

-- create required folders
ensure("KingV5")
ensure("KingV5/games")
ensure("KingV5/profiles")
ensure("KingV5/libraries")
ensure("KingV5/assets")
ensure("KingV5/guis")

-- download universal.lua
local universalCode = downloadFile("KingV5/games/universal.lua")

-- execute universal.lua
return loadstring(universalCode, "universal")()
