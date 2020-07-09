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
    state.Buff['Afflatus Solace'] = buffactive['Afflatus Solace'] or false
    state.Buff['Afflatus Misery'] = buffactive['Afflatus Misery'] or false
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('None', 'Normal')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'PDT')

    select_default_macro_book()
end

-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------

    -- Precast Sets

    -- Fast cast sets for spells
    sets.precast.FC = {
        sub="Ammurapi Shield",
        body="Inyanga Jubbah +1",  --13
        legs="Aya. Cosciales +2", -- 5
        back={ name="Alaunus's Cape", augments={'MND+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+5','"Fast Cast"+10','Occ. inc. resist. to stat. ailments+10',}},
    }
        
    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {})

    sets.precast.FC.Stoneskin = set_combine(sets.precast.FC['Enhancing Magic'], {})

    sets.precast.FC['Healing Magic'] = set_combine(sets.precast.FC, {legs="Orison Pantaloons +2"})

    sets.precast.FC.StatusRemoval = sets.precast.FC['Healing Magic']

    sets.precast.FC.Cure = set_combine(sets.precast.FC['Healing Magic'], {
        left_ear="Nourish. Earring",
    })
    sets.precast.FC.Curaga = sets.precast.FC.Cure
    sets.precast.FC.CureSolace = sets.precast.FC.Cure
    -- CureMelee spell map should default back to Healing Magic.
    
    -- Precast sets to enhance JAs
    sets.precast.JA.Benediction = {body="Piety Briault"}

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {}
    
    
    -- Weaponskill sets

    -- Default set for any weaponskill that isn't any more specifically defined
    gear.default.weaponskill_neck = "Asperity Necklace"
    gear.default.weaponskill_waist = ""
    sets.precast.WS = {}
    
    sets.precast.WS['Flash Nova'] = {}
    

    -- Midcast Sets ------------------------------------------------------------------------------------------
    
    sets.midcast.FastRecast = {}
    
    -- Cure sets
    gear.default.obi_waist = "Goading Belt"
    gear.default.obi_back = "Mending Cape"

    sets.midcast.CureSolace = {}

    sets.midcast.Cure = {
        main={ name="Queller Rod", augments={'Healing magic skill +15','"Cure" potency +10%','"Cure" spellcasting time -7%',}},
        sub="Sors Shield",
        ammo="Kalboron Stone",
        head="Inyanga Tiara +2",
        body="Inyanga Jubbah +1",  --13
        hands="Weath. Cuffs +1",
        legs="Assiduity Pants",
        feet="Weath. Souliers +1",
        neck="Clr. Torque +1",
        waist="Belisama's Rope +1",
        left_ear="Nourish. Earring",
        right_ear="Flashward Earring",
        left_ring="Stikini Ring",
        right_ring="Stikini Ring",
        back={ name="Alaunus's Cape", augments={'MND+20','"Cure" potency +10%',}},
    }

    sets.midcast.CureSolace = set_combine(sets.midcast.Cure, {

    })
    sets.midcast.Curaga = sets.midcast.Cure

    sets.midcast.CureMelee = {}

    sets.midcast.Cursna = {
        main={ name="Queller Rod", augments={'Healing magic skill +15','"Cure" potency +10%','"Cure" spellcasting time -7%',}},
        sub="Ammurapi Shield",
        body="Inyanga Jubbah +1",
        hands="Inyan. Dastanas +2",
        legs="Aya. Cosciales +2",
        neck="Malison Medallion",
        left_ring = {name="Ephedra Ring", bag="wardrobe1"},
        right_ring = {name="Ephedra Ring", bag="wardrobe2"},
        back={ name="Alaunus's Cape", augments={'MND+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+5','"Fast Cast"+10','Occ. inc. resist. to stat. ailments+10',}},
    }

    sets.midcast.StatusRemoval = {
        neck="Clr. Torque +1",
    }

    -- 110 total Enhancing Magic Skill; caps even without Light Arts
    sets.midcast['Enhancing Magic'] = {
        hands="Inyanga Dastanas +2",
        left_ring="Stikini Ring",
        right_ring="Stikini Ring",
    }

    sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {

    })

    sets.midcast.Auspice = set_combine(sets.midcast['Enhancing Magic'], {

    })

    sets.midcast.BarElement = set_combine(sets.midcast['Enhancing Magic'], {

    })

    sets.midcast.Regen =  set_combine(sets.midcast['Enhancing Magic'], {
        head="Inyanga Tiara +2",
    })

    sets.midcast.Protectra = set_combine(sets.midcast['Enhancing Magic'], {

    })

    sets.midcast.Shellra = set_combine(sets.midcast['Enhancing Magic'], {
        
    })


    sets.midcast['Divine Magic'] = {}

    sets.midcast['Dark Magic'] = {}

    -- Custom spell classes
    sets.midcast.MndEnfeebles = {
        sub="Ammurapi Shield",
        hands="Inyan. Dastanas +2",
        body={ name="Vanya Robe", augments={'HP+50','MP+50','"Refresh"+2',}},
        head="Inyanga Tiara +2",
        legs="Aya. Cosciales +2", 
        feet="Aya. Gambieras",
        hands="Inyan. Dastanas +2",
        left_ring="Stikini Ring",
        right_ring="Stikini Ring",
    }

    sets.midcast.IntEnfeebles = {
        sub="Ammurapi Shield",
        hands="Inyan. Dastanas +2",
        body={ name="Vanya Robe", augments={'HP+50','MP+50','"Refresh"+2',}},
        head="Inyanga Tiara +2",
        legs="Aya. Cosciales +2",
        hands="Inyan. Dastanas +2",
        feet="Aya. Gambieras",
        left_ring="Stikini Ring",
        right_ring="Stikini Ring",
    }

    
    -- Sets to return to when not performing an action.
    
    -- Resting sets
    sets.resting = {}
    

    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
    sets.idle = {
        main={ name="Queller Rod", augments={'Healing magic skill +15','"Cure" potency +10%','"Cure" spellcasting time -7%',}},
        sub="Ammurapi Shield",
        ammo="Kalboron Stone",
        head="Inyanga Tiara +2",
        body={ name="Vanya Robe", augments={'HP+50','MP+50','"Refresh"+2',}},
        hands="Inyan. Dastanas +2",
        legs="Assiduity Pants",
        feet="Inyan. Crackows +2",
        neck="Loricate Torque +1",
        waist="Belisama's Rope +1",
        left_ear="Nourish. Earring",
        right_ear="Flashward Earring",
        left_ring="Inyanga Ring",
        right_ring="Woltaris Ring",
        back={ name="Alaunus's Cape", augments={'MND+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+5','"Fast Cast"+10','Occ. inc. resist. to stat. ailments+10',}},
    }

    sets.idle.PDT = {}

    sets.idle.Town = sets.idle
    
    sets.idle.Weak = sets.idle
    
    -- Defense sets

    sets.defense.PDT = {}

    sets.defense.MDT = {}

    sets.Kiting = {feet="Herald's Gaiters"}

    sets.latent_refresh = {waist="Fucho-no-obi"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Basic set for if no TP weapon is defined.
    sets.engaged = {}


    -- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
    sets.buff['Divine Caress'] = {
        back="Mending Cape"
    }
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    if spell.english == "Paralyna" and buffactive.Paralyzed then
        -- no gear swaps if we're paralyzed, to avoid blinking while trying to remove it.
        eventArgs.handled = true
    end
    
    if spell.skill == 'Healing Magic' then
        gear.default.obi_back = "Mending Cape"
    else
        gear.default.obi_back = "Toro Cape"
    end
end


function job_post_midcast(spell, action, spellMap, eventArgs)
    -- Apply Divine Caress boosting items as highest priority over other gear, if applicable.
    if spellMap == 'StatusRemoval' and buffactive['Divine Caress'] then
        equip(sets.buff['Divine Caress'])
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    if stateField == 'Offense Mode' then
        if newValue == 'Normal' then
            disable('main','sub','range')
        else
            enable('main','sub','range')
        end
    end
end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Custom spell mapping.
function job_get_spell_map(spell, default_spell_map)
    if spell.action_type == 'Magic' then
        if (default_spell_map == 'Cure' or default_spell_map == 'Curaga') and player.status == 'Engaged' then
            return "CureMelee"
        elseif default_spell_map == 'Cure' and state.Buff['Afflatus Solace'] then
            return "CureSolace"
        elseif spell.skill == "Enfeebling Magic" then
            if spell.type == "WhiteMagic" then
                return "MndEnfeebles"
            else
                return "IntEnfeebles"
            end
        end
    end
end


function customize_idle_set(idleSet)
    if player.mpp < 75 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
    return idleSet
end

-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
    if cmdParams[1] == 'user' and not areas.Cities:contains(world.area) then
        local needsArts = 
            player.sub_job:lower() == 'sch' and
            not buffactive['Light Arts'] and
            not buffactive['Addendum: White'] and
            not buffactive['Dark Arts'] and
            not buffactive['Addendum: Black']
            
        if not buffactive['Afflatus Solace'] and not buffactive['Afflatus Misery'] then
            if needsArts then
                send_command('@input /ja "Afflatus Solace" <me>;wait 1.2;input /ja "Light Arts" <me>')
            else
                send_command('@input /ja "Afflatus Solace" <me>')
            end
        end
    end
end


-- Function to display the current relevant user state when doing an update.
function display_current_job_state(eventArgs)
    display_current_caster_state()
    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    set_macro_page(1, 1)
end

