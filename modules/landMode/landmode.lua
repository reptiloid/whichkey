local funcs = import("../funcs.lua")

local metaCycle = funcs.metaCycle
local ui_SelByCat = funcs.ui_SelByCat
local meta_select = funcs.meta_select

local mprio = import("../prioMode/prioFns.lua")



function activate_landmode() -- !!!

    local t2_cybran_bot = categories.CYBRAN * categories.BOT * categories.TECH2
    local t2_uef_bot = categories.UEF * categories.BOT * categories.TECH2
    local t3_sniper_bot = categories.SNIPER * categories.TECH3

    local filter_preset = categories.ALLUNITS - categories.ENGINEER - categories.EXPERIMENTAL
    local filter = filter_preset - t2_cybran_bot - t2_uef_bot - t3_sniper_bot

	local selection = ui_SelByCat({ show=false, view=true, str="LAND MOBILE RECLAIMABLE" })
	if selection then
		local s = EntityCategoryFilterDown(filter, selection) or {}
		if table.getn(s) > 0 then
			SelectUnits(s)
		end
	end
end

function land_mobile_indirect()
	metaCycle { "LAND TECH1 INDIRECTFIRE",
		        "LAND TECH2 INDIRECTFIRE",
		        "LAND TECH3 INDIRECTFIRE PRODUCTSC1",
		        "LAND TECH3 INDIRECTFIRE PRODUCTFA", }
end

function land_mobile_aa()
	metaCycle { "LAND MOBILE TECH1 ANTIAIR", "LAND MOBILE TECH2 ANTIAIR", "LAND MOBILE TECH3 ANTIAIR", }
end

function land_scouts()
	metaCycle({ "LAND TECH1 SCOUT AEON", "LAND TECH1 SCOUT CYBRAN", "LAND TECH1 SCOUT UEF", "LAND TECH1 SCOUT SERAPHIM", })
end

function nearest_land_scout()
    --  UISelectionByCategory(expression, addToCurSel, inViewFrustum, nearestToMouse, mustBeIdle)
    UISelectionByCategory("LAND TECH1 SCOUT", false, false, true, false)
end

function land_mobile_bomb()
	metaCycle { "xrl0302", "xsl0203", "xal0203", "uel0203", "url0203" } -- xrl0302 - T2_Mobile_Bomb
end

function land_mobile_snipers()
	-- xel0209            - Field Engi
    
	-- dal0310            - T3_Shield_Disruptor 
	-- xal0305, xsl0305   - T3_Sniper_Bot
	-- xel0306            - T3_Mobile_Missile_Platform
	-- xrl0302            - T2_Mobile_Bomb
	-- drl0204            - T2_Rocket_Bot
	-- del0204            - T2_Gatling_Bot
    

	metaCycle({ 
                -- "xel0209",
                "dal0310",
               { "xal0305", "xsl0305" }, "xel0306", "xrl0302", "drl0204", "del0204" 
    })
end

function cycle_scouts()
    local list = { "AIR TECH1 INTELLIGENCE", "AIR TECH3 INTELLIGENCE", "LAND TECH1 SCOUT" }
    local splitResult = true
    local mustBeIdle = { false, false, false }
    local inViewList = { true, true, true }
    metaCycle(list, splitResult, mustBeIdle, inViewList)
end

function someTestFn()
    LOG("split selection to some groups")
end

function select_land_mobile_indirect_test()
    local land_indirect_table = {
        { expr="LAND TECH1 INDIRECTFIRE", inview=true, near=false, desc="", run_after={ someTestFn, mprio.swp_pd } },
        { expr="LAND TECH2 INDIRECTFIRE", inview=true, near=false, desc="", run_after={ someTestFn, mprio.swp_pd } },
        { expr="LAND TECH3 INDIRECTFIRE PRODUCTSC1", inview=true, near=false, desc="", run_after={ someTestFn, mprio.swp_acu, } },
        { expr="LAND TECH3 INDIRECTFIRE PRODUCTFA", inview=true, near=false, desc="", run_after={ someTestFn, mprio.swp_acu, } },
    }
    meta_select(land_indirect_table)
end

function cycle_main_damage_dealers()
	metaCycle({
                { "ual0401", "xsl0401", "url0402", "xrl0403", "uel0401" },              -- Exps
                { "ual0301_rambo", "xsl0301_rambo", "url0301_rambo", "uel0301_rambo" }, -- rambo preset scu
                { "ual0303", "xsl0303", "xrl0305", "xel0305" },                         -- t3 tanks
                { "ual0202", "xsl0202", "url0202", "uel0202" },                         -- t2 tanks
                { "ual0201", "xsl0201", "url0107", "uel0201" },                         -- t1 tanks
	})
end

function direct_fire_main_dd_tanks()
	metaCycle({
                { "ual0303", "xsl0303", "xrl0305", "xel0305" },                         -- t3 tanks
                { "ual0202", "xsl0202", "url0202", "uel0202" },                         -- t2 tanks
                { "ual0201", "xsl0201", "url0107", "uel0201" },                         -- t1 tanks
	})
end

function all_main_damage_dealers()
	metaCycle({
                { "ual0201", "xsl0201", "url0107", "uel0201",                           -- t1 tanks
                  "ual0202", "xsl0202", "url0202", "uel0202",                           -- t2 tanks
                  "ual0303", "xsl0303", "xrl0305", "xel0305" },                         -- t3 tanks
                { "ual0301_rambo", "xsl0301_rambo", "url0301_rambo", "uel0301_rambo" }, -- rambo preset scu
                { "ual0401", "xsl0401", "url0402", "xrl0403", "uel0401" },              -- Exps
	})
end

function land_mobile_exp()
	metaCycle { "ual0401", "xsl0401", "url0402", "xrl0403", "uel0401" } -- Exps
	--[[ metaCycle { "LAND MOBILE TECH1 ANTIAIR", "LAND MOBILE TECH2 ANTIAIR", "LAND MOBILE TECH3 ANTIAIR", } ]]
end

function rambo_scus()
	metaCycle { { "ual0301_rambo", "xsl0301_rambo", "url0301_rambo", "uel0301_rambo" }, } -- rambo preset scu
end

function sneaky_damage_dealers()

	-- "T1_Light_Assault_Bot" = { "ual0106", "uel0106", "url0106" },
	-- "T2_Amphibious_Tank"   = { "uel0203", "url0203" },
    -- "T2_Hover_Tank"        = { "xsl0203" },
    -- "T2_Mobile_Bomb"       = { "xrl0302" },
    
	-- "T2_Special_Tank"      = { "xsl0203", "xal0203", "uel0203", "url0203" },
    
	-- "T3_Siege_Assault_Bot" = { "url0303", "uel0303"},

	metaCycle({
                { "ual0106", "uel0106", "url0106" },
                { "uel0203", "url0203", "xsl0203", "xal0203" },
                "xrl0302",
                { "url0303", "uel0303" },
	})
end

function navy_tanks()

	-- "T2_Amphibious_Tank"   = { "uel0203", "url0203" },
    -- "T2_Hover_Tank"        = { "xsl0203" },
	-- dal0310            - T3_Shield_Disruptor 
    
	metaCycle({
                { "uel0203", "url0203", "xsl0203", "xal0203" },
                "dal0310",
	})
end

function land_mobile_shields_stealth()
    -- "T3_Mobile_Shield_Generator"     = { "xsl0307" },
    -- "T2_Mobile_Shield_Generator"     = { "ual0307", "uel0307" },
	-- "T2_Mobile_Stealth_Field_System" = { "url0306" },
    
	metaCycle { "ual0307", "uel0307", "xsl0307", "url0306", }
end
