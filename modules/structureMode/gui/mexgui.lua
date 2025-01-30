local LayoutHelpers = import("/lua/maui/layouthelpers.lua")
local UIUtil = import("/lua/ui/uiutil.lua")
local Bitmap = import("/lua/maui/bitmap.lua").Bitmap
local Group = import("/lua/maui/group.lua").Group
local Effect = import("/lua/maui/effecthelpers.lua")

local funcs = import("../../funcs.lua")
local mstructure = import("../strucmode.lua")


local ksMap
local cycleButtons = {}
local ksThread = false

-- 
local mex_keys = {
    { key="C", modifier="", icon="駱", descr="T1", qtt="0+1" },
    { key="Q", modifier="", icon="ﱁ",  descr="T2", qtt="2" },
    { key="E", modifier="", icon="",  descr="T3", qtt="0" },
}

function _test()
    if not get_state() then
        hide_gui()
    else
        initDescr()
        show_gui()
    end
end

function _test1()
    if not get_state() then
        hide_gui()
    else
        show_gui()
    end
end

function CreateBorder(parent)
    local border = {}

    border.tl = Bitmap(parent, UIUtil.SkinnableFile('/game/filter-ping-list-panel/panel_brd_ul.dds'))
    border.tm = Bitmap(parent, UIUtil.SkinnableFile('/game/filter-ping-list-panel/panel_brd_horz_um.dds'))
    border.tr = Bitmap(parent, UIUtil.SkinnableFile('/game/filter-ping-list-panel/panel_brd_ur.dds'))
    border.ml = Bitmap(parent, UIUtil.SkinnableFile('/game/filter-ping-list-panel/panel_brd_vert_l.dds'))
    border.mr = Bitmap(parent, UIUtil.SkinnableFile('/game/filter-ping-list-panel/panel_brd_vert_r.dds'))
    border.bl = Bitmap(parent, UIUtil.SkinnableFile('/game/filter-ping-list-panel/panel_brd_ll.dds'))
    border.bm = Bitmap(parent, UIUtil.SkinnableFile('/game/filter-ping-list-panel/panel_brd_lm.dds'))
    border.br = Bitmap(parent, UIUtil.SkinnableFile('/game/filter-ping-list-panel/panel_brd_lr.dds'))

    border.tl.Bottom:Set(parent.Top)
    border.tl.Right:Set(parent.Left)

    border.bl.Top:Set(parent.Bottom)
    border.bl.Right:Set(parent.Left)

    border.tr.Bottom:Set(parent.Top)
    border.tr.Left:Set(parent.Right)

    border.br.Top:Set(parent.Bottom)
    border.br.Left:Set(parent.Right)

    border.tm.Bottom:Set(parent.Top)
    border.tm.Left:Set(parent.Left)
    border.tm.Right:Set(parent.Right)

    border.bm.Top:Set(parent.Bottom)
    border.bm.Left:Set(parent.Left)
    border.bm.Right:Set(parent.Right)

    border.ml.Top:Set(parent.Top)
    border.ml.Bottom:Set(parent.Bottom)
    border.ml.Right:Set(parent.Left)

    border.mr.Top:Set(parent.Top)
    border.mr.Bottom:Set(parent.Bottom)
    border.mr.Left:Set(parent.Right)

    return border
end

function initksMap()
  ksMap = Bitmap(GetFrame(0), UIUtil.SkinnableFile('/game/filter-ping-list-panel/panel_brd_m.dds'))
	ksMap.Depth:Set(1000)
	ksMap.Width:Set(300)
	ksMap.Height:Set(45)
	ksMap.Top:Set(function()
		return GetFrame(0).Bottom() * 0.2
	end)
	ksMap.Left:Set(31)
  local border = CreateBorder(ksMap)
	ksMap:DisableHitTest()
	ksMap:Hide()

    -- ksMap.msg = UIUtil.CreateText(ksMap, "", 20)
    -- ksMap.msg:SetColor("fade3e")
    -- ksMap.msg:SetFont("UbuntuMono Nerd Font", 23)
    -- LayoutHelpers.AtRightTopIn(ksMap.msg, ksMap, 21, 33)
end


function get_state()
    if ksMap:IsHidden() then
        return true
    else
        return false
    end
end

function show_gui()
    ksMap:Show()
end

function hide_gui()
	if ksThread then
		KillThread(ksThread)
	end

    
    -- ksMap.msg:SetText("")
	ksMap:SetNeedsFrameUpdate(false)
	ksMap.OnFrame = function(self, elapsedTime) end
	ksMap:Hide()
	ksMap:SetAlpha(1, true)
end

function initDescr()
	local buttonH = 6
	local buttonW = 11

    local upt1mexes = {}
    local pat1mexes = {}
    local pat1mexes_buttons = {}

	ksThread = ForkThread(function()
		while true do
            local pos = 0
            local x_pos = 110

            -- ksMap.msg:SetText(GetGameTime())
            
            for _, button in cycleButtons do
                button:Destroy()
            end
            cycleButtons = {}

            for _, button in pat1mexes_buttons do
                button:Destroy()
            end
            pat1mexes_buttons = {}

            for i, v in mstructure.get_mex_info() do
                local txt = LOCF("   T%d: %s", i, v)
                cycleButtons[i] = Bitmap(ksMap)
                cycleButtons[i].Height:Set(buttonH)
                cycleButtons[i].Width:Set(buttonW)
                local t = UIUtil.CreateText(cycleButtons[i], txt, 10)
                t:SetColor("ff00dbff")
                t:SetFont("UbuntuMono Nerd Font", 12)
                LayoutHelpers.AtLeftTopIn(t, cycleButtons[i], 1, 1)
                cycleButtons[i].Depth:Set(1002)
                LayoutHelpers.AtLeftTopIn(cycleButtons[i], ksMap, 1, pos)
                pos = pos + 20

                if i == 1 then
                    for k, v in mstructure.get_t1_upgrading_table() do
                        upt1mexes[k] = v
                        if k <= 5 then
                            x_pos = x_pos + 41
                            local j = k + 3
                            cycleButtons[j] = Bitmap(ksMap)
                            cycleButtons[j].Height:Set(buttonH)
                            cycleButtons[j].Width:Set(buttonW)
                            local mex_string = string.format("%01.0f%%", v:GetWorkProgress()*100)
                            local t = UIUtil.CreateText(cycleButtons[j], mex_string, 10)
                            t:SetColor("fade3e")
                            t:SetFont("UbuntuMono Nerd Font", 12)
                            LayoutHelpers.AtLeftTopIn(t, cycleButtons[j], 1, 1)
                            -- cycleButtons[j].Depth:Set(1002)
                            LayoutHelpers.AtLeftTopIn(cycleButtons[j], ksMap, x_pos, 1)
                            cycleButtons[j].HandleEvent = function(self,event)
                                if event.Type == 'ButtonPress' then
                                    SetPaused({ upt1mexes[j-3] }, true)
                                    SetPaused(mstructure.get_engis_assisting_mexes({ upt1mexes[j-3] }), true)
                                elseif event.Type == 'ButtonDClick' then
                                    SelectUnits({ upt1mexes[j-3] })
                                    -- SelectUnits(mstructure.get_engis_assisting_mexes({ upt1mexes[j-3] }))
                                end
                            end
                        end
                    end

                    x_pos = 110

                    for k, v in mstructure.get_t1_paused_table() do
                        pat1mexes[k] = v
                        if k <= 5 then
                            x_pos = x_pos + 41
                            local j = k
                            pat1mexes_buttons[j] = Bitmap(ksMap)
                            pat1mexes_buttons[j].Height:Set(buttonH)
                            pat1mexes_buttons[j].Width:Set(buttonW)
                            local mex_string = string.format("%01.0f%%", v:GetWorkProgress()*100)
                            local t = UIUtil.CreateText(pat1mexes_buttons[j], mex_string, 10)
                            t:SetColor("EA2B6E")
                            t:SetFont("UbuntuMono Nerd Font", 12)
                            LayoutHelpers.AtLeftTopIn(t, pat1mexes_buttons[j], 1, 1)
                            LayoutHelpers.AtLeftTopIn(pat1mexes_buttons[j], ksMap, x_pos, 24)
                            pat1mexes_buttons[j].HandleEvent = function(self,event)
                                if event.Type == 'ButtonPress' then
                                    SetPaused({ pat1mexes[j] }, false)
                                    SetPaused(mstructure.get_engis_assisting_mexes({ pat1mexes[j] }), false)
                                elseif event.Type == 'ButtonDClick' then
                                    -- SelectUnits(mstructure.get_engis_assisting_mexes({ pat1mexes[j] }))
                                    SelectUnits({ pat1mexes[j] })
                                end
                            end
                        end
                    end


                    
                end
                
            end
            -- ksMap.Width:Set((i - 1) * buttonW + 58)
            -- ksMap.Height:Set(3 * buttonH)
            -- ksMap:DisableHitTest(true)


			WaitSeconds(.5)

		end
	end)

end
