-- NOTE: I do not play bst, so this will not be maintained for 'active' use.
-- It is added to the repository to allow people to have a baseline to build from,
-- and make sure it is up-to-date with the library API.

-- Credit to Quetzalcoatl.Falkirk for most of the original work.

--[[
    Custom commands:

    Ctrl-F8 : Cycle through available pet food options.
    Alt-F8 : Cycle through correlation modes for pet attacks.
]]

-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2

    -- Load and initialize the include file.
    include('Mote-Include.lua')
end

function job_setup()
    -- Set up Reward Modes and keybind Ctrl-F8
    state.RewardMode = M{['description']='Reward Mode', 'Theta', 'Zeta', 'Eta'}
    RewardFood = {name="Pet Food Theta"}
    send_command('bind ^f8 gs c cycle RewardMode')

    -- Set up Monster Correlation Modes and keybind Alt-F8
    state.CorrelationMode = M{['description']='Correlation Mode', 'Neutral','Favorable'}
    send_command('bind !f8 gs c cycle CorrelationMode')

    -- Custom pet modes for engaged gear
    state.PetMode = M{['description']='Pet Mode', 'Normal', 'PetStance', 'PetTank'}


    ready_moves_to_check = S{
        'Sic','Whirl Claws','Dust Cloud','Foot Kick','Sheep Song','Sheep Charge','Lamb Chop',
        'Rage','Head Butt','Scream','Dream Flower','Wild Oats','Leaf Dagger','Claw Cyclone','Razor Fang',
        'Roar','Gloeosuccus','Palsy Pollen','Soporific','Cursed Sphere','Venom','Geist Wall','Toxic Spit',
        'Numbing Noise','Nimble Snap','Cyclotail','Spoil','Rhino Guard','Rhino Attack','Power Attack',
        'Hi-Freq Field','Sandpit','Sandblast','Venom Spray','Mandibular Bite','Metallic Body','Bubble Shower',
        'Bubble Curtain','Scissor Guard','Big Scissors','Grapple','Spinning Top','Double Claw','Filamented Hold',
        'Frog Kick','Queasyshroom','Silence Gas','Numbshroom','Spore','Dark Spore','Shakeshroom','Blockhead',
        'Secretion','Fireball','Tail Blow','Plague Breath','Brain Crush','Infrasonics','1000 Needles',
        'Needleshot','Chaotic Eye','Blaster','Scythe Tail','Ripper Fang','Chomp Rush','Intimidate','Recoil Dive',
        'Water Wall','Snow Cloud','Wild Carrot','Sudden Lunge','Spiral Spin','Noisome Powder','Wing Slap',
        'Beak Lunge','Suction','Drainkiss','Acid Mist','TP Drainkiss','Back Heel','Jettatura','Choke Breath',
        'Fantod','Charged Whisker','Purulent Ooze','Corrosive Ooze','Tortoise Stomp','Harden Shell','Aqua Breath',
        'Sensilla Blades','Tegmina Buffet','Molting Plumage','Swooping Frenzy','Pentapeck','Sweeping Gouge',
        'Zealous Snort', 'Tickling Tendrils', 'Stink Bomb', 'Nectarous Deluge', 'Nepenthic Plunge'
    }
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

function user_setup()
    state.OffenseMode:options('Normal', 'Acc')
    state.WeaponskillMode:options('Normal')
    state.IdleMode:options('Normal')
    state.PhysicalDefenseMode:options('PDT')

    update_combat_form()
end


-- Called when this job file is unloaded (eg: job change)
function user_unload()
    -- Unbinds the Reward and Correlation hotkeys.
   send_command('unbind ^f8')
   send_command('unbind !f8')
end


-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Precast sets
    --------------------------------------

    sets.precast.JA['Killer Instinct'] = {head="Ankusa Helm +1"}
    sets.precast.JA['Feral Howl'] = {body="Ankusa Jackcoat +1"}
    sets.precast.JA['Call Beast'] = {hands="Ankusa Gloves +1"}
    sets.precast.JA['Familiar'] = {legs="Ankusa Trousers +1"}
    sets.precast.JA['Tame'] = {head="Totemic Helm +1",ear1="Tamer's Earring",legs="Stout Kecks"}
    sets.precast.JA['Spur'] = {feet="Ferine Ocreae +2"}

    sets.precast.JA['Reward'] = {ammo=RewardFood,
        head="Stout Bonnet",neck="Aife's Medal",ear1="Lifestorm Earring",ear2="Neptune's Pearl",
        body="Totemic Jackcoat +1",hands="Totemic Gloves +1",ring1="Aquasoul Ring",ring2="Aquasoul Ring",
        back="Pastoralist's Mantle",waist="Crudelis Belt",legs="Ankusa Trousers +1",feet="Ankusa Gaiters +1"}

    sets.precast.JA['Charm'] = {ammo="Tsar's Egg",
        head="Totemic Helm +1",neck="Ferine Necklace",ear1="Enchanter's Earring",ear2="Reverie Earring +1",
        body="Ankusa Jackcoat +1",hands="Ankusa Gloves +1",ring1="Dawnsoul Ring",ring2="Dawnsoul Ring",
        back="Aisance Mantle +1",waist="Aristo Belt",legs="Ankusa Trousers +1",feet="Ankusa Gaiters +1"}

    -- CURING WALTZ
    sets.precast.Waltz = {ammo="Tsar's Egg",
        head="Totemic Helm +1",neck="Ferine Necklace",ear1="Enchanter's Earring",ear2="Reverie Earring +1",
        body="Gorney Haubert +1",hands="Totemic Gloves +1",ring1="Valseur's Ring",ring2="Asklepian Ring",
        back="Aisance Mantle +1",waist="Aristo Belt",legs="Osmium Cuisses",feet="Scamp's Sollerets"}

    -- HEALING WALTZ
    sets.precast.Waltz['Healing Waltz'] = {}

    -- STEPS
    sets.precast.Step = {ammo="Jukukik Feather",
        head="Yaoyotl Helm",neck="Ziel Charm",ear1="Choreia Earring",ear2="Heartseeker Earring",
        body="Mikinaak Breastplate",hands="Buremte Gloves",ring1="Mars's Ring",ring2="Oneiros Annulet",
        back="Letalis Mantle",waist="Hurch'lan Sash",legs="Skadi's Chausses +1",feet="Gorney Sollerets +1"}

    -- VIOLENT FLOURISH
    sets.precast.Flourish1 = {}
    sets.precast.Flourish1['Violent Flourish'] = {body="Ankusa Jackcoat +1",legs="Iuitl Tights +1",feet="Iuitl Gaiters +1"}

    sets.precast.FC = {ammo="Impatiens",neck="Orunmila's Torque",ear1="Loquacious Earring",ring1="Prolix Ring"}
    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads"})

    -- WEAPONSKILLS
    -- Default weaponskill set.
    sets.precast.WS = { -- Physical
        main={ name="Skullrender", augments={'DMG:+15','Pet: Accuracy+20','Pet: Attack+20',}},
        sub={ name="Skullrender", augments={'DMG:+15','Pet: Accuracy+20','Pet: Attack+20',}},
        ammo="Amar Cluster",
        head={ name="Valorous Mask", augments={'"Mag.Atk.Bns."+13','Pet: Attack+30 Pet: Rng.Atk.+30','Accuracy+18 Attack+18','Mag. Acc.+1 "Mag.Atk.Bns."+1',}},
        body={ name="Despair Mail", augments={'Accuracy+10','Pet: VIT+7','Pet: Damage taken -3%',}},
        hands={ name="Valorous Mitts", augments={'Pet: "Mag.Atk.Bns."+16','Pet: "Dbl.Atk."+3 Pet: Crit.hit rate +3','Pet: STR+6','Pet: Accuracy+6 Pet: Rng. Acc.+6',}},
        legs={ name="Valor. Hose", augments={'Pet: Accuracy+27 Pet: Rng. Acc.+27','Pet: "Dbl.Atk."+3 Pet: Crit.hit rate +3','Pet: VIT+7',}},
        feet={ name="Valorous Greaves", augments={'"Fast Cast"+2','Pet: "Mag.Atk.Bns."+28','"Treasure Hunter"+1','Accuracy+18 Attack+18',}},
        neck="Sanctity Necklace",
        waist="Eschan Stone",
        left_ear="Brutal Earring",
        right_ear="Steelflash Earring",
        right_ring="Rajas Ring",
        back={ name="Pastoralist's Mantle", augments={'STR+3 DEX+3','Accuracy+4','Pet: Accuracy+17 Pet: Rng. Acc.+17','Pet: Damage taken -2%',}},
    }

    sets.precast.WS.WSAcc = {}

    -- Specific weaponskill sets.
    sets.precast.WS['Ruinator'] = set_combine(sets.precast.WS, {})

    sets.precast.WS['Ruinator'].WSAcc = set_combine(sets.precast.WS.WSAcc, {})

    sets.precast.WS['Ruinator'].Mekira = set_combine(sets.precast.WS['Ruinator'], {})

    sets.precast.WS['Onslaught'] = set_combine(sets.precast.WS, {})

    sets.precast.WS['Onslaught'].WSAcc = set_combine(sets.precast.WSAcc, {})

    sets.precast.WS['Primal Rend'] = {
        main={ name="Skullrender", augments={'DMG:+15','Pet: Accuracy+20','Pet: Attack+20',}},
        sub={ name="Skullrender", augments={'DMG:+15','Pet: Accuracy+20','Pet: Attack+20',}},
        ammo="Amar Cluster",
        head={ name="Valorous Mask", augments={'"Mag.Atk.Bns."+13','Pet: Attack+30 Pet: Rng.Atk.+30','Accuracy+18 Attack+18','Mag. Acc.+1 "Mag.Atk.Bns."+1',}},
        body={ name="Despair Mail", augments={'Accuracy+10','Pet: VIT+7','Pet: Damage taken -3%',}},
        hands={ name="Valorous Mitts", augments={'Pet: "Mag.Atk.Bns."+16','Pet: "Dbl.Atk."+3 Pet: Crit.hit rate +3','Pet: STR+6','Pet: Accuracy+6 Pet: Rng. Acc.+6',}},
        legs={ name="Emicho Hose", augments={'Pet: Accuracy+15','Pet: Attack+15','Pet: "Dbl. Atk."+3',}},
        feet={ name="Valorous Greaves", augments={'"Fast Cast"+2','Pet: "Mag.Atk.Bns."+28','"Treasure Hunter"+1','Accuracy+18 Attack+18',}},
        neck="Sanctity Necklace",
        waist="Eschan Stone",
        left_ear="Friomisi Earring",
        right_ear="Hecate's Earring",
        left_ring="Acumen Ring",
        right_ring="Rajas Ring",
        back={ name="Pastoralist's Mantle", augments={'STR+3 DEX+3','Accuracy+4','Pet: Accuracy+17 Pet: Rng. Acc.+17','Pet: Damage taken -2%',}},
    }

    sets.precast.WS['Cloudsplitter'] = set_combine(sets.precast.WS['Primal Rend'], {})


    --------------------------------------
    -- Midcast sets
    --------------------------------------

    sets.midcast.FastRecast = {}

    sets.midcast.Utsusemi = sets.midcast.FastRecast


    -- PET SIC & READY MOVES
    sets.midcast.Pet.WS = {
        hands="Ferine Manoplas +2",
        main="Charmer's Merlin",
        legs="Desultor Tassets"
    }

    sets.midcast.Pet.WS.Unleash = set_combine(sets.midcast.Pet.WS, {})

    sets.midcast.Pet.Neutral = {
        hands="Ferine Manoplas +2",
        main="Charmer's Merlin",
        legs="Desultor Tassets"
    }
    sets.midcast.Pet.Favorable = {
        hands="Ferine Manoplas +2",
        main="Charmer's Merlin",
        legs="Desultor Tassets"
    }


    --------------------------------------
    -- Idle/resting/defense/etc sets
    --------------------------------------

    -- RESTING
    sets.resting = {
        main={ name="Skullrender", augments={'DMG:+15','Pet: Accuracy+20','Pet: Attack+20',}},
        sub={ name="Skullrender", augments={'DMG:+15','Pet: Accuracy+20','Pet: Attack+20',}},
        ammo="Amar Cluster",
        head={ name="Valorous Mask", augments={'"Mag.Atk.Bns."+13','Pet: Attack+30 Pet: Rng.Atk.+30','Accuracy+18 Attack+18','Mag. Acc.+1 "Mag.Atk.Bns."+1',}},
        body={ name="Despair Mail", augments={'Accuracy+10','Pet: VIT+7','Pet: Damage taken -3%',}},
        hands={ name="Valorous Mitts", augments={'Pet: "Mag.Atk.Bns."+16','Pet: "Dbl.Atk."+3 Pet: Crit.hit rate +3','Pet: STR+6','Pet: Accuracy+6 Pet: Rng. Acc.+6',}},
        legs={ name="Emicho Hose", augments={'Pet: Accuracy+15','Pet: Attack+15','Pet: "Dbl. Atk."+3',}},
        feet={ name="Valorous Greaves", augments={'Pet: Attack+23 Pet: Rng.Atk.+23','Pet: "Regen"+3','Pet: DEX+14','Pet: Accuracy+13 Pet: Rng. Acc.+13',}},
        neck="Empath Necklace",
        waist="Klouskap Sash",
        left_ear="Brutal Earring",
        right_ear="Enmerkar Earring",
        left_ring="Rajas Ring",
        right_ring="Thurandaut Ring",
        back={ name="Pastoralist's Mantle", augments={'STR+3 DEX+3','Accuracy+4','Pet: Accuracy+17 Pet: Rng. Acc.+17','Pet: Damage taken -2%',}},
    }

    -- IDLE SETS
    sets.idle = {
        main={ name="Skullrender", augments={'DMG:+15','Pet: Accuracy+20','Pet: Attack+20',}},
        sub={ name="Skullrender", augments={'DMG:+15','Pet: Accuracy+20','Pet: Attack+20',}},
        ammo="Amar Cluster",
        head={ name="Valorous Mask", augments={'"Mag.Atk.Bns."+13','Pet: Attack+30 Pet: Rng.Atk.+30','Accuracy+18 Attack+18','Mag. Acc.+1 "Mag.Atk.Bns."+1',}},
        body={ name="Despair Mail", augments={'Accuracy+10','Pet: VIT+7','Pet: Damage taken -3%',}},
        hands={ name="Valorous Mitts", augments={'Pet: "Mag.Atk.Bns."+16','Pet: "Dbl.Atk."+3 Pet: Crit.hit rate +3','Pet: STR+6','Pet: Accuracy+6 Pet: Rng. Acc.+6',}},
        legs={ name="Emicho Hose", augments={'Pet: Accuracy+15','Pet: Attack+15','Pet: "Dbl. Atk."+3',}},
        feet={ name="Valorous Greaves", augments={'Pet: Attack+23 Pet: Rng.Atk.+23','Pet: "Regen"+3','Pet: DEX+14','Pet: Accuracy+13 Pet: Rng. Acc.+13',}},
        neck="Empath Necklace",
        waist="Klouskap Sash",
        left_ear="Brutal Earring",
        right_ear="Enmerkar Earring",
        left_ring="Rajas Ring",
        right_ring="Thurandaut Ring",
        back={ name="Pastoralist's Mantle", augments={'STR+3 DEX+3','Accuracy+4','Pet: Accuracy+17 Pet: Rng. Acc.+17','Pet: Damage taken -2%',}},
    }

    sets.idle.Refresh = {}

    sets.idle.Reraise = set_combine(sets.idle, {})

    sets.idle.Pet = sets.idle

    sets.idle.Pet.Engaged = sets.engaged

    -- DEFENSE SETS
    sets.defense.PDT = {ammo="Jukukik Feather",
        head="Nocturnus Helm",neck="Twilight Torque",
        body="Mekira Meikogai",hands="Iuitl Wristbands +1",ring1="Dark Ring",ring2="Defending Ring",
        back="Mollusca Mantle",waist="Flume Belt",legs="Iuitl Tights +1",feet="Iuitl Gaiters +1"}


    --------------------------------------
    -- Engaged sets
    --------------------------------------
    -- PET centeric:
    sets.engaged = { --NORMAL MODE
        main={ name="Skullrender", augments={'DMG:+15','Pet: Accuracy+20','Pet: Attack+20',}},
        sub={ name="Skullrender", augments={'DMG:+15','Pet: Accuracy+20','Pet: Attack+20',}},
        ammo="Amar Cluster",
        head={ name="Valorous Mask", augments={'"Mag.Atk.Bns."+13','Pet: Attack+30 Pet: Rng.Atk.+30','Accuracy+18 Attack+18','Mag. Acc.+1 "Mag.Atk.Bns."+1',}},
        body={ name="Despair Mail", augments={'Accuracy+10','Pet: VIT+7','Pet: Damage taken -3%',}},
        hands={ name="Valorous Mitts", augments={'Pet: "Mag.Atk.Bns."+16','Pet: "Dbl.Atk."+3 Pet: Crit.hit rate +3','Pet: STR+6','Pet: Accuracy+6 Pet: Rng. Acc.+6',}},
        legs={ name="Emicho Hose", augments={'Pet: Accuracy+15','Pet: Attack+15','Pet: "Dbl. Atk."+3',}},
        feet={ name="Valorous Greaves", augments={'Pet: Attack+23 Pet: Rng.Atk.+23','Pet: "Regen"+3','Pet: DEX+14','Pet: Accuracy+13 Pet: Rng. Acc.+13',}},
        neck="Empath Necklace",
        waist="Klouskap Sash",
        left_ear="Brutal Earring",
        right_ear="Enmerkar Earring",
        left_ring="Rajas Ring",
        right_ring="Thurandaut Ring",
        back={ name="Pastoralist's Mantle", augments={'STR+3 DEX+3','Accuracy+4','Pet: Accuracy+17 Pet: Rng. Acc.+17','Pet: Damage taken -2%',}},
    }

    -- MASTER centeric:
    sets.engaged.Acc = { -- ACC MODE
        main={ name="Skullrender", augments={'DMG:+15','Pet: Accuracy+20','Pet: Attack+20',}},
        sub={ name="Skullrender", augments={'DMG:+15','Pet: Accuracy+20','Pet: Attack+20',}},
        ammo="Amar Cluster",
        head="Tali'ah Turban +1",
        body={ name="Despair Mail", augments={'Accuracy+10','Pet: VIT+7','Pet: Damage taken -3%',}},
        hands="Tali'ah Gages +1",
        legs={ name="Valor. Hose", augments={'Accuracy+30','Enmity+3','DEX+9',}},
        feet="Tali'ah Crackows +1",
        neck="Empath Necklace",
        waist="Klouskap Sash",
        left_ear="Brutal Earring",
        right_ear="Steelflash Earring",
        left_ring="Rajas Ring",
        right_ring="Varar Ring",
        back={ name="Pastoralist's Mantle", augments={'STR+3 DEX+3','Accuracy+4','Pet: Accuracy+17 Pet: Rng. Acc.+17','Pet: Damage taken -2%',}},
    }

    sets.engaged.Killer = set_combine(sets.engaged, {})
    sets.engaged.Killer.Acc = set_combine(sets.engaged.Acc, {})

    --------------------------------------
    -- Custom buff sets
    --------------------------------------

    sets.buff['Killer Instinct'] = {}

end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

function job_precast(spell, action, spellMap, eventArgs)
    -- Define class for Sic and Ready moves.
    if ready_moves_to_check:contains(spell.english) and pet.status == 'Engaged' then
        classes.CustomClass = "WS"
    end
end


function job_post_precast(spell, action, spellMap, eventArgs)
    -- If Killer Instinct is active during WS, equip Ferine Gausape +2.
    if spell.type:lower() == 'weaponskill' and buffactive['Killer Instinct'] then
        equip(sets.buff['Killer Instinct'])
    end
end


function job_pet_post_midcast(spell, action, spellMap, eventArgs)
    -- Equip monster correlation gear, as appropriate
    equip(sets.midcast.Pet[state.CorrelationMode.value])
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

function job_buff_change(buff, gain)
    
end

-- Called when the pet's status changes.
function job_pet_status_change(newStatus, oldStatus)

end

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    if stateField == 'Reward Mode' then
        -- Thena, Zeta or Eta
        RewardFood.name = "Pet Food " .. newValue
    elseif stateField == 'Pet Mode' then
        state.CombatWeapon:set(newValue)
    end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

function get_custom_wsmode(spell, spellMap, defaut_wsmode)
    if defaut_wsmode == 'Normal' then
        if spell.english == "Ruinator" and (world.day_element == 'Water' or world.day_element == 'Wind' or world.day_element == 'Ice') then
            return 'Mekira'
        end
    end
end

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
    update_combat_form()
end


-- Set eventArgs.handled to true if we don't want the automatic display to be run.
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

    msg = msg .. ', Reward: '..state.RewardMode.value..', Correlation: '..state.CorrelationMode.value

    add_to_chat(122, msg)

    eventArgs.handled = true
end


-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function update_combat_form()
   
end
