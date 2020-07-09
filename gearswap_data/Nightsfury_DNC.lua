-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

--[[
    Custom commands:
    
    gs c step
        Uses the currently configured step on the target, with either <t> or <stnpc> depending on setting.
    gs c step t
        Uses the currently configured step on the target, but forces use of <t>.
    
    
    Configuration commands:
    
    gs c cycle mainstep
        Cycles through the available steps to use as the primary step when using one of the above commands.
        
    gs c cycle altstep
        Cycles through the available steps to use for alternating with the configured main step.
        
    gs c toggle usealtstep
        Toggles whether or not to use an alternate step.
        
    gs c toggle selectsteptarget
        Toggles whether or not to use <stnpc> (as opposed to <t>) when using a step.
--]]


-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
    
    -- Load and initialize the include file.
    include('Mote-Include.lua')
end


-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    include('Mote-TreasureHunter')
    state.TreasureMode:set('Tag')

    state.Buff['Climactic Flourish'] = buffactive['climactic flourish'] or false

    state.MainStep = M{['description']='Main Step', 'Box Step', 'Quickstep', 'Feather Step', 'Stutter Step'}
    state.AltStep = M{['description']='Alt Step', 'Quickstep', 'Feather Step', 'Stutter Step', 'Box Step'}
    state.UseAltStep = M(false, 'Use Alt Step')
    state.SelectStepTarget = M(false, 'Select Step Target')
    state.IgnoreTargetting = M(false, 'Ignore Targetting')

    state.CurrentStep = M{['description']='Current Step', 'Main', 'Alt'}
    state.SkillchainPending = M(false, 'Skillchain Pending')

    determine_haste_group()
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'Acc', 'Fodder')
    state.HybridMode:options('Normal', 'Evasion', 'PDT')
    state.WeaponskillMode:options('Normal', 'Acc', 'Fodder')
    state.PhysicalDefenseMode:options('Evasion', 'PDT')


    gear.default.weaponskill_neck = "Asperity Necklace"
    gear.default.weaponskill_waist = "Caudata Belt"
    gear.AugQuiahuiz = {name="Quiahuiz Trousers", augments={'Haste+2','"Snapshot"+2','STR+8'}}

    -- Additional local binds
    send_command('bind ^= gs c cycle mainstep')
    send_command('bind != gs c cycle altstep')
    send_command('bind ^- gs c toggle selectsteptarget')
    send_command('bind !- gs c toggle usealtstep')
    send_command('bind ^` input /ja "Chocobo Jig" <me>')
    send_command('bind !` input /ja "Chocobo Jig II" <me>')

    select_default_macro_book()
end


-- Called when this job file is unloaded (eg: job change)
function user_unload()
    send_command('unbind ^`')
    send_command('unbind !`')
    send_command('unbind ^=')
    send_command('unbind !=')
    send_command('unbind ^-')
    send_command('unbind !-')
end


-- Define sets and vars used by this job file.
function init_gear_sets()

    sets.TreasureHunter = { 
        waist="Chaac Belt",
        --head="Wh. Rarab Cap +1", 
    }
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
    
    -- Precast Sets
    
    -- Precast sets to enhance JAs

    sets.ToeTapper = { name="Toetapper Mantle", augments={'"Store TP"+2','"Dual Wield"+4','"Rev. Flourish"+30','Weapon skill damage +3%',}}
    sets.AmbuCapeTP = { name="Senuna's Mantle", augments={'DEX+1','Accuracy+6 Attack+6','"Dbl.Atk."+10',} }
    

    sets.precast.JA['No Foot Rise'] = {body="Horos Casaque"}

    sets.precast.JA['Trance'] = {head="Horos Tiara"}
    

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {
        head={ name="Herculean Helm", augments={'Accuracy+18 Attack+18','"Waltz" potency +7%','STR+7','Accuracy+15','Attack+8',}}, -- +7
        body="Meg. Cuirie +2",
        hands="Mummu Wrists +1",
        legs="Meg. Chausses +1",
        feet="Meg. Jam. +2",
        neck="Reti Pendant",
        waist="Chaac Belt",
        left_ear="Darkside Earring",
        right_ear="Enervating Earring",
        left_ring="Vocane Ring",
        right_ring="Arvina Ringlet +1",
        back=sets.ToeTapper,  -- +5
    }
        
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}
    
    sets.precast.Samba = {
        back=sets.AmbuCapeTP
    }

    sets.precast.Jig = {
        legs="Horos Tights", feet="Maxixi Toe Shoes"
    }

    sets.precast.Step = {
        waist="Chaac Belt"
    }
    sets.precast.Step['Feather Step'] = {
        feet="Charis Shoes +1"
    }

    sets.precast.Flourish1 = {}
    sets.precast.Flourish1['Violent Flourish'] = {
        waist="Chaac Belt",
        legs={ name="Samnuha Tights", augments={'STR+8','DEX+9','"Dbl.Atk."+3','"Triple Atk."+2',}},
    } -- magic accuracy

    sets.precast.Flourish1['Desperate Flourish'] = {
        back=sets.ToeTapper,
        waist="Hurch'lan Sash",
    } -- acc gear

    sets.precast.Flourish2 = {}
    sets.precast.Flourish2['Reverse Flourish'] = {
        hands="Maculele Bangles +1",
        back=sets.ToeTapper
    }

    sets.precast.Flourish3 = {} 
    sets.precast.Flourish3['Striking Flourish'] = {
        body="Charis Casaque +2"
    }
    sets.precast.Flourish3['Climactic Flourish'] = {
        head="Charis Tiara +2"
    }

    -- Fast cast sets for spells
    
    sets.precast.FC = {
        --ammo="Impatiens",
        head="Haruspex Hat",
        ear2="Loquacious Earring",
        hands="Thaumas Gloves",
        ring1="Prolix Ring"
    }

    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads"})

       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
        head={ name="Herculean Helm", augments={'Accuracy+18 Attack+18','"Waltz" potency +7%','STR+7','Accuracy+15','Attack+8',}},
        body="Meg. Cuirie +2",
        hands="Meg. Gloves +2",
        legs={ name="Samnuha Tights", augments={'STR+8','DEX+9','"Dbl.Atk."+3','"Triple Atk."+2',}},
        feet="Mummu Gamash. +1",
        neck="Lissome Necklace",
        waist="Grunfeld Rope",
        left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +25',}},
        right_ear="Sherida Earring",
        left_ring="Rajas Ring",
        right_ring="Petrov Ring",
    }
    sets.precast.WS.Acc = set_combine(sets.precast.WS, {back=sets.ToeTapper})
    
    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Exenterator'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Exenterator'].Acc = set_combine(sets.precast.WS['Exenterator'], {back=sets.ToeTapper})
    sets.precast.WS['Exenterator'].Fodder = set_combine(sets.precast.WS['Exenterator'], {waist=gear.ElementalBelt})

    sets.precast.WS['Pyrrhic Kleos'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Pyrrhic Kleos'].Acc = set_combine(sets.precast.WS.Acc, {}) 

    sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS, {ammo="Charis Feather"})
    sets.precast.WS['Evisceration'].Acc = set_combine(sets.precast.WS['Evisceration'], {back=sets.ToeTapper})

    sets.precast.WS["Rudra's Storm"] = set_combine(sets.precast.WS, {ammo="Charis Feather",})
    sets.precast.WS["Rudra's Storm"].Acc = set_combine(sets.precast.WS["Rudra's Storm"], {back=sets.ToeTapper})

    sets.precast.WS['Aeolian Edge'] = {
        --head={ name="Herculean Helm", augments={'Mag. Acc.+21','Pet: INT+9','INT+7 MND+7 CHR+7','Accuracy+18 Attack+18','Mag. Acc.+18 "Mag.Atk.Bns."+18',}},
        head="Wh. Rarab Cap +1", --TH +1
        body={ name="Samnuha Coat", augments={'Mag. Acc.+13','"Mag.Atk.Bns."+14','"Fast Cast"+3','"Dual Wield"+4',}},
        hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}},
        legs={ name="Herculean Trousers", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','"Fast Cast"+4','INT+7','"Mag.Atk.Bns."+9',}},
        feet={ name="Herculean Boots", augments={'Mag. Acc.+18 "Mag.Atk.Bns."+18','Crit.hit rate+1','Mag. Acc.+14','"Mag.Atk.Bns."+14',}},
        neck="Sanctity Necklace",
        waist="Chaac Belt",
        left_ear="Friomisi Earring",
        right_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +25',}},
        left_ring="Acumen Ring",
        right_ring="Arvina Ringlet +1",
        back={ name="Toetapper Mantle", augments={'"Store TP"+2','"Dual Wield"+4','"Rev. Flourish"+30','W           eapon skill damage +3%',}},
    }
    
    sets.precast.Skillchain = {hands="Maculele Bangles +1"}
    
    
    -- Midcast Sets
    sets.midcast.FastRecast = {
        head="Felistris Mask",ear2="Loquacious Earring",
        body="Iuitl Vest",hands="Iuitl Wristbands",
        legs="Kaabnax Trousers",}
        
    -- Specific spells
    sets.midcast.Utsusemi = {
        head="Felistris Mask",neck="Ej Necklace",ear2="Loquacious Earring",
        body="Iuitl Vest",hands="Iuitl Wristbands",ring1="Beeline Ring",
        back=sets.ToeTapper,legs={ name="Samnuha Tights", augments={'STR+8','DEX+9','"Dbl.Atk."+3','"Triple Atk."+2',}},}

    
    -- Sets to return to when not performing an action.
    
    -- Resting sets
    sets.resting = {}
    sets.ExtraRegen = {}
    

    -- Idle sets
    sets.idle = {
        main={ name="Taming Sari", augments={'STR+9','DEX+8','DMG:+14',}},
        sub={ name="Enchufla", augments={'DMG:+3','STR+3','Accuracy+3',}},
        --range="Albin Bane",
        ammo="Ginsen",
        head="Skormoth Mask",
        body="Mummu Jacket +1",
        hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
        legs={ name="Samnuha Tights", augments={'STR+8','DEX+9','"Dbl.Atk."+3','"Triple Atk."+2',}},
        feet={ name="Herculean Boots", augments={'"Triple Atk."+4','AGI+2','Accuracy+12',}},
        neck="Lissome Necklace",
        waist="Reiki Yotai",
        left_ear="Cessance Earring",
        right_ear="Sherida Earring",
        left_ring="Epona's Ring",
        right_ring="Petrov Ring",
        back={ name="Senuna's Mantle", augments={'DEX+1','Accuracy+6 Attack+6','"Dbl.Atk."+10',}},
    }

    sets.idle.Town = sets.idle
    
    sets.idle.Weak = {}
    
    -- Defense sets
    sets.defense.Evasion = {}

    sets.defense.PDT = {}

    sets.defense.MDT = {}

    sets.Kiting = {
        feet="Skadi's Jambeaux +1"
    }

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    sets.engaged = {
        main={ name="Taming Sari", augments={'STR+9','DEX+8','DMG:+14',}},
        sub={ name="Enchufla", augments={'DMG:+3','STR+3','Accuracy+3',}},
        --range="Albin Bane",
        ammo="Ginsen",
        head="Skormoth Mask",
        body="Mummu Jacket +1",
        hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
        legs={ name="Samnuha Tights", augments={'STR+8','DEX+9','"Dbl.Atk."+3','"Triple Atk."+2',}},
        feet={ name="Herculean Boots", augments={'"Triple Atk."+4','AGI+2','Accuracy+12',}},
        neck="Lissome Necklace",
        waist="Reiki Yotai",
        left_ear="Cessance Earring",
        right_ear="Sherida Earring",
        left_ring="Epona's Ring",
        right_ring="Petrov Ring",
        back={ name="Senuna's Mantle", augments={'DEX+1','Accuracy+6 Attack+6','"Dbl.Atk."+10',}},
    }
    
    sets.engaged.Fodder = sets.engaged
    sets.engaged.Fodder.Evasion = sets.engaged
    sets.engaged.Acc = sets.engaged
    sets.engaged.Evasion = sets.engaged
    sets.engaged.PDT = sets.engaged
    sets.engaged.Acc.Evasion = sets.engaged
    sets.engaged.Acc.PDT = sets.engaged

    -- Custom melee group: High Haste (2x March or Haste)
    sets.engaged.HighHaste = {
        ammo="Ginsen",
        head="Skormoth Mask",
        body="Mummu Jacket +1",
        hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
        legs={ name="Samnuha Tights", augments={'STR+8','DEX+9','"Dbl.Atk."+3','"Triple Atk."+2',}},
        feet={ name="Herculean Boots", augments={'"Triple Atk."+4','AGI+2','Accuracy+12',}},
        neck="Lissome Necklace",
        waist="Windbuffet Belt +1",
        left_ear="Cessance Earring",
        right_ear="Sherida Earring",
        left_ring="Epona's Ring",
        right_ring="Petrov Ring",
        back={ name="Senuna's Mantle", augments={'DEX+1','Accuracy+6 Attack+6','"Dbl.Atk."+10',}},
    }

    sets.engaged.Fodder.HighHaste =sets.engaged
    sets.engaged.Fodder.Evasion.HighHaste = sets.engaged
    sets.engaged.Acc.HighHaste = sets.engaged
    sets.engaged.Evasion.HighHaste = sets.engaged
    sets.engaged.Acc.Evasion.HighHaste = sets.engaged
    sets.engaged.PDT.HighHaste = sets.engaged
    sets.engaged.Acc.PDT.HighHaste = sets.engaged

    -- Custom melee group: Max Haste (2x March + Haste)
    sets.engaged.MaxHaste = {
        ammo="Ginsen",
        head="Skormoth Mask",
        body="Mummu Jacket +1",
        hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
        legs={ name="Samnuha Tights", augments={'STR+8','DEX+9','"Dbl.Atk."+3','"Triple Atk."+2',}},
        feet={ name="Herculean Boots", augments={'"Triple Atk."+4','AGI+2','Accuracy+12',}},
        neck="Lissome Necklace",
        waist="Windbuffet Belt +1",
        left_ear="Cessance Earring",
        right_ear="Sherida Earring",
        left_ring="Epona's Ring",
        right_ring="Petrov Ring",
        back={ name="Senuna's Mantle", augments={'DEX+1','Accuracy+6 Attack+6','"Dbl.Atk."+10',}},
    }

    -- Getting Marches+Haste from Trust NPCs, doesn't cap delay.
    sets.engaged.Fodder.MaxHaste = sets.engaged
    sets.engaged.Fodder.Evasion.MaxHaste =sets.engaged
    sets.engaged.Acc.MaxHaste = sets.engaged
    sets.engaged.Evasion.MaxHaste =sets.engaged
    sets.engaged.Acc.Evasion.MaxHaste = sets.engaged
    sets.engaged.PDT.MaxHaste = sets.engaged
    sets.engaged.Acc.PDT.MaxHaste = sets.engaged

                

    -- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
    sets.buff['Saber Dance'] = {
        
    }
    sets.buff['Climactic Flourish'] = {
        head="Charis Tiara +1"
    }
end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    auto_presto(spell)
end


function job_post_precast(spell, action, spellMap, eventArgs)
    if spell.type == "WeaponSkill" then
        if state.Buff['Climactic Flourish'] then
            equip(sets.buff['Climactic Flourish'])
        end
        if state.SkillchainPending.value == true then
            equip(sets.precast.Skillchain)
        end
    end
end


-- Return true if we handled the aftercast work.  Otherwise it will fall back
-- to the general aftercast() code in Mote-Include.
function job_aftercast(spell, action, spellMap, eventArgs)
    if not spell.interrupted then
        if spell.english == "Wild Flourish" then
            state.SkillchainPending:set()
            send_command('wait 5;gs c unset SkillchainPending')
        elseif spell.type:lower() == "weaponskill" then
            state.SkillchainPending:toggle()
            send_command('wait 6;gs c unset SkillchainPending')
        end
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff,gain)
    -- If we gain or lose any haste buffs, adjust which gear set we target.
    if S{'haste','march','embrava','haste samba'}:contains(buff:lower()) then
        determine_haste_group()
        handle_equipping_gear(player.status)
    elseif buff == 'Saber Dance' or buff == 'Climactic Flourish' then
        handle_equipping_gear(player.status)
    end
end


function job_status_change(new_status, old_status)
    if new_status == 'Engaged' then
        determine_haste_group()
    end
end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Called by the default 'update' self-command.
function job_update(cmdParams, eventArgs)
    determine_haste_group()
end


function customize_idle_set(idleSet)
    if player.hpp < 80 and not areas.Cities:contains(world.area) then
        idleSet = set_combine(idleSet, sets.ExtraRegen)
    end
    
    return idleSet
end

function customize_melee_set(meleeSet)
    if state.DefenseMode.value ~= 'None' then
        if buffactive['saber dance'] then
            meleeSet = set_combine(meleeSet, sets.buff['Saber Dance'])
        end
        if state.Buff['Climactic Flourish'] then
            meleeSet = set_combine(meleeSet, sets.buff['Climactic Flourish'])
        end
    end
    
    return meleeSet
end

-- Handle auto-targetting based on local setup.
function job_auto_change_target(spell, action, spellMap, eventArgs)
    if spell.type == 'Step' then
        if state.IgnoreTargetting.value == true then
            state.IgnoreTargetting:reset()
            eventArgs.handled = true
        end
        
        eventArgs.SelectNPCTargets = state.SelectStepTarget.value
    end
end


-- Function to display the current relevant user state when doing an update.
-- Set eventArgs.handled to true if display was handled, and you don't want the default info shown.
function display_current_job_state(eventArgs)
    local msg = 'Melee'
    
    if state.CombatForm.has_value then
        msg = msg .. ' (' .. state.CombatForm.value .. ')'
    end
    
    msg = msg .. ': '
    
    msg = msg .. state.OffenseMode.value
    if state.HybridMode.value ~= 'Normal' then
        msg = msg .. '/' .. state.HybridMode.value
    end
    msg = msg .. ', WS: ' .. state.WeaponskillMode.value
    
    if state.DefenseMode.value ~= 'None' then
        msg = msg .. ', ' .. 'Defense: ' .. state.DefenseMode.value .. ' (' .. state[state.DefenseMode.value .. 'DefenseMode'].value .. ')'
    end
    
    if state.Kiting.value then
        msg = msg .. ', Kiting'
    end

    msg = msg .. ', ['..state.MainStep.current

    if state.UseAltStep.value == true then
        msg = msg .. '/'..state.AltStep.current
    end
    
    msg = msg .. ']'

    if state.SelectStepTarget.value == true then
        steps = steps..' (Targetted)'
    end

    add_to_chat(122, msg)

    eventArgs.handled = true
end


-------------------------------------------------------------------------------------------------------------------
-- User self-commands.
-------------------------------------------------------------------------------------------------------------------

-- Called for custom player commands.
function job_self_command(cmdParams, eventArgs)
    if cmdParams[1] == 'step' then
        if cmdParams[2] == 't' then
            state.IgnoreTargetting:set()
        end

        local doStep = ''
        if state.UseAltStep.value == true then
            doStep = state[state.CurrentStep.current..'Step'].current
            state.CurrentStep:cycle()
        else
            doStep = state.MainStep.current
        end        
        
        send_command('@input /ja "'..doStep..'" <t>')
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function determine_haste_group()
    -- We have three groups of DW in gear: Charis body, Charis neck + DW earrings, and Patentia Sash.

    -- For high haste, we want to be able to drop one of the 10% groups (body, preferably).
    -- High haste buffs:
    -- 2x Marches + Haste
    -- 2x Marches + Haste Samba
    -- 1x March + Haste + Haste Samba
    -- Embrava + any other haste buff
    
    -- For max haste, we probably need to consider dropping all DW gear.
    -- Max haste buffs:
    -- Embrava + Haste/March + Haste Samba
    -- 2x March + Haste + Haste Samba

    classes.CustomMeleeGroups:clear()
    
    if buffactive.embrava and (buffactive.haste or buffactive.march) and buffactive['haste samba'] then
        classes.CustomMeleeGroups:append('MaxHaste')
    elseif buffactive.march == 2 and buffactive.haste and buffactive['haste samba'] then
        classes.CustomMeleeGroups:append('MaxHaste')
    elseif buffactive.embrava and (buffactive.haste or buffactive.march or buffactive['haste samba']) then
        classes.CustomMeleeGroups:append('HighHaste')
    elseif buffactive.march == 1 and buffactive.haste and buffactive['haste samba'] then
        classes.CustomMeleeGroups:append('HighHaste')
    elseif buffactive.march == 2 and (buffactive.haste or buffactive['haste samba']) then
        classes.CustomMeleeGroups:append('HighHaste')
    end
end


-- Automatically use Presto for steps when it's available and we have less than 3 finishing moves
function auto_presto(spell)
    if spell.type == 'Step' then
        local allRecasts = windower.ffxi.get_ability_recasts()
        local prestoCooldown = allRecasts[236]
        local under3FMs = not buffactive['Finishing Move 4'] and not buffactive['Finishing Move 5']
        
        if player.main_job_level >= 77 and prestoCooldown < 1 and under3FMs then
            cast_delay(1.1)
            send_command('@input /ja "Presto" <me>')
        end
    end
end


-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    set_macro_page(1, 10)
end