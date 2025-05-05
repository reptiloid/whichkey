local CreateBorder = import("/lua/ui/game/announcement.lua").CreateBorder
local LayoutHelpers = import("/lua/maui/layouthelpers.lua")
local UIUtil = import("/lua/ui/uiutil.lua")
local Bitmap = import("/lua/maui/bitmap.lua").Bitmap
local Group = import("/lua/maui/group.lua").Group
local Effect = import("/lua/maui/effecthelpers.lua")

local Units = import('/mods/common/units.lua')

local ksMap

function initksMap()
  ksMap = Bitmap(GetFrame(0), UIUtil.SkinnableFile('/game/filter-ping-list-panel/panel_brd_m.dds'))
	ksMap.Depth:Set(1000)
	ksMap.Width:Set(151)
	ksMap.Height:Set(45)
	ksMap.Top:Set(function()
		return GetFrame(0).Bottom() * 0.02
	end)
	ksMap.Left:Set(371)
  local border = CreateBorder(ksMap)
	ksMap:DisableHitTest()
	ksMap:Hide()

    ksMap.msg = UIUtil.CreateText(ksMap, "Com HP: 100500", 11)
    ksMap.msg:SetColor("fade3e")
    ksMap.msg:SetFont("UbuntuMono Nerd Font", 20)
    LayoutHelpers.AtRightTopIn(ksMap.msg, ksMap, 3, 3)
end




function init()
    initksMap()
    ForkThread(GetInfo)
end

function GetInfo()
    while true do
        local commanders = Units.Get(categories.COMMAND)
        for _, c in commanders do
            if not c:IsDead() then
                ksMap:Show()
                -- local br = c:GetBuildRate()
                -- local id = c:GetEntityId()
                -- local pos = c:GetPosition()
                local hp = c:GetHealth()
                local hpstring = LOCF("Com HP: %d ", hp)
                ksMap.msg:SetText(hpstring)
            else
                ksMap:Hide()
            end
        end
        WaitSeconds(.1)
    end
end


function test_ga()
    -- local guardedUnit = GetSelectedUnits()[1]:GetGuardedEntity()
    -- LOG(repr(guardedUnit))

    -- ksMap.msg:SetText(GetGameTime())

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

-- unit:GetEntityId()

 -- if unit:IsInCategory("COMMAND") or unit:IsInCategory('SUBCOMMANDER') then
 --                    totalbr = totalbr + unit:GetBuildRate()

 -- for _, unit in self._units do
 --            if not unit:IsDead() then
 --                local econData = unit:GetEconData()
 --                local bp = unit:GetBlueprint()

 --                massRate = massRate - econData["massRequested"] + econData["massProduced"]
 --                energyRate = energyRate - econData["energyRequested"] + econData["energyProduced"]
