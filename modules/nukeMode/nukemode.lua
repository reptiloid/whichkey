local funcs = import("../funcs.lua")

local nukeIndex = 1

function GetNextNukeUnit1()
	local nukeUnits = funcs.ui_SelByCat({ str = "NUKE SILO" })
	if nukeUnits then
		local tableSize = table.getn(nukeUnits)
		local nextUnit = nukeUnits[nukeIndex] or nukeUnits[1]
        local mi = nextUnit:GetMissileInfo()
        local wp = nextUnit:GetWorkProgress()*100
        
        str = LOCF("%d / %d >> (%d): %s", tableSize, nukeIndex, mi.nukeSiloStorageCount, string.format("%01.1f", wp))
        print(str)
        
		SelectUnits({ nextUnit })
        funcs.nukeLaunch()
		nukeIndex = nukeIndex + 1
		if nukeIndex > tableSize then
			nukeIndex = 1
		end
	end
end


function getNukeUnits()
	local nukeUnits = funcs.ui_SelByCat({ str = "NUKE SILO" })
    local nu = {}
	if nukeUnits then
        for _, unit in nukeUnits do
            if unit:IsInCategory("BATTLESHIP") then
                if unit:GetMissileInfo().nukeSiloStorageCount ~= 0 or unit:GetEconData().massConsumed ~= 0 then
                    table.insert(nu, unit)
                end
            else 
                table.insert(nu, unit)
            end
        end
    end
    return nu
end

function GetNextNukeUnit()
	local nukeUnits = getNukeUnits()
	if nukeUnits then
		local tableSize = table.getn(nukeUnits)
		local nextUnit = nukeUnits[nukeIndex] or nukeUnits[1]
        local mi = nextUnit:GetMissileInfo()
        local wp = nextUnit:GetWorkProgress()*100
       
        str = LOCF("%d / %d >> (%d): %s", tableSize, nukeIndex, mi.nukeSiloStorageCount, string.format("%01.1f", wp))
        print(str)
       
		SelectUnits({ nextUnit })
        funcs.nukeLaunch()
		nukeIndex = nukeIndex + 1
		if nukeIndex > tableSize then
			nukeIndex = 1
		end
	end
end
