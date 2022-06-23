fx_version 'adamant'

game 'gta5'

description 'ESX RP Chat'

author '😈 𝐀𝐍𝐔𝐄𝐋 𝐀𝐀 😈#6979'

version '1.0'

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'@es_extended/locale.lua',
	'locales/*.lua',
	'shared/*.lua',
	'server/*.lua'
}

client_scripts {
	'@es_extended/locale.lua',
	'locales/*.lua',
	'shared/*.lua',
	'client/*.lua'
}

dependency 'es_extended'
