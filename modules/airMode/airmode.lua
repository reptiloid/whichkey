local funcs = import("../funcs.lua")




function cycle_air_units()
	funcs.metaCycle {
                "HIGHALTAIR ANTIAIR TECH3",
                { "xaa0202", "AIR ANTIAIR TECH1 PRODUCTSC1", "AIR ANTIAIR TECH1 SERAPHIM", },
	}
end

function cycle_air_aa()
	funcs.metaCycle { "xaa0202", "AIR ANTIAIR TECH1 PRODUCTSC1", "AIR ANTIAIR TECH1 SERAPHIM", }
end

function select_asf()
	funcs.metaCycle { "HIGHALTAIR ANTIAIR TECH3", }
end

function cycle_bombers()
	local cats = {
		"BOMBER TECH1",
		"BOMBER TECH2 ANTIAIR",
		"daa0206",
		"TECH2 ANTINAVY BOMBER",
		"AIR TECH3 ANTINAVY",
		"TECH3 STRATEGICBOMBER",
		"xsa0402",
	}
	local names = {
		" T1Bomber",
		" T2Bomber",
		" Guided Missile",
		" T2 TorpBomber",
		" T3 Torpedo Bomber",
		" T3 Bomber",
		" Ahwassa",
	}
	funcs.metaCycle(cats)
end

function cycle_air_scouts()
    funcs.metaCycle { "AIR TECH1 INTELLIGENCE", "AIR TECH3 INTELLIGENCE", }
end

function cycle_gunships()
	funcs.metaCycle {
		"AIR GROUNDATTACK OVERLAYDIRECTFIRE TECH3",
		"AIR GROUNDATTACK OVERLAYDIRECTFIRE TECH2",
		"AIR GROUNDATTACK OVERLAYDIRECTFIRE TECH1",
	}
end

function cycle_trans()
	funcs.metaCycle { "TRANSPORTATION TECH3", "TRANSPORTATION TECH2", "TRANSPORTATION TECH1" }
end

