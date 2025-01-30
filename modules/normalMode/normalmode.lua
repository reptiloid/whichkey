local funcs = import("../funcs.lua")
local metaCycle = funcs.metaCycle

local CommandMode = import("/lua/ui/game/commandmode.lua")
local Construction = import("/lua/ui/game/construction.lua")
local smartSelect = import("/lua/keymap/smartSelection.lua").smartSelect

function select_engineer(mustBeIdle)
    metaCycle({
        "ENGINEERPRESET",
        "RASPRESET",
        "ENGINEER TECH3 RECLAIMABLE",
        "ENGINEER TECH2 LAND PRODUCTSC1",
        "ENGINEER TECH1 LAND",
    }, true, mustBeIdle)
end

function select_idle_engies()
    select_engineer(true)
    if GetSelectedUnits() then
        Construction.ActivateSelTab()
    end
end
    
function select_engies()
    select_engineer(false)
    if GetSelectedUnits() then
        Construction.ActivateSelTab()
    end
end

function SmartSelEngi()
    smartSelect("ENGINEER TECH1 LAND +nearest")

    local Units = GetSelectedUnits()

    if not Units then
        return
    end

    local BuildType = categories.MASSEXTRACTION * categories.TECH1
    local _, _, BuildableCategories = GetUnitCommandData(Units)
    BuildableCategories = BuildableCategories * BuildType
    local cmd = EntityCategoryGetUnitList(BuildableCategories)[1]
    if cmd then
        CommandMode.StartCommandMode('build', { name = cmd })
    end


end


function enter_normal_mode()
    SelectUnits(nil)
end
