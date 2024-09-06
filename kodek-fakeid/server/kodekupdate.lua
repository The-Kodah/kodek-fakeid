KodekVersionCheck = {}

local githuburl = "https://api.github.com/repos/The-Kodah/kodek-fakeid/releases/latest"

-- Function to normalize version (removes leading "v" and trims spaces)
local function normalizeVersion(version)
    return version:gsub("^v", ""):gsub("%s+", "")
end

-- Function to check for updates
function KodekVersionCheck.checkForUpdates(localVersion)
    PerformHttpRequest(githuburl, function(statusCode, response, headers)
        if statusCode == 200 then
            -- Parse the JSON response
            local data = json.decode(response)
            if data and data.tag_name then
                local remoteVersion = normalizeVersion(data.tag_name)
                local localVersionNormalized = normalizeVersion(localVersion)

                -- Compare local version with remote version
                if remoteVersion ~= localVersionNormalized then
                    print("^7==============================")
                    print("^5[kodek-fakeid] ^7NEW UPDATE: ^2" .. remoteVersion .. "^7 | ^1CURRENT: ^1" .. localVersion .. " ^7>> Download new version from https://github.com/The-Kodah/kodek-fakeid")
                    print("^7==============================")
                else
                    print("^7==============================")
                    print("^5[kodek-fakeid] ^7You are on the latest version: ^2" .. localVersion)
                    print("^7==============================")
                end
            else
                print("^7==============================")
                print("^5[kodek-fakeid] ^7Failed to parse version from GitHub response.")
                print("^7==============================")
            end
        else
            print("^7==============================")
            print("^5[kodek-fakeid] ^7Failed to check for updates. Status code: ^1" .. statusCode)
            print("^7==============================")
        end
    end, "GET", "", {["Content-Type"] = "application/json"})
end

