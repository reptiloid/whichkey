local funcs = import("../funcs.lua")

local Eq = import("/lua/ui/notify/enhancementqueue.lua")
local Construction = import("/lua/ui/game/construction.lua")
local CommandMode = import("/lua/ui/game/commandmode.lua")
local hd = import("/lua/keymap/hotbuild.lua")

overcharge = import("/lua/ui/game/orders.lua").EnterOverchargeMode



function SelectCommander()
    funcs.ui_SelByCat({ str="COMMAND", near=true })
end

function CommanderUpgradeGun()
    CommUpgrade("GUN")
end

function CommanderUpgradeTech2()
    CommUpgrade("T2")
end

function CommanderUpgradeMissle()
    CommUpgrade("Missle")
end

function _upgrade_test()
    local acu = GetSelectedUnits()[1]
	local unitEnhancements = GetEnhancements(acu, true)
    local enh_queue = Eq.getEnhancementQueue()
    local queue = enh_queue[acu:GetEntityId()]
    -- ID: AdvancedEngineering
    -- LOG("enh_queue: " .. repr(enh_queue))
    if enh_queue then
        LOG("upgrade: " .. queue[1]["ID"])
    end
end



function GetEnhancements(unit, log)
	--check what enhancements are already on the unit
	local tempEntityID = unit:GetEntityId()
	local existingEnhancements = import("/lua/enhancementcommon.lua").GetEnhancements(tempEntityID)
	if log then
		LOG("enh: " .. repr(existingEnhancements))
	end
	return existingEnhancements
	-- Gun upgrade
	--SERA   enh: { RCH="RateOfFire" }
	--CYB    enh: { RCH="HeavyAntiMatterCannon" }
	--UEF    enh: { LCH="CoolingUpgrade" }
	--AEON   enh: { LCH="CrysalisBeam", RCH="HeatSink" }
end

function UpgradeACU(upgList)
	for i, upgrade in upgList do
		local currentCommand = CommandMode.GetCommandMode()
		local orderData = { TaskName = "EnhanceTask", Enhancement = upgrade }
		IssueUnitCommand({ GetSelectedUnits()[1] }, "UNITCOMMAND_Script", orderData, false)
		CommandMode.StartCommandMode(currentCommand[1], currentCommand[2])
	end
end

function CheckAcuUpgrade(upgradesList)
	local unitEnhancements = GetEnhancements(GetSelectedUnits()[1])
	if unitEnhancements then
		for _, upg in upgradesList do
			for _, enh in unitEnhancements do
				if enh == upg then
					return upg
				end
			end
		end
	end
	return nil
end

function CommUpgrade(upgType)
	local log
	local acu = GetSelectedUnits()[1]
	local faction_name = string.upper(acu:GetBlueprint().General.FactionName)
	local upgrade_table = {
		GUN = {
			SERAPHIM = { slot="RCH", id="RateOfFire", name="GUN", opposite={ "RegenAura", "AdvancedRegenAura" } },
			UEF = { slot="RCH", id="HeavyAntiMatterCannon", name="GUN", opposite={ "ResourceAllocation" } },
			CYBRAN = { slot="LCH", id="CoolingUpgrade", name="GUN", opposite={ "AdvancedEngineering", "T3Engineering" }, },
			AEON = { slot="LCH", id="HeatSink", name="GUN", opposite={ "EnhancedSensors" } },
		},
		T2 = {
			SERAPHIM = {
				slot = "LCH",
				id = "AdvancedEngineering",
				name = "Tech2",
				opposite = { "T3Engineering", "BlastAttack" },
			},
			UEF = {
				slot = "LCH",
				id = "AdvancedEngineering",
				name = "Tech2",
				opposite = { "T3Engineering", "DamageStablization" },
			},
			CYBRAN = {
				slot = "LCH",
				id = "AdvancedEngineering",
				name = "Tech2",
				opposite = { "T3Engineering", "CoolingUpgrade" },
			},
			AEON = { slot = "LCH", id = "AdvancedEngineering", name = "Tech2", opposite = {
				"T3Engineering",
				"CrysalisBeam",
			} },
		},
		T3 = {
			SERAPHIM = {
				slot = "LCH",
				id = "T3Engineering",
				name = "Tech3",
				prerequisite = "AdvancedEngineering",
				opposite = { "BlastAttack" },
			},
			UEF = {
				slot = "LCH",
				id = "T3Engineering",
				name = "Tech3",
				prerequisite = "AdvancedEngineering",
				opposite = { "DamageStablization" },
			},
			CYBRAN = {
				slot = "LCH",
				id = "T3Engineering",
				name = "Tech3",
				prerequisite = "AdvancedEngineering",
				opposite = { "CoolingUpgrade" },
			},
			AEON = {
				slot = "LCH",
				id = "T3Engineering",
				name = "Tech3",
				prerequisite = "AdvancedEngineering",
				opposite = { "CrysalisBeam" },
			},
		},
		RAS = {
			SERAPHIM = {
				slot = "Back",
				id = "ResourceAllocation",
				name = "RAS",
				opposite = {
					"Teleporter",
					"Missile",
					"DamageStabilization",
					"DamageStabilizationAdvanced",
					"ResourceAllocationAdvanced",
				},
			},
			UEF = { slot = "RCH", id = "ResourceAllocation", name = "RAS", opposite = { "HeavyAntiMatterCannon" } },
			CYBRAN = {
				slot = "Back",
				id = "ResourceAllocation",
				name = "RAS",
				opposite = { "Teleporter", "StealthGenerator", "CloakingGenerator" },
			},
			AEON = {
				slot = "LCH",
				id = "ResourceAllocation",
				name = "RAS",
				opposite = { "Shield", "ShieldHeavy", "Teleporter", "ChronoDampener", "ResourceAllocationAdvanced" },
			},
		},
		ARAS = {
			SERAPHIM = {
				slot = "Back",
				id = "ResourceAllocationAdvanced",
				name = "ARAS",
				opposite = { "Teleporter", "Missile", "DamageStabilization", "DamageStabilizationAdvanced" },
			},
			AEON = {
				slot = "LCH",
				id = "ResourceAllocationAdvanced",
				name = "ARAS",
				opposite = { "Shield", "ShieldHeavy", "Teleporter", "ChronoDampener" },
			},
		},
		Missle = {
			SERAPHIM = {
				slot = "Back",
				id = "Missile",
				name = "TML",
				opposite = {
					"Teleporter",
					"ResourceAllocation",
					"ResourceAllocationAdvanced",
					"DamageStabilization",
					"DamageStabilizationAdvanced",
				},
			},
			UEF = {
				slot = "Back",
				id = "TacticalMissile",
				name = "TML",
				opposite = { "Shield", "ShieldGeneratorField", "Teleporter", "LeftPod", "RightPod" },
			},
		},
	}

	local upgID = upgrade_table[upgType][faction_name]["id"]
	if upgID == nil then
		LOG(LOCF("%s COM have no such upgrade option: [ %s ]", faction_name, upgType))
		return
	end
	local EnhName = upgrade_table[upgType][faction_name]["name"]
	local oppEnhancements = CheckAcuUpgrade(upgrade_table[upgType][faction_name]["opposite"])

	if oppEnhancements == nil then
		if CheckAcuUpgrade({ upgID }) == nil then
			UpgradeACU({ upgID })
			log = LOCF("%s COM upgrading... [ %s ]", faction_name, EnhName)
			--log = LOCF('%s COM upgrading... [ %s ]', faction_name, upgID)
		else
			log = LOCF("%s COMMANDER already has upgrade [ %s ]", faction_name, EnhName)
			--log = LOCF("%s COMMANDER already has upgrade [ %s ]", faction_name, upgID)
		end
	else
		log = LOCF("%s COMMANDER already has opposite upgrade [ %s ]", faction_name, oppEnhancements)
	end

    LOG(log)
end
