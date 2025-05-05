local mdev = import("modules/dev/testFns.lua")
local funcs = import("modules/funcs.lua")
local mnuke = import("modules/nukeMode/nukemode.lua")
local mtml = import("modules/tmlMode/tmlmode.lua")
local mland = import("modules/landMode/landmode.lua")
local mnormal = import("modules/normalMode/normalmode.lua")
local mstructure = import("modules/structureMode/strucmode.lua")
local mmexes = import("modules/structureMode/mexes.lua")
local mair = import("modules/airMode/airmode.lua")
local mnaval = import("modules/navalMode/navalmode.lua")
local moptics = import("modules/opticsMode/opticsmode.lua")
local mengi = import("modules/engiMode/engimode.lua")
local mcommand = import("modules/commandMode/commandmode.lua")
local mspl = import("modules/splitselection/spl.lua")
local mfactory = import("modules/factoryMode/factorymode.lua")

local mmex = import("modules/structureMode/gui/mexgui.lua")
local pGUImodule = import("modules/prioMode/ui.lua")

normal = {
    { key="3",     modifier="",      func=funcs.CycleHQs },

    { key="Q",     modifier="",      func=mstructure.SelectUpgradingMexes },

    { key="W",     modifier="",      func=mnormal.select_idle_engies },
    { key="E",     modifier="",      func=mair.cycle_air_scouts },
    { key="R",     modifier="",      func=mland.land_mobile_indirect },
    { key="T",     modifier="",      func=mstructure.cycle_tml },
    { key="Y",     modifier="",      func=mland.land_mobile_exp },
    { key="A",     modifier="",      func=mair.cycle_air_aa },
    { key="D",     modifier="",      func=mland.cycle_main_damage_dealers },
    { key="F",     modifier="",      func=mland.direct_fire_main_dd_tanks },
    { key="G",     modifier="",      func=mair.cycle_gunships },
    { key="H",     modifier="",      func=mstructure.airFactoryForScouts },
    { key="X",     modifier="",      func=mair.cycle_bombers },
    { key="C",     modifier="",      func=mland.land_mobile_snipers },

    { key="V",     modifier="",      func=funcs.ToggleZoomPop },
    { key="Z",     modifier="",      func=mnormal.SmartSelEngi },
    -- { key="Z",     modifier="",      func=mspl.getNextUnit },

    { key="B",     modifier="",      func=mland.land_mobile_bomb },
    { key="N",     modifier="",      func=mnuke.GetNextNukeUnit },
    { key="M",     modifier="",      func=moptics.get_next_optics },

    { key="W",     modifier="CTRL",  func=mnormal.select_engies },
    { key="E",     modifier="CTRL",  func=mland.land_scouts },
    { key="R",     modifier="CTRL",  func=mair.cycle_trans },

    { key="A",     modifier="CTRL",  func=mair.cycle_air_units },
    { key="S",     modifier="CTRL",  func=mnaval.cycle_naval_units },
    { key="D",     modifier="CTRL",  func=mland.cycle_main_damage_dealers },
    { key="F",     modifier="CTRL",  func=mnaval.naval_direct_fire },


    { key="T",     modifier="CTRL",  func=mstructure.upgrade_pause_t2mexes_with_storages },
    -- { key="G",     modifier="CTRL",  func=mstructure.initT1MexControl },
    { key="G",     modifier="CTRL",      func=mland.sneaky_damage_dealers },


    { key="X",     modifier="CTRL",  func=mstructure.cycle_pds },


    { key="V",     modifier="CTRL",  func=mland.land_mobile_shields_stealth },
    { key="B",     modifier="CTRL",  func=mengi.select_nearest_t1engi },

    { key="N",     modifier="CTRL",  func=mmex._test },

    { key="M",     modifier="CTRL",  func=mmexes.init },
    { key="M",     modifier="SHIFT", func=mmexes.getTECH1Mexes },

    { key="Z",     modifier="SHIFT", func=mengi.LogQueue },
    { key="W",     modifier="SHIFT", func=mstructure.select_walls },
    { key="D",     modifier="SHIFT", func=mland.activate_landmode },
    { key="R",     modifier="SHIFT", func=mland.land_mobile_indirect },
    { key="F",     modifier="SHIFT", func=mnaval.select_destroyers },
    { key="E",     modifier="SHIFT", func=mstructure.cycle_radars },


    { key="Z",     modifier="CTRL",  func=mcommand.SelectCommander },

    { key="Q",     modifier="ALT",   func=mstructure.SelectMex },
    { key="W",     modifier="ALT",   func=mstructure.ShowMexInfo },
    { key="F",     modifier="ALT",   func=mstructure.cycle_pgs },

    { key="Tab",   modifier="",      func=mengi.cycle_tech2tech3_engi },
    { key="Tab",   modifier="CTRL",  func=funcs.cycle_idle_factories },

    { key="Period", modifier="",     func=funcs.cycle_idle_engineers },

    { key="Z",      modifier="ALT",  func=mnormal.enter_normal_mode },

    { key="C",     modifier="ALT",   func=mstructure.pause_t1_upgrading_mex_with_less_wp },
    { key="C",     modifier="SHIFT", func=mstructure.unpause_t1_upgrading_mex_with_greater_wp },
}

structure = {

    { key="Tilde", modifier="",      func=funcs.ground_attack },
    { key="4",     modifier="",      func=funcs.toggle_pause },
    { key="6",     modifier="",      func=funcs.ground_attack },

    { key="F",     modifier="ALT",   func=mstructure.cycle_pgs },
    { key="A",     modifier="",      func=mstructure.cycle_structure_aa },
    { key="R",     modifier="",      func=mstructure.cycle_indirect },
    { key="T",     modifier="",      func=mstructure.cycle_defs },
    { key="X",     modifier="",      func=mstructure.cycle_pds },
    { key="X",     modifier="CTRL",  func=mstructure.cycle_pds },
    { key="X",     modifier="SHIFT", func=mstructure.select_walls },
    { key="X",     modifier="ALT",   func=mstructure.select_walls },
    { key="M",     modifier="",      func=moptics.get_next_optics },
    { key="E",     modifier="",      func=mstructure.cycle_radars },
    { key="E",     modifier="SHIFT", func=mstructure.cycle_radars },
    { key="V",     modifier="",      func=mstructure.cycle_shields },

    { key="C",     modifier="CTRL",  func=funcs.stop },

    { key="Tilde", modifier="CTRL",  func=funcs.EnableUnitsAbility },
    { key="Tilde", modifier="ALT",   func=funcs.DisableUnitsAbility },

    { key="W",     modifier="ALT",   func=mstructure.ShowMexInfo },

    { key="Q",     modifier="",      func=mstructure.SelectUpgradingMexes },

    { key="Y",     modifier="",      func=mstructure.UpgradeStructure },
    { key="G",     modifier="",      func=mstructure.UpgradeStructure },

    -- { key="G",     modifier="CTRL",  func=mstructure.upgrade_pause_t1mexes },

    --[[ { key="T",     modifier="CTRL",  func=mstructure.upgrade_pause_t2mexes_with_storages }, ]]
    { key="T",     modifier="CTRL",  func=mstructure.test_ga },
}

optics = {
    { key="Tilde", modifier="",     func=moptics.optics_chose_target },
    { key="M",     modifier="",     func=moptics.get_next_optics },
    { key="C",     modifier="CTRL", func=funcs.stop },
}

nuke = {
    { key="F",     modifier="",     func=mnuke.GetNextNukeUnit },
    { key="N",     modifier="",     func=mnuke.GetNextNukeUnit },
    { key="Tilde", modifier="",     func=funcs.nukeLaunch },
}

tml = {
    { key="Tilde", modifier="",     func=mtml.launch },
    { key="S",     modifier="",     func=mtml.launch },
    { key="T",     modifier="",     func=mstructure.cycle_tml },
    { key="C",     modifier="CTRL", func=funcs.stop },
    { key="Z",     modifier="",     func=mspl.getNextUnit },
}

land = {
    { key="C",     modifier="CTRL",  func=funcs.stop },
    { key="Tilde", modifier="",      func=funcs.ground_attack },
    { key="3",     modifier="",      func=funcs.spread_attack },
    { key="4",     modifier="",      func=funcs.toggle_all_scripts },
    --[[ { key="5",     modifier="",      func=funcs.toggle_all_scripts2 }, ]]
    { key="5",     modifier="",      func=funcs.patrol },

    { key="Q",     modifier="",      func=mland.rambo_scus },
    { key="Q",     modifier="CTRL",  func=mland.rambo_scus },
    { key="C",     modifier="",      func=mland.land_mobile_snipers },
    { key="A",     modifier="",      func=mland.land_mobile_aa },
    { key="R",     modifier="",      func=mland.land_mobile_indirect },
    { key="R",     modifier="SHIFT", func=mland.land_mobile_indirect },
    { key="X",     modifier="",      func=mland.land_scouts },
    { key="X",     modifier="SHIFT", func=mland.nearest_land_scout },
    { key="E",     modifier="",      func=mland.land_scouts },
    { key="E",     modifier="CTRL",  func=mland.land_scouts },
    { key="T",     modifier="",      func=mland.navy_tanks },
    { key="D",     modifier="",      func=mland.cycle_main_damage_dealers },
    { key="D",     modifier="SHIFT", func=mland.all_main_damage_dealers },
    { key="D",     modifier="CTRL",  func=mland.activate_landmode },
    { key="F",     modifier="",      func=mland.direct_fire_main_dd_tanks },
    { key="F",     modifier="CTRL",  func=mland.land_mobile_exp },
    { key="G",     modifier="",      func=mland.sneaky_damage_dealers },
    { key="V",     modifier="",      func=mland.land_mobile_shields_stealth },
    { key="V",     modifier="CTRL",  func=mland.land_mobile_shields_stealth },
    { key="B",     modifier="",      func=mland.land_mobile_bomb },
    { key="Y",     modifier="",      func=mland.land_mobile_exp },

    { key="R",     modifier="CTRL",  func=mair.cycle_trans },
    { key="X",     modifier="CTRL",  func=mstructure.cycle_pds },

    { key="Space", modifier="",      func=pGUImodule.landPrioritiesGui },
    { key="Tilde", modifier="CTRL",  func=funcs.EnableUnitsAbility },
    { key="Tilde", modifier="ALT",   func=funcs.DisableUnitsAbility },


    { key="Z",     modifier="",      func=mspl.getNextUnit },

    { key="B",     modifier="CTRL",  func=mengi.select_nearest_t1engi },

--     { key="W", modifier="", func=},
}

air = {
    { key="Space", modifier="",     func=pGUImodule.BomberGunshipPrioritiesGui },
    { key="3",     modifier="",     func=funcs.spread_attack },
    { key="5",     modifier="",     func=funcs.patrol },
    { key="A",     modifier="CTRL", func=mair.cycle_air_units },
    { key="A",     modifier="",     func=mair.cycle_air_aa },
    { key="F",     modifier="",     func=mair.select_asf },
    { key="F",     modifier="CTRL", func=funcs.move },
    { key="X",     modifier="",     func=mair.cycle_bombers },
    { key="E",     modifier="",     func=mair.cycle_air_scouts },
    { key="G",     modifier="",     func=mair.cycle_gunships },

    { key="R",     modifier="",     func=mair.cycle_trans },
    { key="R",     modifier="CTRL", func=mair.cycle_trans },

    { key="Tilde", modifier="",     func=funcs.ground_attack },
    { key="C",     modifier="CTRL", func=funcs.stop },

    { key="Z",     modifier="",     func=mspl.getNextUnit },

    { key="N",     modifier="",     func=mstructure.next_idle_air_factory },
    { key="H",     modifier="",     func=mstructure.airFactoryForScouts },
}

trans = {
    { key="5",     modifier="",     func=funcs.patrol, description="Patrol" },

    { key="A",     modifier="",     func=funcs.upload, description="Upload" },
    { key="Q",     modifier="",     func=funcs.upload, description="Upload" },
    { key="Tilde", modifier="",     func=funcs.ferry,  description="Ferry" },
    { key="F",     modifier="",     func=funcs.ferry,  description="Ferry" },
    { key="C",     modifier="CTRL", func=funcs.stop,   description="Stop" },
}

naval = {
    { key="S",     modifier="CTRL",  func=mnaval.cycle_naval_units },

    -- { key="W",     modifier="CTRL",  func=EngineerSelect },


    { key="C",     modifier="CTRL",  func=funcs.stop },
    --[[ { key="Q",     modifier="",      func=funcs.patrol }, ]]

    { key="Tilde", modifier="",      func=funcs.ground_attack },
    { key="3",     modifier="",      func=funcs.spread_attack },
    { key="5",     modifier="",      func=funcs.patrol },
    { key="6",     modifier="",      func=funcs.ground_attack },

    { key="A",     modifier="",      func=mnaval.cycle_naval_aa },
    { key="E",     modifier="",      func=mnaval.sonar },
    { key="R",     modifier="",      func=mnaval.naval_indirect_fire },
    { key="D",     modifier="",      func=mnaval.naval_direct_fire },
    { key="F",     modifier="",      func=mnaval.select_destroyers },
    { key="F",     modifier="SHIFT", func=mnaval.select_destroyers },
    { key="F",     modifier="CTRL",  func=mnaval.naval_direct_fire },
    { key="T",     modifier="",      func=mnaval.cycle_subs },
    -- { key="T",     modifier="CTRL",  func=mair.select_torp_bombers },
    { key="V",     modifier="",      func=mnaval.select_mobile_shields },

    { key="Space", modifier="",      func=pGUImodule.navalPrioritiesGui },

    { key="Z",     modifier="",      func=mspl.getNextUnit },

    { key="N",     modifier="",      func=mnuke.GetNextNukeUnit },
}

command = {
    { key="Tilde", modifier="",      func=mcommand.overcharge },
    { key="5",     modifier="",      func=funcs.patrol },
    { key="6",     modifier="",      func=funcs.ground_attack },
    { key="S",     modifier="",      func=mtml.launch },
    -- { key="Q",     modifier="",      func=mcommand.overcharge },
    { key="Z",     modifier="",      func=funcs.CycleEnhancementTab },

    { key="Space", modifier="",      func=pGUImodule.landPrioritiesGui },
}

enhance = {
    { key="Z",     modifier="",      func=funcs.CycleEnhancementTab },
    { key="G",     modifier="",      func=mcommand.CommanderUpgradeGun },
    { key="Y",     modifier="",      func=mcommand.CommanderUpgradeTech2 },
    { key="H",     modifier="",      func=mcommand.CommanderUpgradeMissle },
    { key="C",     modifier="CTRL",  func=funcs.stop },
    { key="G",     modifier="CTRL",  func=funcs.stop },
}

engi = {
    { key="Tilde", modifier="",      func=funcs.guard },
    { key="1",     modifier="",      func=funcs.easy_reclaim },
    { key="2",     modifier="",      func=funcs.move1 },
    { key="3",     modifier="",      func=funcs.spread_attack },
    { key="4",     modifier="",      func=funcs.toggle_pause },
    { key="5",     modifier="",      func=funcs.patrol },

    { key="7",     modifier="",      func=funcs.sacrifice },
    { key="7",     modifier="CTRL",  func=funcs.upgrade_sacrifice },

    { key="Q",     modifier="",      func=mengi.other_template },
    { key="W",     modifier="",      func=mengi.build_factory },
    { key="E",     modifier="",      func=mengi.build_sensors },
    { key="R",     modifier="",      func=mengi.build_arties },
    { key="T",     modifier="",      func=mengi.build_tmd_smd },
    { key="Y",     modifier="",      func=mengi.build_exp },

    --[[ { key="A",     modifier="",      func=funcs.easy_reclaim }, ]]
    { key="A",     modifier="",      func=mengi.build_mex },
    { key="D",     modifier="",      func=mengi.fab_template },
    -- { key="F",     modifier="",      func=mengi.energy_template },
    { key="F",     modifier="",      func=mengi.build_pg },
    { key="G",     modifier="",      func=mengi.build_estorage },
    { key="H",     modifier="",      func=mengi.build_hive },

    -- { key="Z",     modifier="",      func=mspl.getNextUnit },
    { key="Z",     modifier="",      func=mnormal.SmartSelEngi },
    { key="X",     modifier="",      func=mengi.build_pd },
    { key="C",     modifier="",      func=mengi.build_aa },
    { key="V",     modifier="",      func=mengi.build_torp },
    { key="B",     modifier="",      func=mengi.build_t3_support_air_factory },
    { key="N",     modifier="",      func=mengi.build_nuke_tml },
    { key="M",     modifier="",      func=mengi.build_optics },

    { key="Q",     modifier="CTRL",  func=mengi.build_template },
    { key="W",     modifier="CTRL",  func=mnormal.select_engies },
    { key="E",     modifier="CTRL",  func=funcs.patrol },
    { key="R",     modifier="CTRL",  func=mair.cycle_trans },


    { key="T",     modifier="CTRL",  func=mstructure.test_ga },


    -- { key="Y",     modifier="CTRL",  func= },

    -- { key="A",     modifier="CTRL",  func= },
    -- { key="S",     modifier="CTRL",  func= },
    -- { key="D",     modifier="CTRL",  func= },
    -- { key="F",     modifier="CTRL",  func=mengi.build_hc },
    { key="F",     modifier="CTRL",  func=funcs.move1 },
    -- { key="G",     modifier="CTRL",  func=mstructure.upgrade_pause_t1mexes },
    -- { key="H",     modifier="CTRL",  func= },

    -- { key="Z",     modifier="CTRL",  func= },
    -- { key="X",     modifier="CTRL",  func= },
    { key="C",     modifier="CTRL",  func=funcs.stop },
    { key="V",     modifier="CTRL",  func=mengi.build_shield },
    { key="B",     modifier="CTRL",  func=mengi.select_nearest_t1engi },
    -- { key="N",     modifier="CTRL",  func= },
    -- { key="M",     modifier="CTRL",  func= },

    -- { key="Q",     modifier="SHIFT", func= },
    { key="W",     modifier="SHIFT", func=mengi.build_support_factory },
    -- { key="E",     modifier="SHIFT", func= },
    -- { key="R",     modifier="SHIFT", func= },
    -- { key="T",     modifier="SHIFT", func= },
    -- { key="Y",     modifier="SHIFT", func= },

    -- { key="A",     modifier="SHIFT", func= },
    -- { key="D",     modifier="SHIFT", func= },
    -- { key="F",     modifier="SHIFT", func= },
    -- { key="G",     modifier="SHIFT", func= },
    -- { key="H",     modifier="SHIFT", func= },

    { key="Z",     modifier="SHIFT", func=mengi.LogQueue },
    -- { key="X",     modifier="SHIFT", func= },
    -- { key="C",     modifier="SHIFT", func= },
    -- { key="V",     modifier="SHIFT", func= },
    -- { key="B",     modifier="SHIFT", func= },
    -- { key="N",     modifier="SHIFT", func= },
    -- { key="M",     modifier="SHIFT", func= },

    { key="W",     modifier="ALT",   func=mstructure.ShowMexInfo },

    { key="Z",     modifier="ALT", func=mnormal.enter_normal_mode },


    { key="Tab",    modifier="CTRL", func=funcs.cycle_idle_factories },
    { key="Tab",    modifier="",     func=mengi.cycle_tech2tech3_engi },
    { key="Period", modifier="",     func=funcs.cycle_idle_engineers },
}

factory = {
    { key="3",     modifier="",      func=funcs.CycleHQs },

    { key="G",     modifier="CTRL",  func=mfactory.factory_hard_stop },
    -- { key="G",     modifier="CTRL",  func=mfactory.show_buildingtab },

    { key="2",     modifier="",      func=mfactory.ToggleRepeatBuild },
    { key="4",     modifier="",      func=funcs.toggle_pause },
    { key="5",     modifier="",      func=mfactory.QueueDeleteLastElement },
    { key="6",     modifier="",      func=mfactory.QueueDeleteAll },

    { key="R",     modifier="CTRL",  func=mfactory.ToggleRepeatBuild },
    { key="Y",     modifier="",      func=mfactory.UpgradeStructure },
    { key="C",     modifier="CTRL",  func=mfactory.QueueDeleteAll },
    { key="Z",     modifier="",      func=mfactory.CycleFactoryTechLevels },

    { key="Tab",   modifier="",      func=mfactory.CycleFactoryTechLevels },
    { key="Z",     modifier="CTRL",  func=funcs.cycle_idle_factories },
}

gate = {

    { key="3",     modifier="",      func=funcs.CycleHQs },

    { key="W",     modifier="",      count=1, name="SCU_RAS", func=mfactory.factory_order },
    { key="F",     modifier="",      count=1, name="SCU_Rambo", func=mfactory.factory_order },

    { key="W",     modifier="SHIFT", count=3, name="SCU_RAS", func=mfactory.factory_order },
    { key="F",     modifier="SHIFT", count=3, name="SCU_Rambo", func=mfactory.factory_order },
}

tech1naval = {
    { key="W",     modifier="",      count=1, name="T1_Engineer", func=mfactory.factory_order },
    { key="E",     modifier="",      count=1, name="T1_Attack_Boat", func=mfactory.factory_order },
    { key="T",     modifier="",      count=1, name="T1_Attack_Submarine", func=mfactory.factory_order },
    { key="F",     modifier="",      count=1, name="T1_Frigate", func=mfactory.factory_order },
    { key="B",     modifier="",      count=1, name="T1_Frigate", func=mfactory.factory_order },
    { key="A",     modifier="",      count=1, name="T1_Attack_Boat", func=mfactory.factory_order },
    { key="W",     modifier="SHIFT", count=3, name="T1_Engineer", func=mfactory.factory_order },
    { key="E",     modifier="SHIFT", count=3, name="T1_Attack_Boat", func=mfactory.factory_order },
    { key="T",     modifier="SHIFT", count=3, name="T1_Attack_Submarine", func=mfactory.factory_order },
    { key="F",     modifier="SHIFT", count=3, name="T1_Frigate", func=mfactory.factory_order },
    { key="B",     modifier="SHIFT", count=3, name="T1_Frigate", func=mfactory.factory_order },
    { key="A",     modifier="SHIFT", count=3, name="T1_Attack_Boat", func=mfactory.factory_order },
}

tech2naval = {
    { key="Q",     modifier="",      count=1, name="T2_Field_Engineer", func=mfactory.factory_order },
    { key="W",     modifier="",      count=1, name="T2_Engineer", func=mfactory.factory_order },
    { key="E",     modifier="",      count=1, name="T1_Attack_Boat", func=mfactory.factory_order },
    { key="R",     modifier="",      count=1, name="T2_Cruiser", func=mfactory.factory_order },
    { key="T",     modifier="",      count=1, name="T2_Torpedo_Unit", func=mfactory.factory_order },
    { key="F",     modifier="",      count=1, name="T2_Destroyer", func=mfactory.factory_order },
    { key="G",     modifier="",      count=1, name="T2_Destroyer", func=mfactory.factory_order },
    { key="B",     modifier="",      count=1, name="T1_Frigate", func=mfactory.factory_order },
    { key="A",     modifier="",      count=1, name="T2_Cruiser", func=mfactory.factory_order },
    { key="V",     modifier="",      count=1, name="T2_Shield_Boat", func=mfactory.factory_order },

    { key="Q",     modifier="SHIFT", count=3, name="T2_Field_Engineer", func=mfactory.factory_order },
    { key="W",     modifier="SHIFT", count=3, name="T2_Engineer", func=mfactory.factory_order },
    { key="E",     modifier="SHIFT", count=3, name="T1_Attack_Boat", func=mfactory.factory_order },
    { key="R",     modifier="SHIFT", count=3, name="T2_Cruiser", func=mfactory.factory_order },
    { key="T",     modifier="SHIFT", count=3, name="T2_Torpedo_Unit", func=mfactory.factory_order },
    { key="F",     modifier="SHIFT", count=3, name="T2_Destroyer", func=mfactory.factory_order },
    { key="G",     modifier="SHIFT", count=3, name="T2_Destroyer", func=mfactory.factory_order },
    { key="B",     modifier="SHIFT", count=3, name="T1_Frigate", func=mfactory.factory_order },
    { key="A",     modifier="SHIFT", count=3, name="T2_Cruiser", func=mfactory.factory_order },
    { key="V",     modifier="SHIFT", count=3, name="T2_Shield_Boat", func=mfactory.factory_order },
}

tech3naval = {
    { key="Q",     modifier="",      count=1, name="T2_Field_Engineer", func=mfactory.factory_order },
    { key="W",     modifier="",      count=1, name="T3_Engineer", func=mfactory.factory_order },
    { key="E",     modifier="",      count=1, name="T1_Attack_Boat", func=mfactory.factory_order },
    { key="R",     modifier="",      count=1, name="T2_Cruiser", func=mfactory.factory_order },
    { key="T",     modifier="",      count=1, name="T2_Torpedo_Unit", func=mfactory.factory_order },
    { key="D",     modifier="",      count=1, name="TECH3_SPECIAL_SHIP", func=mfactory.factory_order },
    { key="F",     modifier="",      count=1, name="T3_Battleship", func=mfactory.factory_order },
    { key="G",     modifier="",      count=1, name="T2_Destroyer", func=mfactory.factory_order },
    { key="V",     modifier="",      count=1, name="T2_Shield_Boat", func=mfactory.factory_order },
    { key="B",     modifier="",      count=1, name="T1_Frigate", func=mfactory.factory_order },
    { key="A",     modifier="",      count=1, name="T2_Cruiser", func=mfactory.factory_order },
    { key="C",     modifier="",      count=1, name="T3_Aircraft_Carrier", func=mfactory.factory_order },
    { key="N",     modifier="",      count=1, name="T3_Strategic_Missile_Submarine", func=mfactory.factory_order },

    { key="Q",     modifier="SHIFT", count=3, name="T2_Field_Engineer", func=mfactory.factory_order },
    { key="W",     modifier="SHIFT", count=3, name="T3_Engineer", func=mfactory.factory_order },
    { key="E",     modifier="SHIFT", count=3, name="T1_Attack_Boat", func=mfactory.factory_order },
    { key="R",     modifier="SHIFT", count=3, name="T2_Cruiser", func=mfactory.factory_order },
    { key="T",     modifier="SHIFT", count=3, name="T2_Torpedo_Unit", func=mfactory.factory_order },
    { key="D",     modifier="SHIFT", count=3, name="TECH3_SPECIAL_SHIP", func=mfactory.factory_order },
    { key="F",     modifier="SHIFT", count=3, name="T3_Battleship", func=mfactory.factory_order },
    { key="G",     modifier="SHIFT", count=3, name="T2_Destroyer", func=mfactory.factory_order },
    { key="V",     modifier="SHIFT", count=3, name="T2_Shield_Boat", func=mfactory.factory_order },
    { key="B",     modifier="SHIFT", count=3, name="T1_Frigate", func=mfactory.factory_order },
    { key="A",     modifier="SHIFT", count=3, name="T2_Cruiser", func=mfactory.factory_order },
    { key="C",     modifier="SHIFT", count=3, name="T3_Aircraft_Carrier", func=mfactory.factory_order },
    { key="N",     modifier="SHIFT", count=3, name="T3_Strategic_Missile_Submarine", func=mfactory.factory_order },
}

tech1air = {
    { key="W",     modifier="",      count=1, name="T1_Engineer", func=mfactory.factory_order },
    { key="E",     modifier="",      count=1, name="T1_Air_Scout", func=mfactory.factory_order },
    { key="R",     modifier="",      count=1, name="T1_Light_Air_Transport", func=mfactory.factory_order },
    { key="F",     modifier="",      count=1, name="T1_Interceptor", func=mfactory.factory_order },
    { key="G",     modifier="",      count=1, name="T1_Light_Gunship", func=mfactory.factory_order },
    { key="B",     modifier="",      count=1, name="T1_Attack_Bomber", func=mfactory.factory_order },

    { key="W",     modifier="SHIFT", count=3, name="T1_Engineer", func=mfactory.factory_order },
    { key="E",     modifier="SHIFT", count=3, name="T1_Air_Scout", func=mfactory.factory_order },
    { key="R",     modifier="SHIFT", count=3, name="T1_Light_Air_Transport", func=mfactory.factory_order },
    { key="F",     modifier="SHIFT", count=3, name="T1_Interceptor", func=mfactory.factory_order },
    { key="G",     modifier="SHIFT", count=3, name="T1_Light_Gunship", func=mfactory.factory_order },
    { key="B",     modifier="SHIFT", count=3, name="T1_Attack_Bomber", func=mfactory.factory_order },
}

tech2air = {

    { key="Q",     modifier="",      count=1, name="T2_Field_Engineer", func=mfactory.factory_order },
    { key="W",     modifier="",      count=1, name="T2_Engineer", func=mfactory.factory_order },
    { key="E",     modifier="",      count=1, name="T1_Air_Scout", func=mfactory.factory_order },
    { key="R",     modifier="",      count=1, name="T2_Air_Transport", func=mfactory.factory_order },
    { key="T",     modifier="",      count=1, name="T2_Torpedo_Bomber", func=mfactory.factory_order },
    { key="D",     modifier="",      count=1, name="TECH2_BOMBER", func=mfactory.factory_order },
    { key="F",     modifier="",      count=1, name="TECH2_INTI", func=mfactory.factory_order },
    { key="G",     modifier="",      count=1, name="T2_Gunship", func=mfactory.factory_order },
    { key="B",     modifier="",      count=1, name="T1_Attack_Bomber", func=mfactory.factory_order },

    { key="Q",     modifier="SHIFT", count=3, name="T2_Field_Engineer", func=mfactory.factory_order },
    { key="W",     modifier="SHIFT", count=3, name="T2_Engineer", func=mfactory.factory_order },
    { key="E",     modifier="SHIFT", count=3, name="T1_Air_Scout", func=mfactory.factory_order },
    { key="R",     modifier="SHIFT", count=3, name="T2_Air_Transport", func=mfactory.factory_order },
    { key="T",     modifier="SHIFT", count=3, name="T2_Torpedo_Bomber", func=mfactory.factory_order },
    { key="D",     modifier="SHIFT", count=3, name="TECH2_BOMBER", func=mfactory.factory_order },
    { key="F",     modifier="SHIFT", count=3, name="TECH2_INTI", func=mfactory.factory_order },
    { key="G",     modifier="SHIFT", count=3, name="T2_Gunship", func=mfactory.factory_order },
    { key="B",     modifier="SHIFT", count=3, name="T1_Attack_Bomber", func=mfactory.factory_order },
}

tech3air = {
    { key="Q",     modifier="",      count=1, name="T2_Field_Engineer", func=mfactory.factory_order },
    { key="W",     modifier="",      count=1, name="T3_Engineer", func=mfactory.factory_order },
    { key="E",     modifier="",      count=1, name="T3_Spy_Plane", func=mfactory.factory_order },
    { key="R",     modifier="",      count=1, name="T2_Air_Transport", func=mfactory.factory_order },
    { key="T",     modifier="",      count=1, name="T2_Torpedo_Bomber", func=mfactory.factory_order },
    { key="D",     modifier="",      count=1, name="TECH2_BOMBER", func=mfactory.factory_order },
    { key="F",     modifier="",      count=1, name="T3_Air_Superiority_Fighter", func=mfactory.factory_order },
    { key="G",     modifier="",      count=1, name="T2_Gunship", func=mfactory.factory_order },
    { key="H",     modifier="",      count=1, name="TECH3_GUNSHIP", func=mfactory.factory_order },
    { key="C",     modifier="",      count=1, name="T3_Torpedo_Bomber", func=mfactory.factory_order },
    { key="N",     modifier="",      count=1, name="T3_Strategic_Bomber", func=mfactory.factory_order },
    { key="B",     modifier="",      count=1, name="T1_Attack_Bomber", func=mfactory.factory_order },
    -- { key="N",     modifier="",      count=1, name="T3_Heavy_Air_Transport", func=mfactory.factory_order },

    { key="Q",     modifier="SHIFT", count=3, name="T2_Field_Engineer", func=mfactory.factory_order },
    { key="W",     modifier="SHIFT", count=3, name="T3_Engineer", func=mfactory.factory_order },
    { key="E",     modifier="SHIFT", count=3, name="T3_Spy_Plane", func=mfactory.factory_order },
    { key="R",     modifier="SHIFT", count=3, name="T2_Air_Transport", func=mfactory.factory_order },
    { key="T",     modifier="SHIFT", count=3, name="T2_Torpedo_Bomber", func=mfactory.factory_order },
    { key="D",     modifier="SHIFT", count=3, name="TECH2_BOMBER", func=mfactory.factory_order },
    { key="F",     modifier="SHIFT", count=3, name="T3_Air_Superiority_Fighter", func=mfactory.factory_order },
    { key="G",     modifier="SHIFT", count=3, name="T2_Gunship", func=mfactory.factory_order },
    { key="H",     modifier="SHIFT", count=3, name="TECH3_GUNSHIP", func=mfactory.factory_order },
    { key="C",     modifier="SHIFT", count=3, name="T3_Torpedo_Bomber", func=mfactory.factory_order },
    { key="N",     modifier="SHIFT", count=3, name="T3_Strategic_Bomber", func=mfactory.factory_order },
    { key="B",     modifier="SHIFT", count=3, name="T1_Attack_Bomber", func=mfactory.factory_order },
    -- { key="N",     modifier="SHIFT", count=3, name="T3_Heavy_Air_Transport", func=mfactory.factory_order },
}

tech1land = {
    { key="Q",     modifier="",      count=1, name="T1_Light_Assault_Bot", func=mfactory.factory_order },
    { key="W",     modifier="",      count=1, name="T1_Engineer", func=mfactory.factory_order },
    { key="E",     modifier="",      count=1, name="T1_Land_Scout", func=mfactory.factory_order },
    { key="R",     modifier="",      count=1, name="T1_Mobile_Light_Artillery", func=mfactory.factory_order },
    { key="T",     modifier="",      count=1, name="T1_Light_Assault_Bot", func=mfactory.factory_order },
    { key="A",     modifier="",      count=1, name="T1_Mobile_Anti_Air_Gun", func=mfactory.factory_order },
    { key="F",     modifier="",      count=1, name="T1_Tank", func=mfactory.factory_order },

    { key="Q",     modifier="SHIFT", count=3, name="T1_Light_Assault_Bot", func=mfactory.factory_order },
    { key="W",     modifier="SHIFT", count=3, name="T1_Engineer", func=mfactory.factory_order },
    { key="E",     modifier="SHIFT", count=3, name="T1_Land_Scout", func=mfactory.factory_order },
    { key="R",     modifier="SHIFT", count=3, name="T1_Mobile_Light_Artillery", func=mfactory.factory_order },
    { key="T",     modifier="SHIFT", count=3, name="T1_Light_Assault_Bot", func=mfactory.factory_order },
    { key="A",     modifier="SHIFT", count=3, name="T1_Mobile_Anti_Air_Gun", func=mfactory.factory_order },
    { key="F",     modifier="SHIFT", count=3, name="T1_Tank", func=mfactory.factory_order },
}

tech2land = {
    { key="Q",     modifier="",      count=1, name="T2_Field_Engineer", func=mfactory.factory_order },
    { key="W",     modifier="",      count=1, name="T2_Engineer", func=mfactory.factory_order },
    { key="E",     modifier="",      count=1, name="T1_Land_Scout", func=mfactory.factory_order },
    { key="R",     modifier="",      count=1, name="T2_Mobile_Missile_Launcher", func=mfactory.factory_order },
    { key="T",     modifier="",      count=1, name="T2_Special_Tank", func=mfactory.factory_order },
    { key="A",     modifier="",      count=1, name="T2_Mobile_AA", func=mfactory.factory_order },
    { key="D",     modifier="",      count=1, name="TECH2_LONG_RANGE_BOT", func=mfactory.factory_order },
    { key="F",     modifier="",      count=1, name="T2_Heavy_Tank", func=mfactory.factory_order },
    { key="C",     modifier="",      count=1, name="TECH2_LONG_RANGE_BOT", func=mfactory.factory_order },
    { key="V",     modifier="",      count=1, name="TECH2_STEALTH_SHIELD_LAND_MOBILE", func=mfactory.factory_order },
    { key="B",     modifier="",      count=1, name="T2_Mobile_Bomb", func=mfactory.factory_order },

    { key="Q",     modifier="SHIFT", count=3, name="T2_Field_Engineer", func=mfactory.factory_order },
    { key="W",     modifier="SHIFT", count=3, name="T2_Engineer", func=mfactory.factory_order },
    { key="E",     modifier="SHIFT", count=3, name="T1_Land_Scout", func=mfactory.factory_order },
    { key="R",     modifier="SHIFT", count=3, name="T2_Mobile_Missile_Launcher", func=mfactory.factory_order },
    { key="T",     modifier="SHIFT", count=3, name="T2_Special_Tank", func=mfactory.factory_order },
    { key="A",     modifier="SHIFT", count=3, name="T2_Mobile_AA", func=mfactory.factory_order },
    { key="D",     modifier="SHIFT", count=3, name="TECH2_LONG_RANGE_BOT", func=mfactory.factory_order },
    { key="F",     modifier="SHIFT", count=3, name="T2_Heavy_Tank", func=mfactory.factory_order },
    { key="C",     modifier="SHIFT", count=3, name="TECH2_LONG_RANGE_BOT", func=mfactory.factory_order },
    { key="V",     modifier="SHIFT", count=3, name="TECH2_STEALTH_SHIELD_LAND_MOBILE", func=mfactory.factory_order },
    { key="B",     modifier="SHIFT", count=3, name="T2_Mobile_Bomb", func=mfactory.factory_order },
}

tech3land = {
    { key="Q",     modifier="",      count=1, name="T2_Field_Engineer", func=mfactory.factory_order },
    { key="W",     modifier="",      count=1, name="T3_Engineer", func=mfactory.factory_order },
    { key="E",     modifier="",      count=1, name="T1_Land_Scout", func=mfactory.factory_order },
    { key="R",     modifier="",      count=1, name="T3_Mobile_Heavy_Artillery", func=mfactory.factory_order },
    { key="T",     modifier="",      count=1, name="T2_Special_Tank", func=mfactory.factory_order },
    { key="A",     modifier="",      count=1, name="T3_Land_Mobile_AA", func=mfactory.factory_order },
    { key="S",     modifier="",      count=1, name="T3_Shield_Disruptor", func=mfactory.factory_order },
    { key="D",     modifier="",      count=1, name="TECH3_ASSAULT_BOT", func=mfactory.factory_order },
    { key="F",     modifier="",      count=1, name="T3_Land_Mobile_Tank", func=mfactory.factory_order },
    { key="G",     modifier="",      count=1, name="T2_Mobile_AA", func=mfactory.factory_order },
    { key="C",     modifier="",      count=1, name="T3_Sniper_Bot", func=mfactory.factory_order },
    { key="V",     modifier="",      count=1, name="TECH2_STEALTH_SHIELD_LAND_MOBILE", func=mfactory.factory_order },
    { key="N",     modifier="",      count=1, name="T3_Shield_Disruptor", func=mfactory.factory_order },

    { key="Q",     modifier="SHIFT", count=3, name="T2_Field_Engineer", func=mfactory.factory_order },
    { key="W",     modifier="SHIFT", count=3, name="T3_Engineer", func=mfactory.factory_order },
    { key="E",     modifier="SHIFT", count=3, name="T1_Land_Scout", func=mfactory.factory_order },
    { key="R",     modifier="SHIFT", count=3, name="T3_Mobile_Heavy_Artillery", func=mfactory.factory_order },
    { key="T",     modifier="SHIFT", count=3, name="T2_Special_Tank", func=mfactory.factory_order },
    { key="A",     modifier="SHIFT", count=3, name="T3_Land_Mobile_AA", func=mfactory.factory_order },
    { key="S",     modifier="SHIFT", count=3, name="T3_Shield_Disruptor", func=mfactory.factory_order },
    { key="D",     modifier="SHIFT", count=3, name="TECH3_ASSAULT_BOT", func=mfactory.factory_order },
    { key="F",     modifier="SHIFT", count=3, name="T3_Land_Mobile_Tank", func=mfactory.factory_order },
    { key="G",     modifier="SHIFT", count=3, name="T2_Mobile_AA", func=mfactory.factory_order },
    { key="C",     modifier="SHIFT", count=3, name="T3_Sniper_Bot", func=mfactory.factory_order },
    { key="V",     modifier="SHIFT", count=3, name="TECH2_STEALTH_SHIELD_LAND_MOBILE", func=mfactory.factory_order },
    { key="N",     modifier="SHIFT", count=3, name="T3_Shield_Disruptor", func=mfactory.factory_order },
}

dev = {
    { key="Esc",   modifier="",      func=funcs.selectAirHQ },

    { key="F1",   modifier="",      func=mdev.toggleUnitPause },

    { key="I", modifier="CTRL", func=mdev.toggleLogWindow },
    { key="O", modifier="CTRL", func=mdev.logBpCategories },
    { key="P", modifier="CTRL", func=mdev.logExistingEnhancements },

    { key="K", modifier="ALT", func=mdev.instaKillUnit },
}
