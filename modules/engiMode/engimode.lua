local funcs = import("../funcs.lua")

local Select = import('/lua/ui/game/selection.lua')
local Construction = import("/lua/ui/game/construction.lua")
local CommandMode = import("/lua/ui/game/commandmode.lua")
local hd = import("/lua/keymap/hotbuild.lua")
local smartSelect = import("/lua/keymap/smartSelection.lua").smartSelect

local UIUtil = import("/lua/ui/uiutil.lua")
local Group = import("/lua/maui/group.lua").Group
local Bitmap = import("/lua/maui/bitmap.lua").Bitmap
local LayoutHelpers = import("/lua/maui/layouthelpers.lua")
local Effect = import("/lua/maui/effecthelpers.lua")

local Prefs = import("/lua/user/prefs.lua")
local Templates = import("/lua/ui/game/build_templates.lua")

local cyclePos
local cycleMap
local cycleThread = false
local cycleLastName
local cycleLastMaxPos
local cycleButtons = {}

function initCycleButtons(values)
	local buttonH = 55
	local buttonW = 55
	for _, button in cycleButtons do
		button:Destroy()
	end
	cycleButtons = {}
	local i = 1
	for i_whatever, value in values do
		cycleButtons[i] = Bitmap(cycleMap, UIUtil.SkinnableFile("/icons/units/" .. value .. "_icon.dds"))
		cycleButtons[i].Height:Set(buttonH)
		cycleButtons[i].Width:Set(buttonW)
		cycleButtons[i].Depth:Set(1002)
		LayoutHelpers.AtLeftTopIn(cycleButtons[i], cycleMap, 29 + buttonH * (i - 1), 18)
		i = i + 1
	end
	cycleMap.Height:Set(buttonH + 36)
	cycleMap.Width:Set((i - 1) * buttonH + 58)
	cycleMap:DisableHitTest(true)
end

function initCycleMap()
	cycleMap = Group(GetFrame(0))

	cycleMap.Depth:Set(1000) --always on top
	cycleMap.Width:Set(400)
	cycleMap.Height:Set(150)
	cycleMap.Top:Set(function()
		return GetFrame(0).Bottom() * 0.89
	end)
	cycleMap.Left:Set(function()
		return (GetFrame(0).Right() - cycleMap.Width()) / 2
	end)
	cycleMap:DisableHitTest()
	cycleMap:Hide()

	cycle_Panel_tl = Bitmap(cycleMap)
  cycle_Panel_tl:SetTexture('/textures/ui/hotbuild/cycle-panel-bg-tl.dds')

	cycle_Panel_tl.Top:Set(cycleMap.Top)
	cycle_Panel_tl.Left:Set(cycleMap.Left)
	cycle_Panel_tl.Width:Set(40)

	cycle_Panel_bl = Bitmap(cycleMap)
  cycle_Panel_bl:SetTexture('/textures/ui/hotbuild/cycle-panel-bg-bl.dds')
	cycle_Panel_bl.Bottom:Set(cycleMap.Bottom)
	cycle_Panel_bl.Left:Set(cycleMap.Left)
	cycle_Panel_bl.Width:Set(40)

	cycle_Panel_l = Bitmap(cycleMap)
  cycle_Panel_l:SetTexture('/textures/ui/hotbuild/cycle-panel-bg-l.dds')

	cycle_Panel_l.Top:Set(cycle_Panel_tl.Bottom)
	cycle_Panel_l.Bottom:Set(cycle_Panel_bl.Top)
	cycle_Panel_l.Left:Set(cycleMap.Left)
	cycle_Panel_l.Width:Set(40)

	cycle_Panel_tr = Bitmap(cycleMap)
  cycle_Panel_tr:SetTexture('/textures/ui/hotbuild/cycle-panel-bg-tr.dds')
	cycle_Panel_tr.Top:Set(cycleMap.Top)
	cycle_Panel_tr.Right:Set(cycleMap.Right)
	cycle_Panel_tr.Width:Set(40)

	cycle_Panel_br = Bitmap(cycleMap)
  cycle_Panel_br:SetTexture('/textures/ui/hotbuild/cycle-panel-bg-br.dds')
	cycle_Panel_br.Bottom:Set(cycleMap.Bottom)
	cycle_Panel_br.Right:Set(cycleMap.Right)
	cycle_Panel_br.Width:Set(40)

	cycle_Panel_r = Bitmap(cycleMap)
  cycle_Panel_r:SetTexture('/textures/ui/hotbuild/cycle-panel-bg-r.dds')
	cycle_Panel_r.Top:Set(cycle_Panel_tr.Bottom)
	cycle_Panel_r.Bottom:Set(cycle_Panel_br.Top)
	cycle_Panel_r.Right:Set(cycleMap.Right)
	cycle_Panel_r.Width:Set(40)

	cycle_Panel_t = Bitmap(cycleMap)
  cycle_Panel_t:SetTexture('/textures/ui/hotbuild/cycle-panel-bg-t.dds')
	cycle_Panel_t.Top:Set(cycleMap.Top)
	cycle_Panel_t.Left:Set(cycle_Panel_l.Right)
	cycle_Panel_t.Right:Set(cycle_Panel_r.Left)

	cycle_Panel_b = Bitmap(cycleMap)
  cycle_Panel_b:SetTexture('/textures/ui/hotbuild/cycle-panel-bg-b.dds')
	cycle_Panel_b.Bottom:Set(cycleMap.Bottom)
	cycle_Panel_b.Left:Set(cycle_Panel_l.Right)
	cycle_Panel_b.Right:Set(cycle_Panel_r.Left)

	cycle_Panel_m = Bitmap(cycleMap)
  cycle_Panel_m:SetTexture('/textures/ui/hotbuild/cycle-panel-bg-m.dds')
	cycle_Panel_m.Top:Set(cycle_Panel_t.Bottom)
	cycle_Panel_m.Bottom:Set(cycle_Panel_b.Top)
	cycle_Panel_m.Left:Set(cycle_Panel_l.Right)
	cycle_Panel_m.Right:Set(cycle_Panel_r.Left)
end

function hideCycleMap()
	if cycleThread then
		KillThread(cycleThread)
	end
	cycleMap:SetNeedsFrameUpdate(false)
	cycleMap.OnFrame = function(self, elapsedTime) end
	cycleMap:Hide()
	cycleMap:SetAlpha(1, true)
end
 

-- function build_test_sonar_t1()
-- 	local cmd = "xsb3102"
-- 	CommandMode.StartCommandMode("build", { name=cmd })
-- end

function LogQueue()
	local selection = funcs.ui_SelByCat({ show=false, view=false, str="LAND MOBILE TECH1 ENGINEER" })
  local u = nil
  if not selection then return end
  for _, unit in selection do

      Select.Hidden(function()
          SelectUnits({ unit })
      end)
      local currentCommandQueue = Construction.getCurrentCommandQueue() or {}
      if table.getn(currentCommandQueue) == 0 then
          SelectUnits({unit})
          local BuildType = categories.MASSEXTRACTION * categories.TECH1
          local _, _, BuildableCategories = GetUnitCommandData(selection)
          BuildableCategories = BuildableCategories * BuildType
          local cmd = EntityCategoryGetUnitList(BuildableCategories)[1]
          if cmd then
              CommandMode.StartCommandMode('build', { name = cmd })
          end
          break
      end
	end

end


function build_template()
    hd.buildAction("Templates")
end

function build_support_factory()
    hd.buildAction("T2_Support_Factory")
end

function build_factory()
    hd.buildAction("Builders")
end

function build_pg()
    hd.buildAction("Power_Generator")
end

function build_mex()
    hd.buildAction("Mass_Extractor")
end

function build_exp()
    hd.buildAction("Experimental")
end

function build_tmd_smd()
    hd.buildAction("Alt_TMD")
end

function build_hive()
    hd.buildAction("Engineering_Station")
end

function build_sensors()
    hd.buildAction("Sensors")
end

function build_pd()
    hd.buildAction("Defense")
end

function build_aa()
    hd.buildAction("AA")
end

function build_nuke_tml()
    hd.buildAction("TML")
end

function build_optics()
    hd.buildAction("Quantum_Optics_Facility")
end

function build_hc()
  hd.buildAction("Hydrocarbon_Power_Plant")
end

function build_arties()
    hd.buildAction("Arties")
end

function build_shield()
    hd.buildAction("Alt_Shields")
end

function build_torp()
    hd.buildAction("Torpedo")
end

function build_t3_support_air_factory()
    hd.buildAction("T3_Support_Air_Factory")
end

function build_mass_fab()
    hd.buildAction("Mass_Fabricator")
end

function build_estorage()
    hd.buildAction("Energy_Storage")
end

function select_nearest_t1engi()
    smartSelect("ENGINEER TECH1 +nearest +idle")
    Construction.ActivateSelTab()
end

function cycle_tech2tech3_engi()
	funcs.metaCycle({ "ENGINEER MOBILE RECLAIMABLE TECH3", "ENGINEER MOBILE RECLAIMABLE TECH2",
                --[[ "xel0209", -- uef field engi ]]
                --[[ "uel0301_engineer", "uel0301_ras", -- UEF ]]
                --[[ "url0301_engineer", "url0301_ras", -- CYBRAN ]]
                --[[ "ual0301_engineer", "ual0301_ras", -- AEON ]]
                --[[ "xsl0301_engineer",                -- SERAPHIM ]]
    })
    Construction.ActivateSelTab()
end


function buildActionTemplate2(temp_pattern)

	local options = Prefs.GetFromCurrentProfile("options")
	hideCycleMap()

	-- find all avaiable templates
	local effectiveTemplates = {}
	local effectiveIcons = {}
	local allTemplates = Templates.GetTemplates()

	if not allTemplates or table.getsize(allTemplates) == 0 then
		return
	end

	local selection = GetSelectedUnits()
	local availableOrders, availableToggles, buildableCategories = GetUnitCommandData(selection)
	local buildableUnits = EntityCategoryGetUnitList(buildableCategories)

	--Allow all races to build other races templates
	local currentFaction = selection[1]:GetBlueprint().General.FactionName
	if options.gui_all_race_templates ~= 0 and currentFaction then
		local function ConvertID(BPID)
			local prefixes = {
				["AEON"] = { "uab", "xab", "dab", "zab" },
				["UEF"] = { "ueb", "xeb", "deb", "zeb" },
				["CYBRAN"] = { "urb", "xrb", "drb", "zrb" },
				["SERAPHIM"] = { "xsb", "usb", "dsb", "zsb" },
			}
			for i, prefix in prefixes[string.upper(currentFaction)] do
				if table.find(buildableUnits, string.gsub(BPID, "(%a+)(%d+)", prefix .. "%2")) then
					return string.gsub(BPID, "(%a+)(%d+)", prefix .. "%2")
				end
			end
			return false
		end
		for templateIndex, template in allTemplates do
			local valid = true
			local converted = false
			for _, entry in template.templateData do
				if type(entry) == "table" then
					if not table.find(buildableUnits, entry[1]) then
						entry[1] = ConvertID(entry[1])
						converted = true
						if not table.find(buildableUnits, entry[1]) then
							valid = false
							break
						end
					end
				end
			end
			if valid then
				if string.find(template.name, temp_pattern) ~= nil then
					template.templateID = templateIndex
					table.insert(effectiveTemplates, template)
					table.insert(effectiveIcons, template.icon)
				end
			end
		end
	end

	local maxPos = table.getsize(effectiveTemplates)
	if maxPos == 0 then
		return
	end

	if (cycleLastName == temp_pattern) and (cycleLastMaxPos == maxPos) then
		cyclePos = cyclePos + 1
		if cyclePos > maxPos then
			cyclePos = 1
		end
	else
		initCycleButtons(effectiveIcons)
		cyclePos = 1
		cycleLastName = temp_pattern
		cycleLastMaxPos = maxPos
	end

	if options.hotbuild_cycle_preview == 1 then
		-- Highlight the active button
		for i, button in cycleButtons do
			if i == cyclePos then
				button:SetAlpha(1, true)
			else
				button:SetAlpha(0.4, true)
			end
		end

		cycleMap:Show()
		-- Start the fading thread
		cycleThread = ForkThread(function()
			stayTime = options.hotbuild_cycle_reset_time / 2000.0
			fadeTime = options.hotbuild_cycle_reset_time / 2000.0

			WaitSeconds(stayTime)
			if not cycleMap:IsHidden() then
				Effect.FadeOut(cycleMap, fadeTime, 0.6, 0.1)
			end
			WaitSeconds(fadeTime)
			cyclePos = 0
		end)
	else
		cycleThread = ForkThread(function()
			WaitSeconds(options.hotbuild_cycle_reset_time / 1000.0)
			cyclePos = 0
		end)
	end

	local template = effectiveTemplates[cyclePos]
	local cmd = template.templateData[3][1]

	local templDataFromFunc = nil
	ClearBuildTemplates()
	--[[ if template.name == "four_Ext" then ]]
	--[[ 	templDataFromFunc = GenerateMasStorageTempl2() ]]
	--[[ elseif template.name == "four_Test1" then ]]
	--[[ 	templDataFromFunc = GenerateMasStorageTempl() ]]
	--[[ end ]]
	CommandMode.StartCommandMode("build", { name=cmd })
	SetActiveBuildTemplate(templDataFromFunc or template.templateData)
end

function other_template()
    ConExecute("UI_Lua import('/lua/ui/game/hotkeys/context-based-templates.lua').Cycle()")
    -- buildActionTemplate2("Other_")
end

function fab_template()
    buildActionTemplate2("Fab_")
end

function energy_template()
    buildActionTemplate2("nrg_")
end

