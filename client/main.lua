local QBCore = exports['qb-core']:GetCoreObject()

local speed = 0

--  Function to create blip
local function createBlipForTrap(trap)
    if not trap.Blip or not trap.Blip.Enabled then return end

    local blip = AddBlipForCoord(trap.Coords.x, trap.Coords.y, trap.Coords.z)
    SetBlipSprite(blip, trap.Blip.Sprite or 161) -- Default sprite
    SetBlipDisplay(blip, 4) -- Display on map
    SetBlipScale(blip, trap.Blip.Scale or 0.8)
    SetBlipColour(blip, trap.Blip.Color or 1)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName(trap.Blip.Text or "Speed Trap")
    EndTextCommandSetBlipName(blip)
end

-- Function to play sound
local function playSound(sound)
    if not sound or not sound.Name or not sound.Set then
        if Config.Global.Debug then
            print("Error: Invalid sound configuration. Skipping playback.")
        end
        return
    end
    if Config.Global.Debug then
        print(string.format("Playing sound: %s from set: %s with volume: %.1f", sound.Name, sound.Set, sound.Volume or 1.0))
    end
    PlaySoundFrontend(-1, sound.Name, sound.Set, true)
end

-- Function to play a flash effect
local function playFlashEffect()
    StartScreenEffect("SuccessNeutral", 0, false)
    Citizen.Wait(300)
    StopScreenEffect("SuccessNeutral")
end

-- Function to monitor player speed within a zone
local function monitorSpeedTrap(trap)
    local playerPed = PlayerPedId()
    if IsPedInAnyVehicle(playerPed, false) then
        local vehicle = GetVehiclePedIsIn(playerPed, false)
        local plate = GetVehicleNumberPlateText(vehicle)
        if Config.Global.MetricSystem == 'mph' then
            speed = GetEntitySpeed(vehicle) * 2.236936 -- Convert m/s to mph
        else
            speed = GetEntitySpeed(vehicle) * 3.6 -- Convert m/s to kph
        end
        -- Check for restricted plates
        if plate and trap.RestrictedPlates then
            for _, restrictedPlate in ipairs(trap.RestrictedPlates) do
                if string.find(plate:upper(), restrictedPlate:upper()) then
                    if Config.Global.Debug then
                        print("Whitelisted plate detected:", plate) -- Debug log
                    end
                    return -- Exit early for whitelisted plates
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

        if selectedThreshold then
            if Config.Global.Debug then
                print("Selected Threshold Sound Config:", selectedThreshold.Sound) -- Debug log
            end
            playFlashEffect()
            playSound(selectedThreshold.Sound)

            -- Notify server about the speed trap trigger
            TriggerServerEvent('tcz-speedtraps:server:trigger', trap.ZoneName, math.floor(speed))
            if Config.Global.Debug then
                print(string.format("Speed Trap Triggered: Zone: %s | Speed: %d mph | Threshold: %d mph", trap.ZoneName, math.floor(speed), selectedThreshold.Speed))
            end
        else
            if Config.Global.Debug then
                print("No threshold selected for speed:", math.floor(speed))
            end
        end
    end
end

-- Function to set up zones
local function setupZones()
    for _, trap in ipairs(Config.SpeedTraps) do
        if trap.Enabled then
            -- Create Zone
            lib.zones.sphere({
                coords = trap.Coords,
                radius = trap.Radius,
                debug = Config.Global.DebugZones,
                onEnter = function()
                    monitorSpeedTrap(trap)
                end
            })
            -- Create the blip if enabled
            createBlipForTrap(trap)
        end
    end
end

-- Initialize speed traps
CreateThread(function()
    setupZones()
end)
