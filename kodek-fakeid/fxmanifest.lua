fx_version   'cerulean'
use_experimental_fxv2_oal 'yes'
lua54        'yes'
game         'gta5'

name         'kodek-fakeid'
version      '1.1.0'
author       'Kodah'
repository   'https://github.com/The-Kodah/kodah-fakeid'

client_scripts {
	'config.lua',
	'client/cl_main.lua',
	'@qbx_core/modules/playerdata.lua'
}

escrow_ignore {
    'config.lua'
  }

server_script {
    'server/sv_main.lua',
    'server/kodekupdate.lua'
}

shared_scripts {
    'config.lua',
	'@ox_lib/init.lua'
}

dependencies {
    'qbx_core',
    'ox_target'
}
