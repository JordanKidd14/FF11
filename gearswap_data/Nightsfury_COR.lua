-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

--[[
    gs c toggle LuzafRing -- Toggles use of Luzaf Ring on and off

    Offense mode is melee or ranged.  Used ranged offense mode if you are engaged
    for ranged weaponskills, but not actually meleeing.

    Weaponskill mode, if set to 'Normal', is handled separately for melee and ranged weaponskills.
--]]


-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2

    -- Load and initialize the include file.
    include('Mote-Include.lua')
end

-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    -- Whether to use Luzaf's Ring
    state.LuzafRing = M(false, "Luzaf's Ring")  
    -- Whether a warning has been given for low ammo
    state.warned = M(false)

    define_roll_values()
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Ranged', 'Melee', 'Acc')
    state.RangedMode:options('Normal', 'Acc')
    state.WeaponskillMode:options('Normal', 'Acc', 'Att', 'Mod')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'PDT', 'Refresh')


    gear.exp = "Mecistopins Mantle"

    --gear.magicws = gear.exp           
    --gear.tpback = gear.exp
    --gear.tprange = gear.exp

    gear.magicws = { name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+5','Weapon skill damage +10%',} }
    gear.tpback = { name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',} }
    gear.tprange = { name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','"Store TP"+10',} }
    gear.snap = { name="Camulus's Mantle", augments={'"Snapshot"+10',} }

    gear.RAbullet = "Living Bullet"
    gear.WSbullet = "Living Bullet"
    gear.MAbullet = "Living Bullet"
    gear.QDbullet = "Living Bullet"

    options.ammo_warning_limit = 20

    -- Additional local binds
    --send_command('bind ^` input /ja "Double-up" <me>')
    --send_command('bind !` input /ja "Bolter\'s Roll" <me>')

    select_default_macro_book()
end


-- Called when this job file is unloaded (eg: job change)
function user_unload()
    --send_command('unbind ^`')
    --send_command('unbind !`')
end

-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------

    -- Precast Sets

    -- Precast sets to enhance JAs  

    sets.precast.JA['Triple Shot'] = {body="Chasseur's Frac"}
    sets.precast.JA['Snake Eye'] = {legs="Lanun Culottes"}
    sets.precast.JA['Wild Card'] = {
        feet={ name="Lanun Bottes +2", augments={'Enhances "Wild Card" effect',}},
    }
    sets.precast.JA['Random Deal'] = {body="Lanun Frac"}

    sets.precast.CorsairRoll = {
        head="Lanun Tricorne",  -- +50% for job bonus wo job
        ring2="Barataria Ring", -- +5 effect
        back=gear.tprange, --+30 sec
        hands="Chasseur's Gants +1", -- +50 sec
        legs="Desultor Tassets", -- -5 recast,
        range={ name="Compensator", augments={'DMG:+15','Rng.Atk.+15','"Mag.Atk.Bns."+15',}},
    }

    sets.precast.CorsairRoll["Caster's Roll"] = set_combine(sets.precast.CorsairRoll, {legs="Chasseur's Culottes"})
    sets.precast.CorsairRoll["Courser's Roll"] = set_combine(sets.precast.CorsairRoll, {feet="Chasseur's Bottes +1"})
    sets.precast.CorsairRoll["Blitzer's Roll"] = set_combine(sets.precast.CorsairRoll, {head="Chasseur's Tricorne"})
    sets.precast.CorsairRoll["Tactician's Roll"] = set_combine(sets.precast.CorsairRoll, {body="Chasseur's Frac"})
    sets.precast.CorsairRoll["Allies' Roll"] = set_combine(sets.precast.CorsairRoll, {hands="Chasseur's Gants +1"})

    sets.precast.LuzafRing = {ring1="Luzaf's Ring", ring2="Barataria Ring"}

    sets.precast.FoldDoubleBust = {hands="Lanun Gants"}

    sets.precast.CorsairShot = {}

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {}

    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {
        head="Mummu Bonnet +1"
    }

    -- Fast cast sets for spells

    sets.precast.FC = {head="Haruspex Hat"}

    sets.precast.FC.Utsusemi = {}

    -- snapshot (haste) and rapid shot gear:
    sets.precast.RA = {
        ammo=gear.RAbullet,
        body="Laksa. Frac +2", --rapid
        hands={ name="Carmine Fin. Ga.", augments={'Rng.Atk.+15','"Mag.Atk.Bns."+10','"Store TP"+5',}}, --7 snap, 10 rs
        legs="Nahtirah Trousers", --10
        feet="Meg. Jam. +2", --10
        back=gear.snap --10
    }


    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
        ammo=gear.WSbullet,
        head="Meghanada Visor +1",
        body="Meghanada Cuirie +2",
        hands="Meg. Gloves +2",
        legs={ name="Herculean Trousers", augments={'Rng.Acc.+21 Rng.Atk.+21','Crit.hit rate+2','STR+9','Rng.Acc.+9',}},
        feet={ name="Herculean Boots", augments={'"Triple Atk."+4','AGI+2','Accuracy+12',}},
        neck="Sanctity Necklace",
        waist="Eschan Stone",
        left_ear="Suppanomimi",
        right_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
        left_ring="Longshot Ring",
        right_ring="Rajas Ring",
        back=gear.tprange,
    }


    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.

    sets.precast.WS['Exenterator'] = set_combine(sets.precast.WS, {legs="Nahtirah Trousers"})

    sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, {legs="Nahtirah Trousers"})

    sets.precast.WS['Savage Blade'] = {
        head={ name="Herculean Helm", augments={'"Dbl.Atk."+2','"Triple Atk."+3','Weapon skill damage +4%','Mag. Acc.+16 "Mag.Atk.Bns."+16',}},
        body={ name="Herculean Vest", augments={'Accuracy+11 Attack+11','Weapon skill damage +4%','STR+15','Attack+6',}},
        hands="Meg. Gloves +2",
        legs="Meg. Chausses +1",
        feet="Meg. Jam. +2",
        neck="Caro Necklace",
        waist="Grunfeld Rope",
        left_ear="Ishvara Earring",
        right_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
        left_ring="Rajas Ring",
        right_ring="Petrov Ring",
        back={ name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+5','Weapon skill damage +10%',}},
    }

    sets.precast.WS['Last Stand'] = {
        ammo=gear.WSbullet,
        head="Meghanada Visor +1",
        body="Laksa. Frac +2",
        hands="Meg. Gloves +2",
        legs="Mummu Kecks +2",
        feet="Meg. Jam. +2",
        waist="Eschan Stone",
        neck="Sanctity Necklace",
        left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
        right_ear="Enervating Earring",
        left_ring="Dingir Ring",
        right_ring="Beeline Ring",
        back=gear.tprange,
    }

    sets.precast.WS['Last Stand'].Acc = sets.precast.WS['Last Stand']

    -- MAGIC:
    sets.precast.WS['Wildfire'] = {         
        ammo=gear.MAbullet,
        head={ name="Herculean Helm", augments={'Mag. Acc.+21','Pet: INT+9','INT+7 MND+7 CHR+7','Accuracy+18 Attack+18','Mag. Acc.+18 "Mag.Atk.Bns."+18',}},
        body="Samnuha Coat",
        hands={ name="Carmine Fin. Ga.", augments={'Rng.Atk.+15','"Mag.Atk.Bns."+10'    ,'"Store TP"+5',}},
        legs={ name="Herculean Trousers", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','"Fast Cast"+4','INT+7','"Mag.Atk.Bns."+9',}},
        feet={ name="Herculean Boots", augments={'Mag. Acc.+18 "Mag.Atk.Bns."+18','Crit.hit rate+1','Mag. Acc.+14','"Mag.Atk.Bns."+14',}},
        neck="Sanctity Necklace",
        waist="Eschan Stone",
        left_ear="Hecate's Earring",
        right_ear="Friomisi Earring",           
        left_ring="Arvina Ringlet +1",
        right_ring="Dingir Ring",
        back=gear.magicws
    }

    sets.precast.WS['Leaden Salute'] = {
        ammo=gear.MAbullet,
        head="Pixie Hairpin +1",
        body="Samnuha Coat",
        hands={ name="Carmine Fin. Ga.", augments={'Rng.Atk.+15','"Mag.Atk.Bns."+10','"Store TP"+5',}},
        legs={ name="Herculean Trousers", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','"Fast Cast"+4','INT+7','"Mag.Atk.Bns."+9',}},
        feet={ name="Lanun Bottes +2", augments={'Enhances "Wild Card" effect',}},
        neck="Baetyl Pendant",
        waist="Eschan Stone",
        left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
        right_ear="Friomisi Earring",
        left_ring="Dingir Ring",
        right_ring="Archon Ring",
        back=gear.magicws
    }

    -- Midcast Sets
    sets.midcast.FastRecast = {}

    -- Specific spells
    sets.midcast.Utsusemi = sets.midcast.FastRecast

    sets.midcast.CorsairShot = {
        ammo=gear.QDbullet,
        ear1="Friomisi Earring",
        ear2="Hermetic Earring",
        body="Samnuha Coat",
        head={ name="Herculean Helm", augments={'Mag. Acc.+21','Pet: INT+9','INT+7 MND+7 CHR+7','Accuracy+18 Attack+18','Mag. Acc.+18 "Mag.Atk.Bns."+18',}},
        legs={ name="Herculean Trousers", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','"Fast Cast"+4','INT+7','"Mag.Atk.Bns."+9',}},
        hands={ name="Carmine Fin. Ga.", augments={'Rng.Atk.+15','"Mag.Atk.Bns."+10','"Store TP"+5',}},
        ---feet="Chasseur's Bottes +1", 
        feet={ name="Herculean Boots", augments={'Mag. Acc.+18 "Mag.Atk.Bns."+18','Crit.hit rate+1','Mag. Acc.+14','"Mag.Atk.Bns."+14',}},
        left_ring="Arvina Ringlet +1",
        right_ring="Dingir Ring",
        back=gear.magicws
    }

    sets.midcast.CorsairShot.Acc =  sets.midcast.CorsairShot
    sets.midcast.CorsairShot['Light Shot'] =  sets.midcast.CorsairShot
    sets.midcast.CorsairShot['Dark Shot'] =  sets.midcast.CorsairShot

    -- Ranged gear
    sets.midcast.RA = {
        ammo=gear.RAbullet,
        head="Meghanada Visor +1",
        body="Meg. Cuirie +2",
        hands="Meg. Gloves +2",
        legs="Mummu Kecks +2",
        feet="Meg. Jam. +2",
        neck="Sanctity Necklace",
        waist="Reiki Yotai",
        left_ear="Neritic Earring",
        right_ear="Enervating Earring",
        left_ring="Dingir Ring",
        right_ring="Arvina Ringlet +1",
        back=gear.tprange,
    }

    sets.midcast.RA.Acc = sets.midcast.RA

    -- Sets to return to when not performing an action.

    -- Resting sets
    sets.resting = { }

    -- Idle sets
    sets.idle = {
        ammo=gear.MAbullet,
        range="Death Penalty",
        head="Meghanada Visor +1",
        body="Meg. Cuirie +2",
        hands="Meg. Gloves +2",
        legs="Mummu Kecks +2",
        feet="Meg. Jam. +2",
        neck="Twilight Torque",
        waist="Flume Belt",     
        left_ear="Infused Earring",
        right_ear="Enervating Earring",
        left_ring="Vocane Ring",
        right_ring="Defending Ring",
        back="Solemnity Cape",
    }

    sets.idle.Town =  {
        ammo=gear.MAbullet,
        range="Death Penalty",
        head="Meghanada Visor +1",
        body="Meg. Cuirie +2",
        hands="Meg. Gloves +2",
        legs="Carmine Cuisses +1",
        feet="Meg. Jam. +2",
        neck="Twilight Torque",
        waist="Flume Belt",
        left_ear="Infused Earring",
        right_ear="Enervating Earring",
        left_ring="Dingir Ring",
        right_ring="Defending Ring",
        back=gear.magicws
    }

    -- Defense sets
    sets.defense.PDT = {}

    sets.defense.MDT = {}


    --sets.Kiting = {feet="Skadi's Jambeaux +1"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes,
 --the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion

    -- Normal melee group
    sets.engaged.Melee = {
        range="Death Penalty",
        ammo="Living Bullet",
        head={ name="Herculean Helm", augments={'Attack+23','"Store TP"+3','Accuracy+10',}},
        body="Mummu Jacket +1",
        hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
        legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
        feet={ name="Herculean Boots", augments={'"Triple Atk."+4','AGI+2','Accuracy+12',}},
        neck="Lissome Necklace",
        waist="Reiki Yotai",
        left_ear="Brutal Earring",
        right_ear="Cessance Earring",
        left_ring="Petrov Ring",
        right_ring="Epona's Ring",
        back={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}},
    }

    sets.engaged.Ranged = {
        ammo=gear.RAbullet,
        head="Meghanada Visor +1",
        body="Meghanada Cuirie +2",
        hands="Meg. Gloves +2",
        legs="Mummu Kecks +2",
        feet="Meg. Jam. +2",
        neck="Sanctity Necklace",
        waist="Eschan Stone",
        left_ear="Neritic Earring",
        right_ear="Enervating Earring",
        left_ring="Longshot Ring",
        right_ring="Rajas Ring",
        back=gear.tprange,
    }

    sets.engaged.Acc = {
        head="Meghanada Visor +1",
        body="Meghanada Cuirie +2",
        hands={ name="Floral Gauntlets", augments={'Rng.Acc.+14','Accuracy+13','"Triple Atk."+2','Magic dmg. taken -3%',}},
        legs="Carmine Cuisses +1", 
        feet={ name="Herculean Boots", augments={'"Triple Atk."+4','AGI+2','Accuracy+12',}},
        neck="Sanctity Necklace",
        waist="Windbuffet Belt +1",
        left_ear="Suppanomimi",
        right_ear="Brutal Earring",
        left_ring="Epona's Ring",
        right_ring="Rajas Ring",
        back=gear.tpback
    }

    sets.engaged.Melee.DW = sets.engaged.Melee

    sets.engaged.Acc.DW = sets.engaged.Melee

end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    -- Check that proper ammo is available if we're using ranged attacks or similar.
    if spell.action_type == 'Ranged Attack' or spell.type == 'WeaponSkill' or spell.type == 'CorsairShot' then
        do_bullet_checks(spell, spellMap, eventArgs)
    end

    -- gear sets
    if (spell.type == 'CorsairRoll' or spell.english == "Double-Up") and state.LuzafRing.value then
        equip(sets.precast.LuzafRing)
    elseif spell.type == 'CorsairShot' and state.CastingMode.value == 'Resistant' then
        classes.CustomClass = 'Acc'
    elseif spell.english == 'Fold' and buffactive['Bust'] == 2 then
        if sets.precast.FoldDoubleBust then
            equip(sets.precast.FoldDoubleBust)
            eventArgs.handled = true
        end
    end
end


-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
    if spell.type == 'CorsairRoll' and not spell.interrupted then
        display_roll_info(spell)
    end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Return a customized weaponskill mode to use for weaponskill sets.
-- Don't return anything if you're not overriding the default value.
function get_custom_wsmode(spell, spellMap, default_wsmode)

end


-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
    if newStatus == 'Engaged' and player.equipment.main == 'Chatoyant Staff' then
        add_to_chat(104, 'You are here 1!')
        state.OffenseMode:set('Ranged')
    end
    if newStatus == 'Engaged' then
        add_to_chat(104, 'You are here 2!')
        
        state.OffenseMode:set('Melee')
    end
end


-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)
    local msg = ''

    msg = msg .. 'Off.: '..state.OffenseMode.current
    msg = msg .. ', Rng.: '..state.RangedMode.current
    msg = msg .. ', WS.: '..state.WeaponskillMode.current
    msg = msg .. ', QD.: '..state.CastingMode.current

    if state.DefenseMode.value ~= 'None' then
        local defMode = state[state.DefenseMode.value ..'DefenseMode'].current
        msg = msg .. ', Defense: '..state.DefenseMode.value..' '..defMode
    end

    if state.Kiting.value then
        msg = msg .. ', Kiting'
    end

    if state.PCTargetMode.value ~= 'default' then
        msg = msg .. ', Target PC: '..state.PCTargetMode.value
    end

    if state.SelectNPCTargets.value then
        msg = msg .. ', Target NPCs'
    end

    msg = msg .. ', Roll Size: ' .. ((state.LuzafRing.value and 'Large') or 'Small')

    add_to_chat(122, msg)

    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function define_roll_values()
    rolls = {
        ["Corsair's Roll"]   = {lucky=5, unlucky=9, bonus="Experience Points"},
        ["Ninja Roll"]       = {lucky=4, unlucky=8, bonus="Evasion"},
        ["Hunter's Roll"]    = {lucky=4, unlucky=8, bonus="Accuracy"},
        ["Chaos Roll"]       = {lucky=4, unlucky=8, bonus="Attack"},
        ["Magus's Roll"]     = {lucky=2, unlucky=6, bonus="Magic Defense"},
        ["Healer's Roll"]    = {lucky=3, unlucky=7, bonus="Cure Potency Received"},
        ["Puppet Roll"]      = {lucky=4, unlucky=8, bonus="Pet Magic Accuracy/Attack"},
        ["Choral Roll"]      = {lucky=2, unlucky=6, bonus="Spell Interruption Rate"},
        ["Monk's Roll"]      = {lucky=3, unlucky=7, bonus="Subtle Blow"},
        ["Beast Roll"]       = {lucky=4, unlucky=8, bonus="Pet Attack"},
        ["Samurai Roll"]     = {lucky=2, unlucky=6, bonus="Store TP"},
        ["Evoker's Roll"]    = {lucky=5, unlucky=9, bonus="Refresh"},
        ["Rogue's Roll"]     = {lucky=5, unlucky=9, bonus="Critical Hit Rate"},
        ["Warlock's Roll"]   = {lucky=4, unlucky=8, bonus="Magic Accuracy"},
        ["Fighter's Roll"]   = {lucky=5, unlucky=9, bonus="Double Attack Rate"},
        ["Drachen Roll"]     = {lucky=3, unlucky=7, bonus="Pet Accuracy"},
        ["Gallant's Roll"]   = {lucky=3, unlucky=7, bonus="Defense"},
        ["Wizard's Roll"]    = {lucky=5, unlucky=9, bonus="Magic Attack"},
        ["Dancer's Roll"]    = {lucky=3, unlucky=7, bonus="Regen"},
        ["Scholar's Roll"]   = {lucky=2, unlucky=6, bonus="Conserve MP"},
        ["Bolter's Roll"]    = {lucky=3, unlucky=9, bonus="Movement Speed"},
        ["Caster's Roll"]    = {lucky=2, unlucky=7, bonus="Fast Cast"},
        ["Courser's Roll"]   = {lucky=3, unlucky=9, bonus="Snapshot"},
        ["Blitzer's Roll"]   = {lucky=4, unlucky=9, bonus="Attack Delay"},
        ["Tactician's Roll"] = {lucky=5, unlucky=8, bonus="Regain"},
        ["Allies's Roll"]    = {lucky=3, unlucky=10, bonus="Skillchain Damage"},
        ["Miser's Roll"]     = {lucky=5, unlucky=7, bonus="Save TP"},
        ["Companion's Roll"] = {lucky=2, unlucky=10, bonus="Pet Regain and Regen"},
        ["Avenger's Roll"]   = {lucky=4, unlucky=8, bonus="Counter Rate"},
    }
end

function display_roll_info(spell)
    rollinfo = rolls[spell.english]
    local rollsize = (state.LuzafRing.value and 'Large') or 'Small'

    if rollinfo then
        --add_to_chat(104, spell.english..'  size is '..rollsize)
        add_to_chat(104, 'Lucky roll is '..tostring(rollinfo.lucky)..', Unlucky roll is '..tostring(rollinfo.unlucky)..'.')
    end
end


-- Determine whether we have sufficient ammo for the action being attempted.
function do_bullet_checks(spell, spellMap, eventArgs)
    local bullet_name
    local bullet_min_count = 1

    if spell.type == 'WeaponSkill' then
        if spell.skill == "Marksmanship" then
            if spell.element == 'None' then
                -- physical weaponskills
                bullet_name = gear.WSbullet
            else
                -- magical weaponskills
                bullet_name = gear.MAbullet
            end
        else
            -- Ignore non-ranged weaponskills
            return
        end
    elseif spell.type == 'CorsairShot' then
        bullet_name = gear.QDbullet
    elseif spell.action_type == 'Ranged Attack' then
        bullet_name = gear.RAbullet
        if buffactive['Triple Shot'] then
            bullet_min_count = 3
        end
    end

    local available_bullets = player.inventory[bullet_name] or player.wardrobe[bullet_name]

    -- If no ammo is available, give appropriate warning and end.
    if not available_bullets then
        if spell.type == 'CorsairShot' and player.equipment.ammo ~= 'empty' then
            add_to_chat(104, 'No Quick Draw ammo left.  Using what\'s currently equipped ('..player.equipment.ammo..').')
            return
        -- elseif spell.type == 'WeaponSkill' and player.equipment.ammo == gear.RAbullet then
        --     add_to_chat(104, 'No weaponskill ammo left.  Using what\'s currently equipped (standard ranged bullets: '..player.equipment.ammo..').')
        --     return
        else
            add_to_chat(104, 'No ammo ('..tostring(bullet_name)..') available for that action.')
            eventArgs.cancel = true
            return
        end
    end

    -- Don't allow shooting or weaponskilling with ammo reserved for quick draw.
    if spell.type ~= 'CorsairShot' and bullet_name == gear.QDbullet and available_bullets.count <= bullet_min_count then
        add_to_chat(104, 'No ammo will be left for Quick Draw.  Cancelling.')
        eventArgs.cancel = true
        return
    end

    -- Low ammo warning.
    if spell.type ~= 'CorsairShot' and state.warned.value == false
        and available_bullets.count > 1 and available_bullets.count <= options.ammo_warning_limit then
        local msg = '*****  LOW AMMO WARNING: '..bullet_name..' *****'
        --local border = string.repeat("*", #msg)
        local border = ""
        for i = 1, #msg do
            border = border .. "*"
        end

        add_to_chat(104, border)
        add_to_chat(104, msg)
        add_to_chat(104, border)

        state.warned:set()
    elseif available_bullets.count > options.ammo_warning_limit and state.warned then
        state.warned:reset()
    end
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    set_macro_page(4, 14)
end