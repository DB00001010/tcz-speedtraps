local QBCore = exports['qb-core']:GetCoreObject()

-- Table to track cooldowns for each player and trap
local activeCooldowns = {}

-- Function to handle speed trap logic
local function handleSpeedTrap(src, trap, speed)
    local player = QBCore.Functions.GetPlayer(src)
    if not player then return end

    -- Check if player is on cooldown for this trap
    if activeCooldowns[src] and activeCooldowns[src][trap.ZoneName] then
        TriggerClientEvent('ox_lib:notify', src, {
            title = Config.Notifications.Title,
            position = Config.Notifications.Position,
            description = Config.Notifications.Cooldown,
            type = "error",
            duration = 5000
        })
        return
    end

    -- Check for restricted plates
    local vehicle = GetVehiclePedIsIn(GetPlayerPed(src), false)
    local plate = GetVehicleNumberPlateText(vehicle)
    if plate and trap.RestrictedPlates then
        for _, restrictedPlate in ipairs(trap.RestrictedPlates) do
            if string.find(plate:upper(), restrictedPlate:upper()) then
                return -- Skip the trap logic if the plate is restricted
            end
        end
    end

    -- Determine the highest matching threshold
    local selectedThreshold = nil
    for _, threshold in ipairs(trap.SpeedThresholds) do
        if speed >= threshold.Speed then
            selectedThreshold = threshold
        end
    end

    if not selectedThreshold then return end

    -- Handle the action
    if selectedThreshold.Action == "remove" then
        local bankBalance = player.PlayerData.money['bank']

        if bankBalance >= selectedThreshold.Amount then
            -- Deduct the money
            player.Functions.RemoveMoney('bank', selectedThreshold.Amount, 'speed-trap-penalty')
            TriggerClientEvent('ox_lib:notify', src, {
                title = Config.Notifications.Title,
                position = Config.Notifications.Position,
                description = Config.Notifications.RemoveSuccess
                    :gsub("{speed}", tostring(math.floor(speed)))
                    :gsub("{amount}", tostring(selectedThreshold.Amount))
                    :gsub("{metric}", tostring(Config.Global.MetricSystem)),
                type = "error",
                duration = 5000
            })
        else
            -- Not enough money, send playful notification
            TriggerClientEvent('ox_lib:notify', src, {
                title = Config.Notifications.Title,
                position = Config.Notifications.Position,
                description = Config.Notifications.RemoveInsufficientFunds,
                type = "inform",
                duration = 5000
            })
        end
    elseif selectedThreshold.Action == "add" then
        player.Functions.AddMoney('bank', selectedThreshold.Amount, 'speed-trap-reward')
        TriggerClientEvent('ox_lib:notify', src, {
            title = Config.Notifications.Title,
            position = Config.Notifications.Position,
            description = Config.Notifications.AddSuccess
                :gsub("{amount}", tostring(selectedThreshold.Amount)),
            type = "success",
            duration = 5000
        })
    end

    -- Debugging to confirm the action
    if Config.Global.Debug then
        print(string.format("Speed trap triggered: %s | Speed: %s | Action: %s | Amount: %s", trap.ZoneName, speed, selectedThreshold.Action, selectedThreshold.Amount))
    end

    -- Set cooldown for the player
    activeCooldowns[src] = activeCooldowns[src] or {}
    activeCooldowns[src][trap.ZoneName] = true
    SetTimeout(trap.Cooldown * 1000, function()
        activeCooldowns[src][trap.ZoneName] = nil
    end)
end

-- Event to process speed trap trigger
RegisterNetEvent('tcz-speedtraps:server:trigger', function(trapZone, speed)
    local src = source
    for _, trap in ipairs(Config.SpeedTraps) do
        if trap.ZoneName == trapZone and trap.Enabled then
            handleSpeedTrap(src, trap, speed)
            return
        end
    end
    -- print("Invalid or disabled speed trap triggered: ", trapZone)
end)
