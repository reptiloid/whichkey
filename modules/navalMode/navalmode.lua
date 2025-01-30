local funcs = import("../funcs.lua")
local metaCycle = funcs.metaCycle


function cycle_naval_units()
  metaCycle {
                { "DESTROYER", "FRIGATE" },
                { "T2SUBMARINE", "T1SUBMARINE", "xes0102", "xss0304" }, -- torp naval units
                "NAVAL TECH3 OVERLAYDIRECTFIRE",
                "AEON LIGHTBOAT",
	}
end

function cycle_naval_aa()
  metaCycle { "NAVAL TECH3 ANTIAIR", "CRUISER TECH2", "AEON NAVAL TECH1 ANTIAIR", }
end

function sonar()
  metaCycle { 
                      "xsb3102", "xsb3202",            -- seraphim
                      "uab3102", "uab3202", "uas0305", -- aeon
                      "ueb3102", "ueb3202", "ues0305", -- uef
                      "urb3102", "urb3202", "urs0305", -- cybran
    }
end

function naval_indirect_fire()
  metaCycle {
		"ues0202", -- uef cruiser
		"xss0202", -- sera cruiser
        "xss0303", -- sera carrier
		"xas0306", -- aeon t3_missile_ship
	}
end

function naval_direct_fire()
	metaCycle { "FRIGATE", "NAVAL * TECH3 * OVERLAYDIRECTFIRE", "NAVAL * EXPERIMENTAL * DIRECTFIRE", }
end

function select_destroyers()
	metaCycle { "DESTROYER SERAPHIM",
                    { "DESTROYER UEF", "DESTROYER AEON", "DESTROYER CYBRAN", }
    }
end

function cycle_subs()
	metaCycle { "T1SUBMARINE",
                      "T2SUBMARINE",
                      "xes0102",      -- uef torp boat
                      "xss0304",      -- sera t3 sub
    }
end

function select_mobile_shields()
	metaCycle { 
                      "ual0307", -- aeon mobile shield
                      "xsl0307", -- sera mobile shield
                      "xes0205", -- uef shield boat
    }
end
