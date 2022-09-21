fx_version 'adamant'

game 'gta5'

description 'nv-winkels'


ui_page "html/index.html"

server_scripts {
	'server/sv-shop.lua',
	'config.lua'
}


client_scripts {
	'nui.lua',
	'config.lua'
}

files {
	"html/index.html",
	"html/index.css",
	"html/index.js",
	"html/fontawesome.js",
	"html/wave.png",
	"html/spullen/*.png",
}
