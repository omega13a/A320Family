# A3XX Electronic Centralised Aircraft Monitoring System
# Jonathan Redpath (legoboyvdlp)

##############################################
# Copyright (c) Joshua Davidson (it0uchpods) #
##############################################

# Colors:
# 1 - Red, 2 - Amber, 3 - Cyan 4 - Green 5 - White

# Priority: 1 - LEVEL 3    2 - LEVEL 2    3 - LEVEL 1     4 - LEVEL 0     5 - MEMO
# LEVEL 3 has priority over all other warnings
# LEVEL 2 has priority over 1 and 0
# LEVEL 1 has priority over 0

# LEVEL 3 Messages Priority:
# Red visual warning, repetitive chime or sound
# 1 Stall
# 2 Over speed
# 3 Engine dual failure
# 4 Engine fire
# 5 APU fire
# 6 Takeoff configuration
# 7 Sidestick fault
# 8 Excessive cabin altitude
# 9 Engine oil lo pressure
# 10 L + R Elevator fault
# 11 Landing gear
# 12 Autopilot disconnection
# 13 Auto land
# 14 Smoke
# 15 Emergency configuration
# 16 Dual hydraulic failure

# LEVEL 2 Messages:
# Amber warning, single chime

# LEVEL 1 Messages:
# Amber warning, no chime

# LEVEL 0 Messages: 
# No visual warning or chime: ECAM blue, green, or white message

# TYPES: Independent, Primary and Secondary, Status, and MEMO

# Operation: FWC receives electrical boolean or numeric signals, from the systems, and outputs a message, audible warning, or visual alert

# Electrical Connection: FWC1 is controlled by AC ESS, FWC2 by AC BUS 2

# Sounds: reduce volume by 6DB is engines are off

# ARINC 429: 100kb/s (high speed)

# PHASE: /ECAM/warning-phase

# DISPLAY: 1 - EWD 2 - MEMO 3 - STATUS

# commented lines of logic are waiting for proper FMGC warning phases
var num_lines = 6;
var msg = nil;
var spacer = nil;
var line = nil;
var right_line = nil;
var wow = getprop("/gear/gear[1]/wow");
setprop("/ECAM/show-left-msg", 0);
setprop("/ECAM/show-right-msg", 0);
setprop("/ECAM/warnings/master-warning-light", 0);
setprop("/ECAM/warnings/master-caution-light", 0);

var warning = {
	msg: "",
	active: 0,
	colour: "",
	aural: "",
	light: "",
	noRepeat: 0,
	new: func(msg,active,colour,aural,light,noRepeat) {
		var t = {parents:[warning]};
		
		t.msg = msg;
		t.active = active;
		t.colour = colour;
		t.aural = aural;
		t.light = light;
		t.noRepeat = noRepeat;
		
		return t
	},
	write: func() {
		var line = 1;
		while (getprop("/ECAM/msg/line" ~ line) != "") {
			line = line + 1; # go to next line until empty line
		}
		
		# if (getprop("/ECAM/msg/line" ~ line) != me.msg)
		if (getprop("/ECAM/msg/line" ~ line) == "" and me.active == 1 and me.msg != "") { # at empty line. Also checks if message is not blank to allow for some warnings with no displayed msg, eg stall
			setprop("/ECAM/msg/line" ~ line, me.msg);
			setprop("/ECAM/msg/linec" ~ line, me.colour);
		}
	},
	warnlight: func() {
		if ((me.light != "none" or me.light != "") and me.noRepeat == 0 and me.active == 1) { # only toggle light once per message, allows canceling 
			setprop("/ECAM/warnings/master-"~me.light~"-light", 1);
			me.noRepeat = 1;
		}
	},
	sound: func() {
		if (me.active and (me.aural != "none" or me.aural != "") and getprop("/sim/sound/warnings/"~me.aural) != 1) {
			setprop("/sim/sound/warnings/"~me.aural, 1);
		} else if (!me.active or me.aural == "none") {
			if (getprop("/sim/sound/warnings/"~me.aural) == 1) {
				setprop("/sim/sound/warnings/"~me.aural, 0);
			}
		}
	},
};

var memo = {
	msg: "",
	active: 0,
	colour: "",
	new: func(msg,active,colour) {
		var t = {parents:[memo]};
		
		t.msg = msg;
		t.active = active;
		t.colour = colour;
		
		return t
	},
	write: func() {
		var right_line = 1;
		while (getprop("/ECAM/rightmsg/line" ~ right_line) != "") {
			right_line = right_line + 1; # go to next line until empty line
		} 
		
		if (getprop("/ECAM/rightmsg/line" ~ right_line) == "" and me.active == 1) { # at empty line
			setprop("/ECAM/rightmsg/line" ~ right_line, me.msg);
			setprop("/ECAM/rightmsg/linec" ~ right_line, me.colour);
		}
	},
};

# messages logic and added to arrays

var warnings = std.Vector.new([
	var lg_not_dn = warning.new(msg: "L/G GEAR NOT DOWN", active: 0, colour: "r", aural: "crc", light: "warning", noRepeat: 0),
	var pack1_fault = warning.new(msg: "AIR PACK 1 FAULT ", active: 0, colour: "a", aural: "chime", light: "caution", noRepeat: 0),
	var pack1_fault_subwarn_1 = warning.new(msg: "-PACK 1.............OFF ", active: 0, colour: "b", aural: "none", light: "none", noRepeat: 0),
	var pack2_fault = warning.new(msg: "AIR PACK 2 FAULT ", active: 0, colour: "a", aural: "chime", light: "caution", noRepeat: 0),
	var pack2_fault_subwarn_1 = warning.new(msg: "-PACK 2.............OFF ", active: 0, colour: "b", aural: "none", light: "none", noRepeat: 0),
	var park_brk_on = warning.new(msg: "PARK BRK ON", active: 0, colour: "a", aural: "chime", light: "caution", noRepeat: 0)
]);

var leftmemos = std.Vector.new([
	var company_alert = warning.new(msg: "COMPANY ALERT", active: 0, colour: "g", aural: "buzzer", light: "none", noRepeat: 0), # Not yet implemented, buzzer sound
	var refuelg = warning.new(msg: "REFUELG", active: 0, colour: "g", aural: "none", light: "none", noRepeat: 0),
	var irs_in_align = warning.new(msg: "IRS IN ALIGN", active: 0, colour: "g", aural: "none", light: "none", noRepeat: 0), # Not yet implemented
	var gnd_splrs = warning.new(msg: "GND SPLRS ARMED", active: 0, colour: "g", aural: "none", light: "none", noRepeat: 0),
	var seatbelts = warning.new(msg: "SEAT BELTS", active: 0, colour: "g", aural: "none", light: "none", noRepeat: 0),
	var nosmoke = warning.new(msg: "NO SMOKING", active: 0, colour: "g", aural: "none", light: "none", noRepeat: 0),
	var strobe_lt_off = warning.new(msg: "STROBE LT OFF", active: 0, colour: "g", aural: "none", light: "none", noRepeat: 0),
	var outr_tk_fuel_xfrd = warning.new(msg: "OUTR TK FUEL XFRD", active: 0, colour: "g", aural: "none", light: "none", noRepeat: 0), # Not yet implemented
	var fob_3T = warning.new(msg: "FOB BELOW 3T", active: 0, colour: "g", aural: "none", light: "none", noRepeat: 0),
	var gpws_flap_mode_off = warning.new(msg: "GPWS FLAP MODE OFF", active: 0, colour: "g", aural: "none", light: "none", noRepeat: 0),
	var atc_datalink_stby = warning.new(msg: "ATC DATALINK STBY", active: 0, colour: "g", aural: "none", light: "none", noRepeat: 0), # Not yet implemented
	var company_datalink_stby = warning.new(msg: "COMPANY DATALINK STBY", active: 0, colour: "g", aural: "none", light: "none", noRepeat: 0) # Not yet implemented
]);

var memos = std.Vector.new([
	var to_inhibit = memo.new(msg: "T.O. INHIBIT", active: 0, colour: "m"),
	var ldg_inhibit = memo.new(msg: "LDG INHIBIT", active: 0, colour: "m"),
	var spd_brk = memo.new(msg: "SPEED BRK", active: 0, colour: "g"),
	var park_brk = memo.new(msg: "PARK BRK", active: 0, colour: "g"),
	var ptu = memo.new(msg: "HYD PTU", active: 0, colour: "g"),
	var rat = memo.new(msg: "RAT OUT", active: 0, colour: "g"),
	var emer_gen = memo.new(msg: "EMER GEN", active: 0, colour: "g"),
	var ram_air = memo.new(msg: "RAM AIR ON", active: 0, colour: "g"),
	var nw_strg_disc = memo.new(msg: "NW STRG DISC", active: 0, colour: "g"), # Not yet implemented
	var ignition = memo.new(msg: "IGNITION", active: 0, colour: "g"),
	var cabin_ready = memo.new(msg: "CABIN READY", active: 0, colour: "g"), # Not yet implemented
	var pred_ws_off = memo.new(msg: "PRED W/S OFF", active: 0, colour: "g"), # Not yet implemented
	var terr_stby = memo.new(msg: "TERR STBY", active: 0, colour: "g"), # Not yet implemented
	var tcas_stby = memo.new(msg: "TCAS STBY", active: 0, colour: "g"), # Not yet implemented
	var acars_call = memo.new(msg: "ACARS CALL", active: 0, colour: "g"), # Not yet implemented
	var company_call = memo.new(msg: "COMPANY CALL", active: 0, colour: "g"), # Not yet implemented
	var satcom_alert = memo.new(msg: "SATCOM ALERT", active: 0, colour: "g"), # Not yet implemented
	var acars_msg = memo.new(msg: "ACARS MSG", active: 0, colour: "g"), # Not yet implemented
	var company_msg = memo.new(msg: "COMPANY MSG", active: 0, colour: "g"), # Not yet implemented
	var eng_aice = memo.new(msg: "ENG A.ICE", active: 0, colour: "g"),
	var wing_aice = memo.new(msg: "WING A.ICE", active: 0, colour: "g"),
	var ice_not_det = memo.new(msg: "ICE NOT DET", active: 0, colour: "g"), # Not yet implemented
	var hi_alt = memo.new(msg: "HI ALT", active: 0, colour: "g"), # Not yet implemented
	var apu_avail = memo.new(msg: "APU AVAIL", active: 0, colour: "g"),
	var apu_bleed = memo.new(msg: "APU BLEED", active: 0, colour: "g"), # Not yet implemented
	var ldg_lt = memo.new(msg: "LDG LT", active: 0, colour: "g"),
	var brk_fan = memo.new(msg: "BRK FAN", active: 0, colour: "g"), # Not yet implemented
	var audio3_xfrd = memo.new(msg: "AUDIO 3 XFRD", active: 0, colour: "g"), # Not yet implemented
	var switchg_pnl = memo.new(msg: "SWITCHG PNL", active: 0, colour: "g"), # Not yet implemented
	var gpws_flap3 = memo.new(msg: "GPWS FLAP 3", active: 0, colour: "g"), # Not yet implemented
	var hf_data_ovrd = memo.new(msg: "HF DATA OVRD", active: 0, colour: "g"), # Not yet implemented
	var hf_voice = memo.new(msg: "HF VOICE", active: 0, colour: "g"), # Not yet implemented
	var acars_stby = memo.new(msg: "ACARS STBY", active: 0, colour: "g"), # Not yet implemented
	var vhf3_voice = memo.new(msg: "VHF3 VOICE", active: 0, colour: "g"),
	var auto_brk_lo = memo.new(msg: "AUTO BRK LO", active: 0, colour: "g"),
	var auto_brk_med = memo.new(msg: "AUTO BRK MED", active: 0, colour: "g"),
	var auto_brk_max = memo.new(msg: "AUTO BRK MAX", active: 0, colour: "g"),
	var auto_brk_off = memo.new(msg: "AUTO BRK OFF", active: 0, colour: "g"), # Not yet implemented
	var man_ldg_elev = memo.new(msg: "MAN LDG ELEV", active: 0, colour: "g"), # Not yet implemented
	var ctr_tk_feedg = memo.new(msg: "CTR TK FEEDG", active: 0, colour: "g"), # Not yet implemented
	var fuelx = memo.new(msg: "FUEL X FEED", active: 0, colour: "g")
]);

var clearWarnings = std.Vector.new();

var messages_priority_3 = func {
	if ((getprop("/position/gear-agl-ft") < 750 and getprop("/gear/gear[1]/position-norm") != 1 and (getprop("/ECAM/warning-phase") <= 3 and getprop("/ECAM/warning-phase") >= 5)) and ((((getprop("/engines/engine[0]/n1-actual") < 75.0 and getprop("/engines/engine[1]/n1-actual") < 75.0)) or ((getprop("/engines/engine[0]/n1-actual") < 77.0 and getprop("/controls/engines/engine[1]/cutoff-switch") == 0) or (getprop("/engines/engine[1]/n1-actual") < 77.0 and getprop("/controls/engines/engine[0]/cutoff-switch") == 0))) or getprop("/controls/flight/flap-pos") > 1)) {
		lg_not_dn.active = 1;
		setprop("/systems/gear/landing-gear-warning-light", 1);
	} else {
		lg_not_dn.active = 0;
		lg_not_dn.noRepeat = 0;
		setprop("/systems/gear/landing-gear-warning-light", 0);
	}
}
var messages_priority_2 = func {
	if ((((getprop("/ECAM/warning-phase") >= 1 and getprop("/ECAM/warning-phase") <= 2) or (getprop("/ECAM/warning-phase") >= 9 and getprop("/ECAM/warning-phase") <= 10) and (wow and getprop("/engines/engine[0]/state") == 3)) or getprop("/ECAM/warning-phase") == 6) and getprop("/systems/failures/pack1") == 1) {
		pack1_fault.active = 1;
	} else {
		pack1_fault.active = 0;
		pack1_fault.noRepeat = 0;
	}
	
	if (pack1_fault.active == 1 and getprop("/controls/pneumatic/switches/pack1") == 1) {
		pack1_fault_subwarn_1.active = 1;
	} else {
		pack1_fault_subwarn_1.active = 0;
		pack1_fault_subwarn_1.noRepeat = 0;
	}
	
	if ((((getprop("/ECAM/warning-phase") >= 1 and getprop("/ECAM/warning-phase") <= 2) or (getprop("/ECAM/warning-phase") >= 9 and getprop("/ECAM/warning-phase") <= 10) and (wow and getprop("/engines/engine[1]/state") == 3)) or getprop("/ECAM/warning-phase") == 6) and getprop("/systems/failures/pack2") == 1) {
		pack2_fault.active = 1;
	} else {
		pack2_fault.active = 0;
		pack2_fault.noRepeat = 0;
	}
	
	if (pack2_fault.active == 1 and getprop("/controls/pneumatic/switches/pack2") == 1) {
		pack2_fault_subwarn_1.active = 1;
	} else {
		pack2_fault_subwarn_1.active = 0;
		pack2_fault_subwarn_1.noRepeat = 0;
	}
	
	if (getprop("/controls/gear/brake-parking") and (getprop("/ECAM/warning-phase") >= 6 and getprop("/ECAM/warning-phase") <= 7)) {
		park_brk_on.active = 1;
	} else {
		park_brk_on.active = 0;
		park_brk_on.noRepeat = 0;
	}
}

var messages_priority_1 = func {}
var messages_priority_0 = func {}

var messages_memo = func {
	if (getprop("/services/fuel-truck/enable") == 1 and getprop("/ECAM/left-msg") != "TO-MEMO" and getprop("/ECAM/left-msg") != "LDG-MEMO") {
		refuelg.active = 1;
	} else {
		refuelg.active = 0;
	}
	
	if (getprop("/controls/flight/speedbrake-arm") == 1) {
		gnd_splrs.active = 1;
	} else {
		gnd_splrs.active = 0;
	}
	
	if (getprop("/controls/switches/seatbelt-sign") == 1) {
		seatbelts.active = 1;
	} else {
		seatbelts.active = 0;
	}
	
	if (getprop("/controls/switches/no-smoking-sign") == 1) {
		nosmoke.active = 1;
	} else {
		nosmoke.active = 0;
	}

	if (getprop("/controls/lighting/strobe") == 0 and getprop("/gear/gear[1]/wow") == 0) {
		strobe_lt_off.active = 1;
	} else {
		strobe_lt_off.active = 0;
	}

	if (getprop("instrumentation/mk-viii/inputs/discretes/momentary-flap-all-override") == 1) {
		gpws_flap_mode_off.active = 1;
	} else {
		gpws_flap_mode_off.active = 0;
	}
	
	if (getprop("/consumables/fuel/total-fuel-lbs") < 6000 and getprop("/ECAM/left-msg") != "TO-MEMO" and getprop("/ECAM/left-msg") != "LDG-MEMO") { # assuming US short ton 2000lb
		fob_3T.active = 1;
	} else {
		fob_3T.active = 0;
	}
}

var messages_right_memo = func {
	if (getprop("/ECAM/warning-phase") >= 3 and getprop("/ECAM/warning-phase") <= 5) {
		to_inhibit.active = 1;
	} else {
		to_inhibit.active = 0;
	}
	
	if (getprop("/ECAM/warning-phase") >= 7 and getprop("/ECAM/warning-phase") <= 7) {
		ldg_inhibit.active = 1;
	} else {
		ldg_inhibit.active = 0;
	}
	
	if ((getprop("/ECAM/warning-phase") >= 2 and getprop("/ECAM/warning-phase") <= 7) and getprop("controls/flight/speedbrake") != 0) {
		spd_brk.active = 1;
	} else {
		spd_brk.active = 0;
	}
	
	if (getprop("/systems/thrust/state1") == "IDLE" and getprop("/systems/thrust/state2") == "IDLE" and getprop("/ECAM/warning-phase") >= 6 and getprop("/ECAM/warning-phase") <= 7) {
		spd_brk.colour = "g";
	} else if ((getprop("/ECAM/warning-phase") >= 2 and getprop("/ECAM/warning-phase") <= 5) or ((getprop("/systems/thrust/state1") != "IDLE" or getprop("/systems/thrust/state2") != "IDLE") and (getprop("/ECAM/warning-phase") >= 6 and getprop("/ECAM/warning-phase") <= 7))) {
		spd_brk.colour = "a";
	}
	
	if (getprop("/controls/gear/brake-parking") == 1 and getprop("/ECAM/warning-phase") != 3) {
		park_brk.active = 1;
	} else {
		park_brk.active = 0;
	}
	if (getprop("/ECAM/warning-phase") >= 4 and getprop("/ECAM/warning-phase") <= 8) {
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
	
	if (getprop("/ECAM/warning-phase") >= 1 and getprop("/ECAM/warning-phase") <= 2) {
		rat.colour = "a";
	} else {
		rat.colour = "g";
	}
	
	if (getprop("/controls/electrical/switches/emer-gen") == 1 and getprop("/controls/hydraulic/rat-deployed") == 1 and !wow) {
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
	if (getprop("/instrumentation/comm[2]/frequencies/selected-mhz") != 0 and (getprop("/ECAM/warning-phase") == 1 or getprop("/ECAM/warning-phase") == 2 or getprop("/ECAM/warning-phase") == 6 or getprop("/ECAM/warning-phase") == 9 or getprop("/ECAM/warning-phase") == 10)) {
		vhf3_voice.active = 1;
	} else {
		vhf3_voice.active = 0;
	}
	if (getprop("/controls/autobrake/mode") == 1 and (getprop("/ECAM/warning-phase") == 7 or getprop("/ECAM/warning-phase") == 8)) {
		auto_brk_lo.active = 1;
	} else {
		auto_brk_lo.active = 0;
	}

	if (getprop("/controls/autobrake/mode") == 2 and (getprop("/ECAM/warning-phase") == 7 or getprop("/ECAM/warning-phase") == 8)) {
		auto_brk_med.active = 1;
	} else {
		auto_brk_med.active = 0;
	}

	if (getprop("/controls/autobrake/mode") == 3 and (getprop("/ECAM/warning-phase") == 7 or getprop("/ECAM/warning-phase") == 8)) {
		auto_brk_max.active = 1;
	} else {
		auto_brk_max.active = 0;
	}
	
	if (getprop("/systems/fuel/x-feed") == 1 and getprop("controls/fuel/x-feed") == 1) {
		fuelx.active = 1;
	} else {
		fuelx.active = 0;
	}
	
	if (getprop("/ECAM/warning-phase") >= 3 and getprop("/ECAM/warning-phase") <= 5) {
		fuelx.colour = "a";
	} else {
		fuelx.colour = "g";
	}
}

# Finally the controller

var ECAM_controller = {
	loop: func() {
		# check active messages
		# config_warnings();
		messages_priority_3();
		messages_priority_2();
		messages_priority_1();
		messages_priority_0();
		messages_memo();
		messages_right_memo();
		
		# clear display momentarily
		
		if (warnings.size() > 0) {
			for(var n = 1; n < 8; n += 1) {
				setprop("/ECAM/msg/line" ~ n, "");
			}
		}
		
		if (memos.size() > 0) {
			for(var n = 1; n < 8; n += 1) {
				setprop("/ECAM/rightmsg/line" ~ n, "");
			}
		}
		
		# write to ECAM
		
		foreach (var i; warnings.vector) {
			i.write();
			i.warnlight();
			i.sound();
		}
		
		if (warnings.size() == 0) {
			foreach (var h; leftmemos.vector) {
				h.write();
			}
		}
		
		foreach (var m; memos.vector) {
			m.write();
		}
	},
};
