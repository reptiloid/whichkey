local SetWeaponPriorities = import('/lua/keymap/misckeyactions.lua').SetWeaponPriorities
local SetWeaponPrioritiesHotkey = import('/lua/keymap/misckeyactions.lua').SetWeaponPrioritiesHotkey

function splitStrBySpace(categoriesStr)
    local r = {}
    for v in string.gmatch(categoriesStr, "%S+") do
        table.insert(r, v)
    end
    return r
end


function spltFormat(cats)
    local r = {}
    for _, c in splitStrBySpace(cats) do
        if c == "*" then
            do end
        elseif c == "-" then 
            do end
        else
            c = LOCF("categories.%s", c)
        end
        table.insert(r, c)
    end
    return table.concat(r, " ")
end


function formatCategories(cats)
    local r = {}
    for _, c in cats do
        table.insert(r, spltFormat(c))
    end
    local c = table.concat(r, ", ")
    return LOCF("{%s}", c)
end

function SetPrio(cats, name)
    SetWeaponPriorities(formatCategories(cats), name, false)
end


function target_EXP()
    SetWeaponPrioritiesHotkey("EXP")
end

function target_Arty()
    SetWeaponPrioritiesHotkey("Arty")
end

function target_Shields() 
    SetWeaponPrioritiesHotkey("Shields")
end

function target_Power()
    SetWeaponPrioritiesHotkey("Power")
end

function target_ACU()
    SetWeaponPrioritiesHotkey("ACU")
end

function target_PD()
    SetWeaponPrioritiesHotkey("PD")
end

function target_Engies()
    SetWeaponPrioritiesHotkey("Engies")
end

function target_Mex()
    SetWeaponPrioritiesHotkey("Mex")
end

function target_Units()
    SetWeaponPrioritiesHotkey("Units")
end

function target_Snipe()
    SetWeaponPrioritiesHotkey("Snipe")
end

function target_Destro()
    SetWeaponPrioritiesHotkey("Destros")
end

function target_BattleShip()
    SetWeaponPrioritiesHotkey("Bships")
end


function swp_Land_Mobile()
    local cats = {
        "LAND * MOBILE * TECH3 * DIRECTFIRE",
        "LAND * MOBILE * TECH2 * DIRECTFIRE",
        "LAND * MOBILE - COMMAND - EXPERIMENTAL - ENGINEER - SCOUT - ANTIAIR",
    }
    local name = "Lnd Mob"
    SetPrio(cats, name)
end

function swp_IntelShields()
    local cats = { "INTELLIGENCE - SCOUT", "SHIELD", }
    local name = "Intl Shlds"
    SetPrio(cats, name)
end


function swp_SMD()
    SetWeaponPriorities("{categories.ANTIMISSILE * categories.TECH3, categories.ANTIMISSILE * categories.TECH2}", "SMD and TMD", false)
end

function swp_wall()
    SetWeaponPriorities("{categories.STRUCTURE}", "STRUCTURE", false)
end

function swp_aa()
    SetWeaponPriorities("{categories.MOBILE * categories.ANTIAIR}", "AntiAir", false)
end

function swp_acu()
    SetWeaponPriorities("{categories.COMMAND}", "acu", false)
end

function swp_battleship()
    SetWeaponPriorities("{categories.DESTROYER}", "BS", false)
end

function swp_destroyer()
    SetWeaponPriorities("{categories.DESTROYER}", "Destro", false)
end

function swp_cruiser()
    SetWeaponPriorities("{categories.CRUISER}", "cruiser", false)
end

function swp_submarine()
    SetWeaponPriorities("{categories.CRUISER}", "subs", false)
end

function swp_antimissile()
    SetWeaponPriorities("{categories.ANTIMISSILE}", "TMD", false)
end


function swp_massfabrication()
    SetWeaponPriorities("{categories.MASSFABRICATION}", "MassFabrication", false)
end
