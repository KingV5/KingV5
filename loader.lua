local isfile = isfile or function(file)
	local suc, res = pcall(function()
		return readfile(file)
	end)
	return suc and res ~= nil and res ~= ''
end

local function downloadFile(path)
	if not isfile(path) then
		local suc, res = pcall(function()
			return game:HttpGet(
				"https://raw.githubusercontent.com/KingV5/KingV5/main/" ..
				select(1, path:gsub("KingV5/", "")),
				true
			)
		end)

		if not suc or res == "404: Not Found" then
			error("Failed to download "..path)
		end

		writefile(path, res)
	end

	return readfile(path)
end

-- create folders
for _, folder in {
	"KingV5",
	"KingV5/games",
	"KingV5/profiles",
	"KingV5/assets",
	"KingV5/libraries",
	"KingV5/guis"
} do
	if not isfolder(folder) then
		makefolder(folder)
	end
end

-- download universal.lua
downloadFile("KingV5/games/universal.lua")

-- run universal.lua
return loadstring(readfile("KingV5/games/universal.lua"), "universal")()
