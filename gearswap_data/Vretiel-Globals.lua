-------------------------------------------------------------------
-- SETUP DUALBOX COMMANDS FOR Vretiel -----> NIGHTSFURY / VALENTUS
-------------------------------------------------------------------
send_command('bind numpad7 send @others follow Vretiel')
send_command('bind ^numpad7 send @others /sit')
function file_unload()
    send_command('unbind numpad7')
    send_command('unbind numpad8')
end
