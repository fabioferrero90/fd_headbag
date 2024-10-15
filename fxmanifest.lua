fx_version "cerulean";
games {"gta5"};
lua54 "yes";

client_script "cl_main.lua";
server_script "sv_main.lua";
shared_script "@ox_lib/init.lua";

ui_page "interface/interface.html";
files {
    "interface/*",
}

server_scripts { '@mysql-async/lib/MySQL.lua' }