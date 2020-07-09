-------------------------------------------------------------------------------------------------------------------
-- Initialization function that defines sets and variables to be used.
-------------------------------------------------------------------------------------------------------------------
-- Haste II has the same buff ID [33], so we have to use a toggle.
-- gs c toggle hastemode -- Toggles whether or not you're getting Haste II
-- for Rune Fencer sub, you need to create two macros. One cycles runes, and gives you descrptive text in the log.
-- The other macro will use the actual rune you cycled to.
-- Macro #1 //console gs c cycle Runes
-- Macro #2 //console gs c toggle UseRune
function get_sets()
	mote_include_version = 2
	include('Mote-Include.lua')
	include('organizer-lib')
    require('vectors')
end


-- Setup vars that are user-independent.
function job_setup()

    state.Buff.Migawari = buffactive.migawari or false
    state.Buff.Sange = buffactive.sange or false
    state.Buff.Innin = buffactive.innin or false

    include('Mote-TreasureHunter')
    state.TreasureMode:set('Tag')

    state.HasteMode = M{['description']='Haste Mode', 'Normal', 'Hi'}
    state.UseWarp = M(false, 'Use Warp')

    run_sj = player.sub_job == 'RUN' or false

    select_ammo()
    LugraWSList = S{'Blade: Shun', 'Blade: Ku', 'Blade: Jin', 'Blade: Metsu'}
    state.CapacityMode = M(false, 'Capacity Point Mantle')

    gear.RegularAmmo = 'Togakushi Shuriken'
    gear.SangeAmmo = 'Happo Shuriken'
    gear.CheapAmmo = 'Happo Shuriken'

    wsList = S{'Blade: Hi', 'Blade: Kamu', 'Blade: Ten'}

    update_combat_form()

    state.warned = M(false)
    options.ammo_warning_limit = 25
    -- For th_action_check():
    -- JA IDs for actions that always have TH: Provoke, Animated Flourish
    info.default_ja_ids = S{35, 204}
    -- Unblinkable JA IDs for actions that always have TH: Quick/Box/Stutter Step, Desperate/Violent Flourish
    info.default_u_ja_ids = S{201, 202, 203, 205, 207}

end


-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    -- Options: Override default values
    state.OffenseMode:options('Normal')
    state.WeaponskillMode:options('Normal')

    select_default_macro_book()
    select_movement()
    send_command('bind ^[ gs c toggle UseWarp')
    send_command('bind @f9 gs c cycle HasteMode')

end


function file_unload()
    send_command('unbind ^[')
    send_command('unbind @f9')
    send_command('unbind ^]')
end


-- Ninjutsu tips
-- To stick Slow (Hojo) lower earth resist with Raiton: Ni
-- To stick poison (Dokumori) or Attack down (Aisha) lower resist with Katon: Ni
-- To stick paralyze (Jubaku) lower resistence with Huton: Ni

function init_gear_sets()

    ShadowType = 'None'

    --------------------------------------
    -- Augments
    --------------------------------------
    Andartia = {}
    Andartia.AGI = { name="Yokaze Mantle", augments={'STR+2','DEX+1','Sklchn.dmg.+2%','Weapon skill damage +5%',} }
    Andartia.DEX = { name="Andartia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',} }
    -- Andartia.AGI = {name="Andartia's Mantle", augments={'AGI+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}}

    --------------------------------------
    -- Job Abilties
    --------------------------------------
    sets.precast.JA['Mijin Gakure'] = { }
    sets.precast.JA['Futae'] = { }
    sets.precast.JA['Provoke'] = {
        ammo="Sapience Orb",  --2
        body="Emet Harness", --9
        feet="Ahosi Leggings",  -- 7
        hands="Nilas Gloves", --  --5
        neck="Warder's Charm +1", --8
        left_ear="Friomisi Earring", --2
        left_ring="Supershear Ring", --5
        right_ring="Petrov Ring", --4
    }
    sets.precast.JA['Warcry'] = sets.precast.JA['Provoke']
    sets.precast.JA['Berserk'] = sets.precast.JA['Provoke']
    sets.precast.JA['Defender'] = sets.precast.JA['Provoke']
    sets.precast.JA['Aggressor'] = sets.precast.JA['Provoke']
    sets.precast.JA.Sange = { ammo=gear.SangeAmmo }

    -- Waltz (chr and vit)
    sets.precast.Waltz = {
        head="Hachiya Hatsuburi +1",
        body="Rao Togi",
        hands={ name="Herculean Gloves", augments={'Attack+6','Weapon skill damage +4%','AGI+2','Accuracy+13',}},
        waist="Chaac Belt",
        legs="Nahtirah Trousers",
        feet="Hizamaru Sune-ate +1"
    }
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}
    -- Set for acc on steps, since Yonin drops acc a fair bit
    sets.precast.Step = {
        hands={ name="Herculean Gloves", augments={'Attack+6','Weapon skill damage +4%','AGI+2','Accuracy+13',}},
        back=Andartia.DEX,
    }
    sets.midcast.Trust =  { }

    sets.Warp = { ring1="Warp Ring" }

    --------------------------------------
    -- Utility Sets for rules below
    --------------------------------------
    sets.TreasureHunter = { 
        waist="Chaac Belt",
        --head="Wh. Rarab Cap +1", 
    }
    sets.CapacityMantle = { back="Mecistopins Mantle" }
    sets.WSDayBonus     = {  }
    sets.WSBack         = {  }
    sets.BrutalLugra    = { ear1="Cessance Earring" }
    sets.BrutalTrux     = { ear1="Cessance Earring" }
    sets.BrutalMoon     = { ear1="Brutal Earring" }
    sets.Rajas          = { ring1="Petrov Ring" }

    sets.RegularAmmo    = { ammo=gear.RegularAmmo }
    sets.SangeAmmo      = { ammo=gear.SangeAmmo }

    sets.NightAccAmmo   = { ammo="Ginsen" }
    sets.DayAccAmmo     = { ammo="Tengu-no-Hane" }

    --------------------------------------
    -- Ranged
    --------------------------------------

    sets.precast.RA = { }
    sets.midcast.RA = {
        back={ name="Yokaze Mantle", augments={'STR+2','DEX+1','Sklchn.dmg.+2%','Weapon skill damage +5%',}}
    }
    sets.midcast.RA.TH = set_combine(sets.midcast.RA, set.TreasureHunter)

    ---------------------------------------
    --  SPELLS
    ---------------------------------------

    -- Fast cast sets for spells
    sets.precast.FC = {
        ammo="Sapience Orb",  --2
        head={ name="Herculean Helm", augments={'"Mag.Atk.Bns."+22','"Fast Cast"+4','MND+7','Mag. Acc.+15',}},  -- 11
        body={ name="Taeon Tabard", augments={'"Fast Cast"+3',}}, --8
        hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}}, --8
        legs={ name="Herculean Trousers", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','"Fast Cast"+4','INT+7','"Mag.Atk.Bns."+9',}}, --4
        left_ring="Kishar Ring", -- 4
        feet="Ahosi Leggings",  -- 7
        neck="Baetyl Pendant",  -- 4
    }

    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, { 
        --neck="Magoragaw Beads", 
        --body="Mochizuki Chainmail +1" 
    })

    -- Midcast Sets
    sets.midcast.FastRecast = {
        hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}}, --8
        head={ name="Herculean Helm", augments={'"Mag.Atk.Bns."+22','"Fast Cast"+4','MND+7','Mag. Acc.+15',}}, --11
    }
    -- macc, enfeebles
    sets.midcast.Ninjutsu = {
        head="Mummu Bonnet +1",  -- 38
        body="Mummu Jacket +1", -- 40
        hands="Mummu Wrists +1", -- 37
        legs="Mummu Kecks +2", -- 45
        feet="Mummu Gamash. +1",  -- 36
        neck="Sanctity Necklace",  --10
        waist="Eschan Stone", --7
        left_ear="Hermetic Earring", --7 
        left_ring="Mummu Ring",  --6
        right_ring="Stikini Ring +1",  -- 11
        back={ name="Yokaze Mantle", augments={'STR+2','DEX+1','Sklchn.dmg.+2%','Weapon skill damage +5%',}},  --15
    }
    -- any ninjutsu cast on self / buffs (not utsu)
    sets.midcast.SelfNinjutsu = {

    }

    sets.midcast.Utsusemi = set_combine(sets.midcast.Ninjutsu, {
        hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}},
        back="Andartia's Mantle", -- +1
        feet="Hattori Kyahan", -- +1
        body="Emet Harness",  -- +9 (enmity) / -physical d
        left_ring="Defending Ring",
        right_ring="Vocane Ring",
        ammo="Staunch Tathlum",
    })

    sets.midcast.Migawari = set_combine(sets.midcast.Ninjutsu, {
        right_ring="Stikini Ring +1",
        neck="Incanter's Torque",
        back=Andartia.DEX,
    })  

    -- Nuking Ninjutsu (skill / magic attack / int)
    sets.midcast.ElementalNinjutsu = {
        head={ name="Mochi. Hatsuburi +2", augments={'Increases elem. ninjutsu III damage',}},
        body={ name="Samnuha Coat", augments={'Mag. Acc.+13','"Mag.Atk.Bns."+14','"Fast Cast"+3','"Dual Wield"+4',}},
        hands="Hattori Tekko +1",
        legs="Mummu Kecks +2",
        feet={ name="Herculean Boots", augments={'Mag. Acc.+18 "Mag.Atk.Bns."+18','Crit.hit rate+1','Mag. Acc.+14','"Mag.Atk.Bns."+14',}},
        neck="Baetyl Pendant",
        waist="Eschan Stone",
        left_ear="Friomisi Earring",
        right_ear="Hermetic Earring",
        left_ring="Mujin Band",
        right_ring="Stikini Ring +1",
        back={ name="Yokaze Mantle", augments={'STR+2','DEX+1','Sklchn.dmg.+2%','Weapon skill damage +5%',}},
    }

    -- Effusions
    sets.precast.Effusion = {}
    sets.precast.Effusion.Lunge = sets.midcast.ElementalNinjutsu
    sets.precast.Effusion.Swipe = sets.midcast.ElementalNinjutsu

    sets.idle = {
        main="Kikoku",
        sub={ name="Kanaria", augments={'"Triple Atk."+2','DEX+15','Accuracy+12','Attack+13','DMG:+10',}},
        ammo="Togakushi Shuriken",
        head={ name="Mochi. Hatsuburi +2", augments={'Increases elem. ninjutsu III damage',}},
        body="Hiza. Haramaki +1",
        hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
        legs="Mummu Kecks +2",
        feet={ name="Herculean Boots", augments={'"Triple Atk."+4','AGI+2','Accuracy+12',}},
        neck="Lissome Necklace",
        waist="Windbuffet Belt +1",
        left_ear="Odnowa Earring +1",
        right_ear="Infused Earring",
        left_ring="Epona's Ring",
        right_ring="Petrov Ring",
        back={ name="Andartia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}},
    }
    sets.idle.Town =  {
        main="Kikoku",
        sub={ name="Kanaria", augments={'"Triple Atk."+2','DEX+15','Accuracy+12','Attack+13','DMG:+10',}},
        ammo="Togakushi Shuriken",
        head={ name="Mochi. Hatsuburi +2", augments={'Increases elem. ninjutsu III damage',}},
        body="Hiza. Haramaki +1",
        hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
        legs="Mummu Kecks +2",
        feet={ name="Herculean Boots", augments={'"Triple Atk."+4','AGI+2','Accuracy+12',}},
        neck="Lissome Necklace",
        waist="Windbuffet Belt +1",
        left_ear="Odnowa Earring +1",
        right_ear="Infused Earring",
        left_ring="Epona's Ring",
        right_ring="Petrov Ring",
        back={ name="Andartia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}},
    }

    sets.Adoulin = {
        body="Councilor's Garb",
    }

    --------------------------------------------------------------
    --       ALT F12 REMOVES EMERGENCY DEFENSIVE SET 
    --       ALT F12 REMOVES EMERGENCY DEFENSIVE SET 
    --       ALT F12 REMOVES EMERGENCY DEFENSIVE SET 
    -- Defense sets:
    -- PRESS F10 !!!!!!!
    sets.defense.PDT = {
        ammo="Staunch Tathlum",
        head="Skormoth Mask",
        body="Emet Harness",
        hands={ name="Herculean Gloves", augments={'Attack+6','Weapon skill damage +4%','AGI+2','Accuracy+13',}},
        legs="Mummu Kecks +2",
        feet="Ahosi Leggings",
        neck="Twilight Torque",
        waist="Flume Belt",
        left_ear="Odnowa Earring +1",
        right_ear="Infused Earring",
        left_ring="Defending Ring",
        right_ring="Vocane Ring",
        back="Solemnity Cape",
    }

    -- PRESS F11 !!!!!!!!!!!!!!!!
    sets.defense.MDT = set_combine(sets.defense.PDT, {
        head={ name="Mochi. Hatsuburi +2", augments={'Increases elem. ninjutsu III damage',}},
        body="Mummu Jacket +1",
        hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}},
        neck="Warder's Charm +1",
        waist="Engraved Belt",
        right_ear="Hearty Earring",
    })
    -------------------------------------------------------------
    --       ALT F12 REMOVES EMERGENCY DEFENSIVE SET 
    --       ALT F12 REMOVES EMERGENCY DEFENSIVE SET 
    --       ALT F12 REMOVES EMERGENCY DEFENSIVE SET 
    -------------------------------------------------------------

    sets.DayMovement = { }
    sets.NightMovement = {feet="Ninja Kyahan"}

    sets.Organizer = { }

    -- Normal melee group without buffs
    sets.engaged = {
        ammo=gear.RegularAmmo,
        head={ name="Ryuo Somen", augments={'STR+10','DEX+10','Accuracy+15',}},
        body={ name="Herculean Vest", augments={'Accuracy+18 Attack+18','Weapon skill damage +3%','DEX+6','Accuracy+11','Attack+6',}},
        hands={ name="Floral Gauntlets", augments={'Rng.Acc.+14','Accuracy+13','"Triple Atk."+2','Magic dmg. taken -3%',}},
        legs={ name="Samnuha Tights", augments={'STR+8','DEX+9','"Dbl.Atk."+3','"Triple Atk."+2',}},
        feet="Hiza. Sune-Ate +1",
        neck="Lissome Necklace",
        waist="Reiki Yotai",
        left_ear="Cessance Earring",
        right_ear="Suppanomimi",
        left_ring="Epona's Ring",
        right_ring="Petrov Ring",
        back={ name="Andartia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}},
    }

    -- set for fooling around without dw
    sets.NoDW = set_combine(sets.engaged, {
        ammo=gear.RegularAmmo,
        head={ name="Ryuo Somen", augments={'STR+10','DEX+10','Accuracy+15',}},
        body={ name="Herculean Vest", augments={'Accuracy+18 Attack+18','Weapon skill damage +3%','DEX+6','Accuracy+11','Attack+6',}},
        hands={ name="Floral Gauntlets", augments={'Rng.Acc.+14','Accuracy+13','"Triple Atk."+2','Magic dmg. taken -3%',}},
        legs={ name="Samnuha Tights", augments={'STR+8','DEX+9','"Dbl.Atk."+3','"Triple Atk."+2',}},
        feet="Hiza. Sune-Ate +1",
        neck="Lissome Necklace",
        waist="Windbuffet Belt +1",
        left_ear="Cessance Earring",
        right_ear="Suppanomimi",
        left_ring="Epona's Ring",
        right_ring="Petrov Ring",
        back={ name="Andartia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}},
    })

    sets.engaged.Innin = set_combine(sets.engaged, {
        waist="Windbuffet Belt +1",
    })
----------------------------------------------------------------------
    -- Defenseive sets
    sets.NormalPDT = {
        ammo="Staunch Tathlum",
        head="Skormoth Mask",
        body="Emet Harness",
        hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
        legs="Mummu Kecks +2",
        feet="Ahosi Leggings",
        neck="Twilight Torque",
        waist="Flume Belt",
        left_ear="Odnowa Earring +1",
        right_ear="Infused Earring",
        left_ring="Defending Ring",
        right_ring="Vocane Ring",
        back="Solemnity Cape",
    }

    sets.engaged.PDT = sets.NormalPDT

    sets.engaged.Innin.PDT = sets.NormalPDT
 
    sets.engaged.HastePDT = sets.NormalPDT
--------------------------------------------------------------------
    -- Delay Cap from spell + songs alone
    sets.engaged.MaxHaste = set_combine(sets.engaged, {
        ammo=gear.RegularAmmo,
        head="Skormoth Mask",
        body={ name="Herculean Vest", augments={'Accuracy+18 Attack+18','Weapon skill damage +3%','DEX+6','Accuracy+11','Attack+6',}},
        hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
        legs={ name="Samnuha Tights", augments={'STR+8','DEX+9','"Dbl.Atk."+3','"Triple Atk."+2',}},
        feet={ name="Herculean Boots", augments={'"Triple Atk."+4','AGI+2','Accuracy+12',}},
        neck="Lissome Necklace",
        waist="Windbuffet Belt +1",
        left_ear="Cessance Earring",
        right_ear="Brutal Earring",
        left_ring="Epona's Ring",
        right_ring="Petrov Ring",
        back={ name="Andartia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}},
    })
    -- Base set for hard content

    sets.engaged.Innin.MaxHaste     = set_combine(sets.engaged.MaxHaste, {head="Hattori Zukin +1"})

    -- Defensive sets
    sets.engaged.PDT.MaxHaste = set_combine(sets.engaged.MaxHaste, sets.engaged.HastePDT)

    sets.engaged.Innin.PDT.MaxHaste = set_combine(sets.engaged.Innin.MaxHaste, sets.NormalPDT)

    -- 35% Haste
    sets.engaged.Haste_35 = set_combine(sets.engaged.MaxHaste, {
        ammo=gear.RegularAmmo,
        head={ name="Ryuo Somen", augments={'STR+10','DEX+10','Accuracy+15',}},
        body={ name="Herculean Vest", augments={'Accuracy+18 Attack+18','Weapon skill damage +3%','DEX+6','Accuracy+11','Attack+6',}},
        hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
        legs={ name="Samnuha Tights", augments={'STR+8','DEX+9','"Dbl.Atk."+3','"Triple Atk."+2',}},
        feet={ name="Herculean Boots", augments={'"Triple Atk."+4','AGI+2','Accuracy+12',}},
        neck="Lissome Necklace",
        waist="Windbuffet Belt +1",
        left_ear="Cessance Earring",
        right_ear="Brutal Earring",
        left_ring="Epona's Ring",
        right_ring="Petrov Ring",
        back={ name="Andartia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}},
    })


    sets.engaged.Innin.Haste_35 = set_combine(sets.engaged.Haste_35, {
        ammo=gear.RegularAmmo,
        head="Hattori Zukin +1",
        feet={ name="Herculean Boots", augments={'"Triple Atk."+4','AGI+2','Accuracy+12',}},
    })

    sets.engaged.PDT.Haste_35 = set_combine(sets.engaged.Haste_35, sets.engaged.HastePDT)

    sets.engaged.Innin.PDT.Haste_35 = set_combine(sets.engaged.Innin.Haste_35, sets.engaged.HastePDT)

    -- 30% Haste 1626 / 798
    sets.engaged.Haste_30 = set_combine(sets.engaged.Haste_35, {
        ammo=gear.RegularAmmo,
        head={ name="Ryuo Somen", augments={'STR+10','DEX+10','Accuracy+15',}},
        body={ name="Herculean Vest", augments={'Accuracy+18 Attack+18','Weapon skill damage +3%','DEX+6','Accuracy+11','Attack+6',}},
        hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
        legs={ name="Samnuha Tights", augments={'STR+8','DEX+9','"Dbl.Atk."+3','"Triple Atk."+2',}},
        feet="Hiza. Sune-Ate +1",
        neck="Lissome Necklace",
        waist="Reiki Yotai",
        left_ear="Cessance Earring",
        right_ear="Brutal Earring",
        left_ring="Epona's Ring",
        right_ring="Petrov Ring",
        back={ name="Andartia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}},
    })

    sets.engaged.Innin.Haste_30 = set_combine(sets.engaged.Haste_30, {
        ammo=gear.RegularAmmo,
        head="Hattori Zukin +1",
        feet={ name="Herculean Boots", augments={'"Triple Atk."+4','AGI+2','Accuracy+12',}},
    })


    sets.engaged.PDT.Haste_30 = set_combine(sets.engaged.Haste_30, sets.engaged.HastePDT)

    sets.engaged.Innin.PDT.Haste_30 = set_combine(sets.engaged.Innin.Haste_30, sets.engaged.HastePDT)

    -- haste spell - 139 dex | 275 acc | 1150 total acc (with shigi R15)
    sets.engaged.Haste_15 = set_combine(sets.engaged.Haste_30, {
        ammo=gear.RegularAmmo,
        head={ name="Ryuo Somen", augments={'STR+10','DEX+10','Accuracy+15',}},
        body={ name="Herculean Vest", augments={'Accuracy+18 Attack+18','Weapon skill damage +3%','DEX+6','Accuracy+11','Attack+6',}},
        hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
        legs={ name="Samnuha Tights", augments={'STR+8','DEX+9','"Dbl.Atk."+3','"Triple Atk."+2',}},
        feet="Hiza. Sune-Ate +1",
        neck="Lissome Necklace",
        waist="Reiki Yotai",
        left_ear="Cessance Earring",
        right_ear="Suppanomimi",
        left_ring="Epona's Ring",
        right_ring="Petrov Ring",
        back={ name="Andartia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}},
    })

    sets.engaged.Innin.Haste_15 = set_combine(sets.engaged.Haste_15, {
        ammo=gear.RegularAmmo,
        head={ name="Ryuo Somen", augments={'STR+10','DEX+10','Accuracy+15',}},
        body={ name="Herculean Vest", augments={'Accuracy+18 Attack+18','Weapon skill damage +3%','DEX+6','Accuracy+11','Attack+6',}},
        hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
        legs={ name="Samnuha Tights", augments={'STR+8','DEX+9','"Dbl.Atk."+3','"Triple Atk."+2',}},
        feet="Hiza. Sune-Ate +1",
        neck="Lissome Necklace",
        waist="Reiki Yotai",
        left_ear="Cessance Earring",
        right_ear="Suppanomimi",
        left_ring="Epona's Ring",
        right_ring="Petrov Ring",
        back={ name="Andartia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}},
    })


    sets.engaged.PDT.Haste_15 = set_combine(sets.engaged.Haste_15, sets.engaged.HastePDT)

    sets.engaged.Innin.PDT.Haste_15 = set_combine(sets.engaged.Innin.Haste_15, sets.engaged.HastePDT)

    sets.buff.Migawari = { body="Hattori Ningi +1" }



    -- WEAPONSKILLS!    WEAPONSKILLS     WEAPONSKILLS    WEAPONSKILLS   WEAPONSKILLS   WEAPONSKILLS
    -- WEAPONSKILLS!    WEAPONSKILLS     WEAPONSKILLS    WEAPONSKILLS   WEAPONSKILLS   WEAPONSKILLS
    -- WEAPONSKILLS!    WEAPONSKILLS     WEAPONSKILLS    WEAPONSKILLS   WEAPONSKILLS   WEAPONSKILLS
    -- WEAPONSKILLS!    WEAPONSKILLS     WEAPONSKILLS    WEAPONSKILLS   WEAPONSKILLS   WEAPONSKILLS

    sets.precast.WS = {
        ammo=gear.RegularAmmo,
        head={ name="Ryuo Somen", augments={'STR+10','DEX+10','Accuracy+15',}},
        body={ name="Ryuo Domaru", augments={'STR+10','DEX+10','Accuracy+15',}},
        hands={ name="Ryuo Tekko", augments={'STR+10','DEX+10','Accuracy+15',}},
        legs="Mummu Kecks +2",
        feet="Mummu Gamash. +1",
        neck="Caro Necklace",
        waist="Grunfeld Rope",
        left_ear="Cessance Earring",
        right_ear="Ethereal Earring",
        left_ring="Rajas Ring",
        right_ring="Petrov Ring",
    }

    sets.Kamu = {
        ammo="Ginsen",
        back=Andartia.AGI,
        legs="Hizamaru Hizayoroi +1",
        feet={ name="Herculean Boots", augments={'"Triple Atk."+4','AGI+2','Accuracy+12',}},
    }

    sets.precast.WS['Blade: Kamu'] = set_combine(sets.precast.WS, sets.Kamu)

    sets.precast.WS['Blade: Metsu'] = {
        ammo="Demonry Core",
        head={ name="Herculean Helm", augments={'Attack+1','Weapon skill damage +4%','Accuracy+9',}},
        body={ name="Herculean Vest", augments={'Accuracy+18 Attack+18','Weapon skill damage +3%','DEX+6','Accuracy+11','Attack+6',}},
        hands={ name="Herculean Gloves", augments={'Attack+6','Weapon skill damage +4%','AGI+2','Accuracy+13',}},
        legs="Jokushu Haidate",
        feet={ name="Herculean Boots", augments={'Weapon skill damage +3%','Accuracy+8','Attack+3',}},
        neck="Caro Necklace",
        waist="Grunfeld Rope",
        left_ear="Ishvara Earring",
        right_ear="Cessance Earring",
        left_ring="Rajas Ring",
        right_ring="Petrov Ring",
        back={ name="Andartia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}},
    }

    -- BLADE: JIN
    sets.Jin = {
        ammo="Yetshila",
        head={ name="Ryuo Somen", augments={'STR+10','DEX+10','Accuracy+15',}},
        neck="Breeze Gorget",
        body={ name="Ryuo Domaru", augments={'STR+10','DEX+10','Accuracy+15',}},
        hands={ name="Herculean Gloves", augments={'Attack+6','Weapon skill damage +4%','AGI+2','Accuracy+13',}},
        waist="Windbuffet Belt +1",
        legs="Hiza. Hizayoroi +2",
        feet={ name="Herculean Boots", augments={'"Triple Atk."+4','AGI+2','Accuracy+12',}},
    }
    sets.precast.WS['Blade: Jin'] = set_combine(sets.precast.WS, sets.Jin)

    -- BLADE: HI
    sets.precast.WS['Blade: Hi'] = set_combine(sets.precast.WS, {
        --dark belt / gorget?   
        head="Mummu Bonnet +1", --4 crit
        body={ name="Ryuo Domaru", augments={'STR+10','DEX+10','Accuracy+15',}}, --4 crit
        hands={ name="Ryuo Tekko", augments={'STR+10','DEX+10','Accuracy+15',}}, --4 crit
        legs="Mummu Kecks +2", --4 crit
        feet="Mummu Gamash. +1", --4 crit
        neck="Caro Necklace",
        waist="Grunfeld Rope",
        left_ear="Brutal Earring",
        right_ear="Ishvara Earring",  --2 wsd
        left_ring="Begrudging Ring", --5 crit
        right_ring="Mummu Ring", -- 3
        back={ name="Andartia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}},  --wsd?
    })


    -- BLADE: SHUN
    sets.Shun = {
        --flame belt / gorget?
        ammo="Ginsen",
        head="Mummu Bonnet +1", --4 crit
        body="Mummu Jacket +1",
        hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
        legs="Jokushu Haidate",
        feet="Mummu Gamash. +1",
        neck="Caro Necklace",
        waist="Grunfeld Rope",
        left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
        right_ear="Brutal Earring",
        left_ring="Epona's Ring",
        right_ring="Petrov Ring",
        back={ name="Andartia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}},
    }

    sets.precast.WS['Blade: Shun'] = set_combine(sets.precast.WS, sets.Shun)

    -- BLADE: Rin
    sets.Rin = {
        ammo=gear.RegularAmmo,
        neck="Defiant Collar",
        waist="Windbuffet Belt +1",
        feet={ name="Herculean Boots", augments={'"Triple Atk."+4','AGI+2','Accuracy+12',}},
        back=Andartia.DEX,
    }
    sets.precast.WS['Blade: Rin'] = set_combine(sets.precast.WS, sets.Rin)

    -- BLADE: KU
    sets.Ku = {
        ammo=gear.RegularAmmo,
        head={ name="Ryuo Somen", augments={'STR+10','DEX+10','Accuracy+15',}},
        ear2="Trux Earring",
        feet={ name="Herculean Boots", augments={'"Triple Atk."+4','AGI+2','Accuracy+12',}},
        neck="Shadow Gorget",
        back=Andartia.DEX,
    }
    sets.precast.WS['Blade: Ku'] = set_combine(sets.precast.WS, sets.Ku)

    -- damage varies:
    sets.Ten = {
        ammo="Aqreqaq Bomblet",
        head={ name="Herculean Helm", augments={'Attack+1','Weapon skill damage +4%','Accuracy+9',}},
        body={ name="Herculean Vest", augments={'Accuracy+18 Attack+18','Weapon skill damage +3%','DEX+6','Accuracy+11','Attack+6',}},
        hands={ name="Herculean Gloves", augments={'Attack+6','Weapon skill damage +4%','AGI+2','Accuracy+13',}},
        legs="Hiza. Hizayoroi +2",
        feet={ name="Herculean Boots", augments={'Weapon skill damage +3%','Accuracy+8','Attack+3',}},
        neck="Caro Necklace",
        waist="Grunfeld Rope",
        left_ear="Ishvara Earring",
        right_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
        left_ring="Rajas Ring",
        right_ring="Petrov Ring",
        back={ name="Yokaze Mantle", augments={'STR+2','DEX+1','Sklchn.dmg.+2%','Weapon skill damage +5%',}},
    }
    sets.precast.WS['Blade: Ten'] = sets.Ten

    sets.precast.WS['Tachi: Gekko'] = {
        ammo="Amar Cluster",
        head="Mummu Bonnet +1",
        body="Hiza. Haramaki +1",
        hands={ name="Ryuo Tekko", augments={'STR+10','DEX+10','Accuracy+15',}},
        legs="Mummu Kecks +2",
        feet="Mummu Gamash. +1",
        neck="Caro Necklace",
        waist="Grunfeld Rope",
        left_ear="Cessance Earring",
        right_ear="Ishvara Earring",
        left_ring="Rajas Ring",
        right_ring="Petrov Ring",
        back={ name="Andartia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}},
    }

    sets.precast.WS['Tachi: Ageha'] = {
        ammo="Amar Cluster",
        head="Mummu Bonnet +1",
        body="Mummu Jacket +1",
        hands="Mummu Wrists +1",
        legs="Mummu Kecks +2",
        feet="Mummu Gamash. +1",
        neck="Caro Necklace",
        waist="Eschan Stone",
        left_ear="Cessance Earring",
        right_ear="Hermetic Earring",
        left_ring="Rajas Ring",
        right_ring="Stikini Ring +1",
        back={ name="Andartia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}},
    }

    --ELEMENTAL WS / HYBRID: 
    sets.precast.WS['Aeolian Edge'] = set_combine(sets.precast.WS, sets.midcast.ElementalNinjutsu)
    sets.precast.WS['Blade: Chi'] = set_combine(sets.precast.WS['Aeolian Edge'], {
      
    })
    sets.precast.WS['Blade: To'] = sets.precast.WS['Blade: Chi']
    sets.precast.WS['Blade: Ei'] = {
        head="Pixie Hairpin +1",
        body={ name="Samnuha Coat", augments={'Mag. Acc.+13','"Mag.Atk.Bns."+14','"Fast Cast"+3','"Dual Wield"+4',}},
        hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}},
        legs={ name="Herculean Trousers", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','"Fast Cast"+4','INT+7','"Mag.Atk.Bns."+9',}},
        feet={ name="Herculean Boots", augments={'Mag. Acc.+18 "Mag.Atk.Bns."+18','Crit.hit rate+1','Mag. Acc.+14','"Mag.Atk.Bns."+14',}},
        neck="Baetyl Pendant",
        waist="Eschan Stone",
        left_ear="Hecate's Earring",
        right_ear="Friomisi Earring",
        left_ring="Dingir Ring",
        right_ring="Archon Ring",
        back={ name="Yokaze Mantle", augments={'STR+2','DEX+1','Sklchn.dmg.+2%','Weapon skill damage +5%',}},
    }
    sets.precast.WS['Blade: Yu'] = sets.midcast.ElementalNinjutsu

end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks that are called to process player actions at specific points in time.
-------------------------------------------------------------------------------------------------------------------
function job_pretarget(spell, action, spellMap, eventArgs)
    if state.Buff[spell.english] ~= nil then    
        state.Buff[spell.english] = true
    end
    if (spell.type:endswith('Magic') or spell.type == "Ninjutsu") and buffactive.silence then
        cancel_spell()
        send_command('input /item "Echo Drops" <me>')
    end
end
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    if spell.skill == "Ninjutsu" and spell.target.type:lower() == 'self' and spellMap ~= "Utsusemi" then
        if spell.english == "Migawari" then
            classes.CustomClass = "Migawari"
        else
            classes.CustomClass = "SelfNinjutsu"
        end
    end
    if spell.name == 'Spectral Jig' and buffactive.sneak then
        -- If sneak is active when using, cancel before completion
        send_command('cancel 71')
        end
    if string.find(spell.english, 'Utsusemi') then
        if buffactive['Copy Image (3)'] or buffactive['Copy Image (4)'] or buffactive['Copy Image (4+)'] then
            cancel_spell()
            add_to_chat(123, '**!! '..spell.english..' : [3+ IMAGES] !!**')
            eventArgs.cancel = true
            eventArgs.handled = true
            return
        elseif buffactive['Copy Image'] or buffactive['Copy Image (2)'] then
                send_command('cancel 66; cancel 444; cancel Copy Image; cancel Copy Image (2)')
        end
    end

end

function job_post_precast(spell, action, spellMap, eventArgs)
    -- Ranged Attacks 
    if spell.action_type == 'Ranged Attack' and state.OffenseMode ~= 'Acc' then
        equip( sets.SangeAmmo )
    end
    -- protection for lag
    if spell.name == 'Sange' and player.equipment.ammo == gear.RegularAmmo then
        state.Buff.Sange = false
        eventArgs.cancel = true
    end
    if spell.type == 'WeaponSkill' then
        if spell.english == 'Aeolian Edge' and state.TreasureMode.value ~= 'None' then
            equip(sets.TreasureHunter)
        end
        -- Mecistopins Mantle rule (if you kill with ws)
        if state.CapacityMode.value then
            equip(sets.CapacityMantle)
        end
        -- Swap in special ammo for WS in high Acc mode
        if state.OffenseMode.value == 'Acc' then
            equip(select_ws_ammo())
        end
        -- Lugra Earring for some WS
        if LugraWSList:contains(spell.english) then
            if world.time >= (17*60) or world.time <= (7*60) then
                equip(sets.BrutalLugra)
            else
                equip(sets.BrutalTrux)
            end
        elseif spell.english == 'Blade: Hi' or spell.english == 'Blade: Ten' then
            if world.time >= (17*60) or world.time <= (7*60) then
                equip(sets.BrutalLugra)
            else
                equip(sets.BrutalMoon)
            end
        end

    end
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_midcast(spell, action, spellMap, eventArgs)
    if spell.english == "Monomi: Ichi" then
        if buffactive['Sneak'] then
            send_command('@wait 1.0;cancel sneak')
        end
    end
end

-- Run after the general midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
    --if state.TreasureMode.value ~= 'None' and spell.action_type == 'Ranged Attack' then
    --    equip(sets.TreasureHunter)
    --end
end


-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
    if midaction() then
        return
    end
    -- Aftermath timer creation
    aw_custom_aftermath_timers_aftercast(spell)
end

-------------------------------------------------------------------------------------------------------------------
-- Customization hooks for idle and melee sets, after they've been automatically constructed.
-------------------------------------------------------------------------------------------------------------------

-- Called before the Include starts constructing melee/idle/resting sets.
-- Can customize state or custom melee class values at this point.
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_handle_equipping_gear(status, eventArgs)
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if player.hpp < 80 then
        --idleSet = set_combine(idleSet, sets.idle.Regen)
    end

    idleSet = set_combine(idleSet, select_movement())

    return idleSet
end

-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)

    return meleeSet
end

-------------------------------------------------------------------------------------------------------------------
-- General hooks for other events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)

    if state.Buff[buff] ~= nil then
        if not midaction() then
            handle_equipping_gear(player.status)
        end
    end

    if (buff == 'Innin' and gain or buffactive['Innin']) then
        state.CombatForm:set('Innin')
        if not midaction() then
            handle_equipping_gear(player.status)
        end
    else
        state.CombatForm:reset()
        if not midaction() then
            handle_equipping_gear(player.status)
        end
    end

    -- If we gain or lose any haste buffs, adjust which gear set we target.
    if S{'haste', 'march', 'mighty guard', 'embrava', 'haste samba', 'geo-haste', 'indi-haste'}:contains(buff:lower()) then
        determine_haste_group()
        if not midaction() then
            handle_equipping_gear(player.status)
        end
    end

end

function job_status_change(newStatus, oldStatus, eventArgs)
    if newStatus == 'Engaged' then
        update_combat_form()
    end
end

-- Called by the default 'update' self-command.
function job_update(cmdParams, eventArgs)
    select_ammo()
    --determine_haste_group()
    update_combat_form()
    run_sj = player.sub_job == 'RUN' or false
    select_movement()
    th_update(cmdParams, eventArgs)
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- State buff checks that will equip buff gear and mark the event as handled.
function check_buff(buff_name, eventArgs)
    if state.Buff[buff_name] then
        equip(sets.buff[buff_name] or {})
        if state.TreasureMode.value == 'SATA' or state.TreasureMode.value == 'Fulltime' then
            equip(sets.TreasureHunter)
        end
        eventArgs.handled = true
    end
end

-- Check for various actions that we've specified in user code as being used with TH gear.
-- This will only ever be called if TreasureMode is not 'None'.
-- Category and Param are as specified in the action event packet.
function th_action_check(category, param)
    if category == 2 or -- any ranged attack
        --category == 4 or -- any magic action
        (category == 3 and param == 30) or -- Aeolian Edge
        (category == 6 and info.default_ja_ids:contains(param)) or -- Provoke, Animated Flourish
        (category == 14 and info.default_u_ja_ids:contains(param)) -- Quick/Box/Stutter Step, Desperate/Violent Flourish
        then 
            return true
    end
end

function select_movement()
    -- world.time is given in minutes into each day
    -- 7:00 AM would be 420 minutes
    -- 17:00 PM would be 1020 minutes
    -- temp 18-6 "night time", dush-dawn= 17-7
    if world.time >= (18*60) or world.time <= (6*60) then
        return sets.NightMovement
    else
        return sets.DayMovement
    end
end

function determine_haste_group()
    classes.CustomMeleeGroups:clear()
    -- assuming +4 for marches (ghorn has +5)
    -- Haste (white magic) 15%
    -- Haste Samba (Sub) 5%
    -- Haste (Merited DNC) 10% (never account for this)
    -- Victory March +0/+3/+4/+5    9.4/14%/15.6%/17.1% +0
    -- Advancing March +0/+3/+4/+5  6.3/10.9%/12.5%/14%  +0
    -- Embrava 30% with 500 enhancing skill
    -- Mighty Guard - 15%
    -- buffactive[580] = geo haste
    -- buffactive[33] = regular haste
    -- buffactive[604] = mighty guard
    -- state.HasteMode = toggle for when you know Haste II is being cast on you
    -- Hi = Haste II is being cast. This is clunky to use when both haste II and haste I are being cast
    if state.HasteMode.value == 'Hi' then
        if ( ( (buffactive[33] or buffactive[580] or buffactive.embrava) and (buffactive.march or buffactive[604]) ) or
             ( buffactive[33] and (buffactive[580] or buffactive.embrava) ) or
             ( buffactive.march == 2 and buffactive[604] ) ) then
            add_to_chat(8, '-------------Max-Haste Mode Enabled--------------')
            classes.CustomMeleeGroups:append('MaxHaste')
        elseif ( (buffactive[33] or buffactive.march == 2 or buffactive[580]) and buffactive['haste samba'] ) then
            add_to_chat(8, '-------------Haste 35%-------------')
            classes.CustomMeleeGroups:append('Haste_35')
        elseif ( ( buffactive[580] or buffactive[33] or buffactive.march == 2 ) or
                 ( buffactive.march == 1 and buffactive[604] ) ) then
            add_to_chat(8, '-------------Haste 30%-------------')
            classes.CustomMeleeGroups:append('Haste_30')
        elseif ( buffactive.march == 1 or buffactive[604] ) then
            add_to_chat(8, '-------------Haste 15%-------------')
            classes.CustomMeleeGroups:append('Haste_15')
        end
    else
        if ( buffactive[580] and ( buffactive.march or buffactive[33] or buffactive.embrava or buffactive[604]) ) or  -- geo haste + anything
           ( buffactive.embrava and (buffactive.march or buffactive[33] or buffactive[604]) ) or  -- embrava + anything
           ( buffactive.march == 2 and (buffactive[33] or buffactive[604]) ) or  -- two marches + anything
           ( buffactive[33] and buffactive[604] and buffactive.march ) then -- haste + mighty guard + any marches
            add_to_chat(8, '-------------Max Haste Mode Enabled--------------')
            classes.CustomMeleeGroups:append('MaxHaste')
        elseif ( (buffactive[604] or buffactive[33]) and buffactive['haste samba'] and buffactive.march == 1) or -- MG or haste + samba with 1 march
               ( buffactive.march == 2 and buffactive['haste samba'] ) or
               ( buffactive[580] and buffactive['haste samba'] ) then 
            add_to_chat(8, '-------------Haste 35%-------------')
            classes.CustomMeleeGroups:append('Haste_35')
        elseif ( buffactive.march == 2 ) or -- two marches from ghorn
               ( (buffactive[33] or buffactive[604]) and buffactive.march == 1 ) or  -- MG or haste + 1 march
               ( buffactive[580] ) or  -- geo haste
               ( buffactive[33] and buffactive[604] ) then  -- haste with MG
            add_to_chat(8, '-------------Haste 30%-------------')
            classes.CustomMeleeGroups:append('Haste_30')
        elseif buffactive[33] or buffactive[604] or buffactive.march == 1 then
            add_to_chat(8, '-------------Haste 15%-------------')
            classes.CustomMeleeGroups:append('Haste_15')
        end
    end

end

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    if stateField == 'Capacity Point Mantle' then
        gear.Back = newValue
    elseif stateField == 'Use Warp' then
        add_to_chat(8, '------------WARPING-----------')    
        send_command('input //gs equip sets.Warp;@wait 10.0;input /item "Warp Ring" <me>')
    end
end

--- Custom spell mapping.
function job_get_spell_map(spell, default_spell_map)
    if spell.type == 'Trust' then
        return 'Trust'
    end
end

-- Call from job_precast() to setup aftermath information for custom timers.
function aw_custom_aftermath_timers_precast(spell)
    if spell.type == 'WeaponSkill' then
        info.aftermath = {}

        local empy_ws = "Blade: Hi"

        info.aftermath.weaponskill = empy_ws
        info.aftermath.duration = 0

        info.aftermath.level = math.floor(player.tp / 1000)
        if info.aftermath.level == 0 then
            info.aftermath.level = 1
        end

        if spell.english == empy_ws and player.equipment.main == 'Kannagi' then
            -- nothing can overwrite lvl 3
            if buffactive['Aftermath: Lv.3'] then
                return
            end
            -- only lvl 3 can overwrite lvl 2
            if info.aftermath.level ~= 3 and buffactive['Aftermath: Lv.2'] then
                return
            end

            -- duration is based on aftermath level
            info.aftermath.duration = 30 * info.aftermath.level
        end
    end
end

-- Call from job_aftercast() to create the custom aftermath timer.
function aw_custom_aftermath_timers_aftercast(spell)
    -- prevent gear being locked when it's currently impossible to cast 
    if not spell.interrupted and spell.type == 'WeaponSkill' and
        info.aftermath and info.aftermath.weaponskill == spell.english and info.aftermath.duration > 0 then

        local aftermath_name = 'Aftermath: Lv.'..tostring(info.aftermath.level)
        send_command('timers d "Aftermath: Lv.1"')
        send_command('timers d "Aftermath: Lv.2"')
        send_command('timers d "Aftermath: Lv.3"')
        send_command('timers c "'..aftermath_name..'" '..tostring(info.aftermath.duration)..' down abilities/aftermath'..tostring(info.aftermath.level)..'.png')

        info.aftermath = {}
    end
end

function select_ammo()
    if state.Buff.Sange then
        return sets.SangeAmmo
    else
        return sets.RegularAmmo
    end
end

function select_ws_ammo()
    if world.time >= (18*60) or world.time <= (6*60) then
        return sets.NightAccAmmo
    else
        return sets.DayAccAmmo
    end
end

function update_combat_form()
    if state.Buff.Innin then
        state.CombatForm:set('Innin')
    else
        state.CombatForm:reset()
    end
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'DNC' then
        set_macro_page(2, 8)
    elseif player.sub_job == 'WAR' then
        set_macro_page(2, 8)
    elseif player.sub_job == 'RUN' then
        set_macro_page(2, 8)
    else
        set_macro_page(2, 8)
    end
end