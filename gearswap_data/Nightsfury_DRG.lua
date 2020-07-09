-------------------------------------------------------------------------------------------------------------------
-- Initialization function that defines sets and variables to be used.
-------------------------------------------------------------------------------------------------------------------

-- IMPORTANT: Make sure to also get the Mote-Include.lua file (and its supplementary files) to go with this.

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
    -- Load and initialize the include file.
    include('Mote-Include.lua')
    --include('organizer-lib')
end


-- Setup vars that are user-independent.
function job_setup()
    get_combat_form()
    include('Mote-TreasureHunter')
    state.TreasureMode:set('Tag')   
    
    state.CapacityMode = M(false, 'Capacity Point Mantle')
    
    -- list of weaponskills that make better use of otomi helm in low acc situations
    wsList = S{}

    state.Buff = {}
    -- JA IDs for actions that always have TH: Provoke, Animated Flourish
    info.default_ja_ids = S{}
    -- Unblinkable JA IDs for actions that always have TH: Quick/Box/Stutter Step, Desperate/Violent Flourish
    info.default_u_ja_ids = S{}
end


-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    -- Options: Override default values
    state.OffenseMode:options('Normal')
    state.HybridMode:options('Normal')
    state.WeaponskillMode:options('Normal')
    state.PhysicalDefenseMode:options('PDT', 'Reraise')
    state.MagicalDefenseMode:options('MDT')
    
    war_sj = player.sub_job == 'WAR' or false

    select_default_macro_book(1, 16)
    send_command('bind != gs c toggle CapacityMode')
    send_command('bind ^= gs c cycle treasuremode')
    send_command('bind ^[ input /lockstyle on')
    send_command('bind ![ input /lockstyle off')
end


-- Called when this job file is unloaded (eg: job change)
function file_unload()
    send_command('unbind ^[')
    send_command('unbind ![')
    send_command('unbind ^=')
    send_command('unbind !=')
end


-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
    Taeon = {}
    Taeon.Hands = {}
    Acro = {}
    Acro.Hands = {}
    Acro.Feet = {}
    Acro.Hands.Haste = {} 
    Acro.Hands.STP = {}
    Acro.Feet.STP = {} 
    Acro.Feet.WSD = {} 
    
    -- Precast Sets
    -- Precast sets to enhance JAs
    sets.precast.JA.Angon = {ammo="Angon",hands="Pteroslaver Finger Gauntlets"}
    sets.CapacityMantle = {back="Mecistopins Mantle"}
    --sets.Berserker = {neck="Berserker's Torque"}
    sets.WSDayBonus = { }
    sets.Organizer = {}

    sets.precast.JA.Jump = {

    }

    sets.precast.JA['Ancient Circle'] = {}
    sets.TreasureHunter = {
        waist="Chaac Belt",
        feet={ name="Valorous Greaves", augments={'"Fast Cast"+2','Pet: "Mag.Atk.Bns."+28','"Treasure Hunter"+1','Accuracy+18 Attack+18',}},
    }

    sets.precast.JA['High Jump'] = set_combine(sets.precast.JA.Jump, {}) 
    sets.precast.JA['Soul Jump'] = set_combine(sets.precast.JA.Jump, {})
    sets.precast.JA['Spirit Jump'] = set_combine(sets.precast.JA.Jump, {})
    sets.precast.JA['Super Jump'] = sets.precast.JA.Jump
    sets.precast.JA['Spirit Link'] = {}
    sets.precast.JA['Call Wyvern'] = {}
    sets.precast.JA['Deep Breathing'] = {}
    sets.precast.JA['Spirit Surge'] = {}
    
    -- Healing Breath sets
    sets.HB = {

    }

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {

    }
        
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}

    -- Fast cast sets for spells
    sets.precast.FC = {

    }
    
    -- Midcast Sets
    sets.midcast.FastRecast = {

    }
        
    sets.midcast.Breath = set_combine(sets.midcast.FastRecast, {  })
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined

    sets.precast.WS = {
        ammo="Knobkierrie",
        head={ name="Valorous Mask", augments={'Accuracy+25','Weapon skill damage +4%','VIT+14','Attack+5',}},
        body={ name="Valorous Mail", augments={'Pet: Phys. dmg. taken -4%','Weapon Skill Acc.+3','Weapon skill damage +10%','Mag. Acc.+8 "Mag.Atk.Bns."+8',}},
        hands="Sulev. Gauntlets +2",
        legs={ name="Valor. Hose", augments={'Attack+17','"Dbl.Atk."+4','VIT+4','Accuracy+8',}},
        feet="Sulev. Leggings +1",
        neck="Caro Necklace",
        waist="Ioskeha Belt +1",
        left_ear="Ishvara Earring",
        right_ear="Sherida Earring",
        left_ring="Petrov Ring",
        right_ring="Rajas Ring",
        back={ name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}},
    }
    sets.precast.WS.Acc = sets.precast.WS


    sets.precast.WS['Impulse Drive'] = set_combine(sets.precast.WS, {
        ammo="Knobkierrie",
        head={ name="Valorous Mask", augments={'Accuracy+25','Weapon skill damage +4%','VIT+14','Attack+5',}},
        body={ name="Valorous Mail", augments={'Pet: Phys. dmg. taken -4%','Weapon Skill Acc.+3','Weapon skill damage +10%','Mag. Acc.+8 "Mag.Atk.Bns."+8',}},
        hands="Sulev. Gauntlets +2",
        legs={ name="Valor. Hose", augments={'Attack+17','"Dbl.Atk."+4','VIT+4','Accuracy+8',}},
        feet="Sulev. Leggings +1",
        neck="Caro Necklace",
        waist="Grunfeld Rope",
        left_ear="Ishvara Earring",
        right_ear="Sherida Earring",
        left_ring="Petrov Ring",
        right_ring="Rajas Ring",
        back={ name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}},
    })
    sets.precast.WS['Impulse Drive'].Mid = sets.precast.WS['Impulse Drive']
    sets.precast.WS['Impulse Drive'].Acc = sets.precast.WS['Impulse Drive']
    

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    -- DAMAGE VARIES & CRIT RATE+
    sets.precast.WS['Stardiver'] = set_combine(sets.precast.WS, {
        neck="Shadow Gorget",
        waist="Soil Belt"
    })
    sets.precast.WS['Stardiver'].Mid = sets.precast.WS['Stardiver']
    sets.precast.WS['Stardiver'].Acc = sets.precast.WS['Stardiver']


    --IGNORE DEF
    sets.precast.WS["Camlann's Torment"] = set_combine(sets.precast.WS, {

    })
    sets.precast.WS["Camlann's Torment"].Mid = sets.precast.WS["Camlann's Torment"]
    sets.precast.WS["Camlann's Torment"].Acc = sets.precast.WS["Camlann's Torment"]


    --CRIT
    sets.precast.WS['Drakesbane'] = set_combine(sets.precast.WS, {
        ammo="Knobkierrie",
        head={ name="Valorous Mask", augments={'Accuracy+25','Weapon skill damage +4%','VIT+14','Attack+5',}},
        body={ name="Valorous Mail", augments={'Pet: Phys. dmg. taken -4%','Weapon Skill Acc.+3','Weapon skill damage +10%','Mag. Acc.+8 "Mag.Atk.Bns."+8',}},
        hands="Flam. Manopolas +1",
        legs={ name="Valor. Hose", augments={'Attack+17','"Dbl.Atk."+4','VIT+4','Accuracy+8',}},
        feet="Sulev. Leggings +1",
        neck="Caro Necklace",
        waist="Grunfeld Rope",
        left_ear="Ishvara Earring",
        right_ear="Sherida Earring",
        left_ring="Begrudging Ring",
        right_ring="Rajas Ring",
        back={ name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}},
    })
    sets.precast.WS['Drakesbane'].Mid = sets.precast.WS['Drakesbane']
    sets.precast.WS['Drakesbane'].Acc = sets.precast.WS['Drakesbane']


    sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {
        ammo="Knobkierrie",
        head={ name="Valorous Mask", augments={'Accuracy+25','Weapon skill damage +4%','VIT+14','Attack+5',}},
        body={ name="Valorous Mail", augments={'Pet: Phys. dmg. taken -4%','Weapon Skill Acc.+3','Weapon skill damage +10%','Mag. Acc.+8 "Mag.Atk.Bns."+8',}},
        hands="Sulev. Gauntlets +1",
        legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
        feet="Sulev. Leggings +1",
        neck="Caro Necklace",
        waist="Ioskeha Belt +1",
        left_ear="Ishvara Earring",
        right_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
        left_ring="Petrov Ring",
        right_ring="Rajas Ring",
        back={ name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}},
    })
    sets.precast.WS['Savage Blade'].Mid = sets.precast.WS['Savage Blade']
    sets.precast.WS['Savage Blade'].Acc = sets.precast.WS['Savage Blade']

    -- Sets to return to when not performing an action.
    

    -- Resting sets
    sets.resting = {}
    

    -- Idle sets
    sets.idle = {
        ammo="Ginsen",
        head="Flam. Zucchetto +2",
        body="Sulevia's Plate. +1",
        hands="Sulev. Gauntlets +1",
        legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
        feet="Flam. Gambieras +2",
        neck="Lissome Necklace",
        waist="Ioskeha Belt +1",
        left_ear="Cessance Earring",
        right_ear="Sherida Earring",
        left_ring="Petrov Ring",
        right_ring="Rajas Ring",
        back={ name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}},
    }

    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
    sets.idle.Town = {
        ammo="Ginsen",
        head="Flam. Zucchetto +2",
        body="Flamma Korazin +2",
        hands="Sulev. Gauntlets +2",
        legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
        feet="Flam. Gambieras +2",
        neck="Lissome Necklace",
        waist="Ioskeha Belt +1",
        left_ear="Cessance Earring",
        right_ear="Sherida Earring",
        left_ring="Petrov Ring",
        right_ring="Rajas Ring",
        back={ name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}},
    }
    
    sets.idle.Field = set_combine(sets.idle.Town, {
        legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
    })

    sets.idle.Regen = set_combine(sets.idle.Field, {

    })

    sets.idle.Weak = set_combine(sets.idle.Field, {

    })
    
    -- Defense sets
    sets.defense.PDT = {
        ammo="Staunch Tathlum",
        head="Flam. Zucchetto +2",
        body="Sulevia's Plate. +1",
        hands="Sulev. Gauntlets +2",
        feet="Sulev. Leggings +1",
        neck="Twilight Torque",
        waist="Ioskeha Belt +1",
        left_ear="Odnowa Earring +1",
        right_ear="Sherida Earring",
        left_ring="Moonbeam Ring",
        right_ring="Defending Ring",
        back={ name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}},
    }

    sets.defense.Reraise = set_combine(sets.defense.PDT, {
    
    })

    sets.defense.MDT = sets.defense.PDT

    sets.Kiting = {
       
    }

    sets.Reraise = {head="Twilight Helm",body="Twilight Mail"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    sets.engaged = {
        ammo="Ginsen",
        head="Flam. Zucchetto +2",
        body="Flamma Korazin +2",
        hands="Sulev. Gauntlets +2",
        legs={ name="Valor. Hose", augments={'Attack+17','"Dbl.Atk."+4','VIT+4','Accuracy+8',}},
        feet="Flam. Gambieras +2",
        neck="Lissome Necklace",
        waist="Ioskeha Belt +1",
        left_ear="Cessance Earring",
        right_ear="Sherida Earring",
        left_ring="Petrov Ring",
        right_ring="Rajas Ring",
        back={ name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}},
    }

    sets.engaged.Mid = set_combine(sets.engaged, {
   
    })

    sets.engaged.Acc = set_combine(sets.engaged.Mid, {
        ammo="Ginsen",
        head="Flam. Zucchetto +2",
        body="Flamma Korazin +2",
        hands="Sulev. Gauntlets +2",
        legs={ name="Valor. Hose", augments={'Attack+17','"Dbl.Atk."+4','VIT+4','Accuracy+8',}},
        feet="Flam. Gambieras +2",
        neck="Lissome Necklace",
        waist="Ioskeha Belt +1",
        left_ear="Cessance Earring",
        right_ear="Sherida Earring",
        left_ring="Petrov Ring",
        right_ring="Rajas Ring",
        back={ name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}},
    })

    sets.engaged.PDT = sets.defense.PDT
    sets.engaged.Mid.PDT = sets.defense.PDT
    sets.engaged.Acc.PDT = sets.defense.PDT

    sets.engaged.War = set_combine(sets.engaged, {
      
    })
    sets.engaged.War.Mid = set_combine(sets.engaged.Mid, {
     
    })

    sets.engaged.Reraise = set_combine(sets.engaged, {
    
    })

    sets.engaged.Acc.Reraise = sets.engaged.Reraise

end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks that are called to process player actions at specific points in time.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic target handling to be done.
function job_pretarget(spell, action, spellMap, eventArgs)
    if spell.english == "Spirit Jump" then
        if not pet.isvalid then
            cancel_spell()
            send_command('Jump')
        end
    elseif spell.english == "Soul Jump" then
        if not pet.isvalid then
            cancel_spell()
            send_command("High Jump")
        end
    end
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
end

-- Run after the default precast() is done.
-- eventArgs is the same one used in job_precast, in case information needs to be persisted.
function job_post_precast(spell, action, spellMap, eventArgs)
    if player.hpp < 51 then
        classes.CustomClass = "Breath" 
    end
end


-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_midcast(spell, action, spellMap, eventArgs)
    if spell.action_type == 'Magic' then
        equip(sets.midcast.FastRecast)
        if player.hpp < 51 then
            classes.CustomClass = "Breath" 
        end
    end
end

-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
end

function job_pet_precast(spell, action, spellMap, eventArgs)
end
-- Runs when a pet initiates an action.
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_pet_midcast(spell, action, spellMap, eventArgs)
    if spell.english:startswith('Healing Breath') or spell.english == 'Restoring Breath' or spell.english == 'Steady Wing' or spell.english == 'Smiting Breath' then
        equip(sets.HB)
    end
end

-- Run after the default pet midcast() is done.
-- eventArgs is the same one used in job_pet_midcast, in case information needs to be persisted.
function job_pet_post_midcast(spell, action, spellMap, eventArgs)
    
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
    if state.HybridMode.value == 'Reraise' or
    (state.HybridMode.value == 'Physical' and state.PhysicalDefenseMode.value == 'Reraise') then
        equip(sets.Reraise)
    end
end

-- Run after the default aftercast() is done.
-- eventArgs is the same one used in job_aftercast, in case information needs to be persisted.
function job_post_aftercast(spell, action, spellMap, eventArgs)

end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_pet_aftercast(spell, action, spellMap, eventArgs)

end

-- Run after the default pet aftercast() is done.
-- eventArgs is the same one used in job_pet_aftercast, in case information needs to be persisted.
function job_pet_post_aftercast(spell, action, spellMap, eventArgs)

end


-------------------------------------------------------------------------------------------------------------------
-- Customization hooks for idle and melee sets, after they've been automatically constructed.
-------------------------------------------------------------------------------------------------------------------

-- Called before the Include starts constructing melee/idle/resting sets.
-- Can customize state or custom melee class values at this point.
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_handle_equipping_gear(status, eventArgs)

end

-- Return a customized weaponskill mode to use for weaponskill sets.
-- Don't return anything if you're not overriding the default value.
function get_custom_wsmode(spell, action, spellMap)

end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if player.hpp < 90 then
        idleSet = set_combine(idleSet, sets.idle.Regen)
    end
    return idleSet
end

-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
    if state.TreasureMode.value == 'Fulltime' then
        meleeSet = set_combine(meleeSet, sets.TreasureHunter)
    end
    if state.CapacityMode.value then
        meleeSet = set_combine(meleeSet, sets.CapacityMantle)
    end
    return meleeSet
end

-------------------------------------------------------------------------------------------------------------------
-- General hooks for other events.
-------------------------------------------------------------------------------------------------------------------

-- Called when the player's status changes.
function job_status_change(newStatus, oldStatus, eventArgs)

end

-- Called when the player's pet's status changes.
function job_pet_status_change(newStatus, oldStatus, eventArgs)

end

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    if string.lower(buff) == "sleep" and gain and player.hp > 200 then
        equip(sets.Berserker)
    else
        if not midaction() then
            handle_equipping_gear(player.status)
        end
    end
end

function job_update(cmdParams, eventArgs)
    war_sj = player.sub_job == 'WAR' or false
    classes.CustomMeleeGroups:clear()
    th_update(cmdParams, eventArgs)
    get_combat_form()
end
-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------

-- Called for custom player commands.
function job_self_command(cmdParams, eventArgs)

end

function get_combat_form()
    --if areas.Adoulin:contains(world.area) and buffactive.ionis then
    --	state.CombatForm:set('Adoulin')
    --end

    if war_sj then
        state.CombatForm:set("War")
    else
        state.CombatForm:reset()
    end
end


-- Job-specific toggles.
function job_toggle(field)

end

-- Handle auto-targetting based on local setup.
function job_auto_change_target(spell, action, spellMap, eventArgs)

end

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)

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
        then return true
    end
end
-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    set_macro_page(1, 6)
end