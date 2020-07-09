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
    indi_timer = ''
    indi_duration = 186
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('None', 'Normal')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'PDT')

    gear.default.weaponskill_waist = "Windbuffet Belt"

    select_default_macro_book()
end


-- Define sets and vars used by this job file.
function init_gear_sets()

    --------------------------------------
    -- Precast sets
    --------------------------------------

    -- Precast sets to enhance JAs
    sets.precast.JA.Bolster = {body="Bagua Tunic"}
    sets.precast.JA['Life cycle'] = {body="Geomancy Tunic"}

    -- Fast cast sets for spells

    sets.precast.FC = {
        head="Nahtirah Hat",
        body="Jhakri Robe +2",
        legs="Gyve Trousers",
        feet={ name="Merlinic Crackows", augments={'"Mag.Atk.Bns."+29','Magic burst dmg.+10%','Mag. Acc.+10',}},
        neck="Incanter's Torque",
        waist="Hachirin-no-Obi",
        left_ring="Kishar Ring",
        right_ring="Stikini Ring +1",
        back={ name="Lifestream Cape", augments={'Geomancy Skill +4','Indi. eff. dur. +18','Pet: Damage taken -5%',}},
    }

    sets.precast.FC.Cure = set_combine(sets.precast.FC, {main="Tamaxchi",sub="Genbu's Shield",back="Pahtli Cape"})

    sets.precast.FC['Elemental Magic'] = {
        main="Mindmelter",
        sub="Enki Strap",
        range="Dunna",
        head={ name="Merlinic Hood", augments={'Mag. Acc.+25 "Mag.Atk.Bns."+25','MND+6','"Mag.Atk.Bns."+15',}},
        body={ name="Merlinic Jubbah", augments={'Mag. Acc.+21 "Mag.Atk.Bns."+21','Magic burst dmg.+8%','INT+3','"Mag.Atk.Bns."+9',}},
        hands={ name="Amalric Gages", augments={'INT+10','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
        legs={ name="Merlinic Shalwar", augments={'Mag. Acc.+25 "Mag.Atk.Bns."+25','Magic Damage +8','CHR+2','Mag. Acc.+14','"Mag.Atk.Bns."+7',}},
        feet={ name="Merlinic Crackows", augments={'"Mag.Atk.Bns."+29','Magic burst dmg.+10%','Mag. Acc.+10',}},
        neck="Mizu. Kubikazari",
        waist="Eschan Stone",
        left_ear="Friomisi Earring",
        right_ear="Hecate's Earring",
        left_ring="Mujin Band",
        right_ring="Locus Ring",
        back={ name="Nantosuelta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Magic Damage +3',}},
    }


    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
      
    }

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Flash Nova'] = {ammo="Dosis Tathlum",
        head="Hagondes Hat",neck="Eddy Necklace",ear1="Friomisi Earring",ear2="Crematio Earring",
        body="Hagondes Coat",hands="Yaoyotl Gloves",ring1="Acumen Ring",ring2="Strendu Ring",
        back="Toro Cape",waist="Snow Belt",legs="Hagondes Pants",feet="Hagondes Sabots"}

    sets.precast.WS['Starlight'] = {ear2="Moonshade Earring"}

    sets.precast.WS['Moonlight'] = {ear2="Moonshade Earring"}


    --------------------------------------
    -- Midcast sets
    --------------------------------------

    -- Base fast recast for spells
    sets.midcast.FastRecast = {
        -- head="Nahtirah Hat",
        -- body="Jhakri Robe +2",
        -- legs="Gyve Trousers",
        -- feet={ name="Merlinic Crackows", augments={'"Mag.Atk.Bns."+29','Magic burst dmg.+10%','Mag. Acc.+10',}},
        -- neck="Incanter's Torque",
        -- waist="Hachirin-no-Obi",
        -- left_ring="Kishar Ring",
        -- right_ring="Stikini Ring +1",
        -- back={ name="Lifestream Cape", augments={'Geomancy Skill +4','Indi. eff. dur. +18','Pet: Damage taken -5%',}},
    }

    sets.midcast.Geomancy = {
        main={ name="Solstice", augments={'Mag. Acc.+20','Pet: Damage taken -4%','"Fast Cast"+5',}},
        sub="Genbu's Shield",
        range="Dunna",
        head="Azimuth Hood",
        body={ name="Bagua Tunic +1", augments={'Enhances "Bolster" effect',}},
        hands="Geo. Mitaines +1",
        legs={ name="Merlinic Shalwar", augments={'Mag. Acc.+25 "Mag.Atk.Bns."+25','Magic Damage +8','CHR+2','Mag. Acc.+14','"Mag.Atk.Bns."+7',}},
        feet={ name="Merlinic Crackows", augments={'"Mag.Atk.Bns."+29','Magic burst dmg.+10%','Mag. Acc.+10',}},
        neck="Incanter's Torque",
        waist="Hachirin-no-Obi",
        left_ear="Friomisi Earring",
        right_ear="Hecate's Earring",
        left_ring="Capacity Ring",
        right_ring="Stikini Ring +1",
        back={ name="Lifestream Cape", augments={'Geomancy Skill +4','Indi. eff. dur. +18','Pet: Damage taken -5%',}},
    }
        
    sets.midcast.Geomancy.Indi = {
        main={ name="Solstice", augments={'Mag. Acc.+20','Pet: Damage taken -4%','"Fast Cast"+5',}},
        sub="Genbu's Shield",
        range="Dunna",
        head="Azimuth Hood",
        body={ name="Bagua Tunic +1", augments={'Enhances "Bolster" effect',}},
        hands="Geo. Mitaines +1",
        legs={ name="Merlinic Shalwar", augments={'Mag. Acc.+25 "Mag.Atk.Bns."+25','Magic Damage +8','CHR+2','Mag. Acc.+14','"Mag.Atk.Bns."+7',}},
        feet={ name="Merlinic Crackows", augments={'"Mag.Atk.Bns."+29','Magic burst dmg.+10%','Mag. Acc.+10',}},
        neck="Incanter's Torque",
        waist="Hachirin-no-Obi",
        left_ear="Friomisi Earring",
        right_ear="Hecate's Earring",
        left_ring="Capacity Ring",
        right_ring="Stikini Ring +1",
        back={ name="Lifestream Cape", augments={'Geomancy Skill +4','Indi. eff. dur. +18','Pet: Damage taken -5%',}},   
    }

    sets.midcast.Cure = {
        main={ name="Serenity", augments={'MP+50','Enha.mag. skill +8','"Cure" potency +3%','"Cure" spellcasting time -9%',}},
        sub="Achaq Grip",
        body="Jhakri Robe +2",
        legs="Gyve Trousers",
        neck="Incanter's Torque",
        waist="Hachirin-no-Obi",
        left_ring="Vocane Ring",
        right_ring="Stikini Ring +1",
        back="Solemnity Cape",
    }

    sets.midcast.Curaga = sets.midcast.Cure

    sets.midcast.Protectra = {ring1="Sheltered Ring"}

    sets.midcast.Shellra = {ring1="Sheltered Ring"}


    --------------------------------------
    -- Idle/resting/defense/etc sets
    --------------------------------------

    -- Resting sets
    sets.resting = {
        main={ name="Solstice", augments={'Mag. Acc.+20','Pet: Damage taken -4%','"Fast Cast"+5',}},
        sub="Genbu's Shield",
        range="Dunna",
        head={ name="Merlinic Hood", augments={'Mag. Acc.+25 "Mag.Atk.Bns."+25','MND+6','"Mag.Atk.Bns."+15',}},
        body="Jhakri Robe +2",
        hands="Geo. Mitaines +1",
        legs={ name="Merlinic Shalwar", augments={'Mag. Acc.+25 "Mag.Atk.Bns."+25','Magic Damage +8','CHR+2','Mag. Acc.+14','"Mag.Atk.Bns."+7',}},
        feet={ name="Merlinic Crackows", augments={'"Mag.Atk.Bns."+29','Magic burst dmg.+10%','Mag. Acc.+10',}},
        neck="Twilight Torque",
        waist="Hachirin-no-Obi",
        left_ear="Lugalbanda Earring",
        right_ear="Infused Earring",
        left_ring="Defending Ring",
        right_ring="Vocane Ring",
        back={ name="Lifestream Cape", augments={'Geomancy Skill +4','Indi. eff. dur. +18','Pet: Damage taken -5%',}},
    }

    sets.idle = sets.resting


    --------------------------------------
    -- Engaged sets
    --------------------------------------

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion

    -- Normal melee group
    sets.engaged = {

    }

    --------------------------------------
    -- Custom buff sets
    --------------------------------------

end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

function job_aftercast(spell, action, spellMap, eventArgs)
    if not spell.interrupted then
        if spell.english:startswith('Indi') then
            if not classes.CustomIdleGroups:contains('Indi') then
                classes.CustomIdleGroups:append('Indi')
            end
            send_command('@timers d "'..indi_timer..'"')
            indi_timer = spell.english
            send_command('@timers c "'..indi_timer..'" '..indi_duration..' down spells/00136.png')
        elseif spell.english == 'Sleep' or spell.english == 'Sleepga' then
            send_command('@timers c "'..spell.english..' ['..spell.target.name..']" 60 down spells/00220.png')
        elseif spell.english == 'Sleep II' or spell.english == 'Sleepga II' then
            send_command('@timers c "'..spell.english..' ['..spell.target.name..']" 90 down spells/00220.png')
        end
    elseif not player.indi then
        classes.CustomIdleGroups:clear()
    end
end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    if player.indi and not classes.CustomIdleGroups:contains('Indi')then
        classes.CustomIdleGroups:append('Indi')
        handle_equipping_gear(player.status)
    elseif classes.CustomIdleGroups:contains('Indi') and not player.indi then
        classes.CustomIdleGroups:clear()
        handle_equipping_gear(player.status)
    end
end

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

function job_get_spell_map(spell, default_spell_map)
    if spell.action_type == 'Magic' then
        if spell.skill == 'Enfeebling Magic' then
            if spell.type == 'WhiteMagic' then
                return 'MndEnfeebles'
            else
                return 'IntEnfeebles'
            end
        elseif spell.skill == 'Geomancy' then
            if spell.english:startswith('Indi') then
                return 'Indi'
            end
        end
    end
end

function customize_idle_set(idleSet)
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
    return idleSet
end

-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
    classes.CustomIdleGroups:clear()
    if player.indi then
        classes.CustomIdleGroups:append('Indi')
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
    set_macro_page(1, 6)
end
