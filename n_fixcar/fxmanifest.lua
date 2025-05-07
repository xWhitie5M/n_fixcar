fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'xWhitie'
description 'Simple Car Fix'
version '1.0.0'

shared_script 'config.lua'

client_scripts {
    '@ox_lib/init.lua',
    'client.lua'
}

server_script 'server.lua'

dependencies {
    'ox_lib'
}