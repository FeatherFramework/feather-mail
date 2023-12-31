fx_version 'adamant'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

game 'rdr3'
lua54 'yes'


author 'Bytesizd'
description 'Redm, NUI, Vuejs boilerplate'

client_script {
    'client/client.lua'
}

server_script {
    '@oxmysql/lib/MySQL.lua',
    '/server/server.lua'
}

ui_page {
    "ui/shim.html"
}

files {
    "ui/shim.html",
    "ui/js/*.*",
    "ui/css/*.*"
}

version '1.0.0'