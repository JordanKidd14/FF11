-------------------------------------------------------------------
-- SETUP DUALBOX COMMANDS FOR NIGHTSFURY -----> VALENTUS / VRETIEL
--  Mod  Description
--  ^    Ctrl
--  !    Alt
--  @    Win
--  #    Apps
--  ~    Shift

-------------------------------------------------------------------
send_command('bind numpad1 send @others cure4 Nightsfury')
send_command('bind numpad2 send @others cure4 <me>')
send_command('bind numpad3 send @others cure4 <p3>')
send_command('bind numpad4 send @others cure4 <p4>')
send_command('bind numpad5 send @others cure4 <p5>')
send_command('bind numpad6 send @others cure4 <p6>')

send_command('bind ^numpad1 send @whm curaga III Nightsfury')
send_command('bind ^numpad2 send @whm curaga IV Nightsfury')
send_command('bind ^numpad3 send @whm curaga V Nightsfury')
send_command('bind ^numpad4 send @whm curaga III Nightsfury')
send_command('bind ^numpad5 send @whm curaga III Nightsfury')
send_command('bind ^numpad6 send @whm curaga III Nightsfury')

send_command('bind numpad7 send @others follow Nightsfury')
send_command('bind ^numpad7 send @others /sit')
send_command('bind numpad9 send @rdm dispel <bt>; send @brd Magic Finale <bt>; send @whm Dia II <bt>; send @rdm Dia III <bt>')
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
end 
