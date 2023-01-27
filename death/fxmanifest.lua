fx_version "cerulean"
game "rdr3"
lua54 "yes"

rdr3_warning "I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships."

ui_page "web-side/index.html"

files {
    "web-side/*",
    "web-side/**/*"
}

client_scripts {
	"@zRP/lib/utils.lua", -- change @ to vRP or your framework name
    "config.lua",
    "client-side/*"
}