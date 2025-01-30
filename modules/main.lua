local mPriorityGui = import("prioMode/ui.lua") 
local mmex = import("structureMode/gui/mexgui.lua")
local mengi = import("engiMode/engimode.lua")
local conf = import("../conf.lua")


local Construction = import("/lua/ui/game/construction.lua")

function init()
    mPriorityGui.init()
    mmex.initksMap()
    mengi.initCycleMap()
    bindKeys()
    ForkThread(hideGuiElements, 5)
end

function whichHotkey(keyName, modifier)
    if not mPriorityGui.isHidden() then
        return mPriorityGui.keyStrokeHandler(keyName, modifier)
    end
  
    local devKeys = { "Esc", "F1",
                      "I", "O", "P",
                      "K", }
  
    for _, key in devKeys do
        if keyName == key then
            return devMode(keyName, modifier)
        end
    end

    local selection = GetSelectedUnits()
    if not selection then
        return NormalMode2(keyName, modifier)
    end
    local mtbl = {
        { cat = categories.ENGINEER - categories.COMMAND, mode = EngiMode2 },
        { cat = categories.COMMAND, mode = CommandMode2 },
        { cat = categories.FACTORY - categories.MOBILE, mode = FactoryMode2 },
        { cat = categories.TACTICALMISSILEPLATFORM, mode = tmlMode2 },
        { cat = categories.NUKE - categories.AIR - categories.BATTLESHIP, mode = NukeMode },
        { cat = categories.OPTICS * categories.AEON, mode = OpticsMode },
        { cat = categories.STRUCTURE, mode = StructureMode2 },
        { cat = categories.AIR - categories.TRANSPORTATION, mode = AirMode2 },
        { cat = categories.LAND * categories.MOBILE - categories.COMMAND, mode = LandMode2 },
        { cat = categories.NAVAL, mode = NavalMode2 },
        { cat = categories.TRANSPORTATION, mode = TransMode },
    }
    for _, v in mtbl do
        if table.getn(EntityCategoryFilterDown(v.cat, selection)) > 0 then
            return v.mode(keyName, modifier)
        end
    end
end


function hideGuiElements(sec)
    WaitSeconds(sec)
    ConExecute("UI_Lua import('/lua/ui/game/multifunction.lua').ToggleMFDPanel()")
    ConExecute("UI_Lua import('/lua/ui/game/tabs.lua').ToggleTabDisplay()")
end

function applyBinds(togglePanels)
    if togglePanels == true then
        ForkThread(hideGuiElements, 0)
    end

    bindKeys()
end


function metaMode(keyName, modifier, mode_binds, altMode)
    for _, v in mode_binds do
        if keyName == v.key and modifier == v.modifier then
            return v.func()
        end
    end
    if altMode ~= nil then
        return altMode(keyName, modifier)
    end
end

function factoryMetaMode(keyName, modifier, mode_binds, alt_mode_binds)
    for _, v in mode_binds do
        if keyName == v.key and modifier == v.modifier then
            if v.count ~= nil then
                return v.func(v.name, v.count)
            end
            return v.func()
        end
    end

    for _, v in alt_mode_binds do
        if keyName == v.key and modifier == v.modifier then
            if v.count ~= nil then
                return v.func(v.name, v.count)
            end
            return v.func()
        end
    end
end

function FactoryMode2(keyName, modifier)
    local selection = GetSelectedUnits()
    local tech_level = Construction.GetCurrentTechTab()
    local factory_type = GetFactoryType(selection[1])
    local template = LOCF("TECH%d_%s", tech_level, factory_type)
    local conf_table = {
        ["TECH3_GATE"] = conf.gate,
        ["TECH1_AIR"] = conf.tech1air,
        ["TECH2_AIR"] = conf.tech2air,
        ["TECH3_AIR"] = conf.tech3air,
        ["TECH1_NAVAL"] = conf.tech1naval,
        ["TECH2_NAVAL"] = conf.tech2naval,
        ["TECH3_NAVAL"] = conf.tech3naval,
        ["TECH1_LAND"] = conf.tech1land,
        ["TECH2_LAND"] = conf.tech2land,
        ["TECH3_LAND"] = conf.tech3land,
    }
    factoryMetaMode(keyName, modifier, conf_table[template], conf.factory)
end

function devMode(keyName, modifier)
    metaMode(keyName, modifier, conf.dev)
end

function NormalMode2(keyName, modifier)
    metaMode(keyName, modifier, conf.normal)
end

function StructureMode2(keyName, modifier)
    metaMode(keyName, modifier, conf.structure, NormalMode2)
end

function NavalMode2(keyName, modifier)
    metaMode(keyName, modifier, conf.naval, NormalMode2)
end

function AirMode2(keyName, modifier)
    metaMode(keyName, modifier, conf.air, NormalMode2)
end

function LandMode2(keyName, modifier)
    metaMode(keyName, modifier, conf.land, NormalMode2)
end

function NukeMode(keyName, modifier)
    metaMode(keyName, modifier, conf.nuke, NormalMode2)
end

function tmlMode2(keyName, modifier)
    metaMode(keyName, modifier, conf.tml, NormalMode2)
end

function OpticsMode(keyName, modifier)
    metaMode(keyName, modifier, conf.optics, NormalMode2)
end

function TransMode(keyName, modifier)
    metaMode(keyName, modifier, conf.trans, AirMode2)
end

function CommandMode2(keyName, modifier)
    if Construction.GetCurrentTabName() == "Enhancement" then
        return metaMode(keyName, modifier, conf.enhance)
    end
    metaMode(keyName, modifier, conf.command, EngiMode2)
end

function EngiMode2(keyName, modifier)
    local selection = GetSelectedUnits()
    if table.getsize(EntityCategoryFilterDown(categories.RAMBOPRESET, selection)) > 0 then
        return LandMode2(keyName, modifier)
    end
  -- OVERLAYINDIRECTFIRE
    metaMode(keyName, modifier, conf.engi)
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




function bindKeys()
    local imp = "UI_Lua import('/mods/whichkey/modules/main.lua')."
    local keys = {
        "Tilde",
        "1", "2", "3", "4", "5", "6", "7", "8", "9", "0",
        "Tab", "Comma", "Period", "Space",
        "Q", "W", "E", "R", "T", "Y",
        "A", "S", "D", "F", "G", "H",
        "Z", "X", "C", "V", "B", "N", "M",
        -- "U", "I", "O", "P",
        "Esc", "F1",
        "I", "O", "P",
        "K",
    }
    local modKeys = { "", "CTRL", "SHIFT", "ALT" }

    for _, mk in modKeys do
        for _, k in keys do
            local key = LOCF("%s-%s", mk, k)
            if mk == "" then
                key = k
            end
            local action = LOCF("whichHotkey('%s', '%s')", k, mk)
            ConExecute(LOCF("IN_BindKey %s %s%s", key, imp, action))
        end
    end
end
