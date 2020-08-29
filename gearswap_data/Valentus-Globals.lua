-------------------------------------------------------------------
-- SETUP DUALBOX COMMANDS FOR VALENTUS -----> NIGHTSFURY / VRETIEL
-------------------------------------------------------------------
send_command('bind numpad7 send @others follow Valentus')
send_command('bind ^numpad7 send @others /sit')

-- SINGLE CURES
send_command('bind numpad1 send @others cure4 Valentus')
send_command('bind numpad2 send @others cure4 <me>; send Valentus /echo Self cure')
send_command('bind numpad3 send @others cure4 <p3>;')
send_command('bind numpad4 send @others cure4 <p4>')
send_command('bind numpad5 send @others cure4 <p5>')
send_command('bind numpad6 send @others cure4 <p6>')

-- AOE CURES
send_command('bind ^numpad1 send @whm curaga III Valentus; send Valentus /echo INC Curaga III;')
send_command('bind ^numpad2 send @whm curaga IV Valentus; send Valentus /echo INC Curaga IV;')
send_command('bind ^numpad3 send @whm curaga V Valentus; send Valentus /echo INC Curaga V;')


function file_unload()
    send_command('unbind numpad1')
    send_command('unbind numpad2')
    send_command('unbind numpad3')
    send_command('unbind numpad4')
    send_command('unbind numpad5')
    send_command('unbind numpad6')
    send_command('unbind numpad7')
    send_command('unbind numpad8')
    send_command('unbind numpad9')

    send_command('unbind ^numpad1')
    send_command('unbind ^numpad2')
    send_command('unbind ^numpad3')
    send_command('unbind ^numpad4')
    send_command('unbind ^numpad5')
    send_command('unbind ^numpad6')
    send_command('unbind ^numpad7')
    send_command('unbind ^numpad8')
    send_command('unbind ^numpad9')
end 