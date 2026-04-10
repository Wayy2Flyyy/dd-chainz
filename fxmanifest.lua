fx_version 'cerulean'
game 'gta5'
lua54 'yes'

name 'dd_chains'
author 'Daniel'
description 'Basic ox_inventory chain item system'
version '1.0.0'

shared_scripts {
    '@ox_lib/init.lua'
}

client_scripts {
    'client.lua'
}

server_scripts {
    'server.lua'
}

dependencies {
    'ox_inventory',
    'ox_lib'
}
