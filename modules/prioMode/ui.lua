local mconfig = import("config.lua")

local LayoutHelpers = import("/lua/maui/layouthelpers.lua")
local UIUtil = import("/lua/ui/uiutil.lua")
local Bitmap = import("/lua/maui/bitmap.lua").Bitmap
local Group = import("/lua/maui/group.lua").Group
local Effect = import("/lua/maui/effecthelpers.lua")
local CreateBorder = import("/lua/ui/game/announcement.lua").CreateBorder

local ksMap
local btns = {}
local ksThread = false
local prioTbl = {}

local fontName = "UbuntuMono Nerd Font"
local baseFontSize = 13
local msgFontSize = 15


function init()
    local pansize = 15

    ksMap = Bitmap(GetFrame(0), UIUtil.SkinnableFile('/game/filter-ping-list-panel/panel_brd_m.dds'))

    ksMap.Depth:Set(1000)
    ksMap.Width:Set(510)
    ksMap.Height:Set(260)
    ksMap.Top:Set(function()
        return GetFrame(0).Bottom() * 0.2
    end)
    ksMap.Left:Set(function()
        return (GetFrame(0).Right() - ksMap.Width()) / 2
    end)
    ksMap.border = CreateBorder(ksMap)
    ksMap:DisableHitTest()
    ksMap:Hide()

    ksMap.msg = UIUtil.CreateText(ksMap, "", 20)
    ksMap.msg:SetColor("fade3e")
    ksMap.msg:SetFont(fontName, msgFontSize)
    LayoutHelpers.AtCenterIn(ksMap.msg, ksMap)
end


function fillKsMapLabels()
    local pos = 0

    for _, button in btns do
        button:Destroy()
    end

    btns = {}
    for i, v in prioTbl do
        local strTxt = LOCF("%s:   %s  %s", v.key:lower(), v.icon, v.descr)
        local fn = LayoutHelpers.AtLeftTopIn
        if i > 5 then
            fn = LayoutHelpers.AtRightTopIn
            strTxt = string.format("%-22s", strTxt)
        end

        pos = pos + 25
        if i == 6 then
            pos = 25
        end

        btns[i] = Bitmap(ksMap)
        btns[i].Height:Set(25)
        btns[i].Width:Set(50)
        btns[i].Depth:Set(1002)
        local textLabel = UIUtil.CreateText(btns[i], strTxt, 14)
        textLabel:SetColor("ff00dbff")
        textLabel:SetFont(fontName, baseFontSize)
        fn(textLabel, btns[i], 31, 1)
        fn(btns[i], ksMap, 13, pos + 5)
    end

    ksMap.Height:Set(190)
    ksMap:DisableHitTest(true)
end


function highlightLabel(i, v)
    local strTxt = LOCF("%s:   %s  %s", v.key:lower(), v.icon, v.descr)
    local fn = LayoutHelpers.AtLeftTopIn
    if i > 5 then
        fn = LayoutHelpers.AtRightTopIn
        strTxt = string.format("%-22s", strTxt)
    end
    local button = btns[i]
    button:SetAlpha(0.4, true)
    local textLabel = UIUtil.CreateText(button, strTxt, 14)
    textLabel:SetColor("fade3e")
    textLabel:SetFont(fontName, baseFontSize)
    fn(textLabel, button, 31, 1)
end

function keyStrokeHandler(name, modifier)
    for i, v in prioTbl do
        if name == v.key and modifier == v.modifier then
            highlightLabel(i, v)
            v.func()

            ksThread = ForkThread(function()
                WaitSeconds(0.1)
                if not ksMap:IsHidden() then
                    Effect.FadeOut(ksMap, 0.5, 0.7, 0.1)
                end
                WaitSeconds(0.2)
                killKsThread()
            end)
        end
    end

    local msg = name
    if modifier ~= "" then
        msg = LOCF("%s-%s", modifier, name)
    end
    ksMap.msg:SetText(msg)
end

function killKsThread()
    if ksThread then
        KillThread(ksThread)
    end

    ksMap.msg:SetText("")
    ksMap:SetNeedsFrameUpdate(false)
    ksMap.OnFrame = function(self, elapsedTime) end
    ksMap:Hide()
    ksMap:SetAlpha(1, true)
end

function log()
    for _, v in prioTbl do
        if v.icon then
            LOG(LOCF("%d  -  %s: %s", v.descr:len(), v.key, v.descr))
        end
    end
end

function showGui(tbl)
    if not ksMap:IsHidden() then
        killKsThread()
    else
        prioTbl = tbl
        fillKsMapLabels()
        ksMap:Show()
    end
end

function landPrioritiesGui()
    showGui(mconfig.land)
end

function navalPrioritiesGui()
    showGui(mconfig.naval)
end

function BomberGunshipPrioritiesGui()
    showGui(mconfig.air_bomber)
end

function isHidden()
    if ksMap:IsHidden() then
        return true
    else
        return false
    end
end
