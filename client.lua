local QBCore = exports['qb-core']:GetCoreObject()
local options = {}

RegisterNetEvent('t_ring:client:createring', function()
    local input = lib.inputDialog('Create Custom Item', {
        { type = 'input', label = '名前', placeholder = 'xxxxxxxxxx', required = true },
        { type = 'input', label = '説明', placeholder = 'xxxxxxxxxx', required = false },
    })
    local name, description = table.unpack(input)
    TriggerEvent('t_ring:client:progress', name, description)
end)

CreateThread(function()
    while true do
        local pedCo = GetEntityCoords(PlayerPedId())
        local sleep = 1000
        local dist = #(pedCo - Config.Location)
        if dist <= 5.0 then
            sleep = 1
            if dist <= 3.0 then
                DrawText3D(Config.Location.x, Config.Location.y, Config.Location.z, "[E]指輪クラフト")
                if IsControlJustPressed(0, 38) then
                    TriggerEvent('t_ring:client:checkrecipi')
                    lib.showContext('ring_craft')
                end
            end
        end
        Citizen.Wait(sleep)
    end
end)

RegisterNetEvent('t_ring:client:checkrecipi', function()
    options = {}
    for i, recipi in ipairs(Config.CraftItem) do
        local item = exports.ox_inventory:Items(recipi.name)
        table.insert(options, {
            title = item.label,
            description = recipi.amout .. '個必要です',
            icon = 'flask',
            metadata = {
                { label = 'ID', value = 'Some value' },
            },
        })
    end
    table.insert(options, {
        title = '指輪を作る',
        description = 'オリジナル指輪を作る',
        icon = 'play',
        serverEvent = 't_ring:client:checkitem',
        arrow = true,
        args = {
            someValue = 500
        }
    })
    lib.registerContext({
        id = 'ring_craft',
        title = '指輪クラフト',
        options = options
    })
end)

RegisterNetEvent('t_ring:client:progress',function(name, description)
    if lib.progressBar({
        duration = 2000,
        label = '指輪を作っています',
        useWhileDead = false,
        canCancel = false,
        disable = {
            car = true,
            move = true,
            combat = true,
            sprint = true
        },
        anim = {
            dict = 'anim@amb@drug_processors@coke@female_a@idles',
            clip = 'idle_a'
        },
    }) then 
        TriggerServerEvent('t_ring:server:createRing', {
            name = name,
            description = description,
        })
    end
end)

function DrawText3D(x, y, z, text)
    SetTextScale(0.35, 0.35)
    SetTextFont(0)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    BeginTextCommandDisplayText('STRING')
    SetTextCentre(true)
    AddTextComponentSubstringPlayerName(text)
    SetDrawOrigin(x, y, z, 0)
    EndTextCommandDisplayText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0 + 0.0125, 0.017 + factor + 0.030, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end