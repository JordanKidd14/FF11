include('Nightsfury-Globals.lua')

function get_sets()

    --Idle Sets--
    sets.Idle = {
        main="Lionheart",
        sub="Refined Grip +1",
        ammo="Staunch Tathlum",
        head="Runeist's Bandeau +3",
        body="Runeist's Coat +3",
        hands="Turms Mittens +1",
        legs="Carmine Cuisses +1",
        feet="Turms Leggings +1",
        neck="Warder's Charm +1",
        waist="Ioskeha Belt +1",
        left_ear="Odnowa Earring +1",
        right_ear="Cryptic Earring",
        left_ring="Moonbeam Ring",
        right_ring="Defending Ring",
        back={ name="Ogma's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Phys. dmg. taken-10%',}},
    }

    sets.TP = {}

    TP_ind = 3
    sets.TP.index = {'TP', 'Hybrid', 'EleResist', 'StatusARes', 'Physical', 'DT', 'MPConv' }

    Idle_ind = 1
    sets.Idle.index = { 'Standard', 'DT' }

    --offensive melee set
    sets.TP.TP = {
        sub="Utu Grip",
        ammo="Ginsen",
        head={ name="Herculean Helm", augments={'"Dbl.Atk."+2','"Triple Atk."+3','Weapon skill damage +4%','Mag. Acc.+16 "Mag.Atk.Bns."+16',}},
        body="Ayanmo Corazza +2",
        hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
        legs={ name="Samnuha Tights", augments={'STR+8','DEX+9','"Dbl.Atk."+3','"Triple Atk."+2',}},
        feet="Turms Leggings +1",
        neck="Lissome Necklace",
        waist="Ioskeha Belt +1",
        left_ear="Cessance Earring",
        right_ear="Sherida Earring",
        left_ring="Petrov Ring",
        right_ring="Ilabrat Ring",
        back={ name="Ogma's cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
    }

    --high accuracy/DT hybrid set
    sets.TP.Hybrid = {
        sub="Utu Grip",
        ammo="Ginsen",
        head="Aya. Zucchetto +2",
        body="Ayanmo Corazza +2",
        hands="Turms Mittens +1",
        legs={ name="Samnuha Tights", augments={'STR+8','DEX+9','"Dbl.Atk."+3','"Triple Atk."+2',}},
        feet="Turms Leggings +1",
        neck="Twilight Torque",
        waist="Ioskeha Belt +1",
        left_ear="Odnowa Earring +1",
        right_ear="Sherida Earring",
        left_ring="Defending Ring",
        right_ring="Moonbeam Ring",
        back={ name="Ogma's cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
    }

    --full DT melee set (all dt set)
    sets.TP.DT = {
        sub="Refined Grip +1",
        ammo="Staunch Tathlum",
        head="Aya. Zucchetto +2",
        body="Ayanmo Corazza +2",
        hands="Aya. Manopolas +2",
        legs="Aya. Cosciales +2",
        feet="Aya. Gambieras +2",
        neck="Twilight Torque",
        waist="Ioskeha Belt +1",
        left_ear="Sherida Earring",
        right_ear="Odnowa Earring +1",
        left_ring="Defending Ring",
        right_ring="Moonbeam Ring",
        -- back={ name="Ogma's cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
        back={ name="Ogma's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Phys. dmg. taken-10%',}},
    }

    sets.IdleDT = sets.TP.DT

    --MDT melee set (Magic def)
    sets.TP.EleResist = {
        ammo="Staunch Tathlum",
        head="Runeist's Bandeau +3",
        neck="Warder's Charm +1",
        left_ear="Odnowa Earring +1",
        right_ear="Ethereal Earring",
        body="Runeist's Coat +3",
        hands="Turms Mittens +1",
        ring1="Defending Ring",
        ring2="Moonbeam Ring",
        back={ name="Ogma's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Phys. dmg. taken-10%',}},
        waist="Engraved Belt",
        legs="Eri. Leg Guards +1",
        feet="Turms Leggings +1"
    }

    -- MP refresh / convert damage to MP set
    sets.TP.MPConv = {
        ammo="Staunch Tathlum",
        right_ear="Ethereal Earring",  --3 conv
        body="Erilaz Surcoat +1", --6 conv
        neck="Warder's Charm +1",
        head="Runeist's Bandeau +3",
        hands="Turms Mittens +1",
        left_ear="Odnowa Earring +1",
        ring1="Moonbeam Ring",
        ring2="Vocane Ring",
        back={ name="Ogma's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Phys. dmg. taken-10%',}},  -- ---> Ogma's Cape + 3% parry base chance
        waist="Flume Belt",  --2 conv
        legs="Eri. Leg Guards +1",  -- +2% parry chance base
        feet="Turms Leggings +1"  -- Turms Leggings? SU 3 Parry chance + 5
    }

    sets.TP.StatusARes = {
        ammo="Staunch Tathlum",
        head="Runeist's Bandeau +3",
        body="Runeist's Coat +3",
        hands="Turms Mittens +1",
        legs="Rune. Trousers +2",
        feet="Turms Leggings +1",
        neck="Warder's Charm +1",
        waist="Engraved Belt",
        left_ear="Hearty Earring",
        right_ear="Ethereal Earring",
        left_ring="Moonbeam Ring",
        right_ring="Defending Ring",
        back={ name="Ogma's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Phys. dmg. taken-10%',}},
    }

    sets.TP.Physical = {
        --main={ name="Aettir", augments={'Accuracy+70','Mag. Evasion+50','Weapon skill damage +10%',}},
        --sub="Refined Grip +1",
        ammo="Staunch Tathlum",
        head="Aya. Zucchetto +2",
        body="Ayanmo Corazza +2",
        hands="Turms Mittens +1",
        legs="Eri. Leg Guards +1",
        feet="Turms Leggings +1",
        neck="Twilight Torque",
        waist="Ioskeha Belt +1",
        left_ear="Odnowa Earring +1",
        right_ear="Ethereal Earring",
        left_ring="Moonbeam Ring",
        right_ring="Defending Ring",
        back={ name="Ogma's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Phys. dmg. taken-10%',}},
    }

    sets.Idle.Standard = sets.Idle

	sets.Idle.DT = sets.TP.DT

    --Weaponskill Sets--
    sets.WS = {}

    --multi, carries FTP
    sets.Resolution = {
        ammo="Knobkierrie",
        head={ name="Herculean Helm", augments={'"Dbl.Atk."+2','"Triple Atk."+3','Weapon skill damage +4%','Mag. Acc.+16 "Mag.Atk.Bns."+16',}},
        body={ name="Herculean Vest", augments={'Accuracy+11 Attack+11','Weapon skill damage +4%','STR+15','Attack+6',}},
        hands="Meg. Gloves +2",
        legs="Meg. Chausses +1",
        feet="Meg. Jam. +2",
        neck="Caro Necklace",
        waist="Ioskeha Belt +1",
        left_ear="Sherida Earring",
        right_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
        left_ring="Epona's Ring",
        right_ring="Ilabrat Ring",
        back={ name="Ogma's cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
    }

    --single, doesn't carry FTP (Dimidiation set)
    sets.Single = {
        ammo="Knobkierrie",
        head={ name="Herculean Helm", augments={'"Dbl.Atk."+2','"Triple Atk."+3','Weapon skill damage +4%','Mag. Acc.+16 "Mag.Atk.Bns."+16',}},
        body={ name="Herculean Vest", augments={'Accuracy+11 Attack+11','Weapon skill damage +4%','STR+15','Attack+6',}},
        hands="Meg. Gloves +2",
        feet="Meg. Jam. +2",
        neck="Caro Necklace",
        waist="Grunfeld Rope",
        left_ear="Cessance Earring",
        right_ear="Sherida Earring",
        left_ring="Ilabrat Ring",
        right_ring="Petrov Ring",
        back={ name="Ogma's cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
    }

    --single hit, benefits from DA
    sets.Cleave = sets.Resolution
    --added effect
    sets.Shockwave = sets.Resolution
    --Requiescat
    sets.Req = sets.Resolution
    --crit based
    sets.Vorp = sets.Resolution


    sets.Utility = {}

    --full PDT set for when stunned, etc.
    sets.Utility.PDT = {
        sub="Refined Grip +1",
        ammo="Staunch Tathlum",
        head="Aya. Zucchetto +2",
        body={ name="Futhark Coat +1", augments={'Enhances "Elemental Sforzo" effect',}},
        hands="Aya. Manopolas +2",
        legs="Eri. Leg Guards +1",
        feet="Aya. Gambieras +2",
        neck="Warder's Charm +1",
        waist="Flume Belt",
        left_ear="Odnowa Earring +1",
        right_ear="Ethereal Earring",
        left_ring="Moonbeam Ring",
        right_ring="Defending Ring",
        back={ name="Ogma's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Phys. dmg. taken-10%',}},
    }

    --full MDT set for when stunned, etc
    sets.Utility.MDT = {
        ammo="Staunch Tathlum",
        head="Dampening Tam",
        neck="Twilight Torque",
        left_ear="Odnowa Earring +1",
        right_ear="Zennaroi Earring",
        body="Runeist's Coat +3",
        hands="Erilaz Gauntlets +1",
        ring1="Vocane Ring",
        ring2="Defending Ring",
        back={ name="Ogma's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Phys. dmg. taken-10%',}},
        waist="Flume Belt",
        legs="Rune. Trousers +2",
        feet="Turms Leggings +1"
    }

    --Job Ability Sets--
    sets.JA = {}
    sets.JA.Lunge = {
        ammo="Staunch Tathlum",
        head={ name="Herculean Helm", augments={'Mag. Acc.+21','Pet: INT+9','INT+7 MND+7 CHR+7','Accuracy+18 Attack+18','Mag. Acc.+18 "Mag.Atk.Bns."+18',}},
        body={ name="Samnuha Coat", augments={'Mag. Acc.+13','"Mag.Atk.Bns."+14','"Fast Cast"+3','"Dual Wield"+4',}},
        hands={ name="Carmine Fin. Ga.", augments={'Rng.Atk.+15','"Mag.Atk.Bns."+10','"Store TP"+5',}},
        legs={ name="Herculean Trousers", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','"Fast Cast"+4','INT+7','"Mag.Atk.Bns."+9',}},
        feet={ name="Herculean Boots", augments={'Mag. Acc.+18 "Mag.Atk.Bns."+18','Crit.hit rate+1','Mag. Acc.+14','"Mag.Atk.Bns."+14',}},
        neck="Sanctity Necklace",
        waist="Eschan Stone",
        left_ear="Hecate's Earring",
        right_ear="Hermetic Earring",
        left_ring="Locus Ring",
        right_ring="Mujin Band",
        back={ name="Evasionist's Cape", augments={'Enmity+6','"Embolden"+14','"Dbl.Atk."+2','Damage taken-3%',}},
    }

    sets.HercSlash =  sets.JA.Lunge

    sets.JA.Vallation = {
        body="Runeist's Coat +3", 
        legs="Futhark Trousers +1", 
        back={ name="Ogma's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Phys. dmg. taken-10%',}},
    }
    sets.JA.Gambit = {hands="Runeist mitons"}
    sets.JA.Rayke = {}
    sets.JA.Battuta = { head="Futhark Bandeau +1" }
    sets.JA.Pflug = { feet="Runeist's Boots +2", }   -- check spelling?
    sets.JA.Pulse = {
        head="Erilaz Galea +1",
        legs="Rune. Trousers +2",
        neck="Incanter's Torque",
    }

    --Precast Sets--
    --Fast Cast set
    sets.precast = {
        ammo="Sapience Orb", --2
        body={ name="Taeon Tabard", augments={'"Fast Cast"+3',}}, -- 7
        head="Runeist's Bandeau +3", -- 14 fc
        hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}}, --8
        legs="Aya. Cosciales +2", --6
        ring1="Kishar Ring", -- 4
        neck="Baetyl Pendant",  --4
    }

    sets.Phalanx = {
        head="Futhark Bandeau +1",
        neck="Incanter's Torque",
        legs="Carmine Cuisses +1",
        hands="Runeist Mitons",
        right_ring="Stikini Ring +1",
    }

    --Enmity set for high hate generating spells and JAs
    sets.Enmity =  {  -- 67
        left_ear="Friomisi earring",  -- 2
        feet="Ahosi Leggings",  -- 7
        body="Emet Harness",  --  9
        head="Rabid Visor",  -- 6
        hands="Nilas Gloves", -- 5
		right_ear="Friomisi Earring",  --2
		left_ear="Cryptic Earring",  -- 4
        left_ring="Supershear Ring",  -- 5
        right_ring="Petrov Ring",  -- 4
        ammo="Aqreqaq Bomblet",  -- 2
        neck="Warder's Charm +1",  -- 1~8
        legs="Eri. Leg Guards +1",  -- 11
    }

    --Magic acc for enfeebles, handy for VW
    sets.MagicAcc = {

    }

    sets.TP.TH =  set_combine(sets.TP.EleResist, {
        waist="Chaac Belt",
        head="Wh. Rarab Cap +1",
    })

    --Toggle TP sets button, change if you want; currently ALT+F9 toggles forward, CTRL+F9 toggles backwards
    send_command('bind !f9 gs c toggle TP set')
    send_command('bind ^f9 gs c reverse TP set')
    send_command('bind f12 gs c toggle Idle set')

    --other stuff, don't touch
    ShadowType = 'None'
end

equipSet = {}

--Unload Binds
function file_unload()
    send_command('unbind f12')
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

function ChangeGear(GearSet)
	equipSet = GearSet
	equip(GearSet)
end

--the following section looks at the weather/day to see if the Hachirin-no-Obi is worth using
--add the following line to a section to have it check the element and equip the obi:
-->>>  mid_obi(spell.element,spell.name)
function mid_obi(spelement,spellname)
    if spelement == nil then
        spelement = "Light"
    end
    if spellname == nil then
        spellname = "Cure"
    end
    elements = {}
        elements.list = S{'Fire','Ice','Wind','Earth','Lightning','Water','Light','Dark'}
        elements.number = {[0]="Fire",[1]="Ice",[2]="Wind",[3]="Earth",[4]="Lightning",[5]="Water",[6]="Light",[7]="Dark"}
        elements.weak = {['Light']='Dark', ['Dark']='Light', ['Fire']='Water', ['Ice']='Fire', ['Wind']='Ice', ['Earth']='Wind',['Lightning']='Earth', ['Water']='Lightning'}
        weather = world.weather_element
        intensity = 1 + (world.weather_id % 2)
        day = world.day
        boost = 0
        obi = nil

    for _,buff in pairs (windower.ffxi.get_player().buffs) do
        if buff > 177 and buff < 186 then
            weather = elements.number[(buff - 178)]
            intensity = 1
        elseif buff > 588 and buff < 597 then
            weather = elements.number[(buff - 589)]
            intensity = 2
        end
        if spellname == "Swipe" or spellname == "Lunge" or spellname == "Vivacious Pulse" then
            if buff > 522 and buff < 531 then
                spelement = elements.number[(buff - 523)]
            end
        end
    end
    if weather == spelement then
        boost = boost + intensity
    elseif weather == elements.weak[spelement] then
        boost = boost - intensity
    end
    if day == spelement then
        boost = boost + 1
    elseif day == elements.weak[spelement] then
        boost = boost - 1
    end
    if boost > 0 then
        if player.inventory["Hachirin-no-Obi"] or player.wardrobe["Hachirin-no-Obi"] then
            equip({waist="Hachirin-no-Obi"})
        end
    end
end

function precast(spell,abil)
    --equips favorite weapon if disarmed
    if player.equipment.main == "empty" or player.equipment.sub == "empty" then
        equip({
            main={ name="Aettir", augments={'Accuracy+70','Mag. Evasion+50','Weapon skill damage +10%',}},
            sub="Refined Grip +1",
        })
    end
    if spell.action_type == 'Magic' then
            equip(sets.precast)
    end
    if spell.skill == 'Enhancing Magic' then
            equip({
                head="Runeist's Bandeau +3",
                legs="Futhark Trousers +1",
                waist="Siegel Sash",
                neck="Incanter's Torque",
                right_ring="Stikini Ring +1",
            })
    end
    if string.find(spell.name,'Utsusemi') then
            equip({neck="Magoraga Beads"})
    end
    if spell.name == 'Lunge' or spell.name == 'Swipe' then
            equip(sets.JA.Lunge)
            mid_obi(spell.element, spell.name)
    end
    --prevents Valiance/Vallation/Liement from being prevented by each other (cancels whichever is active)
    if spell.name == 'Valiance' or spell.name == 'Vallation' or spell.name == 'Liement' then
        if buffactive['Valiance'] then
            cast_delay(0.2)
            windower.ffxi.cancel_buff(535)
        elseif buffactive['Vallation'] then
            cast_delay(0.2)
            windower.ffxi.cancel_buff(531)
        elseif buffactive['Liement'] then
            cast_delay(0.2)
            windower.ffxi.cancel_buff(537)
        end
    end
    if spell.name == 'Vallation' or spell.name == 'Valiance' then
            equip(sets.Enmity, sets.JA.Vallation)
    end
    if spell.name == 'Pflug' then
            equip(sets.Enmity, sets.JA.Pflug)
    end
    if spell.name == 'Elemental Sforzo' or spell.name == 'Liement' then
            equip(sets.Enmity, {body="Futhark Coat +1"})
    end
    if spell.name == 'Gambit' then
            equip(sets.Enmity, sets.JA.Gambit)
    end
    if spell.name == 'Rayke' then
            equip(sets.Enmity, sets.JA.Rayke)
    end
    if spell.name == 'Battuta' then
            equip(sets.Enmity, sets.JA.Battuta)
    end
    if spell.name == 'Vivacious Pulse' then
            --equip(sets.Enmity, sets.JA.Pulse)
            equip(sets.JA.Pulse)
            mid_obi(spell.element, spell.name)
    end
    if spell.name == 'One for All' or spell.name == 'Embolden' or spell.name == 'Odyllic Subterfuge' or spell.name == 'Warcry'
    or spell.name == 'Swordplay' or spell.name == 'Rayke' or spell.name == 'Meditate' or spell.name == 'Provoke' then
            equip(sets.Enmity)
    end
    if spell.name == 'Resolution' or spell.name == 'Ruinator'  then
            equip(sets.Resolution)
    end
    if spell.name == 'Spinning Slash' or spell.name == 'Ground Strike' or spell.name == 'Upheaval'
        or spell.name == 'Dimidiation' or spell.name == 'Steel Cyclone' or spell.name == 'Savage Blade' then
            msg('sets.Single equipped')
        equip(sets.Single)
    end
    if spell.name == 'Shockwave' then
        equip(sets.Shockwave)
    end
    if spell.name == 'Fell Cleave' or spell.name == 'Circle Blade' then
            equip(sets.Cleave)
    end
    if spell.name == 'Requiescat' then
            equip(sets.Req)
    end
    if spell.name == 'Vorpal Blade' or spell.name == 'Rampage' then
            equip(sets.Vorp)
    end
    if spell.name == 'Herculean Slash'
        or spell.name == 'Freezebite'
        or spell.name == 'Sanguine Blade'
        or spell.name == 'Red Lotus Blade'
        or spell.name == 'Seraph Blade' then
            equip(sets.HercSlash)
            mid_obi(spell.element,spell.name)
    end
    --prevents casting Utsusemi if you already have 3 or more shadows
    if spell.name == 'Utsusemi: Ichi' and ShadowType == 'Ni' and (buffactive['Copy Image (3)'] or buffactive['Copy Image (4+)']) then
        cancel_spell()
    end
    if buffactive['terror'] or buffactive['petrification'] or buffactive['stun'] or buffactive['sleep'] then
        equip(sets.TP.DT)
    end
    if buffactive.sleep and player.hp > 100 and player.status == "Engaged" then
        equip({head="Frenzy Sallet"})
    end
end

function midcast(spell,act,arg)
        if spell.action_type == 'Magic' then
            equip({
                head="Runeist's Bandeau +3",
                ammo="Staunch Tathlum",
            })
        end
        if spell.skill == 'Blue Magic' then
            --nothing
        end
        if spell.skill == 'Enhancing Magic' then
            equip({
                head="Erilaz Galea +1",
                legs="Futhark Trousers +1",
                ammo="Staunch Tathlum",
                neck="Incanter's Torque",
            })
            if spell.name == "Blink" or spell.name == "Stoneskin" or string.find(spell.name,'Utsusemi') then
                if spell.name == "Stoneskin" then
                    equip({
                        waist="Siegel Sash",
                    })
                end
                equip({
                        head="Erilaz Galea +1",
                        hands="Leyline Gloves",
                        body={ name="Taeon Tabard", augments={'"Fast Cast"+3',}}
                    })
            elseif string.find(spell.name,'Bar') or spell.name=="Temper" then
                equip({hands="Runeist Mitons"})
            end
            if buffactive.embolden then
                equip({
                     back={ name="Evasionist's Cape", augments={'Enmity+6','"Embolden"+14','"Dbl.Atk."+2','Damage taken-3%',}},
                })
            end
        end
        if spell.name == 'Foil' then
            equip(sets.Enmity, {head="Erilaz Galea +1"})
        end
        if spell.name == 'Flash' or spell.name == "Stun" then
            equip(sets.Enmity)
        end
        if spell.name == 'Phalanx' then
            equip(sets.Phalanx)
        end
        if string.find(spell.name,'Regen') then
            equip({
                head="Runeist's Bandeau +3",
                neck="Sacro Gorget",
            })
        end
        if spell.name == "Repose" or spell.skill == 'Enfeebling Magic' or spell.skill == 'Dark Magic' then
            equip(sets.MagicAcc)
        end
        if spell.skill == 'Elemental Magic' then
            equip(sets.JA.Lunge)
            mid_obi(spell.element, spell.name)
        end
        --cancels Ni shadows (if there are only 1 or 2) when casting Ichi
        if spell.name == 'Utsusemi: Ichi' and ShadowType == 'Ni' and (buffactive['Copy Image'] or buffactive['Copy Image (2)']) then
            send_command('cancel Copy Image')
            send_command('cancel Copy Image (2)')
        end
end

function aftercast(spell)
    equip_current()
    if string.find(spell.name,'Utsusemi') and not spell.interrupted then
        if spell.name == 'Utsusemi: Ichi' then
            ShadowType = 'Ichi'
        elseif spell.name == 'Utsusemi: Ni' then
            ShadowType = 'Ni'
        end
    end
end

function status_change(new,old)
    equip_current()
end

function equip_TP()
    equip(sets.TP[sets.TP.index[TP_ind]])
        --equips offensive gear despite being on defensive set if you have shadows
        if TP_ind == 3 and ((buffactive['Copy Image (2)'] or buffactive['Copy Image (3)'] or buffactive['Copy Image (4+)']) or buffactive['Third Eye'] or buffactive['Blink']) then
            equip(sets.TP.Hybrid)
        end
        --equips DW gear if using two weapons
        if player.equipment.sub == "Tramontane Axe" or player.equipment.sub == "Pukulatmuj" or player.equipment.sub == "Anahera Sword" then
            equip({ear2="Suppanomimi"})
        end
        --equips offensive gear and relic boots during Battuta
        if buffactive.battuta then
            --remains on defensive set if Avoidance Down is active
            if buffactive['Avoidance Down'] then
            else
                if TP_ind == 4 or TP_ind == 5 or TP_ind == 6 then
                    equip(sets.TP.Hybrid)
                end
            equip({feet="Futhark Boots +1"})
            end
        end
        --equip defensive gear when hit with terror/petrify/stun/sleep
        if buffactive['terror'] or buffactive['petrification'] or buffactive['stun'] or buffactive['sleep'] then
                equip(sets.TP.DT)
        end
        --equip Frenzy Sallet (will wake you up) if engaged, slept, and over 100 HP
        if buffactive.sleep and player.hp > 100 then
            equip({head="Frenzy Sallet"})
        end
end

function equip_idle()
    equip(sets.Idle)
        --equips extra refresh gear when MP is below 65%
        if player.mpp < 60 then
            equip({body="Runeist's Coat +3"})
        end
        --auto-equip defensive gear when hit with terror/petrify/stun/sleep
        if buffactive['terror'] or buffactive['petrification'] or buffactive['stun'] or buffactive['sleep'] then
            equip(sets.TP.DT)
        end
end

function buff_change(buff,gain)
    local buff = string.lower(buff)
        if buff == "terror" or buff == "petrification" or buff == "stun" or buff == "sleep" then
            if gain then
                if TP_ind == 4 then
                    equip(sets.Utility.MDT) else
                    equip(sets.Utility.PDT)
                end
                if buff == "sleep" and player.hp > 100 and player.status == "Engaged" then
                    equip({head="Frenzy Sallet"})
                end
            else
            equip_current()
            end
        end
end

function equip_current()
    if player.status == 'Engaged' then
        equip_TP()
    else
        equip_idle()
    end
end

function self_command(command)
    if command == 'toggle TP set' then
        TP_ind = TP_ind - 1
        if TP_ind == 0 then 
            TP_ind = #sets.TP.index
        end
        send_command('@input /echo <----- TP Set changed to '..sets.TP.index[TP_ind]..' ----->')
        equip_current()
    elseif command == 'reverse TP set' then
        TP_ind = TP_ind + 1
        if TP_ind > #sets.TP.index then 
            TP_ind = 1 
        end
        send_command('@input /echo <----- TP Set changed to '..sets.TP.index[TP_ind]..' ----->')
        equip_current()
    elseif command == 'toggle Idle set' then
		Idle_ind = Idle_ind + 1
        if Idle_ind > #sets.Idle.index then 
            Idle_ind = 1 
        end
		msg('Idle Set changed to ' .. sets.Idle.index[Idle_ind])
        if player.status == 'Idle' then
            ChangeGear(sets.Idle[sets.Idle.index[Idle_ind]])
        end
    end
end

function msg(str)
	send_command('@input /echo <----- ' .. str .. ' ----->')
end