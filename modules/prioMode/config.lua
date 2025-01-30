local mprio = import("prioFns.lua")

land = {
    { key="Space", modifier="", func=mprio.target_PD,       icon="", descr="Pd" },
    { key="G",     modifier="", func=mprio.target_Power,    icon="⏻", descr="Power" },
    { key="W",     modifier="", func=mprio.target_Mex,      icon="", descr="Mex" },
    { key="Q",     modifier="", func=mprio.swp_Land_Mobile, icon="", descr="Units" },
    { key="E",     modifier="", func=mprio.target_Engies,   icon="", descr="Engi" },

    { key = "Tilde", modifier = "", func = mprio.target_Snipe, icon = "", descr = "Snipe" },
    { key = "C",     modifier = "", func = mprio.swp_IntelShields,   icon = "", descr = "Int Slds" },
    { key = "T",     modifier = "", func = mprio.swp_SMD,      icon = "ﱾ", descr = "SMD TMD" },
    { key = "D",     modifier = "", func = mprio.target_EXP,   icon = "", descr = "Exp" },
    { key = "A",     modifier = "", func = mprio.swp_aa,       icon = "", descr = "AA" },
}

naval = {
    { key = "Space", modifier = "", func = mprio.target_PD, icon = "", descr = "Pd" },
    { key = "F", modifier = "", func = mprio.swp_destroyer, icon = "益", descr = "Destros" },
    { key = "B", modifier = "", func = mprio.swp_battleship, icon = "", descr = "BS" },
    { key = "A", modifier = "", func = mprio.swp_cruiser, icon = "", descr = "Cruiser" },
    { key = "R", modifier = "", func = mprio.swp_submarine, icon = "", descr = "Submarine" },

    { key = "Tilde", modifier = "", func = mprio.target_ACU, icon = "", descr = "ACU" },
    { key = "E", modifier = "", func = mprio.target_Engies, icon = "", descr = "Engi" },
    { key = "X", modifier = "", func = mprio.target_PD, icon = "", descr = "TorpLnr" },
    { key = "W", modifier = "", func = mprio.target_Mex, icon = "", descr = "Mex" },
    { key = "T", modifier = "", func = mprio.swp_antimissile, icon = "", descr = "TMD" },
}

air_bomber = {
    { key = "Space", modifier = "", func = mprio.target_Engies, icon = "", descr = "Engi" },
    { key = "G", modifier = "", func = mprio.target_Power, icon = "益", descr = "Power" },
    { key = "W", modifier = "", func = mprio.target_Mex, icon = "", descr = "Mex" },
    { key = "Q", modifier = "", func = mprio.swp_Land_Mobile, icon = "", descr = "Units" },
    { key = "T", modifier = "", func = mprio.swp_SMD,      icon = "ﱾ", descr = "SMD TMD" },

    { key = "Tilde", modifier = "", func = mprio.target_ACU, icon = "", descr = "ACU" },
    { key = "A", modifier = "", func = mprio.swp_aa, icon = "", descr = "AA" },
    { key = "E", modifier = "", func = mprio.target_Engies, icon = "", descr = "Engi" },
    { key = "X", modifier = "", func = mprio.target_PD, icon = "", descr = "Pd" },
    { key = "R", modifier = "", func = mprio.swp_cruiser, icon = "", descr = "Cruiser" },
}
