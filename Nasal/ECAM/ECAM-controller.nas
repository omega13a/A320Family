# A3XX Electronic Centralised Aircraft Monitoring System
# Copyright (c) 2019 Jonathan Redpath (legoboyvdlp)

var leftmsgEnable = props.globals.initNode("/ECAM/show-left-msg", 1, "BOOL");
var rightmsgEnable = props.globals.initNode("/ECAM/show-right-msg", 1, "BOOL");

var lines = [props.globals.getNode("/ECAM/msg/line1", 1), props.globals.getNode("/ECAM/msg/line2", 1), props.globals.getNode("/ECAM/msg/line3", 1), props.globals.getNode("/ECAM/msg/line4", 1), props.globals.getNode("/ECAM/msg/line5", 1), props.globals.getNode("/ECAM/msg/line6", 1), props.globals.getNode("/ECAM/msg/line7", 1), props.globals.getNode("/ECAM/msg/line8", 1)];
var linesCol = [props.globals.getNode("/ECAM/msg/linec1", 1), props.globals.getNode("/ECAM/msg/linec2", 1), props.globals.getNode("/ECAM/msg/linec3", 1), props.globals.getNode("/ECAM/msg/linec4", 1), props.globals.getNode("/ECAM/msg/linec5", 1), props.globals.getNode("/ECAM/msg/linec6", 1), props.globals.getNode("/ECAM/msg/linec7", 1), props.globals.getNode("/ECAM/msg/linec8", 1)];
var rightLines = [props.globals.getNode("/ECAM/rightmsg/line1", 1), props.globals.getNode("/ECAM/rightmsg/line2", 1), props.globals.getNode("/ECAM/rightmsg/line3", 1), props.globals.getNode("/ECAM/rightmsg/line4", 1), props.globals.getNode("/ECAM/rightmsg/line5", 1), props.globals.getNode("/ECAM/rightmsg/line6", 1), props.globals.getNode("/ECAM/rightmsg/line7", 1), props.globals.getNode("/ECAM/rightmsg/line8", 1)];
var rightLinesCol = [props.globals.getNode("/ECAM/rightmsg/linec1", 1), props.globals.getNode("/ECAM/rightmsg/linec2", 1), props.globals.getNode("/ECAM/rightmsg/linec3", 1), props.globals.getNode("/ECAM/rightmsg/linec4", 1), props.globals.getNode("/ECAM/rightmsg/linec5", 1), props.globals.getNode("/ECAM/rightmsg/linec6", 1), props.globals.getNode("/ECAM/rightmsg/linec7", 1), props.globals.getNode("/ECAM/rightmsg/linec8", 1)];
var statusLines = [props.globals.getNode("/ECAM/status/line1", 1), props.globals.getNode("/ECAM/status/line2", 1), props.globals.getNode("/ECAM/status/line3", 1), props.globals.getNode("/ECAM/status/line4", 1), props.globals.getNode("/ECAM/status/line5", 1), props.globals.getNode("/ECAM/status/line6", 1), props.globals.getNode("/ECAM/status/line7", 1), props.globals.getNode("/ECAM/status/line8", 1)];
var statusLinesCol = [props.globals.getNode("/ECAM/status/linec1", 1), props.globals.getNode("/ECAM/status/linec2", 1), props.globals.getNode("/ECAM/status/linec3", 1), props.globals.getNode("/ECAM/status/linec4", 1), props.globals.getNode("/ECAM/status/linec5", 1), props.globals.getNode("/ECAM/status/linec6", 1), props.globals.getNode("/ECAM/status/linec7", 1), props.globals.getNode("/ECAM/status/linec8", 1)];

var leftOverflow  = props.globals.initNode("/ECAM/warnings/overflow-left", 0, "BOOL");
var rightOverflow = props.globals.initNode("/ECAM/warnings/overflow-right", 0, "BOOL");
var overflow = props.globals.initNode("/ECAM/warnings/overflow", 0, "BOOL");

var dc_ess = props.globals.getNode("/systems/electrical/bus/dc-ess", 1);

var lights = [props.globals.initNode("/ECAM/warnings/master-warning-light", 0, "BOOL"), props.globals.initNode("/ECAM/warnings/master-caution-light", 0, "BOOL")]; 
var aural = [props.globals.initNode("/sim/sound/warnings/crc", 0, "BOOL"), props.globals.initNode("/sim/sound/warnings/chime", 0, "BOOL")];
var warningFlash = props.globals.initNode("/ECAM/warnings/master-warning-flash", 0, "BOOL");

var lineIndex = 0;
var rightLineIndex = 0;
var statusIndex = 0;

var warning = {
	new: func(msg,colour,aural,light) {
		var t = {parents:[warning]};
		
		t.msg = msg;
		t.active = 0;
		t.colour = colour;
		t.aural = aural;
		t.light = light;
		t.noRepeat = 0;
		t.clearFlag = 0;
		
		return t
	},
	write: func() {
		if (me.active == 0) {return;}
		lineIndex = 0;
		while (lineIndex < 7 and lines[lineIndex].getValue() != "") {
			lineIndex = lineIndex + 1; # go to next line until empty line
		}
		
		if (lineIndex == 7) {
			leftOverflow.setBoolValue(1);
		} elsif (leftOverflow.getBoolValue()) {
			leftOverflow.setBoolValue(0);
		}
		
		if (lines[lineIndex].getValue() == "" and me.msg != "" and lineIndex <= 7) { # at empty line. Also checks if message is not blank to allow for some warnings with no displayed msg, eg stall
			lines[lineIndex].setValue(me.msg);
			linesCol[lineIndex].setValue(me.colour);
		}
	},
	warnlight: func() {
		if (me.light >= 1) {return;}
		if (me.active == 1 and me.noRepeat == 0) { # only toggle light once per message, allows canceling 
			lights[me.light].setBoolValue(1);
			me.noRepeat = 1;
		}
	},
	sound: func() {
		if (me.aural > 1) {return;} 
		if (me.active == 1) {
			if (!aural[me.aural].getBoolValue()) {
				aural[me.aural].setBoolValue(1);
			}
		}
	},
};

var memo = {
	new: func(msg,colour) {
		var t = {parents:[memo]};
		
		t.msg = msg;
		t.active = 0;
		t.colour = colour;
		
		return t
	},
	write: func() {
		if (me.active == 1) {
			rightLineIndex = 0;
			while (rightLines[rightLineIndex].getValue() != "" and rightLineIndex <= 7) {
				rightLineIndex = rightLineIndex + 1; # go to next line until empty line
			} 
			
			if (rightLineIndex > 7) {
				rightOverflow.setBoolValue(1);
			} elsif (rightOverflow.getBoolValue()) {
				rightOverflow.setBoolValue(0);
			}
			
			if (rightLines[rightLineIndex].getValue() == "" and rightLineIndex <= 7) { # at empty line
				rightLines[rightLineIndex].setValue(me.msg);
				rightLinesCol[rightLineIndex].setValue(me.colour);
			}
		}
	},
};

var status = {
	new: func(msg,colour) {
		var t = {parents:[status]};
		
		t.msg = msg;
		t.active = 0;
		t.colour = colour;
		
		return t
	},
	write: func() {
		if (me.active == 1) {
			statusIndex = 0;
			while (statusLines[statusIndex].getValue() != "" and statusIndex <= 7) {
				statusIndex = statusIndex + 1; # go to next line until empty line
			} 
			
			if (statusLines[statusIndex].getValue() == "" and statusIndex <= 7) { # at empty line
				statusLines[rightLineIndex].setValue(me.msg);
				statusLinesCol[rightLineIndex].setValue(me.colour);
			}
		}
	},
};

var ECAM_controller = {
	init: func() {
		ECAMloopTimer.start();
		me.reset();
	},
	loop: func() {
		# check active messages
		messages_priority_3();
		messages_priority_2();
		messages_priority_1();
		messages_priority_0();
		messages_memo();
		messages_right_memo();
		
		# clear display momentarily
		
		
		for(var n = 0; n <= 7; n += 1) {
			lines[n].setValue("");
		}
		
		for(var n = 0; n <= 7; n += 1) {
			rightLines[n].setValue("");
		}
		
		# write to ECAM
		
		foreach (var w; warnings.vector) {
			w.write();
			w.warnlight();
			w.sound();
		}
		
		if (lines[0].getValue() == "") { # disable left memos if a warning exists. Warnings are processed first, so this stops leftmemos if line1 is not empty
			foreach (var l; leftmemos.vector) {
				l.write();
			}
		}
		
		foreach (var sL; specialLines.vector) {
			sL.write();
		}
		
		foreach (var sF; secondaryFailures.vector) {
			sF.write();
		}
		
		foreach (var m; memos.vector) {
			m.write();
		}
		
		if (leftOverflow.getBoolValue() == 1 or leftOverflow.getBoolValue() == 1) {
			overflow.setBoolValue(1);
		} elsif (leftOverflow.getBoolValue() == 0 and leftOverflow.getBoolValue() == 0) {
			overflow.setBoolValue(0);
		}
	},
	reset: func() {
		foreach (var w; warnings.vector) {
			if (w.active == 1) {
				w.active = 0;
			}
		}
		
		foreach (var l; leftmemos.vector) {
			if (l.active == 1) {
				l.active = 0;
			}
		}
		
		foreach (var sL; specialLines.vector) {
			if (sL.active == 1) {
				sL.active = 0;
			}
		}
		
		foreach (var sF; secondaryFailures.vector) {
			if (sF.active == 1) {
				sF.active = 0;
			}
		}
		
		foreach (var m; memos.vector) {
			if (m.active == 1) {
				m.active = 0;
			}
		}
	},
	clear: func() {
		foreach (var w; warnings.vector) {
			if (w.active == 1) {
				# if (w.msg == "ENG DUAL FAILURE") { continue; }
				w.clearFlag = 1;
				break;
			}
		}
	},
	recall: func() {
		foreach (var w; warnings.vector) {
			if (w.clearFlag == 1) {
				w.noRepeat = 0;
				w.clearFlag = 0;
				break;
			}
		}
	},
};

setlistener("/systems/electrical/bus/dc-ess", func {
	if (dc_ess.getValue() < 25) {
		ECAM_controller.reset();
	}
}, 0, 0);

var ECAMloopTimer = maketimer(0.2, func {
	ECAM_controller.loop();
});

# Flash Master Warning Light
var warnTimer = maketimer(0.25, func {
	if (!lights[0].getBoolValue()) {
		warnTimer.stop();
		warningFlash.setBoolValue(0);
	} else if (!warningFlash.getBoolValue()) {
		warningFlash.setBoolValue(1);
	} else {
		warningFlash.setBoolValue(0);
	}
});

setlistener("/ECAM/warnings/master-warning-light", func {
	if (lights[0].getBoolValue()) {
		warningFlash.setBoolValue(0);
		warnTimer.start();
	} else {
		warnTimer.stop();
		warningFlash.setBoolValue(0);
	}
}, 0, 0);
