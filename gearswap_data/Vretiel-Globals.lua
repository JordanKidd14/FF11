-------------------------------------------------------------------
-- SETUP DUALBOX COMMANDS FOR Vretiel -----> NIGHTSFURY / VALENTUS
-------------------------------------------------------------------
send_command('bind numpad7 send @others follow Vretiel')
send_command('bind ^numpad7 send @others /sit')

-- BUFFS
send_command('bind numpad0 send @geo indi-fury; wait 6; send @geo blazeofglory; wait 1; sat youcommand @geo geo-frailty; wait 5; send @geo dematerialize; wait 2; send @geo eclipticattrition; wait 2; send @geo lifecycle; wait 1; sat youcommand @geo dia II; wait 0.5; send @all /echo ATK + BoG/EA Frailty done!')

function file_unload()
    send_command('unbind numpad7')
    send_command('unbind numpad8')
end
    