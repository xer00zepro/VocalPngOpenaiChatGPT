fx_version 'cerulean'
game 'gta5'

author 'xer00ze'
description 'Script basé sur intelligence artificielle et le chat GPT pour permettre aux PNJ de discuter avec les vrais joueurs'
version '1.0.0'

client_scripts {
    'client.lua',
    'data/peds.js',
    'data/convert-peds.js'
}

server_scripts {
    'server.lua',
    'data/personalities.json'
}

shared_scripts {
    'config.lua'
}
