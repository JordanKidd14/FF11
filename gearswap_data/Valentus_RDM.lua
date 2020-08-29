-- AF  ----------------------
-- hands - enhance / wsd / atk
-- body - ref / ref potency / macc / enf skill

-- Relic ---------------------
--  head - dia 33 / slow II / wsd / atk / ref
--  body - enh dur / fc / chainspell
--  feet - enf skill / enf effect / para 2
--  hands - gain+

-- Emp ------------------------
--  Hands - Sabotuer
--  Feet - enfeeble potency
--  Legs - Ref potency


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
        state.Buff.Saboteur = buffactive.saboteur or false
    end

    -------------------------------------------------------------------------------------------------------------------
    -- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
    -------------------------------------------------------------------------------------------------------------------

    -- Setup vars that are user-dependent.  Can override this function in a sidecar file.
    function user_setup()
        state.OffenseMode:options('None', 'Normal')
        state.HybridMode:options('Normal', 'PhysicalDef', 'MagicalDef')
        state.CastingMode:options('Normal', 'Resistant')
        state.IdleMode:options('Normal', 'PDT', 'MDT')

        gear.default.obi_waist = "Sekhmet Corset"

        select_default_macro_book()
    end


    -- Define sets and vars used by this job file.
    function init_gear_sets()
        --------------------------------------
        -- Start defining the sets
        --------------------------------------

        -- Precast Sets

        -- Precast sets to enhance JAs
        sets.precast.JA['Chainspell'] = {}


        -- Waltz set (chr and vit)
        sets.precast.Waltz = {}

        -- Don't need any special gear for Healing Waltz.
        sets.precast.Waltz['Healing Waltz'] = {}

        -- Fast cast sets for spells

        -- 80% Fast Cast (including trait) for all spells, plus 5% quick cast
        -- No other FC sets necessary.
        sets.precast.FC = {
            main="Oranyan",
            sub="Enki Strap",
            head={ name="Merlinic Hood", augments={'Mag. Acc.+23 "Mag.Atk.Bns."+23','Magic burst dmg.+5%','Mag. Acc.+10',}},
            body="Duelist's Tabard",
            waist="Channeler's Stone",
            left_ring="Kishar Ring",
            left_ear="Etiolation Earring",
            legs="Aya. Cosciales +1",
            back={ name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','"Fast Cast"+10',}},
        }

        sets.precast.FC.Impact = set_combine(sets.precast.FC, {})

        -- Weaponskill sets
        -- Default set for any weaponskill that isn't any more specifically defined
        sets.precast.WS = {
            left_ring="Karieyh Ring",
        }

        -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
        sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, {})

        sets.precast.WS['Sanguine Blade'] = {}


        -- Midcast Sets

        sets.midcast.FastRecast = {
            left_ring="Kishar Ring",
            left_ear="Etiolation Earring",
        }

        sets.midcast.Cure = {
            main={name="Tamaxchi", priority=2},
            sub={ name="Ammurapi Shield", priority=1},
            ammo="Kalboron Stone",
            head={ name="Telchine Cap", augments={'Enh. Mag. eff. dur. +8',}},
            body={ name="Chironic Doublet", augments={'Mag. Acc.+20','Magic dmg. taken -3%','Weapon skill damage +5%','Mag. Acc.+16 "Mag.Atk.Bns."+16',}},
            hands={ name="Telchine Gloves", augments={'Enh. Mag. eff. dur. +9',}},
            legs={ name="Chironic Hose", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','"Conserve MP"+3','Mag. Acc.+11',}},
            feet="Jhakri Pigaches +1",
            neck={ name="Dls. Torque +1", augments={'Path: A',}},
            waist="Sailfi Belt +1",
            left_ear="Thureous Earring",
            right_ear="Gwati Earring",
            left_ring="Ayanmo Ring",
            right_ring="Jhakri Ring",
            back="Solemnity Cape",
        }

        sets.midcast.Curaga = sets.midcast.Cure
        sets.midcast.CureSelf = sets.midcast.Cure

        sets.midcast['Enhancing Magic'] = {
            main={name="Oranyan", priority=2},
            sub="Enki Strap",
            ammo="Kalboron Stone",
            head={ name="Telchine Cap", augments={'Enh. Mag. eff. dur. +8',}},
            body={ name="Telchine Chas.", augments={'Enh. Mag. eff. dur. +9',}},
            hands={ name="Telchine Gloves", augments={'Enh. Mag. eff. dur. +9',}},
            legs={ name="Chironic Hose", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','"Conserve MP"+3','Mag. Acc.+11',}},
            feet="Leth. Houseaux",
            neck={ name="Dls. Torque +1", augments={'Path: A',}},
            waist="Porous Rope",
            left_ear="Andoaa Earring",
            right_ear="Eabani Earring",
            left_ring="Kishar Ring",
            right_ring="Jhakri Ring",
            back={ name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','"Fast Cast"+10',}},
        }

        sets.midcast.Refresh = {}

        sets.midcast.Stoneskin = {}

        sets.midcast['Enfeebling Magic'] = {
            main={ name="Grioavolr", augments={'Enfb.mag. skill +15','MND+11','Mag. Acc.+18','"Mag.Atk.Bns."+15',},priority=2},
            sub="Enki Strap",
            ammo="Kalboron Stone",
            head={ name="Chironic Hat", augments={'Mag. Acc.+9 "Mag.Atk.Bns."+9','Mag. Acc.+27','Accuracy+20 Attack+20',}},
            body={ name="Chironic Doublet", augments={'Mag. Acc.+20','Magic dmg. taken -3%','Weapon skill damage +5%','Mag. Acc.+16 "Mag.Atk.Bns."+16',}},
            hands="Aya. Manopolas +2",
            legs={ name="Chironic Hose", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','"Conserve MP"+3','Mag. Acc.+11',}},
            feet="Jhakri Pigaches +1",
            neck={ name="Dls. Torque +1", augments={'Path: A',}},
            waist="Rumination Sash",
            left_ear="Etiolation Earring",
            right_ear="Gwati Earring",
            left_ring="Kishar Ring",
            right_ring="Ayanmo Ring",
            back={ name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','"Fast Cast"+10',}},
        }

        sets.midcast['Dia III'] = set_combine(sets.midcast['Enfeebling Magic'], {
            head={ name="Viti. Chapeau +1", augments={'Enfeebling Magic duration','Magic Accuracy',}},
        })
        sets.midcast['Slow II'] = sets.midcast['Dia III']

        sets.midcast['Elemental Magic'] = {
            main={ name="Grioavolr", augments={'Enfb.mag. skill +15','MND+11','Mag. Acc.+18','"Mag.Atk.Bns."+15',},priority=2},
            sub="Enki Strap",
            ammo="Kalboron Stone",
            head={ name="Merlinic Hood", augments={'Mag. Acc.+23 "Mag.Atk.Bns."+23','Magic burst dmg.+5%','Mag. Acc.+10',}},
            body="Jhakri Robe +2",
            hands="Jhakri Cuffs +1",
            legs={ name="Chironic Hose", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','"Conserve MP"+3','Mag. Acc.+11',}},
            feet="Jhakri Pigaches +1",
            neck="Dls. Torque +1",
            waist="Channeler's Stone",
            right_ear="Gwati Earring",
            left_ear="Friomisi Earring",
            left_ring="Fenrir Ring",
            right_ring="Jhakri Ring",
            back={ name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','"Fast Cast"+10',}},
        }

        sets.midcast.Impact = set_combine(sets.midcast['Elemental Magic'], {})

        sets.midcast['Dark Magic'] = {
            main={ name="Grioavolr", augments={'Enfb.mag. skill +15','MND+11','Mag. Acc.+18','"Mag.Atk.Bns."+15',},priority=2},
            sub="Enki Strap",
            ammo="Kalboron Stone",
            head={ name="Chironic Hat", augments={'Mag. Acc.+9 "Mag.Atk.Bns."+9','Mag. Acc.+27','Accuracy+20 Attack+20',}},
            body="Jhakri Robe +2",
            hands="Jhakri Cuffs +1",
            legs={ name="Chironic Hose", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','"Conserve MP"+3','Mag. Acc.+11',}},
            feet="Jhakri Pigaches +1",
            neck="Dls. Torque +1",
            waist="Channeler's Stone",
            left_ear="Aqua Pearl",
            right_ear="Friomisi Earring",
            left_ring="Kishar Ring",
            right_ring="Jhakri Ring",
            back={ name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','"Fast Cast"+10',}},
        }

        --sets.midcast.Stun = set_combine(sets.midcast['Dark Magic'], {})

        sets.midcast.Drain = set_combine(sets.midcast['Dark Magic'], {
            left_ring="Kishar Ring",
        })

        sets.midcast.Aspir = sets.midcast.Drain

        -- Sets for special buff conditions on spells.

        sets.midcast.EnhancingDuration = sets.midcast['Enhancing Magic']

        sets.buff.ComposureOther = {}

        sets.buff.Saboteur = {}


        -- Sets to return to when not performing an action.

        -- Resting sets
        sets.resting = {}


        -- Idle sets
        sets.idle = {
            main={ name="Grioavolr", augments={'Enfb.mag. skill +15','MND+11','Mag. Acc.+18','"Mag.Atk.Bns."+15',},priority=2},
            sub="Enki Strap",
            ammo="Kalboron Stone",
            head={ name="Viti. Chapeau +1", augments={'Enfeebling Magic duration','Magic Accuracy',}},
            body="Jhakri Robe +2",
            hands="Aya. Manopolas +2",
            legs={ name="Chironic Hose", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','"Conserve MP"+3','Mag. Acc.+11',}},
            feet="Aya. Gambieras +2",
            neck="Dls. Torque +1",
            waist="Rumination Sash",
            left_ear="Etiolation Earring",
            right_ear="Eabani Earring",
            left_ring="Ayanmo Ring",
            right_ring="Fenrir Ring",
            --back={ name="Mecisto. Mantle", augments={'Cap. Point+38%','Accuracy+4','DEF+4',}}, 
            back={ name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','"Fast Cast"+10',}},
        }

        sets.idle.Town = sets.idle

        sets.idle.Weak = sets.idle

        sets.idle.PDT = sets.idle

        sets.idle.MDT = sets.idle

        -- Defense sets
        sets.defense.PDT = {}

        sets.defense.MDT = {}

        sets.Kiting = {}

        sets.latent_refresh = {}

        -- Engaged sets

        -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
        -- sets if more refined versions aren't defined.
        -- If you create a set with both offense and defense modes, the offense mode should be first.
        -- EG: sets.engaged.Dagger.Accuracy.Evasion

        -- Normal melee group
        sets.engaged = {
            main={ name="Kaja Knife", priority=2},
            sub={ name="Beatific Shield +1", augments={'Phys. dmg. taken -2%','HP+16 MP+16'}, priority=1},
            ammo="Kalboron Stone",
            head={ name="Viti. Chapeau +1", augments={'Enfeebling Magic duration','Magic Accuracy',}},
            body="Jhakri Robe +2",
            hands="Aya. Manopolas +2",
            legs="Jhakri Slops +1",
            feet="Aya. Gambieras +2",
            neck={ name="Dls. Torque +1", augments={'Path: A',}},
            waist="Rumination Sash",
            left_ear="Etiolation Earring",
            right_ear="Eabani Earring",
            left_ring="Ayanmo Ring",
            right_ring="Fenrir Ring",
            back={ name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','"Fast Cast"+10',}},
        }

        sets.engaged.Defense = {
            main={ name="Elatta Sword", priority=2},
            sub={ name="Beatific Shield +1", augments={'Phys. dmg. taken -2%','HP+16 MP+16'}, priority=1},
            ammo="Kalboron Stone",
            head="Jhakri Coronal +1",
            body="Ayanmo Corazza +2",
            hands="Jhakri Cuffs +1",
            legs="Jhakri Slops +1",
            feet="Jhakri Pigaches +1",
            neck="Dls. Torque +1",
            waist="Channeler's Stone",
            left_ear="Etiolation Earring",
            right_ear="Friomisi Earring",
            left_ring="Ayanmo Ring",
            right_ring="Jhakri Ring",
            back={ name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','"Fast Cast"+10',}},
        }

    end

    -------------------------------------------------------------------------------------------------------------------
    -- Job-specific hooks for standard casting events.
    -------------------------------------------------------------------------------------------------------------------

    -- Run after the default midcast() is done.
    -- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
    function job_post_midcast(spell, action, spellMap, eventArgs)
        if spell.skill == 'Enfeebling Magic' and state.Buff.Saboteur then
            equip(sets.buff.Saboteur)
        elseif spell.skill == 'Enhancing Magic' then
            equip(sets.midcast.EnhancingDuration)
            if buffactive.composure and spell.target.type == 'PLAYER' then
                equip(sets.buff.ComposureOther)
            end
        elseif spellMap == 'Cure' and spell.target.type == 'SELF' then
            equip(sets.midcast.CureSelf)
        end
    end

    -------------------------------------------------------------------------------------------------------------------
    -- Job-specific hooks for non-casting events.
    -------------------------------------------------------------------------------------------------------------------

    -- Handle notifications of general user state change.
    function job_state_change(stateField, newValue, oldValue)
        if stateField == 'Offense Mode' then
            if newValue == 'None' then
                enable('main','sub','range')
            else
                disable('main','sub','range')
            end
        end
    end

    -------------------------------------------------------------------------------------------------------------------
    -- User code that supplements standard library decisions.
    -------------------------------------------------------------------------------------------------------------------

    -- Modify the default idle set after it was constructed.
    function customize_idle_set(idleSet)
        if player.mpp < 51 then
            idleSet = set_combine(idleSet, sets.latent_refresh)
        end

        return idleSet
    end

    -- Set eventArgs.handled to true if we don't want the automatic display to be run.
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
        if player.sub_job == 'DNC' then
            set_macro_page(2, 2)
        elseif player.sub_job == 'NIN' then
            set_macro_page(3, 2)
        elseif player.sub_job == 'THF' then
            set_macro_page(4, 2)
        else
            set_macro_page(1, 2)
        end
    end