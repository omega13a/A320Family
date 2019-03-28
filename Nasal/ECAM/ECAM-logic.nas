# A3XX Electronic Centralised Aircraft Monitoring System

# Copyright (c) 2019 Jonathan Redpath (legoboyvdlp)

# props.nas:

var dualFailNode = props.globals.initNode("/ECAM/dual-failure-enabled", 0, "BOOL");
var phaseNode    = props.globals.getNode("/ECAM/warning-phase", 1);
var leftMsgNode  = props.globals.getNode("/ECAM/left-msg", 1);
var apWarn       = props.globals.getNode("/it-autoflight/output/ap-warning", 1);
var athrWarn     = props.globals.getNode("/it-autoflight/output/athr-warning", 1);
var emerGen      = props.globals.getNode("/controls/electrical/switches/emer-gen", 1);

var fac1Node = props.globals.getNode("/controls/fctl/fac1", 1);

# local variables
var phaseVar = nil;
var dualFailFACActive = 1;

var messages_priority_3 = func {
	phaseVar = phaseNode.getValue();
	
	# FCTL
	if ((flap_not_zero.clearFlag == 0) and phaseVar == 6 and getprop("/controls/flight/flap-lever") != 0 and getprop("/instrumentation/altimeter/indicated-altitude-ft") > 22000) {
		flap_not_zero.active = 1;
	} else {
		flap_not_zero.active = 0;
		flap_not_zero.noRepeat = 0;
		flap_not_zero.clearFlag = 0;
	}
	
	# ENG DUAL FAIL
	
	if (phaseVar >= 5 and phaseVar <= 7 and dualFailNode.getBoolValue()) {
		dualFail.active = 1;
	} elsif (dualFail.clearFlag == 1) {
		dualFail.active = 0;
		dualFail.noRepeat = 0;
		dualFail.clearFlag = 0;
		
		dualFailFACActive = 1; # reset FAC local variable
	}
	
	if (dualFail.active == 1) {
		if (getprop("/controls/engines/engine-start-switch") != 2 and dualFailModeSel.clearFlag == 0) {
			dualFailModeSel.active = 1;
		} else {
			dualFailModeSel.active = 0;
		}
		
		if (getprop("/fdm/jsbsim/fcs/throttle-lever[0]") > 0.01 and getprop("/fdm/jsbsim/fcs/throttle-lever[1]") > 0.01 and dualFailLevers.clearFlag == 0) {
			dualFailLevers.active = 1;
		} else {
			dualFailLevers.active = 0;
		}
		
		if (getprop("/options/eng") == "IAE" and dualFailRelightSPD.clearFlag == 0) {
			dualFailRelightSPD.active = 1;
		} else {
			dualFailRelightSPD.active = 0;
		}
		
		if (getprop("/options/eng") != "IAE" and dualFailRelightSPDCFM.clearFlag == 0) {
			dualFailRelightSPDCFM.active = 1;
		} else {
			dualFailRelightSPDCFM.active = 0;
		}
		
		if (emerGen.getValue() == 0 and dualFailElec.clearFlag == 0) {
			dualFailElec.active = 1;
		} else {
			dualFailElec.active = 0;
		}
		
		if (dualFailRadio.clearFlag == 0) {
			dualFailRadio.active = 1;
		} else {
			dualFailRadio.active = 0;
		}
		
		if (dualFailFACActive == 1 and dualFailFAC.clearFlag == 0) {
			dualFailFAC.active = 1;
		} else {
			dualFailFAC.active = 0;
		}
		
		if (dualFailAPU.clearFlag == 0) { # assumption - not cleared till you clear APU message
			dualFailRelight.active = 1;
			dualFailMasters.active = 1;
			dualFailSuccess.active = 1;
			dualFailAPU.active = 1;
		} else {
			dualFailRelight.active = 1;
			dualFailMasters.active = 1;
			dualFailSuccess.active = 1;
			dualFailAPU.active = 1;
		}
		
		if (dualFailMastersAPU.clearFlag == 0) {
			dualFailMastersAPU.active = 1;
		} else {
			dualFailMastersAPU.active = 0;
		}
		
		if (dualFailSPDGD.clearFlag == 0) {
			dualFailSPDGD.active = 1;
		} else {
			dualFailSPDGD.active = 0;
		}
		
		if (dualFailflap.clearFlag == 0) {
			dualFailAPPR.active = 1;
		} else {
			dualFailAPPR.active = 0;
		}
		
		if (dualFailcabin.clearFlag == 0) {
			dualFailcabin.active = 1;
		} else {
			dualFailcabin.active = 0;
		}
		
		if (dualFailrudd.clearFlag == 0) {
			dualFailrudd.active = 1;
		} else {
			dualFailrudd.active = 0;
		}
		
		if (dualFailflap.clearFlag == 0) {
			dualFailflap.active = 1;
		} else {
			dualFailflap.active = 0;
		}
		
		if (dualFailfinalspeed.clearFlag == 0) {
			dualFail5000.active = 1;
		} else {
			dualFail5000.active = 0;
		}
		
		if (dualFailgear.clearFlag == 0) {
			dualFailgear.active = 1;
		} else {
			dualFailgear.active = 0;
		}
		
		if (dualFailfinalspeed.clearFlag == 0) {
			dualFailfinalspeed.active = 1;
		} else {
			dualFailfinalspeed.active = 0;
		}
		
		dualFailtouch.active = 1;
		dualFailmasteroff.active = 1;
		dualFailapuoff.active = 1;
		dualFailevac.active = 1;
		dualFailbatt.active = 1;
	}
	
	# CONFIG
	if ((slats_config.clearFlag == 0) and (getprop("/controls/flight/flap-lever") == 0 or getprop("/controls/flight/flap-lever")) == 4 and phaseVar >= 3 and phaseVar <= 4) {
		slats_config.active = 1;
		slats_config_1.active = 1;
	} else {
		slats_config.active = 0;
		slats_config.noRepeat = 0;
		slats_config_1.active = 0;
		slats_config_1.noRepeat = 0;
	}
	
	if ((flaps_config.clearFlag == 0) and (getprop("/controls/flight/flap-lever") == 0 or getprop("/controls/flight/flap-lever") == 4) and phaseVar >= 3 and phaseVar <= 4) {
		flaps_config.active = 1;
		flaps_config_1.active = 1;
	} else {
		flaps_config.active = 0;
		flaps_config.noRepeat = 0;
		flaps_config_1.active = 0;
		flaps_config_1.noRepeat = 0;
	}
	
	if ((spd_brk_config.clearFlag == 0) and getprop("/controls/flight/speedbrake") != 0 and phaseVar >= 3 and phaseVar <= 4) {
		spd_brk_config.active = 1;
		spd_brk_config_1.active = 1;
	} else {
		spd_brk_config.active = 0;
		spd_brk_config.noRepeat = 0;
		spd_brk_config_1.active = 0;
		spd_brk_config_1.noRepeat = 0;
	}
	
	if ((pitch_trim_config.clearFlag == 0) and (getprop("/fdm/jsbsim/hydraulics/elevator-trim/final-deg") > 1.75 or getprop("/fdm/jsbsim/hydraulics/elevator-trim/final-deg") < -3.65) and phaseVar >= 3 and phaseVar <= 4) {
		pitch_trim_config.active = 1;
		pitch_trim_config_1.active = 1;
	} else {
		pitch_trim_config.active = 0;
		pitch_trim_config.noRepeat = 0;
		pitch_trim_config_1.active = 0;
		pitch_trim_config_1.noRepeat = 0;
	}
	
	if ((rud_trim_config.clearFlag == 0) and (getprop("/fdm/jsbsim/hydraulics/rudder/trim-cmd-deg") < -3.55 or getprop("/fdm/jsbsim/hydraulics/rudder/trim-cmd-deg") > 3.55) and phaseVar >= 3 and phaseVar <= 4) {
		rud_trim_config.active = 1;
		rud_trim_config_1.active = 1;
	} else {
		rud_trim_config.active = 0;
		rud_trim_config.noRepeat = 0;
		rud_trim_config_1.active = 0;
		rud_trim_config_1.noRepeat = 0;
	}
	
	if ((park_brk_config.clearFlag == 0) and getprop("/controls/gear/brake-parking") == 1 and phaseVar >= 3 and phaseVar <= 4) {
		park_brk_config.active = 1;
	} else {
		park_brk_config.active = 0;
		park_brk_config.noRepeat = 0;
	}
	
	# AUTOFLT
	if ((ap_offw.clearFlag == 0) and apWarn.getValue() == 2) {
		ap_offw.active = 1;
	} else {
		ap_offw.active = 0;
		ap_offw.noRepeat = 0;
	}
	
	if ((athr_lock.clearFlag == 0) and phaseVar >= 5 and phaseVar <= 7 and getprop("/systems/thrust/thr-locked") == 1) {
		athr_lock.active = 1;
		athr_lock_1.active = 1;
	} else {
		athr_lock.active = 0;
		athr_lock_1.active = 0;
		athr_lock.noRepeat = 0;
		athr_lock_1.noRepeat = 0;
	}
	
	if ((athr_offw.clearFlag == 0) and athrWarn.getValue() == 2 and phaseVar != 4 and phaseVar != 8 and phaseVar != 10) {
		athr_offw.active = 1;
		athr_offw_1.active = 1;
	} else {
		athr_offw.active = 0;
		athr_offw_1.active = 0;
		athr_offw.noRepeat = 0;
		athr_offw_1.noRepeat = 0;
	}
	
	if ((athr_lim.clearFlag == 0) and getprop("/it-autoflight/output/athr") == 1 and ((getprop("/systems/thrust/eng-out") != 1 and (getprop("/systems/thrust/state1") == "MAN" or getprop("/systems/thrust/state2") == "MAN")) or (getprop("/systems/thrust/eng-out") == 1 and (getprop("/systems/thrust/state1") == "MAN" or getprop("/systems/thrust/state2") == "MAN" or (getprop("/systems/thrust/state1") == "MAN THR" and getprop("/controls/engines/engine[0]/throttle-pos") <= 0.83) or (getprop("/systems/thrust/state2") == "MAN THR" and getprop("/controls/engines/engine[0]/throttle-pos") <= 0.83)))) and (phaseVar >= 5 and phaseVar <= 7)) {
		athr_lim.active = 1;
		athr_lim_1.active = 1;
	} else {
		athr_lim.active = 0;
		athr_lim_1.active = 0;
		athr_lim.noRepeat = 0;
		athr_lim_1.noRepeat = 0;
	}
}

var messages_priority_2 = func {}
var messages_priority_1 = func {}
var messages_priority_0 = func {}

var messages_memo = func {
	phaseVar = phaseNode.getValue();
	if (getprop("/services/fuel-truck/enable") == 1 and leftMsgNode.getValue() != "TO-MEMO" and leftMsgNode.getValue() != "LDG-MEMO") {
		refuelg.active = 1;
	} else {
		refuelg.active = 0;
	}
	
	if (getprop("/controls/flight/speedbrake-arm") == 1) {
		gnd_splrs.active = 1;
	} else {
		gnd_splrs.active = 0;
	}
	
	if (getprop("/controls/lighting/seatbelt-sign") == 1 and leftMsgNode.getValue() != "TO-MEMO" and leftMsgNode.getValue() != "LDG-MEMO") {
		seatbelts.active = 1;
	} else {
		seatbelts.active = 0;
	}
	
	if (getprop("/controls/lighting/no-smoking-sign") == 1 and leftMsgNode.getValue() != "TO-MEMO" and leftMsgNode.getValue() != "LDG-MEMO") { # should go off after takeoff assuming switch is in auto due to old logic from the days when smoking was allowed!
		nosmoke.active = 1;
	} else {
		nosmoke.active = 0;
	}

	if (getprop("/controls/lighting/strobe") == 0 and getprop("/gear/gear[1]/wow") == 0 and leftMsgNode.getValue() != "TO-MEMO" and leftMsgNode.getValue() != "LDG-MEMO") { # todo: use gear branch properties
		strobe_lt_off.active = 1;
	} else {
		strobe_lt_off.active = 0;
	}

	if (getprop("/consumables/fuel/total-fuel-lbs") < 6000 and leftMsgNode.getValue() != "TO-MEMO" and leftMsgNode.getValue() != "LDG-MEMO") { # assuming US short ton 2000lb
		fob_3T.active = 1;
	} else {
		fob_3T.active = 0;
	}
	
	if (getprop("instrumentation/mk-viii/inputs/discretes/momentary-flap-all-override") == 1) {
		gpws_flap_mode_off.active = 1;
	} else {
		gpws_flap_mode_off.active = 0;
	}
	
}

var messages_right_memo = func {
	phaseVar = phaseNode.getValue();
	if (phaseVar >= 3 and phaseVar <= 5) {
		to_inhibit.active = 1;
	} else {
		to_inhibit.active = 0;
	}
	
	if (phaseVar >= 7 and phaseVar <= 7) {
		ldg_inhibit.active = 1;
	} else {
		ldg_inhibit.active = 0;
	}
	
	if ((getprop("/gear/gear[1]/wow") == 0) and (getprop("/systems/failures/cargo-aft-fire") == 1 or getprop("/systems/failures/cargo-fwd-fire") == 1) or (((getprop("/systems/hydraulic/green-psi") < 1500 and getprop("/engines/engine[0]/state") == 3) and (getprop("/systems/hydraulic/yellow-psi") < 1500 and getprop("/engines/engine[1]/state") == 3)) or ((getprop("/systems/hydraulic/green-psi") < 1500 or getprop("/systems/hydraulic/yellow-psi") < 1500) and getprop("/engines/engine[0]/state") == 3 and getprop("/engines/engine[1]/state") == 3) and phaseVar >= 3 and phaseVar <= 8)) {
		# todo: emer elec
		land_asap_r.active = 1;
	} else {
		land_asap_r.active = 0;
	}
	
	if (land_asap_r.active == 0 and getprop("/gear/gear[1]/wow") == 0 and ((getprop("/fdm/jsbsim/propulsion/tank[0]/contents-lbs") < 1650 and getprop("/fdm/jsbsim/propulsion/tank[1]/contents-lbs") < 1650) or ((getprop("/systems/electrical/bus/dc2") < 25 and (getprop("/systems/failures/elac1") == 1 or getprop("/systems/failures/sec1") == 1)) or (getprop("/systems/hydraulic/green-psi") < 1500 and (getprop("/systems/failures/elac1") == 1 and getprop("/systems/failures/sec1") == 1)) or (getprop("/systems/hydraulic/yellow-psi") < 1500 and (getprop("/systems/failures/elac1") == 1 and getprop("/systems/failures/sec1") == 1)) or (getprop("/systems/hydraulic/blue-psi") < 1500 and (getprop("/systems/failures/elac2") == 1 and getprop("/systems/failures/sec2") == 1))) or (phaseVar >= 3 and phaseVar <= 8 and (getprop("/engines/engine[0]/state") != 3 or getprop("/engines/engine[1]/state") != 3)))) {
		land_asap_a.active = 1;
	} else {
		land_asap_a.active = 0;
	}
	
	if (libraries.ap_active == 1 and apWarn.getValue() == 1) {
		ap_off.active = 1;
	} else {
		ap_off.active = 0;
	}
	
	if (libraries.athr_active == 1 and athrWarn.getValue() == 1) {
		athr_off.active = 1;
	} else {
		athr_off.active = 0;
	}
	
	if ((phaseVar >= 2 and phaseVar <= 7) and getprop("controls/flight/speedbrake") != 0) {
		spd_brk.active = 1;
	} else {
		spd_brk.active = 0;
	}
	
	if (getprop("/systems/thrust/state1") == "IDLE" and getprop("/systems/thrust/state2") == "IDLE" and phaseVar >= 6 and phaseVar <= 7) {
		spd_brk.colour = "g";
	} else if ((phaseVar >= 2 and phaseVar <= 5) or ((getprop("/systems/thrust/state1") != "IDLE" or getprop("/systems/thrust/state2") != "IDLE") and (phaseVar >= 6 and phaseVar <= 7))) {
		spd_brk.colour = "a";
	}
	
	if (getprop("/controls/gear/brake-parking") == 1 and phaseVar != 3) {
		park_brk.active = 1;
	} else {
		park_brk.active = 0;
	}
	if (phaseVar >= 4 and phaseVar <= 8) {
		park_brk.colour = "a";
	} else {
		park_brk.colour = "g";
	}
	
	if (getprop("/controls/hydraulic/ptu") == 1 and ((getprop("/systems/hydraulic/yellow-psi") < 1450 and getprop("/systems/hydraulic/green-psi") > 1450 and getprop("/controls/hydraulic/elec-pump-yellow") == 0) or (getprop("/systems/hydraulic/yellow-psi") > 1450 and getprop("/systems/hydraulic/green-psi") < 1450))) {
		ptu.active = 1;
	} else {
		ptu.active = 0;
	}
	
	if (getprop("/controls/hydraulic/rat-deployed") == 1) {
		rat.active = 1;
	} else {
		rat.active = 0;
	}
	
	if (phaseVar >= 1 and phaseVar <= 2) {
		rat.colour = "a";
	} else {
		rat.colour = "g";
	}
	
	if (getprop("/sim/model/autopush/enabled") == 1) { # this message is only on when towing - not when disc with switch
		nw_strg_disc.active = 1;
	} else {
		nw_strg_disc.active = 0;
	}
	
	if (getprop("/engines/engine[0]/state") == 3 or getprop("/engines/engine[1]/state") == 3) {
		nw_strg_disc.colour = "a";
	} else {
		nw_strg_disc.colour = "g";
	}
	
	if (getprop("/controls/electrical/switches/emer-gen") == 1 and getprop("/controls/hydraulic/rat-deployed") == 1 and getprop("/gear/gear[1]/wow") == 0) {
		emer_gen.active = 1;
	} else {
		emer_gen.active = 0;
	}
	
	if (getprop("/controls/pneumatic/switches/ram-air") == 1) {
		ram_air.active = 1;
	} else {
		ram_air.active = 0;
	}

	if (getprop("/controls/engines/engine[0]/igniter-a") == 1 or getprop("/controls/engines/engine[0]/igniter-b") == 1 or getprop("/controls/engines/engine[1]/igniter-a") == 1 or getprop("/controls/engines/engine[1]/igniter-b") == 1) {
		ignition.active = 1;
	} else {
		ignition.active = 0;
	}
	
	if (getprop("/controls/pneumatic/switches/bleedapu") == 1 and getprop("/systems/apu/rpm") >= 95) {
		apu_bleed.active = 1;
	} else {
		apu_bleed.active = 0;
	}

	if (apu_bleed.active == 0 and getprop("/systems/apu/rpm") >= 95) {
		apu_avail.active = 1;
	} else {
		apu_avail.active = 0;
	}

	if (getprop("/controls/lighting/landing-lights[1]") > 0 or getprop("/controls/lighting/landing-lights[2]") > 0) {
		ldg_lt.active = 1;
	} else {
		ldg_lt.active = 0;
	}

	if (getprop("/controls/switches/leng") == 1 or getprop("/controls/switches/reng") == 1 or getprop("/systems/electrical/bus/dc1") == 0 or getprop("/systems/electrical/bus/dc2") == 0) {
		eng_aice.active = 1;
	} else {
		eng_aice.active = 0;
	}
	
	if (getprop("/controls/switches/wing") == 1) {
		wing_aice.active = 1;
	} else {
		wing_aice.active = 0;
	}
	
	if (getprop("/instrumentation/comm[2]/frequencies/selected-mhz") != 0 and (phaseVar == 1 or phaseVar == 2 or phaseVar == 6 or phaseVar == 9 or phaseVar == 10)) {
		vhf3_voice.active = 1;
	} else {
		vhf3_voice.active = 0;
	}
	if (getprop("/controls/autobrake/mode") == 1 and (phaseVar == 7 or phaseVar == 8)) {
		auto_brk_lo.active = 1;
	} else {
		auto_brk_lo.active = 0;
	}

	if (getprop("/controls/autobrake/mode") == 2 and (phaseVar == 7 or phaseVar == 8)) {
		auto_brk_med.active = 1;
	} else {
		auto_brk_med.active = 0;
	}

	if (getprop("/controls/autobrake/mode") == 3 and (phaseVar == 7 or phaseVar == 8)) {
		auto_brk_max.active = 1;
	} else {
		auto_brk_max.active = 0;
	}
	
	if (getprop("/systems/fuel/x-feed") == 1 and getprop("controls/fuel/x-feed") == 1) {
		fuelx.active = 1;
	} else {
		fuelx.active = 0;
	}
	
	if (phaseVar >= 3 and phaseVar <= 5) {
		fuelx.colour = "a";
	} else {
		fuelx.colour = "g";
	}
	
	if (getprop("/instrumentation/mk-viii/inputs/discretes/momentary-flap-3-override") == 1) { # todo: emer elec
		gpws_flap3.active = 1;
	} else {
		gpws_flap3.active = 0;
	}
	
	if (phaseVar >= 2 and phaseVar <= 9 and getprop("/systems/fuel/only-use-ctr-tank") == 1 and getprop("/systems/electrical/bus/ac1") >= 115 and getprop("/systems/electrical/bus/ac2") >= 115) {
		ctr_tk_feedg.active = 1;
	} else {
		ctr_tk_feedg.active = 0;
	}
}

# Listener
setlistener("/controls/fctl/fac1", func() {
	if (dualFail.active == 0) { return; }
	
	if (fac1Node.getBoolValue()) {
		dualFailFACActive = 0;
	} else {
		dualFailFACActive = 1;
	}
}, 0, 0);