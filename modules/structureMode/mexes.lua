-- local funcs = import("../funcs.lua")

local Construction = import("/lua/ui/game/construction.lua")
local Select = import('/lua/ui/game/selection.lua')
local Units = import('/mods/common/units.lua')




local t1_mexes = { idle={}, paused={}, upgrading={} }
local t1_mex_thread = false


function getTECH1Mexes()
    LOG(repr(t1_mexes))
	--[[ return t1_mexes ]]
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

function update_t1_mexes_thread()
    while true do
        t1_mexes = { idle={}, paused={}, upgrading={} }
        local engis = Units.Get(categories.ENGINEER)
        for _, u in Units.Get(categories.MASSEXTRACTION * categories.STRUCTURE * categories.TECH1) do
            local mc = u:GetEconData().massConsumed
            local wp = u:GetWorkProgress()
            if wp > 0 and mc > 0 then
                local engis = get_assisting_engis_table(engis, u)
                SetPaused(engis, false)
                table.insert(t1_mexes["upgrading"], { mex=u, wp=wp, engis=engis})
            elseif wp > 0 and mc == 0 then
                local engis = get_assisting_engis_table(engis, u)
                SetPaused(engis, true)
                table.insert(t1_mexes["paused"], { mex=u, wp=wp, engis=engis})
            elseif wp == 0 and mc == 0 then
                if not isMexBeingBuilt(u) then
                    table.insert(t1_mexes["idle"], { mex=u, engis=get_assisting_engis_table(engis, u)})
                end
            end
        end
        WaitSeconds(.5)
    end
end 

function get_assisting_engis_table(all_engis, mex)
    local assisting_engis = {}
    for _, e in all_engis do
        if mex == e:GetGuardedEntity() then
            table.insert(assisting_engis, e)
        end
    end
    return assisting_engis
end 

function init()
	if t1_mex_thread then
		KillThread( t1_mex_thread )
        t1_mex_thread = false
        print("t1 mex thread killed")
    else
        t1_mex_thread = ForkThread(update_t1_mexes_thread)
        print("t1 mex thread started")
	end
end



