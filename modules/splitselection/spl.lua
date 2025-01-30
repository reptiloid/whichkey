-- local funcs = import("../funcs.lua")

local unitIndex = 1
local units

function splitUnits()
    units = GetSelectedUnits()
end

function updateUnits()
    if not units then return nil end

    local newUnits = {}

	for _, unit in units do
		if not unit:IsDead() then
            table.insert(newUnits, unit)
        end
    end
    return newUnits
end

function getNextUnit()
    local units = updateUnits()
    if not units then return nil end

    local tableSize = table.getn(units)
    local nextUnit = units[unitIndex] or units[1]

   
    if not nextUnit:IsDead() then
        SelectUnits({ nextUnit })
        local health = nextUnit:GetHealth()
        str = LOCF("%d / %d >> (%d)", tableSize, unitIndex, health)
        print(str)
    end
    unitIndex = unitIndex + 1
    if unitIndex > tableSize then
        unitIndex = 1
    end
end
