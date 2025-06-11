local function parseVersion(version)
    local parts = {}
    for num in version:gmatch("%d+") do
        table.insert(parts, tonumber(num))
    end
    return parts
end

local function compareVersions(current, newest)
    local currentParts = parseVersion(current)
    local newestParts = parseVersion(newest)
    for i = 1, math.max(#currentParts, #newestParts) do
        local c = currentParts[i] or 0
        local n = newestParts[i] or 0
        if c < n then return -1
        elseif c > n then return 1 end
    end
    return 0 -- equal
end

function CheckVersion()
    CreateThread(function()
        Wait(4000)
        local currentVersion =  GetResourceMetadata('t_ring', 'version', 0)
        PerformHttpRequest('https://raw.githubusercontent.com/take01a/t_versions/main/t_ring.txt', function(err, body, headers)
            if not body then
                print("^1バージョンチェックを実行できませんでした^7")
                return
            end
            local lines = {}
            for line in tostring(body):gmatch("[^\r\n]+") do
                table.insert(lines, line)
            end
            local newestVersionRaw = lines[1] or "0.0.0"
            local changelog = {}
            for i = 2, #lines do
                table.insert(changelog, lines[i])
            end
            local compareResult = compareVersions(currentVersion, newestVersionRaw)
            if compareResult == 0 then
                print("^7'^3t_version^7' - ^2最新のバージョンを使用しています^7. ^7(^3"..currentVersion.."^7)")
            elseif compareResult < 0 then
                print("^1----------------------------------------------------------------------^7")
                print("^7'^3t_version^7' - ^1あなたは古いバージョンを使用しています。^7! ^7(^3"..currentVersion.."^7 → ^3"..newestVersionRaw.."^7)")
            for _, line in ipairs(changelog) do
                print((line:find("http") and "^7" or "^5")..line)
            end
            print("^1----------------------------------------------------------------------^7")
            SetTimeout(1200000, function()
                CheckVersion()
            end)
            else
                print("^7'^3t_version^7' - ^5あなたはより新しいバージョンを使用しています。 ^7(^3"..currentVersion.."^7 ← ^3"..newestVersionRaw.."^7)")
            end
        end)
    end)
end

CheckVersion()