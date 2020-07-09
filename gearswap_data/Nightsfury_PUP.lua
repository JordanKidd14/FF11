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
    -- List of pet weaponskills to check for
    petWeaponskills = S{
        "Slapstick", "Knockout", "Magic Mortar",
        "Chimera Ripper", "String Clipper",  "Cannibal Blade", "Bone Crusher", "String Shredder",
        "Arcuballista", "Daze", "Armor Piercer", "Armor Shatterer"
    }
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'Acc', 'PetTank')
    state.WeaponskillMode:options('Normal', 'Acc', 'PetTank')
    state.PhysicalDefenseMode:options('PetTank')

    -- Default maneuvers 1, 2, 3 and 4 for each pet mode.
    defaultManeuvers = {}

    update_pet_mode()
    select_default_macro_book()
end


-- Define sets used by this job file.
function init_gear_sets()

    -- Precast Sets

    -- Fast cast sets for spells
    sets.precast.FC = {}

    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {})


    -- Precast sets to enhance JAs
    sets.precast.JA['Tactical Switch'] = {
        feet="Cirque Scarpe +1"
    }

    sets.precast.JA['Repair'] = {
        right_ear="Guignol Earring", -- 20
        ammo="Automat. Oil +3", -- 40 regen base, 120 sec. +30 regen =  +12 regen = 52
        feet="Pup. Babouches", -- remove 1 effect
        main={ name="Nibiru Sainti", augments={'Melee skill +16','Ranged skill +16','Magic skill +16',}} -- 10
    }

    sets.precast.JA.Maneuver = {
        body="Cirque Farsetto +1",
        hands="Pup. Dastanas",
        neck="Bfn. Collar +1",
        left_ear="Burana Earring",
        back={ name="Visucius's Mantle", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Accuracy+20 Attack+20','Pet: Attack+2 Pet: Rng.Atk.+2','Pet: Haste+10',}},
    }



    -- Waltz set (chr and vit)
    sets.precast.Waltz = {}

    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}


    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
        head={ name="Ryuo Somen", augments={'STR+10','DEX+10','Accuracy+15',}},
        body={ name="Ryuo Domaru", augments={'STR+10','DEX+10','Accuracy+15',}},
        hands={ name="Ryuo Tekko", augments={'STR+10','DEX+10','Accuracy+15',}},
        legs="Hiza. Hizayoroi +2",
        feet={ name="Herculean Boots", augments={'"Triple Atk."+4','AGI+2','Accuracy+12',}},
        neck="Caro Necklace",
        waist="Grunfeld Rope",
        left_ear="Brutal Earring",
        right_ear="Enmerkar Earring",
        left_ring="Petrov Ring",
        right_ring="Epona's Ring",
        back={ name="Visucius's Mantle", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Accuracy+20 Attack+20','Pet: Attack+2 Pet: Rng.Atk.+2','Pet: Haste+10',}},
    }

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Stringing Pummel'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Stringing Pummel'].Mod = set_combine(sets.precast.WS['Stringing Pummel'], {})
    sets.precast.WS['Victory Smite'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Shijin Spiral'] = set_combine(sets.precast.WS, {})

    -- Midcast Sets

    sets.midcast.FastRecast = {}


    -- Midcast sets for pet actions
    sets.midcast.Pet.Cure = {legs="Foire Churidars", waist="Ukko Sash"}

    sets.midcast.Pet['Elemental Magic'] = {feet="Pitre Babouches", waist="Ukko Sash"}

    sets.midcast.Pet.WeaponSkill = {
        head="Tali'ah Turban +1",
        body={ name="Rao Togi", augments={'Pet: HP+100','Pet: Accuracy+15','Pet: Damage taken -3%',}},
        hands={ name="Rao Kote", augments={'Pet: HP+100','Pet: Accuracy+15','Pet: Damage taken -3%',}},
        legs="Tali'ah Seraweels",
        feet="Tali'ah Crackows +1",
        neck="Empath Necklace",
        waist="Klouskap Sash",
        left_ear="Burana Earring",
        right_ear="Enmerkar Earring",
        left_ring="Overbearing Ring",
        right_ring="Varar Ring",
        back={ name="Visucius's Mantle", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Accuracy+20 Attack+20','Pet: Attack+2 Pet: Rng.Atk.+2','Pet: Haste+10',}},
    }


    -- Sets to return to when not performing an action.

    -- Resting sets
    sets.resting = {}


    -- Idle sets

    sets.idle = {
        main={ name="Ohtas", augments={'Accuracy+70','Pet: Accuracy+70','Pet: Haste+10%',}},
        range="Animator P",
        ammo="Automat. Oil +3",
        head="Tali'ah Turban +1",
        body={ name="Rao Togi", augments={'Pet: HP+100','Pet: Accuracy+15','Pet: Damage taken -3%',}},
        hands={ name="Rao Kote", augments={'Pet: HP+100','Pet: Accuracy+15','Pet: Damage taken -3%',}},
        legs={ name="Herculean Trousers", augments={'Accuracy+14 Attack+14','Weapon skill damage +2%','STR+4','Accuracy+15','Attack+12',}},
        feet={ name="Herculean Boots", augments={'Accuracy+25 Attack+25','Crit.hit rate+1','AGI+1','Attack+9',}},
        neck="Empath Necklace",
        waist="Klouskap sash",
        left_ear="Burana Earring",
        right_ear="Enmerkar Earring",
        left_ring="Overbearing Ring",
        right_ring="Thurandaut Ring",
        back={ name="Visucius's Mantle", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Accuracy+20 Attack+20','Pet: Attack+2 Pet: Rng.Atk.+2','Pet: Haste+10',}},
    }

    sets.idle.Town = set_combine(sets.idle, {})

    -- Set for idle while pet is out (eg: pet regen gear)
    sets.idle.Pet = sets.idle

    -- Idle sets to wear while pet is engaged
    sets.idle.Pet.Engaged = set_combine(sets.defense.PDT, {
        main={ name="Ohtas", augments={'Accuracy+70','Pet: Accuracy+70','Pet: Haste+10%',}},
    })

    sets.idle.Pet.Engaged.Ranged = set_combine(sets.idle.Pet.Engaged, {hands="Cirque Guanti +1",legs="Cirque Pantaloni +1"})

    sets.idle.Pet.Engaged.Nuke = set_combine(sets.idle.Pet.Engaged, {legs="Cirque Pantaloni +1",feet="Cirque Scarpe +1"})

    sets.idle.Pet.Engaged.Magic = set_combine(sets.idle.Pet.Engaged, {legs="Cirque Pantaloni +1",feet="Cirque Scarpe +1"})


    -- Defense sets

    sets.defense.Evasion = {}

    sets.defense.PDT = {
        main={ name="Midnights", augments={'Pet: Attack+25','Pet: Accuracy+25','Pet: Damage taken -3%',}},
        range="Animator P",
        ammo="Automat. Oil +3",
        head="Tali'ah Turban +1",
        body={ name="Rao Togi", augments={'Pet: HP+100','Pet: Accuracy+15','Pet: Damage taken -3%',}},
        hands={ name="Rao Kote", augments={'Pet: HP+100','Pet: Accuracy+15','Pet: Damage taken -3%',}},
        legs={ name="Herculean Trousers", augments={'Pet: "Mag.Atk.Bns."+25','Pet: "Dbl. Atk."+4','Pet: DEX+3','Pet: Attack+14 Pet: Rng.Atk.+14',}},
        feet="Tali'ah Crackows +1",
        neck="Shepherd's Chain",
        waist="Klouskap Sash",
        left_ear="Burana Earring",
        right_ear="Enmerkar Earring",
        left_ring="Overbearing Ring",
        right_ring="Thurandaut Ring",
        back={ name="Visucius's Mantle", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Accuracy+20 Attack+20','Pet: Attack+2 Pet: Rng.Atk.+2','Pet: Haste+10',}},
    }

    sets.defense.MDT = sets.defense.PDT

    sets.Kiting = {feet="Hermes' Sandals"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion

    -- Normal melee group
    sets.engaged = {
        head="Tali'ah Turban +1",
        body={ name="Ryuo Domaru", augments={'STR+10','DEX+10','Accuracy+15',}},
        hands="Tali'ah Gages +1",
        legs={ name="Samnuha Tights", augments={'STR+8','DEX+9','"Dbl.Atk."+3','"Triple Atk."+2',}},
        feet={ name="Herculean Boots", augments={'"Triple Atk."+4','AGI+2','Accuracy+12',}},
        neck="Empath Necklace",
        waist="Klouskap Sash",
        left_ear="Brutal Earring",
        right_ear="Enmerkar Earring",
        left_ring="Petrov Ring",
        right_ring="Varar Ring",
        back={ name="Visucius's Mantle", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Accuracy+20 Attack+20','Pet: Attack+2 Pet: Rng.Atk.+2','Pet: Haste+10',}},
    }

    sets.engaged.Acc = sets.engaged
    sets.engaged.DT = sets.defense.PDT
    sets.engaged.Acc.DT = sets.defense.PDT

end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when pet is about to perform an action
function job_pet_midcast(spell, action, spellMap, eventArgs)
    if petWeaponskills:contains(spell.english) then
        classes.CustomClass = "Weaponskill"

    end
end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    if buff == 'Wind Maneuver' then

    end
end

-- Called when a player gains or loses a pet.
-- pet == pet gained or lost
-- gain == true if the pet was gained, false if it was lost.
function job_pet_change(pet, gain)

end

-- Called when the pet's status changes.
function job_pet_status_change(newStatus, oldStatus)
    if newStatus == 'Engaged' then
        display_pet_status()
    end
end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)

end


-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)
    display_pet_status()
end


-------------------------------------------------------------------------------------------------------------------
-- User self-commands.
-------------------------------------------------------------------------------------------------------------------

-- Called for custom player commands.
function job_self_command(cmdParams, eventArgs)
    if cmdParams[1] == 'maneuver' then
        if pet.isvalid then
    add_to_chat(104, 'Pet WS applied!')
        end
    end
end


-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Get the pet mode value based on the equipped head of the automaton.
-- Returns nil if pet is not valid.
function get_pet_mode()

end

-- Update state.PetMode, as well as functions that use it for set determination.
function update_pet_mode()

end

-- Update custom groups based on the current pet.
function update_custom_groups()

end

-- Display current pet status.
function display_pet_status()
    if pet.isvalid then
        local petInfoString = pet.name..' ['..pet.head..']: '..tostring(pet.status)..'  TP='..tostring(pet.tp)..'  HP%='..tostring(pet.hpp)

        add_to_chat(122,petInfoString)
    end
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
        set_macro_page(9, 1)
end