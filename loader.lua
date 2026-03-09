local function getGithubFile(path)
	return game:HttpGet("https://raw.githubusercontent.com/KingV5/KingV5/main/"..path, true)
end

local function ensureFolder(folder)
	if not isfolder(folder) then
		makefolder(folder)
	end
end

local function saveFile(path, data)
	writefile(path, data)
end

-- folders
ensureFolder("KingV5")
ensureFolder("KingV5/games")
ensureFolder("KingV5/libraries")
ensureFolder("KingV5/assets")
ensureFolder("KingV5/guis")
ensureFolder("KingV5/profiles")

-- download universal
local universal = getGithubFile("games/universal.lua")
saveFile("KingV5/games/universal.lua", universal)

-- run universal
loadstring(universal)()
