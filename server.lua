local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('t_ring:server:createRing', function(data)
    local src = source
    local item = exports.ox_inventory:Items(Config.RingItem)
    local name = data.name or item.label
    local desc = data.description or item.description
    -- local image = data.image or 'default.png'
    for i, item in ipairs(Config.CraftItem) do
        local count = exports.ox_inventory:Search(src, 'count', item.name)
        if count < item.amout then
            local data = exports.ox_inventory:Items(item.name)
            QBCore.Functions.Notify(source, 'アイテムが足りません', 'error', 5000)
            return
        elseif count > item.amout or  count == item.amout then
            exports.ox_inventory:RemoveItem(src, item.name, item.amout)
        else
            return
        end
    end
    exports.ox_inventory:AddItem(src, Config.RingItem, 1, {
        label = name,
        description = desc,
        image = image,
    })
end)

AddEventHandler('ox_inventory:createItem', function(payload)
    if payload.item.name == Config.RingItem and payload.metadata then
        return {
            label = payload.metadata.label,
            description = payload.metadata.description,
            -- image = payload.metadata.image
        }
    end
end)

RegisterNetEvent('t_ring:client:checkitem', function()
    local src = source
    for i, item in ipairs(Config.CraftItem) do
        local count = exports.ox_inventory:Search(src, 'count', item.name)
        if count < item.amout then
            local data = exports.ox_inventory:Items(item.name)
            QBCore.Functions.Notify(source, 'アイテムが足りません', 'error', 5000)
            return
        end
    end
    TriggerClientEvent('t_ring:client:createring', source)
end)