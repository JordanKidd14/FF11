-------------------------------------------------------------------
-- SETUP DUALBOX COMMANDS FOR VALENTUS -----> NIGHTSFURY / VRETIEL
-------------------------------------------------------------------
send_command('bind numpad7 send @others follow Valentus')
send_command('bind ^numpad7 send @others /sit')
function file_unload()
    send_command('unbind numpad7')
end
