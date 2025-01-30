local upgradeTab = import("../../upgradetab.lua").upgradeTab

local Construction = import("/lua/ui/game/construction.lua")

local buildingTab
local shift_count = 3


function QueueDeleteLastElement()
	local currentCommandQueue = Construction.getCurrentCommandQueue()
	if currentCommandQueue then
		local index = table.getn(currentCommandQueue)
		local count = currentCommandQueue[index].count
        if index == 1 then
            count = count - 1
        end
		DecreaseBuildCountInQueue(index, count)
	end
end

function QueueDeleteAll()

	local currentCommandQueue = Construction.getCurrentCommandQueue()
	if currentCommandQueue then
		local tableSize = table.getn(currentCommandQueue)
		local gn_count = currentCommandQueue[tableSize].count

		if (tableSize > 1) or (gn_count > 1) then
			for index = table.getn(currentCommandQueue), 1, -1 do
				local count = currentCommandQueue[index].count
				if index == 1 then
					count = count - 1
				end
				DecreaseBuildCountInQueue(index, count)
			end
		else
			ConExecute("IssueCommand Stop")
		end
	end
end

function factory_hard_stop()
  ConExecute("IssueCommand Stop")
  RepeatBuild_OFF()
end

function CycleFactoryTechLevels()
	local bp = GetSelectedUnits()[1]:GetBlueprint().BlueprintId
	local maxLevel = GetFactoryLevel(bp)
	local curLevel = Construction.GetCurrentTechTab()

	if maxLevel > 1 then
		if curLevel > 1 then
			Construction.SetCurrentTechTab(curLevel - 1)
		elseif curLevel == 1 then
			Construction.SetCurrentTechTab(maxLevel)
		end
	end
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

function GetCmdFromQueue()
	local currentCommandQueue = Construction.getCurrentCommandQueue() or {}
	if table.getn(currentCommandQueue) > 0 then
		for index = table.getn(currentCommandQueue), 1, -1 do
			local cmd = upgradeTab[currentCommandQueue[index].id]
			if cmd ~= nil then
				return cmd
			end
		end
	end
	return nil
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

function RepeatBuild_OFF()
  local selection = GetSelectedUnits()
  if selection then
      local allFactories = true
    local currentInfiniteQueueCheckStatus = false
    for i, v in selection do
      if v:IsRepeatQueue() then
          currentInfiniteQueueCheckStatus = true
      end
      if not v:IsInCategory("FACTORY") then
          allFactories = false
      end
    end
    if allFactories then
        for i, v in selection do
          if currentInfiniteQueueCheckStatus then
              v:ProcessInfo("SetRepeatQueue", "false")
          end
        end
    end
  end
end

function ToggleRepeatBuild() 
	local selection = GetSelectedUnits()
	if selection then
		local allFactories = true
		local currentInfiniteQueueCheckStatus = false
		for i, v in selection do
			if v:IsRepeatQueue() then
				currentInfiniteQueueCheckStatus = true
			end
			if not v:IsInCategory("FACTORY") then
				allFactories = false
			end
		end
		if allFactories then
			for i, v in selection do
				if currentInfiniteQueueCheckStatus then
					v:ProcessInfo("SetRepeatQueue", "false")
				else
					v:ProcessInfo("SetRepeatQueue", "true")
				end
			end
		end
	end
end


function getBuildingTab()
	local btSource = import("../../buildingtab.lua").buildingTab
	local buildingTab = {}
	for name, values in btSource do
		buildingTab[name] = {}
		for i, value in values do
			if nil ~= __blueprints[value] then
				table.insert(buildingTab[name], value)
			elseif nil ~= btSource[value] then
				for i, realValue in btSource[value] do
					if nil ~= __blueprints[realValue] then
						table.insert(buildingTab[name], realValue)
					else
						LOG("!!!!! Invalid indirect building value " .. value .. " -> " .. realValue)
					end
				end
			elseif value == "_upgrade" or value == "_templates" then
				table.insert(buildingTab[name], value)
			else
				LOG("!!!!! Invalid building value " .. value)
			end
		end
	end
	return buildingTab
end

function ParseBpId(BPID) 
	local lvl = string.gsub(BPID, "%a+%d(%d)%d+", "%1")
	lvl = tonumber(lvl)
	if lvl > 3 then
		lvl = lvl - 3
	end
	return lvl
end

function GetFactoryLevel(bpid) 
	local bpid_str = bpid .. "_sup"
	local cmdList = {
		upgradeTab[upgradeTab[bpid_str]],
		upgradeTab[upgradeTab[bpid]],
		upgradeTab[bpid_str],
		upgradeTab[bpid],
	}
	local q = Construction.getCurrentCommandQueue()
	if q then
		for _, cmdValue in cmdList do
			for index = table.getn(q), 1, -1 do
				if cmdValue and cmdValue == q[index].id then
					return ParseBpId(cmdValue)
				end
			end
		end
	end
	return ParseBpId(bpid)
end

function SetMaxTechLevelTab()
	local bp = GetSelectedUnits()[1]:GetBlueprint().BlueprintId
	local maxLevel = GetFactoryLevel(bp)
	Construction.SetCurrentTechTab(maxLevel)
end










function GetFactoryType(unit)
	if unit:IsInCategory("LAND") then
		return "LAND"
	elseif unit:IsInCategory("AIR") then
		return "AIR"
	elseif unit:IsInCategory("NAVAL") then
		return "NAVAL"
	elseif unit:IsInCategory("GATE") then
		return "GATE"
	else
		return "-"
	end
end


function show_buildingtab()
    local buildingTab = getBuildingTab()

    LOG(repr(buildingTab["T1_Air_Scout"]))
    --[[ LOG(repr(buildingTab["B_lvl1"])) ]]

end

function FactoryOrdersTab(name, modifier, count)

    --[[ ["B_lvl1"] = { "T1_Frigate", "T1_Light_Assault_Bot", "T1_Attack_Bomber" }, ]]

  local buildingTab = getBuildingTab()
	local sel = GetSelectedUnits()
	local unit = sel[1]
	if modifier == "SHIFT" then
		count = 3
	end
	if count == nil then
		count = 1
	end
	local lvl = Construction.GetCurrentTechTab()
	SetMaxTechLevelTab()
	--{{{ build command
	local values = buildingTab[name]
	if values == nil then
		return
	end

	local availableOrders, availableToggles, buildableCategories = GetUnitCommandData({ unit })
	local buildable = EntityCategoryGetUnitList(buildableCategories)
	for _, v in values do
		for _, ba in buildable do
			if v == ba then
				IssueBlueprintCommand("UNITCOMMAND_BuildFactory", v, count)
			end
		end
	end
end

function factory_order(name, count)
    local buildingTab = getBuildingTab()
    local values = buildingTab[name]

	local sel = GetSelectedUnits()
	local unit = sel[1]

	local availableOrders, availableToggles, buildableCategories = GetUnitCommandData({ unit })
	local buildable = EntityCategoryGetUnitList(buildableCategories)
	for _, v in values do
		for _, ba in buildable do
			if v == ba then
				IssueBlueprintCommand("UNITCOMMAND_BuildFactory", v, count)
			end
		end
	end
end

function get_tech_level()
	local bp = GetSelectedUnits()[1]:GetBlueprint().BlueprintId
	local maxLevel = GetFactoryLevel(bp)
    print(maxLevel)
end

