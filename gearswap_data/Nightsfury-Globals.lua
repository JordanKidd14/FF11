-------------------------------------------------------------------
-- SETUP DUALBOX COMMANDS FOR NIGHTSFURY -----> VALENTUS / VRETIEL
--  Mod  Description
--  ^    Ctrl
--  !    Alt
--  @    Win
--  #    Apps
--  ~    Shift
-------------------------------------------------------------------

-- ATTACK!
send_command('bind numpad. sat allattack; wait 0.5; send @all /echo ALL ATTACK!')
--CMD:
send_command('bind !numpad. send @others /attack; wait 0.5; send @all /echo OFF ATTACK!')
--ALT:
send_command('bind ^numpad. send @thf "Rudra\'s Storm"; send @all /echo WS!')

-- SINGLE CURES
send_command('bind numpad1 send @others cure4 Nightsfury')
send_command('bind numpad2 send @others cure4 <me>; send @all /echo SELF cures')
send_command('bind numpad3 send @others cure4 <p3>')
send_command('bind numpad4 send @others cure4 <p4>')
send_command('bind numpad5 send @others cure4 <p5>')
send_command('bind numpad6 send @others cure4 <p6>')

-- AOE CURES
send_command('bind ^numpad1 send @others barwatera; send Nightsfury /echo INC Curaga;')
send_command('bind ^numpad2 send @others curaga II Nightsfury; send Nightsfury /echo INC Curaga II;')
send_command('bind ^numpad3 send @others curaga III Nightsfury; send Nightsfury /echo INC Curaga III;')
send_command('bind ^numpad4 send @others curaga IV Nightsfury; send Nightsfury /echo INC Curaga IV;')

--send_command('bind ^numpad4 send @whm curaga III Nightsfury; send Nightsfury /echo Curaga III;')
--send_command('bind ^numpad5 send @whm curaga III Nightsfury; send Nightsfury /echo Curaga III;')
--send_command('bind ^numpad6 send @whm curaga III Nightsfury; send Nightsfury /echo Curaga III;')

-- MOVEMENT
send_command('bind numpad7 send @others follow Nightsfury')
send_command('bind ^numpad7 send @others /sit')

-- DEBUFFS
send_command('bind numpad8 send Nightsfury /echo RDM Debuffs; sat youcommand @rdm Frazzle3; wait 5; sat youcommand @rdm Distract3; wait 5; sat youcommand @rdm Paralyze2; wait 5; sat youcommand @rdm Slow2; wait 5; sat youcommand @rdm Addle2; wait 5; sat youcommand @rdm Dia3;')
send_command('bind ^numpad8 send Nightsfury /echo BRD Debuffs; sat youcommand @brd CarnageElegy; wait 5; sat youcommand @brd PiningNocturne; wait 5; sat youcommand @brd FoeRequiem7; wait 4; sat youcommand @brd DarkThreondy;')
-- SLEEPS
send_command('bind !numpad8 send Nightsfury /echo Sleep! brd/geo; sat youcommand @brd hordelullaby2; wait 0.3; wait 0.3; sat youcommand @geo sleep2; wait 0.3;')

send_command('bind numpad9 send Nightsfury /echo Dispels rdm/brd/geo; sat youcommand @rdm dispel; wait 0.3; sat youcommand @brd MagicFinale; wait 0.3; sat youcommand @geo dispel;')
send_command('bind ^numpad9 send Nightsfury /echo Dia rdm/brd/geo/whm; sat youcommand @rdm dia3; wait 0.3; sat youcommand @brd dia2; wait 0.3; sat youcommand @geo dia2; swait 0.3; sat youcommand @whm dia2;')

-- BUFFS
send_command('bind ^numpad0 send @geo indi-fury; wait 6; send @geo blazeofglory; wait 1; sat youcommand @geo geo-frailty; wait 5; send @geo dematerialize; wait 2; send @geo eclipticattrition; wait 2; send @geo lifecycle; wait 1; sat youcommand @geo dia II; wait 0.5; send @all /echo ATK + BoG/EA Frailty done!')
--send_command('bind ^numpad0 send @geo indi-wilt; wait 6; send @geo blazeofglory; wait 1; sat youcommand @geo geo-malaise; wait 5; send @geo dematerialize; wait 2; send @geo eclipticattrition; wait 2; send @geo lifecycle; wait 1; sat youcommand @geo dia II; wait 0.5; send @all /echo ATK- + BoG/EA MDEF- done!')
--send_command('bind ^numpad0 send @geo indi-regen; wait 6; send @geo blazeofglory; wait 1; sat youcommand @geo geo-frailty; wait 5; send @geo dematerialize; wait 2; send @geo eclipticattrition; wait 2; send @geo lifecycle; wait 1; sat youcommand @geo dia II; wait 0.5; send @all /echo ATK- + BoG/EA MDEF- done!')
send_command('bind numpad0 send @geo indi-fury; wait 0.5; send @smn crimson howl')













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
    send_command('unbind numpad.')
    send_command('unbind numpad+')

    send_command('unbind ^numpad1')
    send_command('unbind ^numpad2')
    send_command('unbind ^numpad3')
    send_command('unbind ^numpad4')
    send_command('unbind ^numpad5')
    send_command('unbind ^numpad6')
    send_command('unbind ^numpad7')
    send_command('unbind ^numpad8')
    send_command('unbind ^numpad9')
    send_command('unbind ^numpad.')
    send_command('unbind ^numpad+')
end 
