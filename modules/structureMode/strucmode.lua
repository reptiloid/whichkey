local funcs = import("../funcs.lua")
local economy = import("../EM/economy.lua")
local upgradeTab = import("../../upgradeTab.lua").upgradeTab

local Construction = import("/lua/ui/game/construction.lua")
local Select = import('/lua/ui/game/selection.lua')
local Units = import('/mods/common/units.lua')


local ToggleUnitPause = import("/lua/ui/game/construction.lua").ToggleUnitPause

local smartSelect = import("/lua/keymap/smartSelection.lua").smartSelect

local cycleIndex = 1
local prevFacIndex = 1
local nextFacIndex = 1

local t1mexThread = false







function cycle_hqs()
	local hqs = {
		{ "uab0303", "uab0203", "uab0103" },
		{ "ueb0303", "ueb0203", "ueb0103" },
		{ "urb0303", "urb0203", "urb0103" },
		{ "xsb0303", "xsb0203", "xsb0103" },
		{ "uab0302", "uab0202", "uab0102" },
		{ "ueb0302", "ueb0202", "ueb0102" },
		{ "urb0302", "urb0202", "urb0102" },
		{ "xsb0302", "xsb0202", "xsb0102" },
		{ "uab0301", "uab0201", "uab0101" },
		{ "ueb0301", "ueb0201", "ueb0101" },
		{ "urb0301", "urb0201", "urb0101" },
		{ "xsb0301", "xsb0201", "xsb0101" },
	}
	local listSize = table.getn(hqs)
	for i=1, listSize do
		funcs.IncrimentCycleIndex(listSize)
		for _, bp in hqs[cycleIndex] do
			if funcs.ui_SelByCat({ str=bp, view=true, near=true }) then
				return
			end
		end
	end
end

function getNextIdleFactory(facType)
	local factoryList = funcs.ui_SelByCat({ str="STRUCTURE FACTORY " .. facType, view=true, idle=true })
	if factoryList then
		prevFacIndex = nextFacIndex
		nextFacIndex = nextFacIndex + 1
		if nextFacIndex > table.getn(factoryList) then
			nextFacIndex = 1
			prevFacIndex = table.getn(factoryList)
		end
		local nextFac = factoryList[nextFacIndex] or factoryList[1]
		SelectUnits({ nextFac })
	end
end


function cycle_indirect()
	local catlist = {
		"STRUCTURE TECH2 ARTILLERY",
		"STRUCTURE TECH3 INDIRECTFIRE PRODUCTSC1",
		"STRUCTURE TECH3 INDIRECTFIRE PRODUCTFA",
		"STRUCTURE ARTILLERY EXPERIMENTAL",
	}
	local splitResult = true
	local mustBeIdle = false
	local inViewList = { true, false, false, false }
	funcs.metaCycle(catlist, splitResult, mustBeIdle, inViewList)
end

function cycle_pgs()
	funcs.metaCycle { 
                      "STRUCTURE ENERGYPRODUCTION TECH1",
                      { "STRUCTURE ENERGYPRODUCTION TECH1",
                        "STRUCTURE ENERGYPRODUCTION TECH2",
                        "STRUCTURE ENERGYPRODUCTION TECH3", },
	}
end

function cycle_defs()
	funcs.metaCycle { "STRUCTURE TECH3 ANTIMISSILE", "STRUCTURE TECH2 ANTIMISSILE", }
end

function cycle_shields()
	funcs.metaCycle { "STRUCTURE SHIELD", "STRUCTURE COUNTERINTELLIGENCE", }
end

function cycle_tml()
	funcs.metaCycle { "STRUCTURE TACTICALMISSILEPLATFORM" }
end

function select_walls()
   funcs.ui_SelByCat { str="WALL", view=true }
end

function cycle_pds()
	funcs.metaCycle { "STRUCTURE TECH1 DIRECTFIRE", "STRUCTURE TECH2 DIRECTFIRE", "STRUCTURE TECH3 DIRECTFIRE" }
end

function cycle_radars()
	funcs.metaCycle { {"STRUCTURE TECH1 OVERLAYRADAR", "STRUCTURE TECH2 OVERLAYRADAR", },
                      "STRUCTURE TECH3 OVERLAYRADAR", "STRUCTURE TECH2 OVERLAYRADAR", "STRUCTURE TECH1 OVERLAYRADAR" }
end

function cycle_structure_aa()
	funcs.metaCycle { "STRUCTURE TECH1 ANTIAIR", "STRUCTURE TECH2 ANTIAIR", "STRUCTURE TECH3 ANTIAIR" }
end


function next_idle_air_factory()
	getNextIdleFactory("AIR")
end


function airFactoryForScouts()
	local carbonList = {}
	local facList = {}
	local finalTable = {}
	for _, unit in funcs.ui_SelByCat({ str="HYDROCARBON", show=false }) or {} do
		local pos = unit:GetPosition()
		local id = unit:GetEntityId()
		table.insert(carbonList, { id=id, x=pos.x, y=pos.z })
	end
	for _, unit in funcs.ui_SelByCat({ str="AIR FACTORY", show=false }) or {} do
		local pos = unit:GetPosition()
		local id = unit:GetEntityId()
		table.insert(facList, { id=id, x=pos.x, y=pos.z, unit=unit })
	end
	SelectUnits(nil)
	for _, fac in facList do
		for _, carb in carbonList do
			local diffX = fac.x - carb.x
			local diffY = fac.y - carb.y
			if (math.abs(diffX) == 7 and math.abs(diffY) == 1) or (math.abs(diffX) == 1 and math.abs(diffY) == 7) then
				table.insert(finalTable, fac.unit)
			end
		end
	end

	if table.getn(finalTable) == 0 then
		for _, unit in funcs.ui_SelByCat({ str="AIR FACTORY STRUCTURE", show=false }) or {} do
			if unit:GetEconData().massConsumed == 0 and unit:GetEconData().energyConsumed == 0 then
				table.insert(finalTable, unit)
			end
		end
	end

	local tableSize = table.getn(finalTable)
	if tableSize > 0 then
		local unit = finalTable[cycleIndex] or finalTable[tableSize]
		SelectUnits({ unit })
		cycleIndex = cycleIndex + 1
		if cycleIndex > tableSize then
			cycleIndex = 1
		end
	else
		funcs.ui_SelByCat({ str="AIR FACTORY STRUCTURE", near=true })
	end
end





function isMexBeingBuilt(mex)
	if mex:GetEconData().energyRequested ~= 0 then
		return false
	end

	if mex:GetHealth() == mex:GetMaxHealth() then
		return false
	end

	return true
end

function get_t1_paused_table_with_engis()
    local patable = {}
	local mexes = Units.Get(categories.MASSEXTRACTION * categories.STRUCTURE * categories.TECH1)
	local engis = Units.Get(categories.ENGINEER)
    for _, m in mexes do
        if m:GetWorkProgress() > 0 and m:GetEconData().massConsumed == 0 then
            local assisting_engis = {}
            for _, e in engis do
                if m == e:GetGuardedEntity() then
                    table.insert(assisting_engis, e)
                end
            end
            if table.getn(assisting_engis) > 0 then
                SetPaused(assisting_engis, true)
            end
            table.insert(patable, {mex=m, engis=assisting_engis})
        end
    end
    table.sort(patable, function(v1, v2) return (v1.mex:GetWorkProgress()*100 + (table.getn(v1.engis)*5) > v2.mex:GetWorkProgress()*100 + (table.getn(v2.engis)*5)) end)
	return patable
end 


function get_t1_upgrading_table_with_engis()
    local uptable = {}
	local mexes = Units.Get(categories.MASSEXTRACTION * categories.STRUCTURE * categories.TECH1)
	local engis = Units.Get(categories.ENGINEER)
    for _, m in mexes do
        if m:GetWorkProgress() > 0 and m:GetEconData().massConsumed > 0 then
            local assisting_engis = {}
            for _, e in engis do
                if m == e:GetGuardedEntity() then
                    table.insert(assisting_engis, e)
                end
            end
            table.insert(uptable, {mex=m, engis=assisting_engis})
        end
    end
    table.sort(uptable, function(v1, v2) return (v1.mex:GetWorkProgress() < v2.mex:GetWorkProgress()) end)
	return uptable
end 


function get_t1_paused_table()
    local pamexes = {}
	local mexes = Units.Get(categories.MASSEXTRACTION * categories.STRUCTURE * categories.TECH1)
    for _, unit in mexes do
        if unit:GetWorkProgress() > 0 and unit:GetEconData().massConsumed == 0 then
            table.insert(pamexes, unit)
        end
    end
    table.sort(pamexes, function(mex1, mex2) return (mex1:GetWorkProgress() > mex2:GetWorkProgress()) end)
	return pamexes
end 

function get_t1_upgrading_table()
    local upmexes = {}
	local mexes = Units.Get(categories.MASSEXTRACTION * categories.STRUCTURE * categories.TECH1)
    for _, unit in mexes do
        if unit:GetWorkProgress() > 0 and unit:GetEconData().massConsumed > 0 then
            table.insert(upmexes, unit)
        end
    end
    table.sort(upmexes, function(mex1, mex2) return (mex1:GetWorkProgress() > mex2:GetWorkProgress()) end)
	return upmexes
end 

function get_t1_idle_mexes()
    local mexes = {}
    for _, unit in Units.Get(categories.MASSEXTRACTION * categories.STRUCTURE * categories.TECH1) do
        if unit:GetWorkProgress() == 0 and unit:GetEconData().massConsumed == 0 then
            if not isMexBeingBuilt(unit) then
                table.insert(mexes, unit)
            end
        end
    end
	return mexes
end 

function gen_mex_table()

	local AllUnits = {}

	local mexTable = {
		[1] = { ["idle"] = {}, ["paused"] = {}, ["upgrading"] = {} },
		[2] = { ["idle"] = {}, ["paused"] = {}, ["upgrading"] = {} },
		[3] = { ["idle"] = {}, ["paused"] = {}, ["upgrading"] = {} },
	}
    
    for _, u in Units.Get() do
        table.insert(AllUnits, u)
    end
    local mexes = EntityCategoryFilterDown(categories.MASSEXTRACTION, AllUnits)

    for _, unit in mexes do
        local upgradeProgress = unit:GetWorkProgress()
        local techLevel = funcs.GetTechLevel(unit)
        local massConsumed = unit:GetEconData().massConsumed
        if upgradeProgress > 0 and massConsumed > 0 then
            table.insert(mexTable[techLevel]["upgrading"], unit)
        elseif upgradeProgress > 0 and massConsumed == 0 then
            table.insert(mexTable[techLevel]["paused"], unit)
        elseif upgradeProgress == 0 and massConsumed == 0 then
            if not isMexBeingBuilt(unit) then
                table.insert(mexTable[techLevel]["idle"], unit)
            end
        end
    end
	return mexTable
end 

function get_mex_info()
    local mex_info = {}
    local txt
	local mexTable = gen_mex_table()
	for techLevel = 1, 3 do
		local idleQty = table.getn(mexTable[techLevel]["idle"])
		local upgQty = table.getn(mexTable[techLevel]["upgrading"])
		local pausedQty = table.getn(mexTable[techLevel]["paused"])
		local allQty = idleQty + upgQty + pausedQty
        if upgQty > 0 then
            txt = LOCF("%d + %d ", allQty - upgQty, upgQty)
        else
            txt = LOCF("%d", allQty)
        end
        table.insert(mex_info, txt)
	end
    -- LOG(repr(mex_info))
    return mex_info
end

function GenerateMexTable()
    local sel
    Select.Hidden(function()
        sel = funcs.ui_SelByCat({ str="MASSEXTRACTION", view=true, show=false })
        SelectUnits(nil)
    end)

	local mexTable = {
		[1] = { ["idle"] = {}, ["paused"] = {}, ["upgrading"] = {} },
		[2] = { ["idle"] = {}, ["paused"] = {}, ["upgrading"] = {} },
		[3] = { ["idle"] = {}, ["paused"] = {}, ["upgrading"] = {} },
	}
	if sel then
		for _, unit in sel do
			local upgradeProgress = unit:GetWorkProgress()
			local techLevel = funcs.GetTechLevel(unit)
			local massConsumed = unit:GetEconData().massConsumed
			if upgradeProgress > 0 and massConsumed > 0 then
				table.insert(mexTable[techLevel]["upgrading"], unit)
			elseif upgradeProgress > 0 and massConsumed == 0 then
				table.insert(mexTable[techLevel]["paused"], unit)
			elseif upgradeProgress == 0 and massConsumed == 0 then
                if not isMexBeingBuilt(unit) then
                    table.insert(mexTable[techLevel]["idle"], unit)
                end
			end
		end
	end
	return mexTable
end

function SelectMex()
	local mexTable = GenerateMexTable()
	local unitStates = { "idle", "paused" }
	local mexList = {}
	local mexNames = {}
	for tech = 1, 3 do
		for _, state in unitStates do
			if table.getn(mexTable[tech][state]) > 0 then
				table.insert(mexList, mexTable[tech][state])
				table.insert(mexNames, LOCF("tech%d [ '%s' ]: ", tech, state))
			end
		end
	end
	local listSize = table.getn(mexList)
	if listSize > 0 then
		funcs.IncrimentCycleIndex(listSize)
		SelectUnits(mexList[cycleIndex])
		print(mexNames[cycleIndex], table.getn(mexList[cycleIndex]))
	end
end

function upgrade_pause_t1mexes()
    local units = GenerateMexTable()[1]["idle"]
    local count_t1_idle = table.getn(units)
	local upgrades = {}

    if count_t1_idle == 0 then
        return
    end

	for _, m in units do
        local upgrades_to = m:GetBlueprint().General.UpgradesTo
        if not upgrades[upgrades_to] then
            upgrades[upgrades_to] = {}
        end
        table.insert(upgrades[upgrades_to], m)
    end

	if table.getsize(upgrades) > 0 then
		Select.Hidden(function()
			for upgrades_to, up_mexes in upgrades do
				SelectUnits(up_mexes)
				IssueBlueprintCommand("UNITCOMMAND_Upgrade", upgrades_to, 1, false)
			end
            SelectUnits(nil)
		end)
	end

    function pause_mexes()
        WaitSeconds(.5)
        SetPaused(units, true)
        print("mexes paused: " .. count_t1_idle)
    end

	ForkThread(pause_mexes)
end 

function initT1MexControl()
	if t1mexThread then
		KillThread( t1mexThread )
        t1mexThread = false
    else
        t1mexThread = ForkThread(upgrade_pause_t1mexes_thread)
        --[[ economy.init() ]]
	end
end

function get_eco_data()
    local data = economy.getEconomy()
    LOG(repr(data))
end

function upgrade_pause_t1mexes_thread()
    while true do
    
        local units = get_t1_idle_mexes()
        local upgrades = {}

        for _, m in units do
            local upgrades_to = m:GetBlueprint().General.UpgradesTo
            if not upgrades[upgrades_to] then
                upgrades[upgrades_to] = {}
            end
            table.insert(upgrades[upgrades_to], m)
        end

        if table.getsize(upgrades) > 0 then
            Select.Hidden(function()
                for upgrades_to, up_mexes in upgrades do
                    SelectUnits(up_mexes)
                    IssueBlueprintCommand("UNITCOMMAND_Upgrade", upgrades_to, 1, false)
                end
                SelectUnits(nil)
            end)
        end

        WaitSeconds(.5)
        SetPaused(units, true)
        WaitSeconds(1)
    end
end 

function upgrade_pause_t2mexes_with_storages()
    local mexes = get_t2mexes_with_storages()
    if table.getn(mexes) == 0 then return end
	local upgrades = {}

	for _, m in mexes do
        local upgrades_to = m:GetBlueprint().General.UpgradesTo
        if not upgrades[upgrades_to] then
            upgrades[upgrades_to] = {}
        end
        table.insert(upgrades[upgrades_to], m)
    end

	if table.getsize(upgrades) > 0 then
		Select.Hidden(function()
			for upgrades_to, up_mexes in upgrades do
				SelectUnits(up_mexes)
				IssueBlueprintCommand("UNITCOMMAND_Upgrade", upgrades_to, 1, false)
			end
            SelectUnits(nil)
		end)
	end

    function pause_mexes()
        WaitSeconds(.5)
        for upgrades_to, up_mexes in upgrades do
            SetPaused(up_mexes, true)
            SetPaused(get_engis_assisting_mexes(up_mexes), true)
            print("mexes paused: " .. table.getn(up_mexes))
        end
    end

	ForkThread(pause_mexes)
    
end

function get_t2mexes_with_storages()
    local units
	local mexes = {}
    Select.Hidden(function()
        smartSelect("MASSEXTRACTION TECH2 +idle")
        units = GetSelectedUnits()
        SelectUnits(nil)
    end)
	for _, m in units do
        if m:GetEconData().massProduced == 9 then
            table.insert(mexes, m)
        end
    end
    return mexes
end

function get_engis_assisting_mexes(mexes)
    local assist_engis = {}
    local engs
    Select.Hidden(function()
        smartSelect("ENGINEER")
        engs = GetSelectedUnits() or {}
        SelectUnits(nil)
    end)
    for _, e in engs do
        local guardedmex = e:GetGuardedEntity()
        for _, mex in mexes do
            if mex == guardedmex then
                table.insert(assist_engis, e)
            end
        end
    end
    -- SetPaused(assist_engis, true)
    return assist_engis
end

function test_ga()
    -- local guardedUnit = GetSelectedUnits()[1]:GetGuardedEntity()
    -- LOG(repr(guardedUnit))

    for _, u in GetSelectedUnits() do
        local id = u:GetEntityId()
		local pos = u:GetPosition()
        --[[ LOG(LOCF("unit id: %d, pos: x:%d, z:%d ", id, pos.x, pos.z)) ]]
        local mid = LOCF("%d|%d ", pos.x, pos.z) 
        LOG(mid)
    end
    
    --[[ local data = Units.Data(GetSelectedUnits()[1]) ]]
    --[[ LOG(repr(data)) ]]
    
end

function SelectUpgradingMexes()
	local mexTable = GenerateMexTable()
	local unitStates = { "upgrading" }
	local mexList = {}
	local mexNames = {}
	for tech = 1, 2 do
		for _, state in unitStates do
			if table.getn(mexTable[tech][state]) > 0 then
				table.insert(mexList, mexTable[tech][state])
				table.insert(mexNames, LOCF("tech%d [ '%s' ]: ", tech, state))
			end
		end
	end
	local listSize = table.getn(mexList)
	if listSize > 0 then
		funcs.IncrimentCycleIndex(listSize)
		SelectUnits(mexList[cycleIndex])
		print(mexNames[cycleIndex], table.getn(mexList[cycleIndex]))
	end
end

function ShowMexInfo()
	-- local mexTable = GenerateMexTable()
	local mexTable = gen_mex_table()
	for techLevel = 1, 3 do
		local idleQty = table.getn(mexTable[techLevel]["idle"])
		local upgQty = table.getn(mexTable[techLevel]["upgrading"])
		local pausedQty = table.getn(mexTable[techLevel]["paused"])
		local allQty = idleQty + upgQty + pausedQty
		if allQty > 0 then
			if upgQty > 0 then
				local difAllUpgr = allQty - upgQty
				print(LOCF("T%d: %d + %d ", techLevel, difAllUpgr, upgQty))
			elseif upgQty == 0 then
				print(LOCF("T%d: %d", techLevel, allQty))
			end
		end
	end
	-- local masStorageQty = table.getn(funcs.ui_SelByCat({ str="MASSSTORAGE", view=true, show=false }) or {})
	-- if masStorageQty > 0 then
	-- 	SelectUnits(nil)
	-- 	print("MS: " .. masStorageQty / 4)
	-- end
end


function UpgradeStructure()
	local sel = GetSelectedUnits()
	if sel then
		for _, unit in sel do
			SelectUnits({ unit })
			local bpid = unit:GetBlueprint().BlueprintId
			local cmd = GetCmdFromQueue() or GetCmdFromBp(bpid, unit)
			if cmd then
				IssueBlueprintCommand("UNITCOMMAND_Upgrade", cmd, 1, false)
			end
		end
		SelectUnits(sel)
	end
end

function GetCmdFromQueue()
	local currentCommandQueue = Construction.getCurrentCommandQueue() or {}
	if table.getn(currentCommandQueue) > 0 then
		for index = table.getn(currentCommandQueue), 1, -1 do
			--LOG("c: " .. currentCommandQueue[index].id)
			local cmd = upgradeTab[currentCommandQueue[index].id]
			if cmd ~= nil then
				return cmd
			end
		end
	end
	return nil
end

function GetCmdFromBp(bpid, unit)
	local bpid_str = bpid .. "_sup"
	local cmd = { upgradeTab[bpid_str], upgradeTab[bpid] }
	local availableOrders, availableToggles, buildableCategories = GetUnitCommandData({ unit })
	local buildable = EntityCategoryGetUnitList(buildableCategories) or {}
	for i, v_cmd in cmd do
		for ii, v_bui in buildable do
			if v_cmd == v_bui then
				return v_cmd
			end
		end
	end
end

function pause_t1_upgrading_mex_with_less_wp()
    --[[ local mexes = get_t1_upgrading_table() ]]
    --[[ table.sort(mexes, function(mex1,mex2) return (mex1:GetWorkProgress() < mex2:GetWorkProgress()) end) ]]
    --[[ local mex = mexes[1] ]]
    --[[ SetPaused({ mex }, true) ]]
    --[[ SetPaused(get_engis_assisting_mexes({ mex }), true) ]]
    local uptable = get_t1_upgrading_table_with_engis()
    local mex = uptable[1].mex
    local engis = uptable[1].engis
    SetPaused({mex}, true)
    SetPaused(engis, true)
end

function unpause_t1_upgrading_mex_with_greater_wp()
    local patable = get_t1_paused_table_with_engis()
    local mex = patable[1].mex
    local engis = patable[1].engis
    SetPaused({mex}, false)
    SetPaused(engis, false)
end


