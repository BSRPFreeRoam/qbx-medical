fx_version 'cerulean'
game 'gta5'
author 'Bacon_Space'
description 'qbx_medical'
repository 'https://github.com/Qbox-project/qbx_medical'
version '1.0.0'

ox_lib 'locale'

shared_scripts {
    '@ox_lib/init.lua',
    'shared/**/*.lua',
}

client_scripts {
    '@qbx_core/modules/playerdata.lua',
    'client/ui.lua',
    'client/clothing.lua',
    'client/damage/apply-damage-effects.lua',
    'client/damage/damage.lua',
    'client/dead.lua',
    'client/laststand.lua',
    'client/load-unload.lua',
    'client/main.lua',
    'client/setdownedstate.lua',
    'client/wounding.lua',
}

server_scripts {
    'server/main.lua',
}

files {
    'locales/*.json',
    'config/client.lua',
    'config/shared.lua',
    'ui/index.html',
    'ui/style.css',
    'ui/app.js',
}

ui_page 'ui/index.html'

--dependencies {
 --   'ox_lib',
  --  'qbx_core',
-- }

lua54 'yes'
use_experimental_fxv2_oal 'yes'
