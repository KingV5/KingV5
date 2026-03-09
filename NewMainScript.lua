local Arguments = {}

if script_key then
    Arguments.Key = script_key
else
    Arguments.Key = "unknown key"
end

if shared.VapeDeveloper then
    return loadstring(readfile("catrewrite/loader.lua"), "loader.lua")(Arguments)
else
    if not isfolder("catrewrite") then
        makefolder("catrewrite")
    end

    if not isfolder("catrewrite/profiles") then
        makefolder("catrewrite/profiles")
    end

    -- get latest commit
    local commit = "main"
    local suc, subbed = pcall(function()
        return game:HttpGet("https://github.com/MaxlaserTech/CatV6")
    end)

    if suc and subbed then
        local pos = subbed:find("currentOid")
        if pos then
            local possible = subbed:sub(pos + 13, pos + 52)
            if #possible == 40 then
                commit = possible
            end
        end
    end

    Arguments.Commit = commit

    local function downloadFile(path, func)
        local needUpdate = not isfile(path)

        if isfile("catrewrite/profiles/commit.txt") then
            if readfile("catrewrite/profiles/commit.txt") ~= commit then
                needUpdate = true
            end
        else
            needUpdate = true
        end

        if needUpdate and not shared.VapeDeveloper then
            local suc2, res = pcall(function()
                local url = "https://raw.githubusercontent.com/MaxlaserTech/CatV6/"..commit.."/"..select(1, path:gsub("catrewrite/", ""))
                return game:HttpGet(url)
            end)

            if not suc2 or not res or res == "404: Not Found" then
                error(res or "Download failed")
            end

            if path:find(".lua") then
                res = "--cache watermark\n"..res
            end

            writefile(path, res)
            writefile("catrewrite/profiles/commit.txt", commit)
        end

        return (func or readfile)(path)
    end

    if getconnections and not shared.catdebug then
        for _, v in pairs(getconnections(game:GetService("ScriptContext").Error)) do
            v:Disable()
        end

        for _, v in pairs(getconnections(game:GetService("LogService").MessageOut)) do
            v:Disable()
        end
    end

    shared.VapeDeveloper = Arguments.Developer
    return loadstring(downloadFile("catrewrite/loader.lua"), "loader.lua")(Arguments)
end
