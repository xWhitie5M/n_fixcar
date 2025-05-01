ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(100)
    end
end)

-- MechanicZone Funktion
function MechanicZone()
    local zonePosition = Config.ZonePos
    local hasInteracted = false
    local notified = false
    local blip = AddBlipForCoord(zonePosition.x, zonePosition.y, zonePosition.z)
    SetBlipSprite(blip, Config.BlipID)
    SetBlipDisplay(blip, 4)
    SetBlipScale(blip, Config.BlipScale)
    SetBlipColour(blip, Config.BlipColor)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(Config.BlipName)
    EndTextCommandSetBlipName(blip)

    while true do
        Citizen.Wait(0)

        local playerPed = PlayerPedId()
        local playerPos = GetEntityCoords(playerPed)
        local distance = #(playerPos - zonePosition)

        if distance < 20.0 then
            DrawMarker(
                1, zonePosition.x, zonePosition.y, zonePosition.z - 1.0,
                0.0, 0.0, 0.0, 0.0, 0.0, 0.0,
                6.0, 6.0, 0.5, 0, 255, 255, 150,
                false, true, 2, nil, nil, false
            )

            if distance < 1.5 and IsPedInAnyVehicle(playerPed, false) and not hasInteracted then
                if not notified then
                    ESX.ShowHelpNotification(Config.PressE)
                    notified = true
                end

                if IsControlJustPressed(1, 51) then
                    hasInteracted = true
                    if lib.progressCircle({
                        duration = Config.RepairTime,
                        position = 'middle',
                        useWhileDead = false,
                        canCancel = true,
                        disable = {
                            car = true,
                        },
                    }) then
                        local vehicle = GetVehiclePedIsIn(playerPed, false)
                        SetVehicleFixed(vehicle)
                        SetVehicleDirtLevel(vehicle, 0.0)

    TriggerServerEvent('mechanic:chargePlayer', Config.Price)
   -- ESX.ShowNotification("Dein Fahrzeug wurde repariert und 5000$ wurden abgezogen.")
                    else
                        print('Do stuff when cancelled')
                    end
                    hasInteracted = false
                end
            else
                notified = false
            end
        else
            hasInteracted = false
            Citizen.Wait(500)
        end
    end
end

Citizen.CreateThread(function()
    MechanicZone()
end)
