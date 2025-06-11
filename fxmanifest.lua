fx_version 'cerulean'
game 'gta5'

author 'take'
description 'ox_inventory用オリジナルアイテム指輪スクリプト'
version '1.0.0'

shared_script {
    '@ox_lib/init.lua',
    'config.lua',
}

client_scripts {
    'client.lua',
}

server_script {
    'server.lua',
    'versioncheck.lua',
}

lua54 'yes'
