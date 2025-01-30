local mspl = import("splitselection/spl.lua")

local Construction = import("/lua/ui/game/construction.lua")


local cycleIndex = 0

local RETURN_FIRE = 0
local HOLD_FIRE = 1
local GROUND_FIRE = 2

local CommandMode = import("/lua/ui/game/commandmode.lua")







function ToggleZoomPop()
    local cam = GetCamera("WorldCamera")
    cam:Reset()
end



function IncrimentCycleIndex(max)
    cycleIndex = cycleIndex + 1
    if cycleIndex > max then
        cycleIndex = 1
    end
end




function NamedArgs(selection)
    if selection == nil then
        selection = { str = "ALLUNITS", add = false, view = false, near = false, idle = false }
    elseif selection.str == nil then
        selection.str = "ALLUNITS"
    end
    for _, v in { "add", "view", "near", "idle" } do
        if selection[v] == nil then
            selection[v] = false
        end
    end
    return selection.str, selection.add, selection.view, selection.near, selection.idle
end

function ui_SelByCat(selection)
    --UISelectionByCategory(expression, addToCurSel, inViewFrustum, nearestToMouse, mustBeIdle)
    if type(selection.str) == "table" then
        for i, v in selection.str do
            local add
            if i > 1 then
                add = true
            else
                add = false
            end
            ui_SelByCat({
                str = v,
                add = add,
                view = selection.view or false,
                near = selection.near or false,
                idle = selection.idle or false,
                show = selection.show or true,
            })
        end
    else
        if selection.show == nil or selection.show == true then
            UISelectionByCategory(NamedArgs(selection))
        elseif selection.show == false then
            UISelectionByCategory(NamedArgs(selection))
        end
    end
    return GetSelectedUnits()
end

function toggle_all_scripts()
    ConExecute('UI_Lua import("/lua/keymap/misckeyactions.lua").toggleCloakJammingStealthScript()')
end

function upload()
    ConExecute("StartCommandMode order RULEUCC_Transport")
end

function patrol()
    ConExecute("StartCommandMode order RULEUCC_Patrol")
end

function move1()
    ConExecute("StartCommandMode order RULEUCC_Move")
end

function ferry()
    ConExecute("StartCommandMode order RULEUCC_Ferry")
end

function stop()
    ConExecute("IssueCommand Stop")
end

function guard()
    ConExecute("StartCommandMode order RULEUCC_Guard")
end

function easy_reclaim()
    --[[ ConExecute('UI_Lua import("/lua/ui/game/commandmode.lua").EasyReclaim()') ]]
    ConExecute("StartCommandMode order RULEUCC_Reclaim")
end

function move()
    ConExecute('UI_Lua import("/lua/ui/game/commandmode.lua").MoveOnly()')
end

function sacrifice()
    ConExecute("StartCommandMode order RULEUCC_Sacrifice")
end

function upgrade_sacrifice()
    local currentCommand = CommandMode.GetCommandMode()
    local orderData = { TaskName = "EnhanceTask", Enhancement = "Sacrifice" }
    IssueUnitCommand(GetSelectedUnits(), "UNITCOMMAND_Script", orderData, false)
    CommandMode.StartCommandMode(currentCommand[1], currentCommand[2])
end

function nukeLaunch()
    ConExecute("StartCommandMode order RULEUCC_Nuke")
end

function CycleTrans_Test()
    local list = {
        { info = "T2_Trans", func = ui_SelByCat, args = { str = "TRANSPORTATION TECH2", view = true } },
        {
            info = "T2 idle Trans",
            func = ui_SelByCat,
            args = { str = "TRANSPORTATION TECH2", idle = true, view = true },
        },
        { info = "T1 Trans", func = ui_SelByCat, args = { str = "TRANSPORTATION TECH1", view = true } },
    }
    CycleAnyListTwo(list)
end

function CycleAnyListTwo(list)
    local listSize = table.getn(list)
    for i = 1, listSize do
        IncrimentCycleIndex(listSize)
        local func = list[cycleIndex]["func"]
        local args = list[cycleIndex]["args"]
        local selection = func(args)
        if selection then
            if list[cycleIndex]["info"] ~= nil then
                local txt = LOCF("%d %s", table.getn(selection), list[cycleIndex]["info"])
                print(txt)
            end
            break
        end
    end
end

function metaCycle(catTable, splitResult, mustBeIdleList, inViewList, printInfo, infoList)
    -- UISelectionByCategory(expression, addToCurSel, inViewFrustum, nearestToMouse, mustBeIdle)
    local listSize = table.getn(catTable)
    if mustBeIdleList == nil or mustBeIdleList == false then
        mustBeIdleList = {}
        for i = 1, listSize do
            table.insert(mustBeIdleList, false)
        end
    elseif type(mustBeIdleList) == "table" then
    elseif mustBeIdleList == true then
        mustBeIdleList = {}
        for i = 1, listSize do
            table.insert(mustBeIdleList, true)
        end
    end
    if splitResult == nil then
        splitResult = true
    end
    if inViewList == nil then
        inViewList = {}
        for i = 1, listSize do
            table.insert(inViewList, true)
        end
    end
    for i = 1, listSize do
        IncrimentCycleIndex(listSize)
        if type(catTable[cycleIndex]) == "table" then
            local addToCurSel
            for index, cat in catTable[cycleIndex] do
                if index == 1 then
                    addToCurSel = false
                else
                    addToCurSel = true
                end
                UISelectionByCategory(cat, addToCurSel, inViewList[cycleIndex], false, mustBeIdleList[cycleIndex])
            end
        else
            UISelectionByCategory(
                catTable[cycleIndex],
                false,
                inViewList[cycleIndex],
                false,
                mustBeIdleList[cycleIndex]
            )
        end
        local s = GetSelectedUnits()
        if s then
            if printInfo then
                print(">  " .. table.getn(s) .. " " .. (infoList[cycleIndex] or catTable[cycleIndex]))
            end
            if splitResult then
                mspl.splitUnits()
            end
            return
        end
    end
end

function GetCurrentEnhTabName()
    for _,v in {"Back", "RCH", "LCH"} do
        if Construction.GetTabByID(v):IsChecked() then
            return v
        end
    end
end

function SetEnhSubTab(enh)
    Construction.GetTabByID(enh):SetCheck(true)
end

function CycleEnhancementTab()
    Construction.ActivateEnhTab()
    local current_enh = GetCurrentEnhTabName()
    local t = {LCH = "Back", Back = "RCH", RCH = "LCH"}
    SetEnhSubTab(t[current_enh])
end

function meta_select(selection_table)
    -- UISelectionByCategory(expression, addToCurSel, inViewFrustum, nearestToMouse, mustBeIdle)
    local stsize = table.getn(selection_table)
    for i = 1, stsize do
        IncrimentCycleIndex(stsize)
        local v = selection_table[cycleIndex]
        UISelectionByCategory(v.expr, false, v.inview, v.near, false)
        local selection = GetSelectedUnits()
        if selection then
            for _, f in v.run_after do
                f()
            end
            break
        end
    end
end

function cycle_idle_factories()
    local idleFactories = GetIdleFactories()
    if idleFactories then
        local sel = idleFactories[cycleIndex] or idleFactories[1]
        cycleIndex = cycleIndex + 1
        if cycleIndex > table.getn(idleFactories) then
            cycleIndex = 1
        end
        SelectUnits({ sel })
    end
end

function cycle_idle_engineers()
    local idleEngineers = GetIdleEngineers()
    if idleEngineers then
        local selEngineer = idleEngineers[cycleIndex] or idleEngineers[1]
        cycleIndex = cycleIndex + 1
        if cycleIndex > table.getn(idleEngineers) then
            cycleIndex = 1
        end
        SelectUnits({ selEngineer })
        Construction.ActivateSelTab()
    end
end

function ground_attack()
    SetFireState(GetSelectedUnits(), GROUND_FIRE)
    ConExecute("StartCommandMode order RULEUCC_Attack")
end

function spread_attack()
    ConExecute('UI_Lua import("/lua/ui/game/hotkeys/distribute-queue.lua").DistributeOrders(true)')
end

function toggle_pause()
    ConExecute("UI_Lua import('/lua/ui/game/construction.lua').ToggleUnitPause()")
    ConExecute('UI_Lua import("/lua/keymap/misckeyactions.lua").toggleAllScript()')
end

function toggle_all_scripts2()
    ConExecute('UI_Lua import("/lua/keymap/misckeyactions.lua").toggleAllScript()')
end

function GetTechLevel(unit)
    if unit:IsInCategory("TECH1") then
        return 1
    elseif unit:IsInCategory("TECH2") then
        return 2
    elseif unit:IsInCategory("TECH3") then
        return 3
        -- elseif unit:IsInCategory("COMMAND") then
        -- 	return checkACUEngiSuite()
    else
        return 1
    end
end

--unitToggleRules = {
--    Shield =  0,
--    Weapon = 1, --?
--    Jamming = 2,
--    Intel = 3,
--    Production = 4, --?
--    Stealth = 5,
--    Generic = 6,
--    Special = 7,
--Cloak = 8,}

function GetOnValueForScriptBit(i)
    if i == 0 then
        return false
    end -- shield is weird and reversed... you need to set it to false to get it to turn off - unlike everything else
    return true
end

function DisableUnitsAbility()
    for i = 0, 8 do
        ToggleScriptBit(GetSelectedUnits(), i, not GetOnValueForScriptBit(i))
    end
end

function EnableUnitsAbility()
    for i = 0, 8 do
        ToggleScriptBit(GetSelectedUnits(), i, GetOnValueForScriptBit(i))
    end
end

function GetIsUnitAbilityEnabled(units)
    for i = 0, 8 do
        if GetScriptBit(units, i) == GetOnValueForScriptBit(i) then
            return true
        end
    end
    return false
end

function map_info()
    -- local options = SessionGetScenarioInfo()
    -- local tps = GetSimTicksPerSecond()
    local data = GetEconomyTotals()
    LOG(repr(data))
end

function selectAirHQ()
    local hqs = {
        { "uab0302", "uab0202", "uab0102" },
        { "ueb0302", "ueb0202", "ueb0102" },
        { "urb0302", "urb0202", "urb0102" },
        { "xsb0302", "xsb0202", "xsb0102" },
    }
    local listSize = table.getn(hqs)
    for i = 1, listSize do
        IncrimentCycleIndex(listSize)
        for _, bp in hqs[cycleIndex] do
            if ui_SelByCat({ str = bp, near = true }) then
                return
            end
        end
    end
end 

function CycleHQs()
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
    for i = 1, listSize do
        IncrimentCycleIndex(listSize)
        for _, bp in hqs[cycleIndex] do
            if ui_SelByCat({ str = bp, view = true, near = true }) then
                return
            end
        end
    end
end
