-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2

    -- Load and initialize the include file.
    include('Mote-Include.lua')
end


-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    state.Buff.Footwork = buffactive.Footwork or false
    state.Buff.Impetus = buffactive.Impetus or false
    state.Buff.Boost = buffactive.Boost or false

    include('Mote-TreasureHunter')
    state.TreasureMode:set('Tag')

    state.FootworkWS = M(false, 'Footwork on WS')

    info.impetus_hit_count = 0
    --windower.raw_register_event('action', on_action_for_impetus)
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'Counter', 'SomeAcc', 'Acc')  -- F9
    state.WeaponskillMode:options('Normal', 'SomeAcc', 'Acc')
    state.HybridMode:options('Normal', 'PDT', 'Counter') -- SHIFT F9
    state.PhysicalDefenseMode:options('PDT', 'HP')  -- CTRL F10

    update_combat_form()
    update_melee_groups()

    select_default_macro_book()
end


-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------

    -- Precast Sets

    -- Precast sets to enhance JAs on use
    sets.precast.JA['Provoke'] = {
        ammo="Sapience Orb",
        body="Emet Harness",
        hands="Nilas Gloves",
        feet="Ahosi Leggings",
        neck="Warder's Charm +1",
        left_ear="Friomisi Earring",
        right_ear="Cryptic Earring",
        left_ring="Petrov Ring",
        right_ring="Supershear Ring",
        back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','System: 1 ID: 640 Val: 4',}},
    }
    sets.precast.JA['Warcry'] = sets.precast.JA['Provoke']
    sets.precast.JA['Defender'] = sets.precast.JA['Provoke']
    sets.precast.JA['Aggressor'] = sets.precast.JA['Provoke']

    sets.precast.JA['Hundred Fists'] = {
        legs={ name="Hes. Hose +3", augments={'Enhances "Hundred Fists" effect',}},
    }
    sets.precast.JA['Boost'] = {
        hands="Anchor. Gloves +2",
        waist="Ask Sash",
    }
    sets.precast.JA['Dodge'] = {
        feet="Anch. Gaiters +2",
    }
    sets.precast.JA['Focus'] = {}
    sets.precast.JA['Impetus'] = {
        body="Bhikku Cyclas +1",
    }
    sets.precast.JA['Counterstance'] = set_combine(sets.precast.JA['Provoke'], {
        feet="Melee Gaiters",  -- +5
    })
    sets.precast.JA['Footwork'] = {
        feet="Shukuyu Sune-Ate",
    }
    sets.precast.JA['Formless Strikes'] = {}
    sets.precast.JA['Mantra'] = {
        ammo="Falcon Eye",
        head="Hiza. Somen　+2",
        body={ name="Ryuo Domaru", augments={'STR+10','DEX+10','Accuracy+15',}},
        hands="Anchor. Gloves +2",
        legs={ name="Hes. Hose +3", augments={'Enhances "Hundred Fists" effect',}},
        feet="Hiza. Sune-Ate +1",
        neck="Sanctity Necklace",
        waist="Eschan Stone",
        left_ear="Odnowa Earring +1",
        right_ear="Cryptic Earring",
        left_ring="Ilabrat Ring",
        right_ring="Supershear Ring",
        back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}},
    }

    sets.precast.JA['Chi Blast'] = {}

    sets.precast.JA['Chakra'] = {}

    sets.TreasureHunter = {
        waist="Chaac Belt",
    }


    -- Waltz set (chr and vit)
    sets.precast.Waltz = {}
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}
    sets.precast.Step = {waist="Chaac Belt"}
    sets.precast.Flourish1 = {waist="Chaac Belt"}

    -- Fast cast sets for spells

    sets.precast.FC = {}
    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {})

       ----------------------------------------------------------------------------------
    -- Weaponskill   Weaponskill   Weaponskill   Weaponskill   Weaponskill   Weaponskill
    -- Default set for any weaponskill that isn't any more specifically defined
    -------------------------------------------------------------------------------------


    sets.precast.WS = {
        ammo="Knobkierrie",
        head={ name="Herculean Helm", augments={'"Dbl.Atk."+2','"Triple Atk."+3','Weapon skill damage +4%','Mag. Acc.+16 "Mag.Atk.Bns."+16',}},
        body={ name="Herculean Vest", augments={'Accuracy+11 Attack+11','Weapon skill damage +4%','STR+15','Attack+6',}},
        hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
        legs="Hiza. Hizayoroi +2",
        feet={ name="Herculean Boots", augments={'Attack+24','Crit. hit damage +3%','AGI+5','Accuracy+11',}},
        neck="Caro Necklace",
        waist="Moonbow Belt +1",
        left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
        right_ear="Sherida Earring",
        left_ring="Petrov Ring",
        right_ring="Ilabrat Ring",
        back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','System: 1 ID: 640 Val: 4',}},
    }
    sets.precast.WSAcc = {
        ammo="Amar Cluster",
        head="Mummu Bonnet +1",
        body="Mummu Jacket +2",
        hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
        legs="Mummu Kecks +2",
        feet="Mummu Gamash. +1",
        neck="Mnk. Nodowa +1",
        waist="Moonbow Belt +1",
        left_ear="Cessance Earring",
        right_ear="Sherida Earring",
        left_ring="Ilabrat Ring",
        right_ring="Beeline Ring",
        back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','System: 1 ID: 640 Val: 4',}},
    }
    sets.precast.WSMod = {}
    sets.precast.MaxTP = {
        left_ear="Cessance Earring",
        right_ear="Sherida Earring",
    }
    sets.precast.WS.Acc = set_combine(sets.precast.WS, sets.precast.WSAcc)
    sets.precast.WS.Mod = set_combine(sets.precast.WS, sets.precast.WSMod)

    -- Specific weaponskill sets.

    sets.precast.WS['Raging Fists']    = set_combine(sets.precast.WS, {
        ammo="Knobkierrie",
        head={ name="Herculean Helm", augments={'"Dbl.Atk."+2','"Triple Atk."+3','Weapon skill damage +4%','Mag. Acc.+16 "Mag.Atk.Bns."+16',}},
        body={ name="Herculean Vest", augments={'Accuracy+11 Attack+11','Weapon skill damage +4%','STR+15','Attack+6',}},
        hands={ name="Herculean Gloves", augments={'Attack+6','Weapon skill damage +4%','AGI+2','Accuracy+13',}},
        legs="Hiza. Hizayoroi +2",
        feet={ name="Herculean Boots", augments={'Attack+24','Crit. hit damage +3%','AGI+5','Accuracy+11',}},
        neck="Mnk. Nodowa +1",
        waist="Moonbow Belt +1",
        left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
        right_ear="Sherida Earring",
        left_ring="Petrov Ring",
        right_ring="Ilabrat Ring",
        back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}},
    })
    sets.precast.WS['Final Heaven']    = set_combine(sets.precast.WS, {
        -- VIT 80%, fTP 3.0; 2 hits
        ammo="Knobkierrie",
        head={ name="Herculean Helm", augments={'"Dbl.Atk."+2','"Triple Atk."+3','Weapon skill damage +4%','Mag. Acc.+16 "Mag.Atk.Bns."+16',}},
        body={ name="Herculean Vest", augments={'Accuracy+11 Attack+11','Weapon skill damage +4%','STR+15','Attack+6',}},
        hands="Anchor. Gloves +2",
        legs="Hiza. Hizayoroi +2",
        feet="Hiza. Sune-Ate +1",
        neck="Light Gorget",
        waist="Ask Sash",
        left_ear="Ishvara Earring",
        right_ear="Sherida Earring",
        left_ring="Supershear Ring",
        right_ring="Petrov Ring",
        back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}},
    })
    sets.precast.WS['Howling Fist']    = set_combine(sets.precast.WS, {
        ammo="Knobkierrie",
        head={ name="Herculean Helm", augments={'"Dbl.Atk."+2','"Triple Atk."+3','Weapon skill damage +4%','Mag. Acc.+16 "Mag.Atk.Bns."+16',}},
        body={ name="Herculean Vest", augments={'Accuracy+11 Attack+11','Weapon skill damage +4%','STR+15','Attack+6',}},
        hands="Anchor. Gloves +2",
        legs="Hiza. Hizayoroi +2",
        feet={ name="Herculean Boots", augments={'Attack+24','Crit. hit damage +3%','AGI+5','Accuracy+11',}},
        neck="Caro Necklace",
        waist="Moonbow Belt +1",
        left_ear="Ishvara Earring",
        right_ear="Sherida Earring",
        left_ring="Rajas Ring",
        right_ring="Petrov Ring",
        back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}},
    })
    sets.precast.WS['Asuran Fists']    = set_combine(sets.precast.WS, {
        ammo="Knobkierrie",
        head="Hiza. Somen　+2",
        body={ name="Herculean Vest", augments={'Accuracy+11 Attack+11','Weapon skill damage +4%','STR+15','Attack+6',}},
        hands="Anchor. Gloves +2",
        legs="Hiza. Hizayoroi +2",
        feet={ name="Herculean Boots", augments={'Attack+24','Crit. hit damage +3%','AGI+5','Accuracy+11',}},
        neck="Caro Necklace",
        waist="Moonbow Belt +1",
        left_ear="Ishvara Earring",
        right_ear="Sherida Earring",
        left_ring="Rajas Ring",
        right_ring="Petrov Ring",
        back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}},
    })
    sets.precast.WS["Ascetic's Fury"]  = set_combine(sets.precast.WS, {
        ammo="Knobkierrie",
        head={ name="Herculean Helm", augments={'"Dbl.Atk."+2','"Triple Atk."+3','Weapon skill damage +4%','Mag. Acc.+16 "Mag.Atk.Bns."+16',}},
        body={ name="Ryuo Domaru", augments={'STR+10','DEX+10','Accuracy+15',}},
        hands={ name="Ryuo Tekko", augments={'STR+10','DEX+10','Accuracy+15',}},
        legs="Mummu Kecks +2",
        feet="Mummu Gamash. +1",
        neck="Light Gorget",
        waist="Moonbow Belt +1",
        left_ear="Ishvara Earring",
        right_ear="Sherida Earring",
        left_ring="Petrov Ring",
        right_ring="Ilabrat Ring",
        back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}},
    }) 
    sets.precast.WS['Victory Smite']   = set_combine(sets.precast.WS, {
        ammo="Knobkierrie",
        head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
        body="Bhikku Cyclas +1",  -- body={ name="Herculean Vest", augments={'Accuracy+11 Attack+11','Weapon skill damage +4%','STR+15','Attack+6',}},
        hands={ name="Ryuo Tekko", augments={'STR+10','DEX+10','Accuracy+15',}},
        legs={ name="Hes. Hose +3", augments={'Enhances "Hundred Fists" effect',}},
        feet={ name="Herculean Boots", augments={'Attack+24','Crit. hit damage +3%','AGI+5','Accuracy+11',}},
        neck="Light Gorget",
        waist="Moonbow Belt +1",
        left_ear="Cessance Earring",
        right_ear="Sherida Earring",
        left_ring="Begrudging Ring",
        right_ring="Ilabrat Ring",
        back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','System: 1 ID: 640 Val: 4',}},
        -- CRIT IMP DOWN; DA IMP UP back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}},
    })
    sets.precast.WS['Shijin Spiral']   = set_combine(sets.precast.WS, {
        ammo="Knobkierrie",
        head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
        body={ name="Herculean Vest", augments={'Accuracy+11 Attack+11','Weapon skill damage +4%','STR+15','Attack+6',}},
        hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
        legs={ name="Hes. Hose +3", augments={'Enhances "Hundred Fists" effect',}},
        feet={ name="Herculean Boots", augments={'Attack+24','Crit. hit damage +3%','AGI+5','Accuracy+11',}},
        neck="Light Gorget",
        waist="Moonbow Belt +1",
        left_ear="Cessance Earring",
        right_ear="Sherida Earring",
        left_ring="Rajas Ring",
        right_ring="Ilabrat Ring",
        back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','System: 1 ID: 640 Val: 4',}},
    })
    sets.precast.WS['Dragon Kick'] = set_combine(sets.precast.WS, {
        ammo="Knobkierrie",
        head={ name="Herculean Helm", augments={'"Dbl.Atk."+2','"Triple Atk."+3','Weapon skill damage +4%','Mag. Acc.+16 "Mag.Atk.Bns."+16',}},
        body={ name="Herculean Vest", augments={'Accuracy+11 Attack+11','Weapon skill damage +4%','STR+15','Attack+6',}},
        hands="Anchor. Gloves +2",
        legs="Hiza. Hizayoroi +2",
        feet="Anch. Gaiters +2",
        neck="Mnk. Nodowa +1",  -- kick attack damage+
        waist="Moonbow Belt +1",
        left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
        right_ear="Sherida Earring",
        left_ring="Petrov Ring",
        right_ring="Ilabrat Ring",
        back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}},
    })
    sets.precast.WS['Tornado Kick']    = set_combine(sets.precast.WS, {
        ammo="Knobkierrie",
        head={ name="Herculean Helm", augments={'"Dbl.Atk."+2','"Triple Atk."+3','Weapon skill damage +4%','Mag. Acc.+16 "Mag.Atk.Bns."+16',}},
        body={ name="Herculean Vest", augments={'Accuracy+11 Attack+11','Weapon skill damage +4%','STR+15','Attack+6',}},
        hands="Anchor. Gloves +2",
        legs="Hiza. Hizayoroi +2",
        feet="Anch. Gaiters +2",
        neck="Mnk. Nodowa +1", -- kick attack damage+
        waist="Moonbow Belt +1",
        left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
        right_ear="Sherida Earring",
        left_ring="Petrov Ring",
        right_ring="Ilabrat Ring",
        back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}},
    })
    sets.precast.WS['Spinning Attack'] = set_combine(sets.precast.WS, {
        ammo="Knobkierrie",
        head="Mummu Bonnet +1",
        body="Mummu Jacket +2",
        hands={ name="Herculean Gloves", augments={'Attack+6','Weapon skill damage +4%','AGI+2','Accuracy+13',}},
        legs="Hiza. Hizayoroi +2",
        feet="Anch. Gaiters +2",
        neck="Caro Necklace",
        waist="Moonbow Belt +1",
        left_ear="Ishvara Earring",
        right_ear="Sherida Earring",
        left_ring="Petrov Ring",
        right_ring="Ilabrat Ring",
        back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}},
    })
    sets.precast.WS['Shell Crusher'] = set_combine(sets.precast.WSAcc, {
        ammo="Falcon Eye",
        head="Mummu Bonnet +1",
        body="Mummu Jacket +2",
        hands="Mummu Wrists +1",
        legs="Mummu Kecks +2",
        feet="Mummu Gamash. +1",
        neck="Sanctity Necklace",
        waist="Eschan Stone",
        left_ear="Hermetic Earring",
        right_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
        left_ring="Beeline Ring",
        right_ring="Ilabrat Ring",
        back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','System: 1 ID: 640 Val: 4',}},
    })
    --ACC
    sets.precast.WS["Raging Fists"].Acc = set_combine(sets.precast.WS["Raging Fists"], sets.precast.WSAcc)
    sets.precast.WS["Howling Fist"].Acc = set_combine(sets.precast.WS["Howling Fist"], sets.precast.WSAcc)
    sets.precast.WS["Asuran Fists"].Acc = set_combine(sets.precast.WS["Asuran Fists"], sets.precast.WSAcc)
    sets.precast.WS["Ascetic's Fury"].Acc = set_combine(sets.precast.WS["Ascetic's Fury"], sets.precast.WSAcc)
    sets.precast.WS["Victory Smite"].Acc = set_combine(sets.precast.WS["Victory Smite"], sets.precast.WSAcc)
    sets.precast.WS["Shijin Spiral"].Acc = set_combine(sets.precast.WS["Shijin Spiral"], sets.precast.WSAcc)
    sets.precast.WS["Dragon Kick"].Acc = set_combine(sets.precast.WS["Dragon Kick"], sets.precast.WSAcc)
    sets.precast.WS["Tornado Kick"].Acc = set_combine(sets.precast.WS["Tornado Kick"], sets.precast.WSAcc)
    --MOD
    sets.precast.WS["Raging Fists"].Mod = set_combine(sets.precast.WS["Raging Fists"], sets.precast.WSMod)
    sets.precast.WS["Howling Fist"].Mod = set_combine(sets.precast.WS["Howling Fist"], sets.precast.WSMod)
    sets.precast.WS["Asuran Fists"].Mod = set_combine(sets.precast.WS["Asuran Fists"], sets.precast.WSMod)
    sets.precast.WS["Ascetic's Fury"].Mod = set_combine(sets.precast.WS["Ascetic's Fury"], sets.precast.WSMod)
    sets.precast.WS["Victory Smite"].Mod = set_combine(sets.precast.WS["Victory Smite"], sets.precast.WSMod)
    sets.precast.WS["Shijin Spiral"].Mod = set_combine(sets.precast.WS["Shijin Spiral"], sets.precast.WSMod)
    sets.precast.WS["Dragon Kick"].Mod = set_combine(sets.precast.WS["Dragon Kick"], sets.precast.WSMod)
    sets.precast.WS["Tornado Kick"].Mod = set_combine(sets.precast.WS["Tornado Kick"], sets.precast.WSMod)


    sets.precast.WS['Cataclysm'] = {}


    -- Midcast Sets
    sets.midcast.FastRecast = {}

    -- Specific spells
    sets.midcast.Utsusemi = {}

    -- Sets to return to when not performing an action.

    -- Resting sets
    sets.resting = {}

    -- Idle sets
    sets.idle = {
        ammo="Ginsen",
        head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
        body="Mummu Jacket +2",
        hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
        legs={ name="Hes. Hose +3", augments={'Enhances "Hundred Fists" effect',}},
        feet="Anch. Gaiters +2",
        neck={ name="Mnk. Nodowa +1", augments={'Path: A',}},
        waist="Moonbow Belt +1",
        left_ear="Cessance Earring",
        right_ear="Sherida Earring",
        left_ring="Defending Ring",
        right_ring="Ilabrat Ring",
        back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','System: 1 ID: 640 Val: 4',}},
    }

    sets.idle.Town = set_combine(sets.idle, {
        feet="Hermes' Sandals",
    })

    sets.idle.Weak = sets.idle

    -- Defense sets
    sets.defense.PDT = {
        ammo="Staunch Tathlum",
        head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
        body="Mummu Jacket +2",
        hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
        legs="Mummu Kecks +2",
        feet="Ahosi Leggings",
        neck="Twilight Torque",
        waist="Moonbow Belt +1",
        left_ear="Odnowa Earring +1",
        right_ear="Sherida Earring",
        left_ring="Defending Ring",
        right_ring="Vocane Ring",
        back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','System: 1 ID: 640 Val: 4',}},
    }

    sets.defense.HP = {}

    sets.defense.MDT = {
        ammo="Staunch Tathlum",
        head="Skormoth Mask",
        body="Emet Harness",
        hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
        legs="Mummu Kecks +2",
        feet="Ahosi Leggings",
        neck="Twilight Torque",
        waist="Moonbow Belt +1",
        left_ear="Sherida Earring",
        right_ear="Odnowa Earring +1",
        left_ring="Vocane Ring",
        right_ring="Defending Ring",
        back="Solemnity Cape",
    }

    sets.Kiting = {
        feet="Hermes' Sandals",
    }

    sets.ExtraRegen = {
        left_ear="Infused Earring",
        neck="Sanctity Necklace",
        body="Hiza. Haramaki +1",
    }

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion

    -- Normal melee sets
    sets.engaged = {
        -- 1089
        main="Spharai",
        ammo="Ginsen",
        head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
        body="Mummu Jacket +2",
        hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
        legs={ name="Hes. Hose +3", augments={'Enhances "Hundred Fists" effect',}},
        feet="Anch. Gaiters +2",
        neck="Mnk. Nodowa +1",
        waist="Moonbow Belt +1",
        left_ear="Cessance Earring",
        right_ear="Sherida Earring",
        left_ring="Epona's Ring",
        right_ring="Ilabrat Ring",
        back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','System: 1 ID: 640 Val: 4',}},
   }
   --=======================================================================
    sets.engaged.Counter = {
        -- 1089
        -- AF+3 Legs 6
        -- Relic Body -- 5
        ammo="Amar Cluster",  --2
        head="Hiza. Somen　+2",  --2
        body="Sweller's Harness", --5
        legs="Mummu Kecks +2",
        back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','System: 1 ID: 640 Val: 4',}}, -- 10
        right_ring="Hizamaru Ring",  --2
        left_ring="Defending Ring",
        neck="Mnk. Nodowa +1",
        left_ear="Cryptic Earring",  --4
        right_ear="Sherida Earring",
    }
   -- =======================================================================
    sets.engaged.SomeAcc = set_combine(sets.engaged, {
        -- 1163
        ammo="Falcon Eye",
        head="Hiza. Somen　+2",
        body="Mummu Jacket +2",
        hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
        legs={ name="Hes. Hose +3", augments={'Enhances "Hundred Fists" effect',}},
        feet="Anch. Gaiters +2",
        neck="Mnk. Nodowa +1",
        waist="Moonbow Belt +1",
        left_ear="Cessance Earring",
        right_ear="Sherida Earring",
        left_ring="Epona's Ring",
        right_ring="Hizamaru Ring",
        back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','System: 1 ID: 640 Val: 4',}},
    })
    -- =======================================================================
    sets.engaged.Acc = {
        -- 1196
        ammo="Falcon Eye",
        head="Hiza. Somen　+2",
        body="Mummu Jacket +2",
        hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
        legs={ name="Hes. Hose +3", augments={'Enhances "Hundred Fists" effect',}},
        feet="Anch. Gaiters +2",
        neck="Mnk. Nodowa +1",
        waist="Moonbow Belt +1",
        left_ear="Cessance Earring",
        right_ear="Sherida Earring",
        left_ring="Mummu Ring",
        right_ring="Hizamaru Ring",
        back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','System: 1 ID: 640 Val: 4',}},
    }
    sets.engaged.Mod = sets.engaged

    -- Defensive melee hybrid sets
    sets.engaged.PDT = {
        main="Spharai",
        ammo="Staunch Tathlum",
        head="Hiza. Somen　+2",
        body="Sweller's Harness",
        hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
        legs="Mummu Kecks +2",
        feet="Ahosi Leggings",
        neck="Twilight Torque",
        waist="Moonbow Belt +1",
        left_ear="Odnowa Earring +1",
        right_ear="Sherida Earring",
        left_ring="Defending Ring",
        right_ring="Vocane Ring",
        back="Solemnity Cape",
    }
    sets.engaged.SomeAcc.PDT = sets.engaged.PDT
    sets.engaged.Acc.PDT = sets.engaged.PDT
    sets.engaged.Counter = set_combine(sets.Counter, {
        -- COUNTER SET / COUNTERSTANCE !!!!!!!!
        ammo="Amar Cluster",  --2
        head="Hiza. Somen　+2",  --2
        body="Sweller's Harness", --5
        legs="Mummu Kecks +2",
        back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','System: 1 ID: 640 Val: 4',}}, -- 10
        right_ring="Hizamaru Ring",  --2
        left_ring="Defending Ring",
        neck="Twilight Torque",
        left_ear="Sherida Earring",
        right_ear="Cryptic Earring",  --4
    })
    sets.engaged.Acc.Counter = sets.engaged.PDT

    -- Hundred Fists/Impetus melee set mods
    sets.engaged.HF = set_combine(sets.engaged)
    sets.engaged.HF.Impetus = set_combine(sets.engaged, {body="Bhikku Cyclas +1",})
    sets.engaged.Acc.HF = set_combine(sets.engaged.Acc)
    sets.engaged.Acc.HF.Impetus = set_combine(sets.engaged.Acc, {body="Bhikku Cyclas +1",})
    sets.engaged.Counter.HF = set_combine(sets.engaged.Counter)
    sets.engaged.Counter.HF.Impetus = set_combine(sets.engaged.Counter, {body="Bhikku Cyclas +1",})
    sets.engaged.Acc.Counter.HF = set_combine(sets.engaged.Acc.Counter)
    sets.engaged.Acc.Counter.HF.Impetus = set_combine(sets.engaged.Acc.Counter, {body="Bhikku Cyclas +1",})

    -- Footwork combat form
    sets.engaged.Footwork = {
        feet="Anch. Gaiters +2",
    }
    sets.engaged.Footwork.Acc = sets.engaged.Footwork

    -- Quick sets for post-precast adjustments, listed here so that the gear can be Validated.
    sets.impetus_body = {
        body="Bhikku Cyclas +1",
    }
    sets.footwork_kick_feet = sets.engaged.Footwork

    sets.boost_gear = {
        waist="Ask Sash"
    }

    -- KEEP BOOST TP BELT ON DURING BOOST:
    sets.engaged.Boost = set_combine(sets.engaged, sets.boost_gear)
    sets.engaged.Boost.Acc = set_combine(sets.engaged, sets.boost_gear)
    sets.engaged.Boost.Counter = set_combine(sets.engaged, sets.boost_gear)
    sets.engaged.Boost.SomeAcc = set_combine(sets.engaged, sets.boost_gear)
    -- THESE ALLOW FOR IMPETUS BODY ON TP (AFTER MUCH TESTING...):
    sets.engaged.Impetus = set_combine(sets.engaged, sets.impetus_body)
    sets.engaged.Impetus.Acc = set_combine(sets.engaged, sets.impetus_body)
    sets.engaged.Impetus.Counter = set_combine(sets.engaged, sets.impetus_body)
    sets.engaged.Impetus.SomeAcc = set_combine(sets.engaged, sets.impetus_body)
    -- SAME WITH FOOTWORK DURING TP:
    sets.engaged.Footwork = set_combine(sets.engaged, sets.footwork_kick_feet)
    sets.engaged.Footwork.Acc = set_combine(sets.engaged, sets.footwork_kick_feet)
    sets.engaged.Footwork.Counter = set_combine(sets.engaged, sets.footwork_kick_feet)
    sets.engaged.Footwork.SomeAcc = set_combine(sets.engaged, sets.footwork_kick_feet)

end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    -- Don't gearswap for weaponskills when Defense is on.
    if spell.type == 'WeaponSkill' and state.DefenseMode.current ~= 'None' then
        eventArgs.handled = true
    end
end

-- Run after the general precast() is done.
function job_post_precast(spell, action, spellMap, eventArgs)
    if spell.type == 'WeaponSkill' and state.DefenseMode.current ~= 'None' then
        if state.Buff.Impetus then
            equip(sets.impetus_body)
        end
        -- Replace Moonshade Earring if we're at cap TP
        if player.tp == 3000 then
            add_to_chat(123, '-- 3K WS SET -- ')
            equip(sets.precast.MaxTP)
        end
    end
end

function job_aftercast(spell, action, spellMap, eventArgs)
    if spell.type == 'WeaponSkill' and not spell.interrupted and state.FootworkWS and state.Buff.Footwork then
        send_command('cancel Footwork')
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    -- Set Footwork as combat form any time it's active and Hundred Fists is not.
    if buff == 'Footwork' and gain and not buffactive['hundred fists'] then
        add_to_chat(123, '-- FOOTWORK ACTIVE -- ')
        state.CombatForm:set('Footwork')
    elseif buff == "Hundred Fists" and not gain and buffactive.footwork then
        state.CombatForm:set('Footwork')
    else
        state.CombatForm:reset()
    end

    if buff == "Boost" and gain then
        classes.CustomMeleeGroups:append('Boost')
    elseif buff == "Boost" and not gain then
        classes.CustomMeleeGroups:clear()
    end

    -- Hundred Fists and Impetus modify the custom melee groups
    if buff == "Hundred Fists" or buff == "Impetus" then
        classes.CustomMeleeGroups:clear()

        if (buff == "Hundred Fists" and gain) or buffactive['hundred fists'] then
            classes.CustomMeleeGroups:append('HF')
        end

        if (buff == "Impetus" and gain) or buffactive.impetus then
            add_to_chat(123, '-- IMPETUS ACTIVE -- ')
            classes.CustomMeleeGroups:append('Impetus')
        end
    end

    -- Update gear if any of the above changed
    if buff == "Hundred Fists" or buff == "Impetus" or buff == "Footwork" or buff == "Boost" then
        handle_equipping_gear(player.status)
    end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

function customize_idle_set(idleSet)
    if player.hpp < 80 then
        add_to_chat(123, '-- REGEN SET ACTIVE -- ')
        idleSet = set_combine(idleSet, sets.ExtraRegen)
    end
    if state.Buff.Impetus then
        idleSet = set_combine(idleSet, {
            body="Bhikku Cyclas +1",
        })
    end
    if state.Buff.Boost then
        idleSet = set_combine(idleSet, sets.boost_gear)
    end
    return idleSet
end

-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
    update_combat_form()
    update_melee_groups()
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function update_combat_form()
    if buffactive.footwork and not buffactive['hundred fists'] then
        state.CombatForm:set('Footwork')
    else
        state.CombatForm:reset()
    end
end

function update_melee_groups()
    classes.CustomMeleeGroups:clear()

    if buffactive['hundred fists'] then
        classes.CustomMeleeGroups:append('HF')
    end

    if buffactive.impetus then
        classes.CustomMeleeGroups:append('Impetus')
    end

    if buffactive.boost then
        classes.CustomMeleeGroups:append('Boost')
    end
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'DNC' then
        set_macro_page(8, 9)
    elseif player.sub_job == 'NIN' then
        set_macro_page(2, 1)
    elseif player.sub_job == 'THF' then
        set_macro_page(4, 9)
    elseif player.sub_job == 'RUN' then
        set_macro_page(1, 1)
    else
        set_macro_page(1, 9)
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Custom event hooks.
-------------------------------------------------------------------------------------------------------------------

-- Keep track of the current hit count while Impetus is up.
function on_action_for_impetus(action)
    if state.Buff.Impetus then  -- count melee hits by player
        if action.actor_id == player.id then
            if action.category == 1 then
                for _,target in pairs(action.targets) do
                    for _,action in pairs(target.actions) do
                        -- Reactions (bitset):
                        -- 1 = evade
                        -- 2 = parry
                        -- 4 = block/guard
                        -- 8 = hit
                        -- 16 = JA/weaponskill?
                        -- If action.reaction has bits 1 or 2 set, it missed or was parried. Reset count.
                        if (action.reaction % 4) > 0 then
                            info.impetus_hit_count = 0
                        else
                            info.impetus_hit_count = info.impetus_hit_count + 1
                        end
                    end
                end
            elseif action.category == 3 then
                -- Missed weaponskill hits will reset the counter.  Can we tell?
                -- Reaction always seems to be 24 (what does this value mean? 8=hit, 16=?)
                -- Can't tell if any hits were missed, so have to assume all hit.
                -- Increment by the minimum number of weaponskill hits: 2.
                for _,target in pairs(action.targets) do
                    for _,action in pairs(target.actions) do
                        -- This will only be if the entire weaponskill missed or was parried.
                        if (action.reaction % 4) > 0 then
                            info.impetus_hit_count = 0
                        else
                            info.impetus_hit_count = info.impetus_hit_count + 2
                        end
                    end
                end
            end
        elseif action.actor_id ~= player.id and action.category == 1 then
            -- If mob hits the player, check for counters.
            for _,target in pairs(action.targets) do
                if target.id == player.id then
                    for _,action in pairs(target.actions) do
                        -- Spike effect animation:
                        -- 63 = counter
                        -- ?? = missed counter
                        if action.has_spike_effect then -- spike_effect_message of 592 == missed counter
                            if action.spike_effect_message == 592 then
                                info.impetus_hit_count = 0
                            elseif action.spike_effect_animation == 63 then
                                info.impetus_hit_count = info.impetus_hit_count + 1
                            end
                        end
                    end
                end
            end
        end
        if info.impetus_hit_count % 10 == 0 and info.impetus_hit_count > 1 then
            add_to_chat(123, '-- Impetus Count = ' .. tostring(info.impetus_hit_count))
        end
    else
        info.impetus_hit_count = 0
    end
end
