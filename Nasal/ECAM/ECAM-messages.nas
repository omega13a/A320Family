# A3XX Electronic Centralised Aircraft Monitoring System

# Copyright (c) 2019 Jonathan Redpath (legoboyvdlp)

# messages stored in vectors

# Left E/WD
var warningsOld               = std.Vector.new([
	var lg_not_dn             = warning.new(msg: "L/G GEAR NOT DOWN",        active: 0, colour: "r", aural: "crc",   light: "warning", noRepeat: 0),
	var pack1_fault           = warning.new(msg: "AIR PACK 1 FAULT ",        active: 0, colour: "a", aural: "chime", light: "caution", noRepeat: 0),
	var pack1_fault_subwarn_1 = warning.new(msg: "-PACK 1.............OFF ", active: 0, colour: "b", aural: "none",  light: "none",    noRepeat: 0),
	var pack2_fault           = warning.new(msg: "AIR PACK 2 FAULT ",        active: 0, colour: "a", aural: "chime", light: "caution", noRepeat: 0),
	var pack2_fault_subwarn_1 = warning.new(msg: "-PACK 2.............OFF ", active: 0, colour: "b", aural: "none",  light: "none",    noRepeat: 0),
	var park_brk_on           = warning.new(msg: "PARK BRK ON",              active: 0, colour: "a", aural: "chime", light: "caution", noRepeat: 0)
]);

var warnings				  = std.Vector.new([
	var flap_not_zero         = warning.new(msg: "F/CTL FLAP LVR NOT ZERO",  active: 0, colour: "r", aural: "crc",   light: "warning", noRepeat: 0),
	var ap_offw				  = warning.new(msg: "AUTO FLT AP OFF",			 active: 0, colour: "r", aural: "calv",  light: "warning", noRepeat: 0),
	var athr_offw			  = warning.new(msg: "AUTO FLT A/THR OFF", 	     active: 0, colour: "a", aural: "chime", light: "caution", noRepeat: 0),
	var athr_offw_1			  = warning.new(msg: "-THR LEVERS........MOVE",  active: 0, colour: "b", aural: "none",  light: "none",    noRepeat: 0),
	var athr_lock			  = warning.new(msg: "ENG THRUST LOCKED", 		 active: 0, colour: "a", aural: "chime", light: "caution", noRepeat: 0),
	var athr_lock_1			  = warning.new(msg: "-THR LEVERS........MOVE",  active: 0, colour: "b", aural: "none",  light: "none",    noRepeat: 0),
	var athr_lim			  = warning.new(msg: "AUTO FLT A/THR LIMITED",   active: 0, colour: "a", aural: "chime", light: "caution", noRepeat: 0),
	var athr_lim_1			  = warning.new(msg: "-THR LEVERS........MOVE",  active: 0, colour: "b", aural: "none",  light: "none",    noRepeat: 0)
]);

var leftmemos                 = std.Vector.new([
	var company_alert         = warning.new(msg: "COMPANY ALERT",            active: 0, colour: "g", aural: "buzz",  light: "none", noRepeat: 0), # Not yet implemented, buzzer sound
	var refuelg               = warning.new(msg: "REFUELG",                  active: 0, colour: "g", aural: "none",  light: "none", noRepeat: 0),
	var irs_in_align          = warning.new(msg: "IRS IN ALIGN",             active: 0, colour: "g", aural: "none",  light: "none", noRepeat: 0), # Not yet implemented
	var gnd_splrs             = warning.new(msg: "GND SPLRS ARMED",          active: 0, colour: "g", aural: "none",  light: "none", noRepeat: 0),
	var seatbelts             = warning.new(msg: "SEAT BELTS",               active: 0, colour: "g", aural: "none",  light: "none", noRepeat: 0),
	var nosmoke               = warning.new(msg: "NO SMOKING",               active: 0, colour: "g", aural: "none",  light: "none", noRepeat: 0),
	var strobe_lt_off         = warning.new(msg: "STROBE LT OFF",            active: 0, colour: "g", aural: "none",  light: "none", noRepeat: 0),
	var outr_tk_fuel_xfrd     = warning.new(msg: "OUTR TK FUEL XFRD",        active: 0, colour: "g", aural: "none",  light: "none", noRepeat: 0), # Not yet implemented
	var fob_3T                = warning.new(msg: "FOB BELOW 3T",             active: 0, colour: "g", aural: "none",  light: "none", noRepeat: 0),
	var gpws_flap_mode_off    = warning.new(msg: "GPWS FLAP MODE OFF",       active: 0, colour: "g", aural: "none",  light: "none", noRepeat: 0),
	var atc_datalink_stby     = warning.new(msg: "ATC DATALINK STBY",        active: 0, colour: "g", aural: "none",  light: "none", noRepeat: 0), # Not yet implemented
	var company_datalink_stby = warning.new(msg: "COMPANY DATALINK STBY",    active: 0, colour: "g", aural: "none",  light: "none", noRepeat: 0) # Not yet implemented
]);

# Right E/WD

var specialLines         = std.Vector.new([
	var to_inhibit       = memo.new(msg: "T.O. INHIBIT", active: 0, colour: "m"),
	var ldg_inhibit      = memo.new(msg: "LDG INHIBIT",  active: 0, colour: "m"),
	var land_asap_r      = memo.new(msg: "LAND ASAP",    active: 0, colour: "r"),
	var land_asap_a      = memo.new(msg: "LAND ASAP",    active: 0, colour: "a"),
	var ap_off           = memo.new(msg: "AP OFF",       active: 0, colour: "r"),
	var athr_off         = memo.new(msg: "A/THR OFF",    active: 0, colour: "a"),
]);

var secondaryFailures    = std.Vector.new([
	var secondary_bleed  = memo.new(msg: "•AIR BLEED",  active: 0, colour: "a"), # Not yet implemented
	var secondary_press  = memo.new(msg: "•CAB PRESS",  active: 0, colour: "a"), # Not yet implemented
	var secondary_vent   = memo.new(msg: "•AVNCS VENT", active: 0, colour: "a"), # Not yet implemented
	var secondary_elec   = memo.new(msg: "•ELEC",       active: 0, colour: "a"), # Not yet implemented
	var secondary_hyd    = memo.new(msg: "•HYD",        active: 0, colour: "a"), # Not yet implemented
	var secondary_fuel   = memo.new(msg: "•FUEL",       active: 0, colour: "a"), # Not yet implemented
	var secondary_cond   = memo.new(msg: "•AIR COND",   active: 0, colour: "a"), # Not yet implemented
	var secondary_brake  = memo.new(msg: "•BRAKES",     active: 0, colour: "a"), # Not yet implemented
	var secondary_wheel  = memo.new(msg: "•WHEEL",      active: 0, colour: "a"), # Not yet implemented
	var secondary_fctl   = memo.new(msg: "•F/CTL",      active: 0, colour: "a"), # Not yet implemented
]);

var memos                = std.Vector.new([
	var spd_brk          = memo.new(msg: "SPEED BRK",    active: 0, colour: "g"),  
	var park_brk         = memo.new(msg: "PARK BRK",     active: 0, colour: "g"),
	var ptu              = memo.new(msg: "HYD PTU",      active: 0, colour: "g"),
	var rat              = memo.new(msg: "RAT OUT",      active: 0, colour: "g"),
	var emer_gen         = memo.new(msg: "EMER GEN",     active: 0, colour: "g"),
	var ram_air          = memo.new(msg: "RAM AIR ON",   active: 0, colour: "g"),
	var nw_strg_disc     = memo.new(msg: "NW STRG DISC", active: 0, colour: "g"),
	var ignition         = memo.new(msg: "IGNITION",     active: 0, colour: "g"),
	var cabin_ready      = memo.new(msg: "CABIN READY",  active: 0, colour: "g"), # Not yet implemented
	var pred_ws_off      = memo.new(msg: "PRED W/S OFF", active: 0, colour: "g"), # Not yet implemented
	var terr_stby        = memo.new(msg: "TERR STBY",    active: 0, colour: "g"), # Not yet implemented
	var tcas_stby        = memo.new(msg: "TCAS STBY",    active: 0, colour: "g"), # Not yet implemented
	var acars_call       = memo.new(msg: "ACARS CALL",   active: 0, colour: "g"), # Not yet implemented
	var company_call     = memo.new(msg: "COMPANY CALL", active: 0, colour: "g"), # Not yet implemented
	var satcom_alert     = memo.new(msg: "SATCOM ALERT", active: 0, colour: "g"), # Not yet implemented
	var acars_msg        = memo.new(msg: "ACARS MSG",    active: 0, colour: "g"), # Not yet implemented
	var company_msg      = memo.new(msg: "COMPANY MSG",  active: 0, colour: "g"), # Not yet implemented
	var eng_aice         = memo.new(msg: "ENG A.ICE",    active: 0, colour: "g"),
	var wing_aice        = memo.new(msg: "WING A.ICE",   active: 0, colour: "g"),
	var ice_not_det      = memo.new(msg: "ICE NOT DET",  active: 0, colour: "g"), # Not yet implemented
	var hi_alt           = memo.new(msg: "HI ALT",       active: 0, colour: "g"), # Not yet implemented
	var apu_avail        = memo.new(msg: "APU AVAIL",    active: 0, colour: "g"),
	var apu_bleed        = memo.new(msg: "APU BLEED",    active: 0, colour: "g"),
	var ldg_lt           = memo.new(msg: "LDG LT",       active: 0, colour: "g"),
	var brk_fan          = memo.new(msg: "BRK FAN",      active: 0, colour: "g"), # Not yet implemented
	var audio3_xfrd      = memo.new(msg: "AUDIO 3 XFRD", active: 0, colour: "g"), # Not yet implemented
	var switchg_pnl      = memo.new(msg: "SWITCHG PNL",  active: 0, colour: "g"), # Not yet implemented
	var gpws_flap3       = memo.new(msg: "GPWS FLAP 3",  active: 0, colour: "g"), 
	var hf_data_ovrd     = memo.new(msg: "HF DATA OVRD", active: 0, colour: "g"), # Not yet implemented
	var hf_voice         = memo.new(msg: "HF VOICE",     active: 0, colour: "g"), # Not yet implemented
	var acars_stby       = memo.new(msg: "ACARS STBY",   active: 0, colour: "g"), # Not yet implemented
	var vhf3_voice       = memo.new(msg: "VHF3 VOICE",   active: 0, colour: "g"),
	var auto_brk_lo      = memo.new(msg: "AUTO BRK LO",  active: 0, colour: "g"),
	var auto_brk_med     = memo.new(msg: "AUTO BRK MED", active: 0, colour: "g"),
	var auto_brk_max     = memo.new(msg: "AUTO BRK MAX", active: 0, colour: "g"),
	var auto_brk_off     = memo.new(msg: "AUTO BRK OFF", active: 0, colour: "g"), # Not yet implemented
	var man_ldg_elev     = memo.new(msg: "MAN LDG ELEV", active: 0, colour: "g"), # Not yet implemented
	var ctr_tk_feedg     = memo.new(msg: "CTR TK FEEDG", active: 0, colour: "g"),
	var fuelx            = memo.new(msg: "FUEL X FEED",  active: 0, colour: "g")
]);

var clearWarnings        = std.Vector.new();

# Status SD page
var statusLim            = std.Vector.new([
	var min_rat_spd      = status.new(msg: "MIN RAT SPD.....140 KT",    active: 0, colour: "c"), # Not yet implemented
	var max_spd_gear     = status.new(msg: "MAX SPD........280/.67",    active: 0, colour: "c"), # Not yet implemented
	var max_spd_rev      = status.new(msg: "MAX SPD........300/.78",    active: 0, colour: "c"), # Not yet implemented
	var buffet_rev       = status.new(msg: "   •IF BUFFET :",           active: 0, colour: "w"), # Not yet implemented
	var max_spd_rev_buf  = status.new(msg: "MAX SPD.............240",   active: 0, colour: "c"), # Not yet implemented
	var max_spd_fctl     = status.new(msg: "MAX SPD........320/.77",    active: 0, colour: "c"), # Not yet implemented
	var max_spd_fctl2    = status.new(msg: "MAX SPD.........300 KT",    active: 0, colour: "c"), # Not yet implemented
	var max_spd_gr_door  = status.new(msg: "MAX SPD 250/.60",           active: 0, colour: "c"), # Not yet implemented
	var max_alt_press    = status.new(msg: "MAX FL : 100/MEA",          active: 0, colour: "c"), # Not yet implemented
	var gravity_fuel     = status.new(msg: "-PROC:GRAVTY FUEL FEEDING", active: 0, colour: "c"), # Not yet implemented
	var gear_kp_dn       = status.new(msg: "L/G............KEEP DOWN",  active: 0, colour: "c"), # Not yet implemented
	var park_brk_only    = status.new(msg: "PARK BRK ONLY",             active: 0, colour: "c"), # Not yet implemented
	var park_brk_only    = status.new(msg: "MAX BRK PR........1000PSI", active: 0, colour: "c"), # Not yet implemented
	var fuel_gravity     = status.new(msg: "FUEL GRAVTY FEED",          active: 0, colour: "c"), # Not yet implemented
	var fctl_manvr       = status.new(msg: "MANOEUVER WITH CARE",       active: 0, colour: "c"), # Not yet implemented
	var fctl_spdbrk_care = status.new(msg: "USE SPD BRK WITH CARE",     active: 0, colour: "c"), # Not yet implemented
	var fctl_spdbrk_dont = status.new(msg: "SPD BRK......DO NOT USE",   active: 0, colour: "c"), # Not yet implemented
	var fctl_rud_care    = status.new(msg: "RUD WITH CARE ABV 160KT",   active: 0, colour: "c"), # Not yet implemented
	var eng_thr_changes  = status.new(msg: "AVOID RAPID THR CHANGES",   active: 0, colour: "c"), # Not yet implemented
	var avoid_neg_g_fac  = status.new(msg: "AVOID NEGATIVE G FACTOR",   active: 0, colour: "c"), # Not yet implemented
	var avoid_icing      = status.new(msg: "AVOID ICING CONDITONS",     active: 0, colour: "c"), # Not yet implemented
	var severe_icing     = status.new(msg: " IF A/C ICING SEVERE :",    active: 0, colour: "w"), # Not yet implemented, a319 only
	var severe_icing_2   = status.new(msg: "MIN SPD ALPHA PROT",        active: 0, colour: "c"), # Not yet implemented, a319 only
	var avoid_thr_chg    = status.new(msg: "AVOID THR CHANGES",         active: 0, colour: "c"), # Not yet implemented, iae only
	var avoid_thr_chg_2  = status.new(msg: "AVOID RAPID THR CHANGES",   active: 0, colour: "c"), # Not yet implemented, iae only
	var avoid_adv_cond   = status.new(msg: "AVOID ADVERSE CONDITIONS",  active: 0, colour: "c"), # Not yet implemented, iae only
	var atc_com_voice    = status.new(msg: "ATC COM VOICE ONLY",        active: 0, colour: "c") # Not yet implemented, iae only
]);

var statusApprProc       = std.Vector.new([
	var dual_hyd_b_g     = status.new(msg: "APPR PROC DUAL HYD LO PR",             active: 0, colour: "r"), # Not yet implemented
	var dual_hyd_b_g_2   = status.new(msg: "   •IF BLUE OVHT OUT:",                active: 0, colour: "w"), # Not yet implemented
	var dual_hyd_b_g_3   = status.new(msg: "-BLUE ELEC PUMP.....AUTO",             active: 0, colour: "c"), # Not yet implemented
	var dual_hyd_b_g_4   = status.new(msg: "   •IF GREEN OVHT OUT:",               active: 0, colour: "w"), # Not yet implemented
	var dual_hyd_b_g_5   = status.new(msg: "-GREEN ENG 1 PUMP.....ON",             active: 0, colour: "c"), # Not yet implemented
	var dual_hyd_b_g_6   = status.new(msg: "-PTU................AUTO",             active: 0, colour: "c"), # Not yet implemented
	
	var dual_hyd_b_y     = status.new(msg: "APPR PROC DUAL HYD LO PR",             active: 0, colour: "r"), # Not yet implemented
	var dual_hyd_b_y_2   = status.new(msg: "   •IF BLUE OVHT OUT:",                active: 0, colour: "w"), # Not yet implemented
	var dual_hyd_b_y_3   = status.new(msg: "-BLUE ELEC PUMP.....AUTO",             active: 0, colour: "c"), # Not yet implemented
	var dual_hyd_b_y_4   = status.new(msg: "   •IF YELLOW OVHT OUT:",              active: 0, colour: "w"), # Not yet implemented
	var dual_hyd_b_y_5   = status.new(msg: "-YELLOW ENG 2 PUMP....ON",             active: 0, colour: "c"), # Not yet implemented
	var dual_hyd_b_y_6   = status.new(msg: "-PTU................AUTO",             active: 0, colour: "c"), # Not yet implemented
	
	var dual_hyd_g_y     = status.new(msg: "APPR PROC DUAL HYD LO PR",             active: 0, colour: "r"), # Not yet implemented
	var dual_hyd_g_y_2   = status.new(msg: "   •IF GREEN OVHT OUT:",               active: 0, colour: "w"), # Not yet implemented
	var dual_hyd_b_y_3   = status.new(msg: "-GREEN ENG 1 PUMP.....ON",             active: 0, colour: "c"), # Not yet implemented
	var dual_hyd_g_y_4   = status.new(msg: "   •IF YELLOW OVHT OUT:",              active: 0, colour: "w"), # Not yet implemented
	var dual_hyd_g_y_5   = status.new(msg: "-YELLOW ENG 2 PUMP....ON",             active: 0, colour: "c"), # Not yet implemented
	var dual_hyd_g_y_6   = status.new(msg: "-PTU................AUTO",             active: 0, colour: "c"), # Not yet implemented
	
	var single_hyd_b     = status.new(msg: "APPR PROC HYD LO PR",                  active: 0, colour: "a"), # Not yet implemented
	var single_hyd_b_2   = status.new(msg: "   •IF BLUE OVHT OUT:",                active: 0, colour: "w"), # Not yet implemented
	var single_hyd_b_3   = status.new(msg: "-BLUE ELEC PUMP.....AUTO",             active: 0, colour: "c"), # Not yet implemented
	
	var single_hyd_g     = status.new(msg: "APPR PROC HYD LO PR",                  active: 0, colour: "a"), # Not yet implemented
	var single_hyd_g_2   = status.new(msg: "   •IF GREEN OVHT OUT:",               active: 0, colour: "w"), # Not yet implemented
	var single_hyd_g_3   = status.new(msg: "-GREEN ENG 1 PUMP.....ON",             active: 0, colour: "c"), # Not yet implemented
	var single_hyd_g_4   = status.new(msg: "-PTU................AUTO",             active: 0, colour: "c"), # Not yet implemented
	
	var single_hyd_y     = status.new(msg: "APPR PROC HYD LO PR",                  active: 0, colour: "a"), # Not yet implemented
	var single_hyd_y_2   = status.new(msg: "   •IF YELLOW OVHT OUT:",              active: 0, colour: "w"), # Not yet implemented
	var single_hyd_y_3   = status.new(msg: "-YELLOW ENG 1 PUMP....ON",             active: 0, colour: "c"), # Not yet implemented
	var single_hyd_y_4   = status.new(msg: "-PTU................AUTO",             active: 0, colour: "c"), # Not yet implemented
	
	var avionics_smk     = status.new(msg: "APPR PROC:",                           active: 0, colour: "w"), # Not yet implemented
	var avionics_smk_2   = status.new(msg: "   •BEFORE L/G EXTENSION :",           active: 0, colour: "w"), # Not yet implemented
	var avionics_smk_2   = status.new(msg: "-GEN 2...............ON",              active: 0, colour: "c"), # Not yet implemented
	var avionics_smk_4   = status.new(msg: "-EMER ELEC GEN1 LINE ON",              active: 0, colour: "c"), # Not yet implemented
	
	var ths_stuck        = status.new(msg: "APPR PROC:",                           active: 0, colour: "w"), # Not yet implemented
	var ths_stuck_2      = status.new(msg: "-FOR LDG.....USE FLAP 3",              active: 0, colour: "c"), # Not yet implemented
	var ths_stuck_3      = status.new(msg: "-GPWS LDG FLAP 3.....ON",              active: 0, colour: "c"), # Not yet implemented
	var ths_stuck_4      = status.new(msg: " •IF MAN TRIM NOT AVAIL:",             active: 0, colour: "w"), # Not yet implemented
	var ths_stuck_5      = status.new(msg: " •WHEN CONF3 AND VAPP  :",             active: 0, colour: "w"), # Not yet implemented
	var ths_stuck_6      = status.new(msg: "-L/G.................DN",              active: 0, colour: "c"), # Not yet implemented
	
	var flap_stuck       = status.new(msg: "APPR PROC:",                           active: 0, colour: "w"), # Not yet implemented
	var flap_stuck_2     = status.new(msg: "-FOR LDG.....USE FLAP 3",              active: 0, colour: "c"), # Not yet implemented
	var flap_stuck_3     = status.new(msg: "-FLAPS...KEEP CONF FULL",              active: 0, colour: "c"), # Not yet implemented
	var flap_stuck_4     = status.new(msg: "-GPWS FLAP MODE.....OFF",              active: 0, colour: "c"), # Not yet implemented
	var flap_stuck_5     = status.new(msg: "-GPWS LDG FLAP 3.....ON",              active: 0, colour: "c"), # Not yet implemented
	
	var slat_stuck       = status.new(msg: "APPR PROC:",                           active: 0, colour: "w"), # Not yet implemented
	var slat_stuck_2     = status.new(msg: "-FOR LDG.....USE FLAP 1",              active: 0, colour: "c"), # Not yet implemented
	var slat_stuck_3     = status.new(msg: "-FOR LDG.....USE FLAP 3",              active: 0, colour: "c"), # Not yet implemented
	var slat_stuck_4     = status.new(msg: "-CTR TK PUMPS.......OFF",              active: 0, colour: "c"), # Not yet implemented
	var slat_stuck_5     = status.new(msg: "-GPWS LDG FLAP 3.....ON",              active: 0, colour: "c"), # Not yet implemented
	var slat_stuck_6     = status.new(msg: "-GPWS FLAP MODE.....OFF",              active: 0, colour: "c"), # Not yet implemented

	var fctl_proc        = status.new(msg: "APPR PROC:",                           active: 0, colour: "w"), # Not yet implemented
	var fctl_proc_2      = status.new(msg: " •IF BUFFET:",                         active: 0, colour: "w"), # Not yet implemented
	var fctl_proc_3      = status.new(msg: "-FOR LDG.....USE FLAP 3",              active: 0, colour: "c"), # Not yet implemented
	var fctl_proc_4      = status.new(msg: "-GPWS LDG FLAP 3.....ON",              active: 0, colour: "c"), # Not yet implemented
	var fctl_proc_5      = status.new(msg: "-AT 1000FT AGL:L/G...DN",              active: 0, colour: "c"), # Not yet implemented
	
	var rev_unlc_proc    = status.new(msg: "APPR PROC:",                           active: 0, colour: "w"), # Not yet implemented
	var rev_unlc_proc_2  = status.new(msg: " •IF BUFFET:",                         active: 0, colour: "w"), # Not yet implemented
	var rev_unlc_proc_3  = status.new(msg: "-FOR LDG.....USE FLAP 3",              active: 0, colour: "c"), # Not yet implemented
	var rev_unlc_proc_4  = status.new(msg: "-APPR SPD : VREF + 55KT",              active: 0, colour: "c"), # Not yet implemented
	var rev_unlc_proc_5  = status.new(msg: "-APPR SPD : VREF + 60KT",              active: 0, colour: "c"), # Not yet implemented
	var rev_unlc_proc_6  = status.new(msg: "-RUD TRIM.......5 DEG R",              active: 0, colour: "c"), # Not yet implemented
	var rev_unlc_proc_7  = status.new(msg: "-RUD TRIM.......5 DEG L",              active: 0, colour: "c"), # Not yet implemented
	var rev_unlc_proc_8  = status.new(msg: "-ATHR...............OFF",              active: 0, colour: "c"), # Not yet implemented
	var rev_unlc_proc_9  = status.new(msg: "-GPWS FLAP MODE.....OFF",              active: 0, colour: "c"), # Not yet implemented
	var rev_unlc_proc_10 = status.new(msg: " •WHEN LDG ASSURED:",                  active: 0, colour: "w"), # Not yet implemented
	var rev_unlc_proc_11 = status.new(msg: "-L/G...............DOWN",              active: 0, colour: "c"), # Not yet implemented
	var rev_unlc_proc_12 = status.new(msg: " •AT 800FT AGL:",                      active: 0, colour: "w"), # Not yet implemented
	var rev_unlc_proc_13 = status.new(msg: "-TARGET SPD : VREF+40KT",              active: 0, colour: "c"), # Not yet implemented
	var rev_unlc_proc_14 = status.new(msg: "-TARGET SPD : VREF+45KT",              active: 0, colour: "c"), # Not yet implemented
	
	var thr_lvr_flt      = status.new(msg: "APPR PROC THR LEVER",                  active: 0, colour: "a"), # Not yet implemented
	var thr_lvr_flt_2    = status.new(msg: "-AUTOLAND...........USE",              active: 0, colour: "c"), # Not yet implemented
	var thr_lvr_flt_3    = status.new(msg: " •IF AUTOLAND NOT USED:",              active: 0, colour: "w"), # Not yet implemented
	var thr_lvr_flt_4    = status.new(msg: "   •AT 500FT AGL :",                   active: 0, colour: "w"), # Not yet implemented
	var thr_lvr_flt_5    = status.new(msg: "-ENG MASTER 1.......OFF",              active: 0, colour: "c"), # Not yet implemented
	var thr_lvr_flt_6    = status.new(msg: "-ENG MASTER 2.......OFF",              active: 0, colour: "c"), # Not yet implemented
	
	var fuel_ctl_flt     = status.new(msg: "APPR PROC FUEL CTL FAULT",             active: 0, colour: "a"), # Not yet implemented
	var fuel_ctl_flt_2   = status.new(msg: "REV 1........DO NOT USE",              active: 0, colour: "w"), # Not yet implemented
	var fuel_ctl_flt_3   = status.new(msg: "REV 2........DO NOT USE",              active: 0, colour: "w"), # Not yet implemented
	var fuel_ctl_flt_4   = status.new(msg: " •AFTER TOUCHDOWN:",                   active: 0, colour: "w"), # Not yet implemented
	var fuel_ctl_flt_5   = status.new(msg: "-ENG MASTER 1.......OFF",              active: 0, colour: "c"), # Not yet implemented
	var fuel_ctl_flt_6   = status.new(msg: "-ENG MASTER 2.......OFF",              active: 0, colour: "c"), # Not yet implemented
]);

var statusProc           = std.Vector.new();
var statusInfo           = std.Vector.new();
var statusCancelled      = std.Vector.new();
var statusInop           = std.Vector.new();
var statusMaintenance    = std.Vector.new();