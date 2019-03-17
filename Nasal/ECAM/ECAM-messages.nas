# A3XX Electronic Centralised Aircraft Monitoring System

# Copyright (c) 2019 Jonathan Redpath (legoboyvdlp)

# messages stored in vectors

# Lights: 0 = red, 1 = yellow, 9 = none
# Sounds: 0 = master warn, 1 = chime, 9 = other

# Left E/WD

var warnings				  = std.Vector.new([
	var flap_not_zero         = warning.new(msg: "F/CTL FLAP LVR NOT ZERO",   colour: "r", aural: 0, light: 0),
	
	# DUAL ENG FAIL
	var dualFail              = warning.new(msg: "ENG DUAL FAILURE",          colour: "r", aural: 0, light: 0),
	var dualFailModeSel       = warning.new(msg: " -ENG MODE SEL.......IGN",  colour: "c", aural: 9, light: 9),
	var dualFailLevers        = warning.new(msg: " -THR LEVERS........IDLE",  colour: "c", aural: 9, light: 9),
	var dualFailRelightSPD    = warning.new(msg: " OPTIMUM RELIGHT SPD.280",  colour: "c", aural: 9, light: 9),
	var dualFailRelightSPDCFM = warning.new(msg: " OPTIMUM RELIGHT SPD.300",  colour: "c", aural: 9, light: 9),
	var dualFailElec          = warning.new(msg: " -EMER ELEC PWR...MAN ON",  colour: "c", aural: 9, light: 9),
	var dualFailRadio         = warning.new(msg: " -VHF1/ATC1..........USE",  colour: "c", aural: 9, light: 9),
	var dualFailFAC           = warning.new(msg: " -FAC 1......OFF THEN ON",  colour: "c", aural: 9, light: 9),
	var dualFailRelight       = warning.new(msg: "•IF NO RELIGHT AFTER 30S",  colour: "w", aural: 9, light: 9),
	var dualFailMasters       = warning.new(msg: " -ENG MASTERS.OFF 30S/ON",  colour: "c", aural: 9, light: 9),
	var dualFailSuccess       = warning.new(msg: "   •IF UNSUCCESSFUL :   ",  colour: "w", aural: 9, light: 9),
	var dualFailAPU           = warning.new(msg: " -APU (IF AVAIL)...START",  colour: "c", aural: 9, light: 9),
	var dualFailMastersAPU    = warning.new(msg: " -ENG MASTERS.OFF 30S/ON",  colour: "c", aural: 9, light: 9),
	var dualFailSPDGD         = warning.new(msg: " OPTIMUM SPEED.....G DOT",  colour: "c", aural: 9, light: 9),
	var dualFailAPPR          = warning.new(msg: "    •EARLY IN APPR :    ",  colour: "w", aural: 9, light: 9),
	var dualFailcabin         = warning.new(msg: " -CAB SECURE.......ORDER",  colour: "c", aural: 9, light: 9),
	var dualFailrudd          = warning.new(msg: " -USE RUDDER WITH CARE  ",  colour: "c", aural: 9, light: 9),
	var dualFailflap          = warning.new(msg: " -FOR LDG.....USE FLAP 3",  colour: "c", aural: 9, light: 9),
	var dualFail5000          = warning.new(msg: "   •AT 5000 FT AGL :    ",  colour: "w", aural: 9, light: 9),
	var dualFailgear          = warning.new(msg: " -L/G.........GRVTY EXTN",  colour: "c", aural: 9, light: 9),
	var dualFailfinalspeed    = warning.new(msg: " TARGET SPEED.....150 KT",  colour: "c", aural: 9, light: 9),
	var dualFailtouch         = warning.new(msg: "    •AT TOUCH DOWN :    ",  colour: "w", aural: 9, light: 9),
	var dualFailmasteroff     = warning.new(msg: " -ENG MASTERS........OFF",  colour: "c", aural: 9, light: 9),
	var dualFailapuoff        = warning.new(msg: " -APU MASTER SW......OFF",  colour: "c", aural: 9, light: 9),
	var dualFailevac          = warning.new(msg: " -EVAC..........INITIATE",  colour: "c", aural: 9, light: 9),
	var dualFailbatt          = warning.new(msg: " -BAT 1+2............OFF",  colour: "c", aural: 9, light: 9),
	
	# Config
	var slats_config          = warning.new(msg: "CONFIG",                    colour: "r", aural: 0, light: 0),
	var slats_config_1        = warning.new(msg: "SLATS NOT IN T.O. CONFIG",  colour: "r", aural: 0, light: 0),
	var flaps_config          = warning.new(msg: "CONFIG",                    colour: "r", aural: 0, light: 0),
	var flaps_config_1        = warning.new(msg: "FLAPS NOT IN T.O. CONFIG",  colour: "r", aural: 0, light: 0),
	var spd_brk_config        = warning.new(msg: "CONFIG",                    colour: "r", aural: 0, light: 0),
	var spd_brk_config_1      = warning.new(msg: "SPD BRK NOT RETRACTED",     colour: "r", aural: 0, light: 0),
	var pitch_trim_config     = warning.new(msg: "CONFIG PITCH TRIM",         colour: "r", aural: 0, light: 0),
	var pitch_trim_config_1   = warning.new(msg: "   NOT IN T.O. RANGE",      colour: "r", aural: 0, light: 0),
	var rud_trim_config       = warning.new(msg: "CONFIG RUD TRIM",           colour: "r", aural: 0, light: 0),
	var rud_trim_config_1     = warning.new(msg: "   NOT IN T.O. RANGE",      colour: "r", aural: 0, light: 0),
	var park_brk_config       = warning.new(msg: "CONFIG PARK BRK ON",        colour: "r", aural: 0, light: 0),
	
	# Autopilot
	var ap_offw				  = warning.new(msg: "AUTO FLT AP OFF",			  colour: "r", aural: 9, light: 0),
	var athr_offw			  = warning.new(msg: "AUTO FLT A/THR OFF", 	      colour: "a", aural: 1, light: 1),
	var athr_offw_1			  = warning.new(msg: "-THR LEVERS........MOVE",   colour: "c", aural: 9, light: 9),
	var athr_lock			  = warning.new(msg: "ENG THRUST LOCKED", 		  colour: "a", aural: 1, light: 1),
	var athr_lock_1			  = warning.new(msg: "-THR LEVERS........MOVE",   colour: "c", aural: 9, light: 9),
	var athr_lim			  = warning.new(msg: "AUTO FLT A/THR LIMITED",    colour: "a", aural: 1, light: 1),
	var athr_lim_1			  = warning.new(msg: "-THR LEVERS........MOVE",   colour: "c", aural: 9, light: 9)
]);

var leftmemos                 = std.Vector.new([
	var company_alert         = warning.new(msg: "COMPANY ALERT",             colour: "g", aural: 9, light: 9), # Not yet implemented, buzzer sound
	var refuelg               = warning.new(msg: "REFUELG",                   colour: "g", aural: 9, light: 9),
	var irs_in_align          = warning.new(msg: "IRS IN ALIGN",              colour: "g", aural: 9, light: 9), # Not yet implemented
	var gnd_splrs             = warning.new(msg: "GND SPLRS ARMED",           colour: "g", aural: 9, light: 9),
	var seatbelts             = warning.new(msg: "SEAT BELTS",                colour: "g", aural: 9, light: 9),
	var nosmoke               = warning.new(msg: "NO SMOKING",                colour: "g", aural: 9, light: 9),
	var strobe_lt_off         = warning.new(msg: "STROBE LT OFF",             colour: "g", aural: 9, light: 9),
	var outr_tk_fuel_xfrd     = warning.new(msg: "OUTR TK FUEL XFRD",         colour: "g", aural: 9, light: 9), # Not yet implemented
	var fob_3T                = warning.new(msg: "FOB BELOW 3T",              colour: "g", aural: 9, light: 9),
	var gpws_flap_mode_off    = warning.new(msg: "GPWS FLAP MODE OFF",        colour: "g", aural: 9, light: 9),
	var atc_datalink_stby     = warning.new(msg: "ATC DATALINK STBY",         colour: "g", aural: 9, light: 9), # Not yet implemented
	var company_datalink_stby = warning.new(msg: "COMPANY DATALINK STBY",     colour: "g", aural: 9, light: 9)  # Not yet implemented
]);

# Right E/WD

var specialLines         = std.Vector.new([
	var to_inhibit       = memo.new(msg: "T.O. INHIBIT",  colour: "m"),
	var ldg_inhibit      = memo.new(msg: "LDG INHIBIT",   colour: "m"),
	var land_asap_r      = memo.new(msg: "LAND ASAP",     colour: "r"),
	var land_asap_a      = memo.new(msg: "LAND ASAP",     colour: "a"),
	var ap_off           = memo.new(msg: "AP OFF",        colour: "r"),
	var athr_off         = memo.new(msg: "A/THR OFF",     colour: "a")
]);

var secondaryFailures    = std.Vector.new([
	var secondary_bleed  = memo.new(msg: "•AIR BLEED",   colour: "a"), # Not yet implemented
	var secondary_press  = memo.new(msg: "•CAB PRESS",   colour: "a"), # Not yet implemented
	var secondary_vent   = memo.new(msg: "•AVNCS VENT",  colour: "a"), # Not yet implemented
	var secondary_elec   = memo.new(msg: "•ELEC",        colour: "a"), # Not yet implemented
	var secondary_hyd    = memo.new(msg: "•HYD",         colour: "a"), # Not yet implemented
	var secondary_fuel   = memo.new(msg: "•FUEL",        colour: "a"), # Not yet implemented
	var secondary_cond   = memo.new(msg: "•AIR COND",    colour: "a"), # Not yet implemented
	var secondary_brake  = memo.new(msg: "•BRAKES",      colour: "a"), # Not yet implemented
	var secondary_wheel  = memo.new(msg: "•WHEEL",       colour: "a"), # Not yet implemented
	var secondary_fctl   = memo.new(msg: "•F/CTL",       colour: "a")  # Not yet implemented
]);

var memos                = std.Vector.new([
	var spd_brk          = memo.new(msg: "SPEED BRK",     colour: "g"),  
	var park_brk         = memo.new(msg: "PARK BRK",      colour: "g"),
	var ptu              = memo.new(msg: "HYD PTU",       colour: "g"),
	var rat              = memo.new(msg: "RAT OUT",       colour: "g"),
	var emer_gen         = memo.new(msg: "EMER GEN",      colour: "g"),
	var ram_air          = memo.new(msg: "RAM AIR ON",    colour: "g"),
	var nw_strg_disc     = memo.new(msg: "NW STRG DISC",  colour: "g"),
	var ignition         = memo.new(msg: "IGNITION",      colour: "g"),
	var cabin_ready      = memo.new(msg: "CABIN READY",   colour: "g"), # Not yet implemented
	var pred_ws_off      = memo.new(msg: "PRED W/S OFF",  colour: "g"), # Not yet implemented
	var terr_stby        = memo.new(msg: "TERR STBY",     colour: "g"), # Not yet implemented
	var tcas_stby        = memo.new(msg: "TCAS STBY",     colour: "g"), # Not yet implemented
	var acars_call       = memo.new(msg: "ACARS CALL",    colour: "g"), # Not yet implemented
	var company_call     = memo.new(msg: "COMPANY CALL",  colour: "g"), # Not yet implemented
	var satcom_alert     = memo.new(msg: "SATCOM ALERT",  colour: "g"), # Not yet implemented
	var acars_msg        = memo.new(msg: "ACARS MSG",     colour: "g"), # Not yet implemented
	var company_msg      = memo.new(msg: "COMPANY MSG",   colour: "g"), # Not yet implemented
	var eng_aice         = memo.new(msg: "ENG A.ICE",     colour: "g"),
	var wing_aice        = memo.new(msg: "WING A.ICE",    colour: "g"),
	var ice_not_det      = memo.new(msg: "ICE NOT DET",   colour: "g"), # Not yet implemented
	var hi_alt           = memo.new(msg: "HI ALT",        colour: "g"), # Not yet implemented
	var apu_avail        = memo.new(msg: "APU AVAIL",     colour: "g"),
	var apu_bleed        = memo.new(msg: "APU BLEED",     colour: "g"),
	var ldg_lt           = memo.new(msg: "LDG LT",        colour: "g"),
	var brk_fan          = memo.new(msg: "BRK FAN",       colour: "g"), # Not yet implemented
	var audio3_xfrd      = memo.new(msg: "AUDIO 3 XFRD",  colour: "g"), # Not yet implemented
	var switchg_pnl      = memo.new(msg: "SWITCHG PNL",   colour: "g"), # Not yet implemented
	var gpws_flap3       = memo.new(msg: "GPWS FLAP 3",   colour: "g"), 
	var hf_data_ovrd     = memo.new(msg: "HF DATA OVRD",  colour: "g"), # Not yet implemented
	var hf_voice         = memo.new(msg: "HF VOICE",      colour: "g"), # Not yet implemented
	var acars_stby       = memo.new(msg: "ACARS STBY",    colour: "g"), # Not yet implemented
	var vhf3_voice       = memo.new(msg: "VHF3 VOICE",    colour: "g"),
	var auto_brk_lo      = memo.new(msg: "AUTO BRK LO",   colour: "g"),
	var auto_brk_med     = memo.new(msg: "AUTO BRK MED",  colour: "g"),
	var auto_brk_max     = memo.new(msg: "AUTO BRK MAX",  colour: "g"),
	var auto_brk_off     = memo.new(msg: "AUTO BRK OFF",  colour: "g"), # Not yet implemented
	var man_ldg_elev     = memo.new(msg: "MAN LDG ELEV",  colour: "g"), # Not yet implemented
	var ctr_tk_feedg     = memo.new(msg: "CTR TK FEEDG",  colour: "g"),
	var fuelx            = memo.new(msg: "FUEL X FEED",   colour: "g")
]);

var clearWarnings        = std.Vector.new();

# Status SD page
var statusLim            = std.Vector.new([
	var min_rat_spd      = status.new(msg: "MIN RAT SPD.....140 KT",     colour: "c"), # Not yet implemented
	var max_spd_gear     = status.new(msg: "MAX SPD........280/.67",     colour: "c"), # Not yet implemented
	var max_spd_rev      = status.new(msg: "MAX SPD........300/.78",     colour: "c"), # Not yet implemented
	var buffet_rev       = status.new(msg: "   •IF BUFFET :",            colour: "w"), # Not yet implemented
	var max_spd_rev_buf  = status.new(msg: "MAX SPD.............240",    colour: "c"), # Not yet implemented
	var max_spd_fctl     = status.new(msg: "MAX SPD........320/.77",     colour: "c"), # Not yet implemented
	var max_spd_fctl2    = status.new(msg: "MAX SPD.........300 KT",     colour: "c"), # Not yet implemented
	var max_spd_gr_door  = status.new(msg: "MAX SPD 250/.60",            colour: "c"), # Not yet implemented
	var max_alt_press    = status.new(msg: "MAX FL : 100/MEA",           colour: "c"), # Not yet implemented
	var gravity_fuel     = status.new(msg: "-PROC:GRAVTY FUEL FEEDING",  colour: "c"), # Not yet implemented
	var gear_kp_dn       = status.new(msg: "L/G............KEEP DOWN",   colour: "c"), # Not yet implemented
	var park_brk_only    = status.new(msg: "PARK BRK ONLY",              colour: "c"), # Not yet implemented
	var park_brk_only    = status.new(msg: "MAX BRK PR........1000PSI",  colour: "c"), # Not yet implemented
	var fuel_gravity     = status.new(msg: "FUEL GRAVTY FEED",           colour: "c"), # Not yet implemented
	var fctl_manvr       = status.new(msg: "MANOEUVER WITH CARE",        colour: "c"), # Not yet implemented
	var fctl_spdbrk_care = status.new(msg: "USE SPD BRK WITH CARE",      colour: "c"), # Not yet implemented
	var fctl_spdbrk_dont = status.new(msg: "SPD BRK......DO NOT USE",    colour: "c"), # Not yet implemented
	var fctl_rud_care    = status.new(msg: "RUD WITH CARE ABV 160KT",    colour: "c"), # Not yet implemented
	var eng_thr_changes  = status.new(msg: "AVOID RAPID THR CHANGES",    colour: "c"), # Not yet implemented
	var avoid_neg_g_fac  = status.new(msg: "AVOID NEGATIVE G FACTOR",    colour: "c"), # Not yet implemented
	var avoid_icing      = status.new(msg: "AVOID ICING CONDITONS",      colour: "c"), # Not yet implemented
	var severe_icing     = status.new(msg: " IF A/C ICING SEVERE :",     colour: "w"), # Not yet implemented, a319 only
	var severe_icing_2   = status.new(msg: "MIN SPD ALPHA PROT",         colour: "c"), # Not yet implemented, a319 only
	var avoid_thr_chg    = status.new(msg: "AVOID THR CHANGES",          colour: "c"), # Not yet implemented, iae only
	var avoid_thr_chg_2  = status.new(msg: "AVOID RAPID THR CHANGES",    colour: "c"), # Not yet implemented, iae only
	var avoid_adv_cond   = status.new(msg: "AVOID ADVERSE CONDITIONS",   colour: "c"), # Not yet implemented, iae only
	var atc_com_voice    = status.new(msg: "ATC COM VOICE ONLY",         colour: "c") # Not yet implemented, iae only
]);

var statusApprProc       = std.Vector.new([
	var dual_hyd_b_g     = status.new(msg: "APPR PROC DUAL HYD LO PR",              colour: "r"), # Not yet implemented
	var dual_hyd_b_g_2   = status.new(msg: "   •IF BLUE OVHT OUT:",                 colour: "w"), # Not yet implemented
	var dual_hyd_b_g_3   = status.new(msg: "-BLUE ELEC PUMP.....AUTO",              colour: "c"), # Not yet implemented
	var dual_hyd_b_g_4   = status.new(msg: "   •IF GREEN OVHT OUT:",                colour: "w"), # Not yet implemented
	var dual_hyd_b_g_5   = status.new(msg: "-GREEN ENG 1 PUMP.....ON",              colour: "c"), # Not yet implemented
	var dual_hyd_b_g_6   = status.new(msg: "-PTU................AUTO",              colour: "c"), # Not yet implemented
	
	var dual_hyd_b_y     = status.new(msg: "APPR PROC DUAL HYD LO PR",              colour: "r"), # Not yet implemented
	var dual_hyd_b_y_2   = status.new(msg: "   •IF BLUE OVHT OUT:",                 colour: "w"), # Not yet implemented
	var dual_hyd_b_y_3   = status.new(msg: "-BLUE ELEC PUMP.....AUTO",              colour: "c"), # Not yet implemented
	var dual_hyd_b_y_4   = status.new(msg: "   •IF YELLOW OVHT OUT:",               colour: "w"), # Not yet implemented
	var dual_hyd_b_y_5   = status.new(msg: "-YELLOW ENG 2 PUMP....ON",              colour: "c"), # Not yet implemented
	var dual_hyd_b_y_6   = status.new(msg: "-PTU................AUTO",              colour: "c"), # Not yet implemented
	
	var dual_hyd_g_y     = status.new(msg: "APPR PROC DUAL HYD LO PR",              colour: "r"), # Not yet implemented
	var dual_hyd_g_y_2   = status.new(msg: "   •IF GREEN OVHT OUT:",                colour: "w"), # Not yet implemented
	var dual_hyd_b_y_3   = status.new(msg: "-GREEN ENG 1 PUMP.....ON",              colour: "c"), # Not yet implemented
	var dual_hyd_g_y_4   = status.new(msg: "   •IF YELLOW OVHT OUT:",               colour: "w"), # Not yet implemented
	var dual_hyd_g_y_5   = status.new(msg: "-YELLOW ENG 2 PUMP....ON",              colour: "c"), # Not yet implemented
	var dual_hyd_g_y_6   = status.new(msg: "-PTU................AUTO",              colour: "c"), # Not yet implemented
	
	var single_hyd_b     = status.new(msg: "APPR PROC HYD LO PR",                   colour: "a"), # Not yet implemented
	var single_hyd_b_2   = status.new(msg: "   •IF BLUE OVHT OUT:",                 colour: "w"), # Not yet implemented
	var single_hyd_b_3   = status.new(msg: "-BLUE ELEC PUMP.....AUTO",              colour: "c"), # Not yet implemented
	
	var single_hyd_g     = status.new(msg: "APPR PROC HYD LO PR",                   colour: "a"), # Not yet implemented
	var single_hyd_g_2   = status.new(msg: "   •IF GREEN OVHT OUT:",                colour: "w"), # Not yet implemented
	var single_hyd_g_3   = status.new(msg: "-GREEN ENG 1 PUMP.....ON",              colour: "c"), # Not yet implemented
	var single_hyd_g_4   = status.new(msg: "-PTU................AUTO",              colour: "c"), # Not yet implemented
	
	var single_hyd_y     = status.new(msg: "APPR PROC HYD LO PR",                   colour: "a"), # Not yet implemented
	var single_hyd_y_2   = status.new(msg: "   •IF YELLOW OVHT OUT:",               colour: "w"), # Not yet implemented
	var single_hyd_y_3   = status.new(msg: "-YELLOW ENG 1 PUMP....ON",              colour: "c"), # Not yet implemented
	var single_hyd_y_4   = status.new(msg: "-PTU................AUTO",              colour: "c"), # Not yet implemented
	
	var avionics_smk     = status.new(msg: "APPR PROC:",                            colour: "w"), # Not yet implemented
	var avionics_smk_2   = status.new(msg: "   •BEFORE L/G EXTENSION :",            colour: "w"), # Not yet implemented
	var avionics_smk_2   = status.new(msg: "-GEN 2...............ON",               colour: "c"), # Not yet implemented
	var avionics_smk_4   = status.new(msg: "-EMER ELEC GEN1 LINE ON",               colour: "c"), # Not yet implemented
	
	var ths_stuck        = status.new(msg: "APPR PROC:",                            colour: "w"), # Not yet implemented
	var ths_stuck_2      = status.new(msg: "-FOR LDG.....USE FLAP 3",               colour: "c"), # Not yet implemented
	var ths_stuck_3      = status.new(msg: "-GPWS LDG FLAP 3.....ON",               colour: "c"), # Not yet implemented
	var ths_stuck_4      = status.new(msg: " •IF MAN TRIM NOT AVAIL:",              colour: "w"), # Not yet implemented
	var ths_stuck_5      = status.new(msg: " •WHEN CONF3 AND VAPP  :",              colour: "w"), # Not yet implemented
	var ths_stuck_6      = status.new(msg: "-L/G.................DN",               colour: "c"), # Not yet implemented
	
	var flap_stuck       = status.new(msg: "APPR PROC:",                            colour: "w"), # Not yet implemented
	var flap_stuck_2     = status.new(msg: "-FOR LDG.....USE FLAP 3",               colour: "c"), # Not yet implemented
	var flap_stuck_3     = status.new(msg: "-FLAPS...KEEP CONF FULL",               colour: "c"), # Not yet implemented
	var flap_stuck_4     = status.new(msg: "-GPWS FLAP MODE.....OFF",               colour: "c"), # Not yet implemented
	var flap_stuck_5     = status.new(msg: "-GPWS LDG FLAP 3.....ON",               colour: "c"), # Not yet implemented
	
	var slat_stuck       = status.new(msg: "APPR PROC:",                            colour: "w"), # Not yet implemented
	var slat_stuck_2     = status.new(msg: "-FOR LDG.....USE FLAP 1",               colour: "c"), # Not yet implemented
	var slat_stuck_3     = status.new(msg: "-FOR LDG.....USE FLAP 3",               colour: "c"), # Not yet implemented
	var slat_stuck_4     = status.new(msg: "-CTR TK PUMPS.......OFF",               colour: "c"), # Not yet implemented
	var slat_stuck_5     = status.new(msg: "-GPWS LDG FLAP 3.....ON",               colour: "c"), # Not yet implemented
	var slat_stuck_6     = status.new(msg: "-GPWS FLAP MODE.....OFF",               colour: "c"), # Not yet implemented

	var fctl_proc        = status.new(msg: "APPR PROC:",                            colour: "w"), # Not yet implemented
	var fctl_proc_2      = status.new(msg: " •IF BUFFET:",                          colour: "w"), # Not yet implemented
	var fctl_proc_3      = status.new(msg: "-FOR LDG.....USE FLAP 3",               colour: "c"), # Not yet implemented
	var fctl_proc_4      = status.new(msg: "-GPWS LDG FLAP 3.....ON",               colour: "c"), # Not yet implemented
	var fctl_proc_5      = status.new(msg: "-AT 1000FT AGL:L/G...DN",               colour: "c"), # Not yet implemented
	
	var rev_unlc_proc    = status.new(msg: "APPR PROC:",                            colour: "w"), # Not yet implemented
	var rev_unlc_proc_2  = status.new(msg: " •IF BUFFET:",                          colour: "w"), # Not yet implemented
	var rev_unlc_proc_3  = status.new(msg: "-FOR LDG.....USE FLAP 3",               colour: "c"), # Not yet implemented
	var rev_unlc_proc_4  = status.new(msg: "-APPR SPD : VREF + 55KT",               colour: "c"), # Not yet implemented
	var rev_unlc_proc_5  = status.new(msg: "-APPR SPD : VREF + 60KT",               colour: "c"), # Not yet implemented
	var rev_unlc_proc_6  = status.new(msg: "-RUD TRIM.......5 DEG R",               colour: "c"), # Not yet implemented
	var rev_unlc_proc_7  = status.new(msg: "-RUD TRIM.......5 DEG L",               colour: "c"), # Not yet implemented
	var rev_unlc_proc_8  = status.new(msg: "-ATHR...............OFF",               colour: "c"), # Not yet implemented
	var rev_unlc_proc_9  = status.new(msg: "-GPWS FLAP MODE.....OFF",               colour: "c"), # Not yet implemented
	var rev_unlc_proc_10 = status.new(msg: " •WHEN LDG ASSURED:",                   colour: "w"), # Not yet implemented
	var rev_unlc_proc_11 = status.new(msg: "-L/G...............DOWN",               colour: "c"), # Not yet implemented
	var rev_unlc_proc_12 = status.new(msg: " •AT 800FT AGL:",                       colour: "w"), # Not yet implemented
	var rev_unlc_proc_13 = status.new(msg: "-TARGET SPD : VREF+40KT",               colour: "c"), # Not yet implemented
	var rev_unlc_proc_14 = status.new(msg: "-TARGET SPD : VREF+45KT",               colour: "c"), # Not yet implemented
	
	var thr_lvr_flt      = status.new(msg: "APPR PROC THR LEVER",                   colour: "a"), # Not yet implemented
	var thr_lvr_flt_2    = status.new(msg: "-AUTOLAND...........USE",               colour: "c"), # Not yet implemented
	var thr_lvr_flt_3    = status.new(msg: " •IF AUTOLAND NOT USED:",               colour: "w"), # Not yet implemented
	var thr_lvr_flt_4    = status.new(msg: "   •AT 500FT AGL :",                    colour: "w"), # Not yet implemented
	var thr_lvr_flt_5    = status.new(msg: "-ENG MASTER 1.......OFF",               colour: "c"), # Not yet implemented
	var thr_lvr_flt_6    = status.new(msg: "-ENG MASTER 2.......OFF",               colour: "c"), # Not yet implemented
	
	var fuel_ctl_flt     = status.new(msg: "APPR PROC FUEL CTL FAULT",              colour: "a"), # Not yet implemented
	var fuel_ctl_flt_2   = status.new(msg: "REV 1........DO NOT USE",               colour: "w"), # Not yet implemented
	var fuel_ctl_flt_3   = status.new(msg: "REV 2........DO NOT USE",               colour: "w"), # Not yet implemented
	var fuel_ctl_flt_4   = status.new(msg: " •AFTER TOUCHDOWN:",                    colour: "w"), # Not yet implemented
	var fuel_ctl_flt_5   = status.new(msg: "-ENG MASTER 1.......OFF",               colour: "c"), # Not yet implemented
	var fuel_ctl_flt_6   = status.new(msg: "-ENG MASTER 2.......OFF",               colour: "c")  # Not yet implemented
]);

var statusProc           = std.Vector.new();
var statusInfo           = std.Vector.new();
var statusCancelled      = std.Vector.new();
var statusInop           = std.Vector.new();
var statusMaintenance    = std.Vector.new();