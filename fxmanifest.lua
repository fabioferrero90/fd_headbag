fx_version "cerulean"
games "gta5"
lua54 "yes"

author "RealSly - FullDevs"
version "1.0.1"

client_script "cl_main.lua"
server_script "sv_main.lua"
shared_script "@ox_lib/init.lua"

ui_page "interface/interface.html"

files {
    "interface/*",
}