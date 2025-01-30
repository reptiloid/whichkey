--list of blueprint id's used for each category
buildingTab = {
	-- buildingTab

	["4"] = {},

	["W"] = {
		"Land_Factory",
		"Air_Factory",
		"Naval_Factory",
		"Quantum_Gateway",
		"T1_Engineer",
		"url0301", -- SuppComs
		"ual0301",
		"uel0301",
		"xsl0301",
	},

	["W_lvl1"] = { "T1_Engineer" },
	["W_lvl2"] = { "T2_Engineer" },
	["W_lvl3"] = { "T3_Engineer", "SCU_Engineer" },

	["E"] = {
		"Omni_Sensor",
		"Radar_System",
		"Sonar_Platform",
		"Sonar_System",
		"Perimeter_Monitoring_System",
		--"Quantum_Optics_Facility",
		"T1_Land_Scout",
		--"T1_Combat_Scout",
		"T1_Air_Scout",
		"T1_Attack_Submarine",
	},

	["E_lvl1"] = { "T1_Land_Scout", "T1_Air_Scout" },
	["E_lvl2"] = { "T1_Land_Scout", "T1_Air_Scout" },
	["E_lvl3"] = { "T1_Land_Scout", "T3_Spy_Plane" },

	["R"] = {
		"Heavy_Shield_Generator",
		"Shield_Generator",
		"Stealth_Field_Generator",
		"T1_Light_Assault_Bot",
		"T1_Interceptor",
		"T1_Frigate",
	},

	["R_lvl1"] = { "T1_Mobile_Light_Artillery", "T1_Light_Air_Transport" },
	["R_lvl2"] = { "T2_Mobile_Missile_Launcher", "T2_Air_Transport", "T2_Cruiser" },

	["R_lvl3"] = {
		"T3_Mobile_Heavy_Artillery",
		"T3_Heavy_Air_Transport",
		"uaa0104",
		"ura0104",
		"xsa0104", -- T2_Air_Transport
		"T3_Missile_Ship",
	},

	["T"] = {
		"Strategic_Missile_Defense",
		"Tactical_Missile_Defense",
		"Stealth_Field_Generator",
		"T1_Tank",
		"T1_Assault_Bot", -- stupid Mantis
		"T1_Attack_Bomber",
		"T1_Attack_Boat", -- Aeon extra
	},

	["T_lvl1"] = { "T1_Light_Assault_Bot", "T1_Attack_Submarine" },

	["T_lvl2"] = {
		"T2_Special_Tank", --"T2_Hover_Tank", "T2_Assault_Tank", "T2_Amphibious_Tank",
		"T2_Torpedo_Bomber",
		"T2_Torpedo_Unit", --"T2_Submarine_Hunter", "T2_Torpedo_Boat", "T2_Submarine_Killer",
	},

	["T_lvl3"] = {
		"T2_Special_Tank", --"T2_Hover_Tank", "T2_Assault_Tank", "T2_Amphibious_Tank",
		"T3_Torpedo_Bomber",
		"uea0204",
		"ura0204",
		"xsa0204", -- T2_Torpedo_Bomber
		"T3_Strategic_Missile_Submarine",
		"T3_Submarine_Hunter",
		"SCU",
	},

	["Z"] = { "Support_Factory_Land", "Support_Factory_Air", "Support_Factory_Naval" },

	["Y"] = { "_upgrade", "Experimental" },

	["U"] = { "T1_Mobile_Light_Artillery", "T1_Light_Gunship" },

	-- Second Row

	["S"] = { "Heavy_Shield_Generator", "Shield_Generator", },

	["S_lvl1_LAND"] = {
		"T1_Tank",
		"T1_Land_Scout",
		"T1_Tank",
		"T1_Mobile_Light_Artillery",
		"T1_Tank",
		"T1_Land_Scout",
		"T1_Tank",
		"T1_Mobile_Anti_Air_Gun",
		"T1_Tank",
		"T1_Land_Scout",
		"T1_Tank",
		"T1_Mobile_Light_Artillery",
		"T1_Engineer",
		"T1_Tank",
		"T1_Land_Scout",
		"T1_Tank",
		"T1_Tank",
		"T1_Tank",
		"T1_Tank",
		"T1_Mobile_Anti_Air_Gun",
	},

	["S_lvl2_LAND"] = {
		"T2_Special_Tank",
		"T2_Special_Tank",
		"T2_Mobile_AA",
		"T2_Mobile_Shield_Generator",
		"T1_Engineer",
		"T1_Engineer",
		"T1_Engineer",
		"T1_Land_Scout",
		"T2_Special_Tank",
		"T2_Special_Tank",
		"T2_Special_Tank",
		"T2_Mobile_Shield_Generator",
		"T2_Special_Tank",
		"T1_Engineer",
		"T1_Engineer",
	},

	["S_lvl1_AIR"] = { "T1_Air_Scout" },

	["S_lvl2_AIR"] = {
		"T1_Air_Scout",
		"T2_Combat_Fighter",
		"T2_Combat_Fighter",
		"T2_Combat_Fighter",
		"T2_Combat_Fighter",
	},

	["S_lvl3_AIR"] = {
		"T3_Air_Superiority_Fighter",
		"T3_Spy_Plane",
		"T3_Air_Superiority_Fighter",
		"T3_Air_Superiority_Fighter",
		"T3_Air_Superiority_Fighter",
		"T3_Air_Superiority_Fighter",
		"T3_Air_Superiority_Fighter",
	},

	["S_lvl1_NAVAL"] = {
		"T1_Frigate",
		"T1_Attack_Submarine",
		"T1_Frigate",
		"T1_Attack_Boat",
		"T1_Frigate",
		"T1_Frigate",
		"T1_Frigate",
		"T1_Frigate",
		"T1_Frigate",
		"T1_Frigate",
		"T1_Frigate",
		"T1_Frigate",
	},

	["S_lvl2_NAVAL"] = {
		"T2_Destroyer",
		"T2_Destroyer",
		"T2_Destroyer",
		"T2_Cruiser",
		"T2_Destroyer",
		"T2_Destroyer",
		"T2_Destroyer",
		"T2_Destroyer",
		"T2_Destroyer",
		"T2_Destroyer",
	},

	["S_lvl3_NAVAL"] = {
		"T3_Battleship",
		"T3_Aircraft_Carrier",
		"T3_Battlecruiser",
		"T3_Missile_Ship",
	},

	["S_lvl3_GATE"] = {
		"SCU",
		--"SCU_Rambo",

		--"ual0301", -- unit from Quantum Gateway no upgrades
		--"ual0301_Engineer",
		--"ual0301_SimpleCombat",
		--"ual0301_NanoCombat",
		--"ual0301_ShieldCombat",
		--"ual0301_Rambo",
	},

	--"url0301", -- SuppComs
	--"ual0301",
	--"uel0301",
	--"xsl0301",

	--["D"] = { "Mass_Fabricator", },
	--["D"] = { "Mass_Fabricator", "Energy_Storage", "Mass_Storage", },

	["D_lvl1_AIR"] = { "T1_Interceptor" },
	["D_lvl2_AIR"] = { "T1_Interceptor" },
	["D_lvl3_AIR"] = { "T2_Fighter/Bomber" },

	["D_lvl1_LAND"] = {
		"T1_Tank",
		"T1_Tank",
		"T1_Tank",
		"T1_Mobile_Light_Artillery",
		"T1_Mobile_Light_Artillery",
		"T1_Mobile_Light_Artillery",
	},

	["D_lvl2_LAND"] = {
		"T1_Tank",
		"T1_Tank",
		"T1_Tank",
		"T1_Mobile_Light_Artillery",
		"T1_Mobile_Light_Artillery",
		"T1_Mobile_Light_Artillery",
	},

	["12_t1_arty"] = {
		"T1_Mobile_Light_Artillery",
		"T1_Mobile_Light_Artillery",
		"T1_Mobile_Light_Artillery",
		"T1_Mobile_Light_Artillery",
		"T1_Mobile_Light_Artillery",
		"T1_Mobile_Light_Artillery",
		"T1_Mobile_Light_Artillery",
		"T1_Mobile_Light_Artillery",
		"T1_Mobile_Light_Artillery",
		"T1_Mobile_Light_Artillery",
		"T1_Mobile_Light_Artillery",
		"T1_Mobile_Light_Artillery",
	},

	["DROP_s"] = {
		"T1_Tank",
		"T1_Land_Scout",
		"T1_Tank",
		"T1_Land_Scout",
		"T1_Mobile_Light_Artillery",
		"T1_Mobile_Light_Artillery",
		"T1_Mobile_Light_Artillery",
		"T1_Mobile_Light_Artillery",
		"T1_Mobile_Light_Artillery",
		"T1_Mobile_Light_Artillery",
		"T1_Mobile_Light_Artillery",
		"T1_Mobile_Light_Artillery",
		"T1_Mobile_Light_Artillery",
		"T1_Mobile_Light_Artillery",
		"T1_Mobile_Light_Artillery",
		"T1_Mobile_Light_Artillery",
	},

	["DROP1"] = {
		"T1_Tank",
		"T1_Tank",
		"T1_Tank",
		"T1_Tank",
		"T1_Tank",
		"T1_Tank",
		"T1_Mobile_Light_Artillery",
		"T1_Mobile_Light_Artillery",
		"T1_Mobile_Light_Artillery",
		"T1_Mobile_Light_Artillery",
		"T1_Mobile_Light_Artillery",
		"T1_Land_Scout",
	},

	["DROP2"] = {
		"T1_Mobile_Light_Artillery",
		"T1_Mobile_Light_Artillery",
		"T1_Mobile_Light_Artillery",
		"T1_Mobile_Light_Artillery",
		"T1_Mobile_Light_Artillery",
		"T1_Land_Scout",
	},

	--["DROP2_lvl2_LAND"] = {
	--"T1_Mobile_Light_Artillery", "T1_Mobile_Light_Artillery", "T1_Mobile_Light_Artillery",
	--"T1_Mobile_Light_Artillery", "T1_Mobile_Light_Artillery", "T1_Mobile_Light_Artillery",
	--"T1_Mobile_Light_Artillery", "T1_Mobile_Light_Artillery", "T1_Mobile_Light_Artillery",
	--"T1_Mobile_Light_Artillery", "T1_Mobile_Light_Artillery", "T1_Land_Scout",
	--},

	--["D_lvl2_LAND"] = {
	--"T2_Special_Tank", "T2_Heavy_Tank", "T2_Mobile_AA_Flak_Artillery",
	--"T1_Mobile_Light_Artillery", "T1_Land_Scout", "T1_Mobile_Light_Artillery",
	--"T1_Mobile_Light_Artillery", "T1_Mobile_Light_Artillery", "T1_Mobile_Light_Artillery",
	--},
	--"T2_Mobile_Shield_Generator",

	["F"] = { "Power_Generator", "Hydrocarbon_Power_Plant" },

	-- land t3 mobile tank -- {{{
	--"ual0303", -- Harbinger
	--"xrl0305", -- Brick
	--"xel0305", -- Percival
	--"xsl0303", -- Seraphim Tank }}}

	["F_lvl1"] = { "T1_Tank", "T1_Interceptor", "T1_Frigate" },
	["F_lvl2"] = { "T2_Heavy_Tank", "T2_Fighter/Bomber", "T2_Combat_Fighter", "T2_Destroyer" },
	["F_lvl3"] = { "T3_Land_Mobile_Tank", "T3_Air_Superiority_Fighter", "T3_Battleship", "SCU_Rambo" },

	["G"] = {
		"_templates", -- Special :)

		"T2_Gunship",
	},

	--[[
["G_lvl1"] = { 
  "T1_Land_Scout", "T1_Mobile_Anti_Air_Gun", "T1_Light_Assault_Bot",
  "T1_Land_Scout", "T1_Mobile_Anti_Air_Gun", "T1_Light_Assault_Bot",
  "T1_Mobile_Anti_Air_Gun", "T1_Light_Assault_Bot",
  "T1_Mobile_Anti_Air_Gun", "T1_Light_Assault_Bot",
  "T1_Mobile_Light_Artillery", "T1_Engineer", "T1_Engineer", "T1_Engineer", "T1_Engineer",
  "T1_Tank", "T1_Tank", 
},
--]]
	["G_lvl1"] = {
		"T1_Tank",
		"T1_Tank",
		"T1_Tank",
		"T1_Mobile_Light_Artillery",
		"T1_Mobile_Light_Artillery",
		"T1_Mobile_Light_Artillery",
		"T1_Combat_Scout",
		"T1_Combat_Scout",
	},

	["G_lvl2"] = { "T2_Gunship", "T1_Mobile_Light_Artillery" },
	["G_lvl3"] = { "T3_AA_Gunship", "T3_Heavy_Gunship" },

	["H"] = {
		"Engineering_Station",

		"T2_Mobile_Anti_Air_Cannon",
		"T2_Mobile_AA_Flak_Artillery",

		"T2_Air_Transport",

		"T2_Counter_Intelligence_Boat",
		"T2_Shield_Boat",
	},

	["J"] = { "Support_Factory_Land", "Support_Factory_Air", "Support_Factory_Naval" },

	["K"] = {
		"T2_Mobile_Shield_Generator",
		"T2_Mobile_Stealth_Field_System",
	},

	["L"] = {
		"T2_Field_Engineer",
	},

	-- Row 3 XCVBNM

	["X"] = {
		"Heavy_Point_Defense",
		"Point_Defense",
		"Wall_Section",

		"T3_Engineer",
	},

	["C"] = {
		"AntiAirPd",
		"Air_Staging",

		"T3_Torpedo_Bomber",

		"T3_Strategic_Missile_Submarine",
		"T3_Submarine_Hunter",
	},

	["C_lvl2"] = { "T2_Field_Engineer", "T2_Rocket_Bot" },
	["C_lvl3"] = { "SCU_RAS" },
	["C_lvl3_GATE"] = { "SCU_RAS" },

	["A"] = {
		"Torpedo_Ambushing_System",
		"Torpedo_Launcher",

		"T3_Air_Superiority_Fighter",
		"T3_Battleship",
	},

	["A_lvl1"] = { "T1_Mobile_Anti_Air_Gun", "T1_Interceptor", "T1_Attack_Boat" },

	["A_lvl2"] = {
		-- land
		"T2_Mobile_Anti_Air_Cannon",
		"T2_Mobile_AA_Flak_Artillery",
		-- air
		"T2_Fighter/Bomber",
		"T2_Combat_Fighter",
		-- naval
		"T2_Cruiser",
	},

	["A_lvl3"] = {
		-- land
		"T3_Land_Mobile_AA",
		-- air
		"T3_Air_Superiority_Fighter",
		-- naval
		"T3_Aircraft_Carrier",
		"T3_Battlecruiser",
	},

	["V"] = {
		"Torpedo_Ambushing_System",
		"Torpedo_Launcher",

		"T2_Mobile_Stealth_Field_System",
		"T2_Mobile_Shield_Generator",
		"T3_Mobile_Shield_Generator",

		"T2_Shield_Boat",
		"T2_Counter_Intelligence_Boat",
	},

	--["V_lvl2"] = { "T2_Mobile_Shield_Generator", },
	--["V_lvl3"] = { "T3_Shield_Disruptor", "T3_Mobile_Shield_Generator", },

	["B"] = {
		"Artillery_Installation",
		"Heavy_Artillery_Installation",

		--"T3_Strategic_Bomber",

		--"T3_Mobile_Heavy_Artillery",

		--"T3_Aircraft_Carrier",
		--"T3_Battlecruiser",
	},

	["B_lvl1"] = { "T1_Frigate", "T1_Light_Assault_Bot", "T1_Attack_Bomber" },
	["B_lvl2"] = { "T1_Frigate", "T2_Guided_Missile", "T2_Mobile_Bomb" },
	["B_lvl3"] = { "T2_Destroyer", "T3_Strategic_Bomber", "T2_Mobile_Bomb", "T3_Mobile_Missile_Platform" },

	["N"] = {
		"Tactical_Missile_Launcher",
		"Artillery_Installation",
		"Strategic_Missile_Launcher",

		"T3_Mobile_Missile_Platform",
		"T3_Shield_Disruptor",
		"T3_Mobile_Shield_Generator",

		"T3_Heavy_Gunship",
		"T3_AA_Gunship",

		"T3_Missile_Ship",
	},

	["M"] = {
		"_upgrade",
		"T3_Heavy_Air_Transport",
		"T3_Torpedo_Bomber",
	},

	["Experimental"] = {
		-- Aeon
		"ual0401",
		"uaa0310",
		"uas0401",
		"xab1401",
		-- Cyb
		"url0402", -- Monkeylord
		"xrl0403", -- Megalith
		"url0401", -- Scathis
		"ura0401", -- Soulripper
		-- UEF
		"uel0401", -- Fatboy
		"ues0401", -- Atlantis
		"xeb2402", -- Novax
		"ueb2401", -- Mavor
		-- Sera
		"xsl0401", -- Ythotha
		"xsa0402", -- Bomber
		"xsb2401", -- SML
	},

	-- Buildings: -- {{{
	["Land_Factory"] = { "xsb0101", "urb0101", "ueb0101", "uab0101" },
	["Air_Factory"] = { "xsb0102", "urb0102", "ueb0102", "uab0102" },
	["Naval_Factory"] = { "xsb0103", "urb0103", "ueb0103", "uab0103" },
	["Quantum_Gateway"] = { "xsb0304", "urb0304", "ueb0304", "uab0304" },
	["Power_Generator"] = {
		"xsb1301",
		"xsb1201",
		"xsb1101",
		"urb1301",
		"urb1201",
		"urb1101",
		"ueb1301",
		"ueb1201",
		"ueb1101",
		"uab1301",
		"uab1201",
		"uab1101",
	},
	["Hydrocarbon_Power_Plant"] = { "xsb1102", "urb1102", "ueb1102", "uab1102" },
	["Mass_Extractor"] = { "xsb1302", "urb1302", "ueb1302", "uab1302" },
	--["Mass_Extractor"] = { "xsb1302", "xsb1202", "urb1302", "urb1202", "ueb1302", "ueb1202", "uab1302", "uab1202",},
	["Mass_Fabricator"] = { "xsb1303", "xsb1104", "urb1303", "urb1104", "ueb1303", "ueb1104", "uab1303", "uab1104" },
	["Energy_Storage"] = { "xsb1105", "urb1105", "ueb1105", "uab1105" },
	["Mass_Storage"] = { "xsb1106", "urb1106", "ueb1106", "uab1106" },
	["Point_Defense"] = { "xsb2301", "xsb2101", "urb2301", "urb2101", "ueb2301", "ueb2101", "uab2301", "uab2101" },
	--["AntiAirPd"] = { "xsb2304", "xsb2204", "xsb2104", "urb2304", "urb2204", "urb2104", "ueb2304", "ueb2204", "ueb2104", "uab2304", "uab2204", "uab2104",},
	["AntiAirPd"] = { "xsb2304", "xsb2104", "urb2304", "urb2104", "ueb2304", "ueb2104", "uab2304", "uab2104" },
	["Tactical_Missile_Launcher"] = { "xsb2108", "urb2108", "ueb2108", "uab2108" },
	["Torpedo_Launcher"] = { "xsb2205", "xsb2109", "urb2205", "urb2109", "ueb2205", "ueb2109", "uab2205", "uab2109" },
	["Heavy_Artillery_Installation"] = { "xsb2302", "urb2302", "ueb2302", "uab2302" },
	["Artillery_Installation"] = { "xsb2303", "urb2303", "ueb2303", "uab2303" },
	["Strategic_Missile_Launcher"] = { "xsb2305", "urb2305", "ueb2305", "uab2305" },
	--["Radar_System"] = { "xsb3201", "xsb3101", "urb3201", "urb3101", "ueb3201", "ueb3101", "uab3201", "uab3101",},
	["Radar_System"] = { "xsb3101", "urb3101", "ueb3101", "uab3101" },
	--["Sonar_System"] = { "xsb3202", "xsb3102", "urb3202", "urb3102", "ueb3202", "ueb3102", "uab3202", "uab3102",},
	["Sonar_System"] = { "xsb3202", "xsb3102", "urb3102", "ueb3102", "uab3102" },
	["Omni_Sensor"] = { "xsb3104", "urb3104", "ueb3104", "uab3104" },
	["Tactical_Missile_Defense"] = { "xsb4201", "urb4201", "ueb4201", "uab4201" },
	["Shield_Generator"] = { "xsb4202", "urb4202", "ueb4202", "uab4202" },
	["Stealth_Field_Generator"] = { "xsb4203", "urb4203", "ueb4203", "uab4203" },
	["Heavy_Shield_Generator"] = { "xsb4301", "ueb4301", "uab4301", "urb4206" },
	["Strategic_Missile_Defense"] = { "xsb4302", "urb4302", "ueb4302", "uab4302" },
	["Wall_Section"] = { "xsb5101", "urb5101", "ueb5101", "uab5101" },
	["Aeon_Quantum_Gate_Beacon"] = { "uab5103" },
	["Air_Staging"] = { "xsb5202", "urb5202", "ueb5202", "uab5202" },
	["Sonar_Platform"] = { "urs0305", "ues0305", "uas0305" },

	["Rapid_Fire_Artillery_Installation"] = { "xab2307" },
	["Quantum_Optics_Facility"] = { "xab3301" },
	["Engineering_Station"] = { "xrb0104", "xeb0104" },
	["Heavy_Point_Defense"] = { "xeb2306" },
	["Torpedo_Ambushing_System"] = { "xrb2308" },
	["Perimeter_Monitoring_System"] = { "xrb3301" },

	["Support_Factory_Land"] = {
		"zab9601",
		"zab9501",
		"zeb9601",
		"zeb9501",
		"zrb9601",
		"zrb9501",
		"zsb9601",
		"zsb9501",
	},
	["Support_Factory_Air"] = {
		"zab9602",
		"zab9502",
		"zeb9602",
		"zeb9502",
		"zrb9602",
		"zrb9502",
		"zsb9602",
		"zsb9502",
	},
	["Support_Factory_Naval"] = {
		"zab9603",
		"zab9503",
		"zeb9603",
		"zeb9503",
		"zrb9603",
		"zrb9503",
		"zsb9603",
		"zsb9503",
	},

	-- }}}
	-- Units: -- {{{
	["T2_Guided_Missile"] = { "daa0206" },
	["T3_Shield_Disruptor"] = { "dal0310", "xel0306" },
	["T2_Fighter/Bomber"] = { "dea0202", "dra0202", "xsa0202" },
	["T2_Gatling_Bot"] = { "del0204" },
	["T2_Rocket_Bot"] = { "drl0204" },
	["T1_Air_Scout"] = { "uaa0101", "uea0101", "ura0101", "xsa0101" },
	["T1_Interceptor"] = { "uaa0102", "uea0102", "ura0102", "xsa0102" },
	["T1_Attack_Bomber"] = { "uaa0103", "uea0103", "ura0103", "xsa0103" },
	["T2_Air_Transport"] = { "uaa0104", "uea0104", "ura0104", "xsa0104" },
	["T1_Light_Air_Transport"] = { "uaa0107", "uea0107", "ura0107", "xsa0107" },
	["T2_Gunship"] = { "uaa0203", "uea0203", "ura0203", "xsa0203" },
	["T2_Torpedo_Bomber"] = { "uaa0204", "uea0204", "ura0204", "xsa0204" },
	["T3_Spy_Plane"] = { "uaa0302", "uea0302", "ura0302", "xsa0302" },
	["T3_Air_Superiority_Fighter"] = { "uaa0303", "uea0303", "ura0303", "xsa0303" },
	["T3_Strategic_Bomber"] = { "uaa0304", "uea0304", "ura0304", "xsa0304" },
	["T1_Land_Scout"] = { "ual0101", "uel0101", "url0101", "xsl0101" },
	["T1_Mobile_Light_Artillery"] = { "ual0103", "uel0103", "url0103", "xsl0103" },
	["T1_Mobile_Anti_Air_Gun"] = { "ual0104", "uel0104", "url0104", "xsl0104" },
	["T3_Land_Mobile_AA"] = { "dalk003", "delk002", "drlk001", "dslk004" },
	["T3_Land_Mobile_Tank"] = { "ual0303", "xrl0305", "xel0305", "xsl0303" },
	["T1_Engineer"] = { "ual0105", "uel0105", "url0105", "xsl0105" },
	["T1_Light_Assault_Bot"] = { "ual0106", "uel0106", "url0106" },
	["T2_Mobile_Missile_Launcher"] = { "ual0111", "uel0111", "url0111", "xsl0111" },
	["T1_Tank"] = { "ual0201", "uel0201", "xsl0201", "url0107" },
	["T2_Heavy_Tank"] = { "ual0202", "uel0202", "url0202", "xsl0202" },
	["T2_Mobile_AA_Flak_Artillery"] = { "ual0205", "uel0205", "url0205" },
	["T2_Engineer"] = { "ual0208", "uel0208", "url0208", "xsl0208" },
	["T3_Tank"] = { "ual0303", "uel0303" },
	["T3_Mobile_Heavy_Artillery"] = { "ual0304", "uel0304", "url0304", "xsl0304" },
	["T2_Mobile_Shield_Generator"] = { "ual0307", "uel0307" },
	["T3_Engineer"] = { "ual0309", "uel0309", "url0309", "xsl0309" },
	["T1_Attack_Boat"] = { "uas0102" },
	["T1_Frigate"] = { "uas0103", "ues0103", "urs0103", "xss0103" },
	["T2_Destroyer"] = { "uas0201", "ues0201", "urs0201", "xss0201" },
	["T2_Cruiser"] = { "uas0202", "ues0202", "urs0202", "xss0202" },
	["T1_Attack_Submarine"] = { "uas0203", "ues0203", "urs0203", "xss0203" },
	["T3_Battleship"] = { "uas0302", "ues0302", "urs0302", "xss0302" },
	["T3_Aircraft_Carrier"] = { "uas0303", "urs0303", "xss0303" },
	["T3_Strategic_Missile_Submarine"] = { "uas0304", "ues0304", "urs0304" },
	["T3_Heavy_Gunship"] = { "uea0305", "xra0305" },
	["T2_Amphibious_Tank"] = { "uel0203", "url0203" },
	["T1_Assault_Bot"] = { "url0107" },
	["T3_Siege_Assault_Bot"] = { "url0303" },
	["T2_Mobile_Stealth_Field_System"] = { "url0306" },
	["T2_Combat_Fighter"] = { "xaa0202" },
	["T3_AA_Gunship"] = { "xaa0305" },
	["T3_Torpedo_Bomber"] = { "xaa0306" },
	["T2_Assault_Tank"] = { "xal0203" },
	["T3_Sniper_Bot"] = { "xal0305", "xsl0305" },
	["T2_Submarine_Hunter"] = { "xas0204" },
	["T3_Missile_Ship"] = { "xas0306" },
	["T3_Heavy_Air_Transport"] = { "xea0306" },
	["T2_Field_Engineer"] = { "xel0209" },
	["T3_Armored_Assault_Bot"] = { "xel0305", "xrl0305" },
	["T3_Mobile_Missile_Platform"] = { "xel0306" },
	["T2_Torpedo_Boat"] = { "xes0102" },
	["T2_Shield_Boat"] = { "xes0205", "xrs0205" },
	["T3_Battlecruiser"] = { "xes0307" },
	["T1_Light_Gunship"] = { "xra0105" },
	["T2_Mobile_Bomb"] = { "xrl0302" },
	["T2_Submarine_Killer"] = { "xrs0204" },
	["T2_Counter_Intelligence_Boat"] = { "xrs0205" },
	["T1_Combat_Scout"] = { "xsl0101" },
	["T2_Assault_Bot"] = { "xsl0202" },
	["T2_Hover_Tank"] = { "xsl0203" },
	["T2_Mobile_Anti_Air_Cannon"] = { "xsl0205" },
	["T3_Siege_Tank"] = { "xsl0303" },
	["T3_Mobile_Shield_Generator"] = { "xsl0307" },
	["T3_Submarine_Hunter"] = { "xss0304" },
	["T2_Special_Tank"] = { "xsl0203", "xal0203", "uel0203", "url0203" },
	["T2_Mobile_AA"] = { "xsl0205", "ual0205", "uel0205", "url0205" },
	["T2_Torpedo_Unit"] = { "xas0204", "xes0102", "xrs0204", "xss0304" },
	["SCU"] = { "url0301", "ual0301", "uel0301", "xsl0301" },
	["SCU_Engineer"] = { "url0301_engineer", "ual0301_engineer", "uel0301_engineer", "xsl0301_engineer" },
	["SCU_Rambo"] = { "url0301_rambo", "ual0301_rambo", "uel0301_rambo", "xsl0301_rambo" },
	["SCU_RAS"] = { "url0301_ras", "ual0301_ras", "uel0301_ras" },
    ["TECH3_GUNSHIP"] = { "xaa0305", "uea0305", "xra0305", "xsa0203" },
    ["TECH2_BOMBER"] = { "daa0206", "dea0202", "dra0202", "xsa0202"  },
	["TECH2_INTI"] = { "xaa0202", "uea0102", "ura0102", "xsa0102" },
	["TECH3_SPECIAL_SHIP"] = { "xas0306", "xes0307" },
	["TECH2_STEALTH_SHIELD_LAND_MOBILE"] = { "url0306", "ual0307", "uel0307", "xsl0307" },
	["TECH2_LONG_RANGE_BOT"] = { "drl0204", "del0204" },
	["TECH3_ASSAULT_BOT"] = { "url0303", "uel0303"},
	-- }}}
        
}
