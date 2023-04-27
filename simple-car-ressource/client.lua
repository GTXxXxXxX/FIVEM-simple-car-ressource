RegisterCommand('car', function(source, args, rawCommand)
    local playerPed = PlayerPedId()
    local playerPosition = GetEntityCoords(playerPed)
    local playerHeading = GetEntityHeading(playerPed)
    local vehicleName = args[1]

        if IsModelAVehicle(vehicleName) then
            print('Valid input')
        else 
            print('Invalid')
            return
        end

    local vehicleHash = GetHashKey(vehicleName)

        if IsModelValid(vehicleHash) then
            print('Hash valid')
        else
            print('Hash invalid')
            return
        end

    RequestModel(vehicleHash)

        while not HasModelLoaded(vehicleHash) do
            Citizen.Wait(10)
        end

    ClearAreaOfVehicles(playerPosition.x, playerPosition.y, playerPosition.z, 500.0, false, false, false, false, false)

        if IsPedInAnyVehicle(playerPed, false) then
            local pedVehicle = GetVehiclePedIsIn(playerPed, false)
            DeleteVehicle(pedVehicle)
        else
            print('Not in a vehicle')
        end

    local spawnVehicle = CreateVehicle(vehicleHash, playerPosition, playerHeading, true, false)
    
    TaskWarpPedIntoVehicle(playerPed, spawnVehicle, -1)
    SetModelAsNoLongerNeeded(vehicleHash)
end, false)