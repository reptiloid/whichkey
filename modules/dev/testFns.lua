function logBpCategories()
    local sel = GetSelectedUnits()
    if sel then
        local availableOrders, availableToggles, buildableCategories = GetUnitCommandData(sel)
        local bp = sel[1]:GetBlueprint()
        local bpCats = bp.Categories

        LOG("bpCats: " .. repr(bpCats))
        LOG("bpid: " .. bp.BlueprintId)
        LOG("Faction: " .. bp.General.FactionName)
        -- LOG("Test: " .. repr(sel[1]))

        LOG("toggles: " .. repr(availableToggles))
    end
end


function getEnhancements(unit, log)
    local id = unit:GetEntityId()
    local existingEnhancements = import("/lua/enhancementcommon.lua").GetEnhancements(id)
    if log then
        LOG("existingEnhancements: " .. repr(existingEnhancements))
    end
    return existingEnhancements
    --Gun upgrade
    --SERA   enh: { RCH="RateOfFire" }
    --CYB    enh: { RCH="HeavyAntiMatterCannon" }
    --UEF    enh: { LCH="CoolingUpgrade" }
    --AEON   enh: { LCH="CrysalisBeam", RCH="HeatSink" }
end

function logExistingEnhancements()
    local _ = getEnhancements(GetSelectedUnits()[1], true)
end


function instaKillUnit()
    ConExecute("KillSelectedUnits")
end

function toggleLogWindow()
  
    -- ConExecute("ui_RenderSelectionSetNames off")
    -- ConExecute("IN_BindKey F12 ui_lua import('/lua/ui/game/tabs.lua').ToggleTab('diplomacy')")
    ConExecute("WIN_ToggleLogDialog")
end

function toggleUnitPause()
    ConExecute("Ui_lua import('/lua/ui/game/construction.lua').ToggleUnitPause()")
end
