fx_version 'cerulean'
game 'gta5'
lua54 'yes'
-- Resource Metadata
author 'TCZ'
description 'TCZ Speed Trap Script'
version '1.0.0'

-- Shared Configuration
shared_script 'config.lua'
shared_script '@ox_lib/init.lua'

-- Client Scripts
client_script 'client/main.lua'

-- Server Scripts
server_script 'server/main.lua'

-- Dependencies
dependencies {
    'ox_lib',
    'qb-core'
}
