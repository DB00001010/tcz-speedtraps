Config = {}

-- Global Settings
Config.Global = {
    FlashEffect = true, -- Enable/disable flash effect
    DebugZones = false, -- Show zone markers for debugging (lib zones)
    Debug = false, -- Enale Debug Comments
    MetricSystem = "mph" -- Choose Metric System 'kph' or 'mph'
}

-- Notifications
Config.Notifications = {
    Title                           = "TCZ Speed Trap",
    Position                        = 'center-right', -- for ox_lib notification position
    Cooldown                        = "Calm down Speed Racer ! Even speed traps need a break. Try again later!",
    RemoveSuccess                   = "Thank You for your generous donation. Driving at {speed} {metric} just cost you ${amount}.",
    RemoveInsufficientFunds         = "Broke and fast, huh?! Flashing you is pointless...",
    AddSuccess                      = "Impressive driving! ${amount} in your bank for not being a maniac!"
}

-- --- SOUND LIBRARY https://gist.github.com/Sainan/021bd2f48f1c68d3eb002caab635b5a4
-- EXAMPLE:                                     NAME                SET
--          AUDIO::PLAY_SOUND_FRONTEND(-1, "Camera_Shoot", "Phone_Soundset_Franklin", true);

-- Speed Traps
Config.SpeedTraps = {
    {
        ZoneName = "Pillbox Hill Hospital",
        Enabled = true, -- Enable/disable the zone
        Coords = vector3(262.1, -582.13, 43.36),
        Radius = 50.0, -- Detection radius
        Cooldown = 10, -- Cooldown in seconds (I recommend setting this higher to prevent abuse)
        RestrictedPlates = { "LSPD", "EMS" }, -- Plates that won't trigger the trap
        Blip = {
                Enabled = true,
                Sprite = 604,  
                Color = 49,
                Text = "Pillbox Hill Speed Trap",
                Scale = 0.7
            },
        SpeedThresholds = {
            {
                Speed = 35,
                Action = "add",
                Amount = 100,
                Sound = { Name = "ROBBERY_MONEY_TOTAL", Set = "HUD_FRONTEND_CUSTOM_SOUNDSET", Volume = 1.5 }   
            },
            {
                Speed = 70,
                Action = "remove",
                Amount = 200,
                Sound = { Name = "Camera_Shoot", Set = "Phone_Soundset_Franklin", Volume = 2.0 } 
            }
        },
    },
    {
        ZoneName = "Mission Row",
        Enabled = true, -- Enable/disable the zone
        Coords = vector3(219.09, -1042.67, 28.73),
        Radius = 50.0, -- Detection radius
        Cooldown = 10, -- Cooldown in seconds
        RestrictedPlates = { "LSPD", "EMS" }, -- Plates that won't trigger the trap
        Blip = {
                Enabled = true,
                Sprite = 604,
                Color = 49,
                Text = "Mission Row Speed Trap",
                Scale = 0.7
            },
        SpeedThresholds = {
            {
                Speed = 35,
                Action = "add",
                Amount = 100,
                Sound = { Name = "ROBBERY_MONEY_TOTAL", Set = "HUD_FRONTEND_CUSTOM_SOUNDSET", Volume = 1.5 } 
            },
            {
                Speed = 70,
                Action = "remove",
                Amount = 200,
                Sound = { Name = "Camera_Shoot", Set = "Phone_Soundset_Franklin", Volume = 2.0 } 
            }
        },
    },
    {
        ZoneName = "Del Perro FWY",
        Enabled = true, -- Enable/disable the zone
        Coords = vector3(-2168.24, -349.88, 13.17),
        Radius = 50.0, -- Detection radius
        Cooldown = 10, -- Cooldown in seconds
        RestrictedPlates = { "LSPD", "EMS" }, -- Plates that won't trigger the trap
        Blip = {
                Enabled = true,
                Sprite = 604,
                Color = 49,
                Text = "Del Perro Speed Trap",
                Scale = 0.7
            },
        SpeedThresholds = {
            {
                Speed = 70,
                Action = "add",
                Amount = 100,
                Sound = { Name = "ROBBERY_MONEY_TOTAL", Set = "HUD_FRONTEND_CUSTOM_SOUNDSET", Volume = 1.5 } 
            },
            {
                Speed = 100,
                Action = "remove",
                Amount = 200,
                Sound = { Name = "Camera_Shoot", Set = "Phone_Soundset_Franklin", Volume = 2.0 } 
            }
        },
    },
    {
        ZoneName = "Los Santos FWY",
        Enabled = true, -- Enable/disable the zone
        Coords = vector3(1292.65, 585.04, 80.16),
        Radius = 50.0, -- Detection radius
        Cooldown = 10, -- Cooldown in seconds
        RestrictedPlates = { "LSPD", "EMS" }, -- Plates that won't trigger the trap
        Blip = {
                Enabled = true,
                Sprite = 604,
                Color = 49,
                Text = "Los Santos FWY Speed Trap",
                Scale = 0.7
            },
        SpeedThresholds = {
            {
                Speed = 70,
                Action = "add",
                Amount = 100,
                Sound = { Name = "ROBBERY_MONEY_TOTAL", Set = "HUD_FRONTEND_CUSTOM_SOUNDSET", Volume = 1.5 } 
            },
            {
                Speed = 100,
                Action = "remove",
                Amount = 200,
                Sound = { Name = "Camera_Shoot", Set = "Phone_Soundset_Franklin", Volume = 2.0 } 
            }
        },
    },
    --- ADD MORE BELOW HERE

}
