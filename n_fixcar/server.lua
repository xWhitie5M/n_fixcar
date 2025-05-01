ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


RegisterNetEvent('mechanic:chargePlayer')
AddEventHandler('mechanic:chargePlayer', function(amount)
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.getMoney() >= amount then
        xPlayer.removeMoney(amount)
        TriggerClientEvent('ox_lib:notify', source, {type = 'success', description = Config.Repaired})
    else
        TriggerClientEvent('ox_lib:notify', source, {type = 'error', description = Config.NotEnoughMoney})
    end
end)
