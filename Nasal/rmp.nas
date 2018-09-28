# A3XX Radio Managment Panel
# merspieler

############################
# Copyright (c) merspieler #
############################

# GLOBAL TODO add stuff for HF1, HF2, VOR, LS and ADF

var rmp_update = nil;

var act_vhf1 = props.globals.getNode("/instrumentation/comm[0]/frequencies/selected-mhz");
var act_vhf2 = props.globals.getNode("/instrumentation/comm[1]/frequencies/selected-mhz");
var act_vhf3 = props.globals.getNode("/instrumentation/comm[2]/frequencies/selected-mhz");

var act_display_rmp1 = props.globals.initNode("/controls/radio/rmp[0]/active-display", "123.900", "STRING");
var stby_display_rmp1 = props.globals.initNode("/controls/radio/rmp[0]/standby-display", "118.700", "STRING");
var stby_rmp1_vhf1 = props.globals.initNode("/systems/radio/rmp[0]/vhf1-standby", 118.7, "DOUBLE");
var stby_rmp1_vhf2 = props.globals.initNode("/systems/radio/rmp[0]/vhf2-standby", 123.12, "DOUBLE");
var stby_rmp1_vhf3 = props.globals.initNode("/systems/radio/rmp[0]/vhf3-standby", 121.5, "DOUBLE");

var act_display_rmp2 = props.globals.initNode("/controls/radio/rmp[1]/active-display", "127.900", "STRING");
var stby_display_rmp2 = props.globals.initNode("/controls/radio/rmp[1]/standby-display", "123.125", "STRING");
var stby_rmp2_vhf1 = props.globals.initNode("/systems/radio/rmp[1]/vhf1-standby", 118.7, "DOUBLE");
var stby_rmp2_vhf2 = props.globals.initNode("/systems/radio/rmp[1]/vhf2-standby", 123.12, "DOUBLE");
var stby_rmp2_vhf3 = props.globals.initNode("/systems/radio/rmp[1]/vhf3-standby", 121.5, "DOUBLE");

var act_display_rmp3 = props.globals.initNode("/controls/radio/rmp[2]/active-display", "127.900", "STRING");
var stby_display_rmp3 = props.globals.initNode("/controls/radio/rmp[2]/standby-display", "123.125", "STRING");
var stby_rmp3_vhf1 = props.globals.initNode("/systems/radio/rmp[2]/vhf1-standby", 118.7, "DOUBLE");
var stby_rmp3_vhf2 = props.globals.initNode("/systems/radio/rmp[2]/vhf2-standby", 123.12, "DOUBLE");
var stby_rmp3_vhf3 = props.globals.initNode("/systems/radio/rmp[2]/vhf3-standby", 121.5, "DOUBLE");

var chan_rmp1 = props.globals.initNode("/systems/radio/rmp[0]/sel_chan", "vhf1", "STRING");
var chan_rmp2 = props.globals.initNode("/systems/radio/rmp[1]/sel_chan", "vhf2", "STRING");
var chan_rmp3 = props.globals.initNode("/systems/radio/rmp[2]/sel_chan", "vhf3", "STRING");

var pwr_sw_rmp1 = props.globals.initNode("/controls/radio/rmp[0]/on", 0, "BOOL");
var pwr_sw_rmp2 = props.globals.initNode("/controls/radio/rmp[1]/on", 0, "BOOL");
var pwr_sw_rmp3 = props.globals.initNode("/controls/radio/rmp[2]/on", 0, "BOOL");

var init = func() {
	for(var i = 0; i < 3; i += 1) {
		setprop("/systems/radio/rmp[" ~ i ~ "]/hf1-standby", 510);
		setprop("/systems/radio/rmp[" ~ i ~ "]/hf2-standby", 891);
	}
	
	chan_rmp1.setValue("vhf1");
	chan_rmp2.setValue("vhf2");
	chan_rmp3.setValue("vhf3");
	pwr_sw_rmp1.setBoolValue(0);
	pwr_sw_rmp2.setBoolValue(0);
	pwr_sw_rmp3.setBoolValue(0);
	
	var rmp_update = maketimer(0.2, func {
		rmp_refresh.update();
	});
}

var update_active_vhf = func(vhf) {
	var sel1 = chan_rmp1.getValue();
	var sel2 = chan_rmp2.getValue();
# In case that a 3rd RMP is added, uncomment the following line and expand the if statements with the sel3 comparison
#	var sel3 = chan_rmp3.getValue();

	if (vhf == 1) {
		if (sel1 == "vhf1" or sel2 == "vhf1") {
			var act = sprintf("%3.3f", act_vhf1.getValue());

			if (sel1 == "vhf1") {
				act_display_rmp1.setValue(act);
			}
			if (sel2 == "vhf1") {
				act_display_rmp2.setValue(act);
			}
		}
	} else if (vhf == 2) {
		if (sel1 == "vhf2" or sel2 == "vhf2") {
			var act = sprintf("%3.3f", act_vhf2.getValue());

			if (sel1 == "vhf2") {
				act_display_rmp1.setValue(act);
			}
			if (sel2 == "vhf2") {
				act_display_rmp2.setValue(act);
			}
		}
	} else {
		if (sel1 == "vhf3" or sel2 == "vhf3") {
			var act = sprintf("%3.3f", act_vhf3.getValue());

			if (sel1 == "vhf3") {
				act_display_rmp1.setValue(act);
			}
			if (sel2 == "vhf3") {
				act_display_rmp2.setValue(act);
			}
		}
	}
};

var update_stby_vhf = func(rmp_no, vhf) {
	if (rmp_no == 0) {
		if (vhf == 1) {
			var stby = sprintf("%3.3f", stby_rmp1_vhf1.getValue());
		} else if (vhf == 2) {
			var stby = sprintf("%3.3f", stby_rmp1_vhf2.getValue());
		} else {
			var stby = sprintf("%3.3f", stby_rmp1_vhf3.getValue());
		}

		stby_display_rmp1.setValue(stby);
	} else {
		if (vhf == 1) {
			var stby = sprintf("%3.3f", stby_rmp2_vhf1.getValue());
		} else if (vhf == 2) {
			var stby = sprintf("%3.3f", stby_rmp2_vhf2.getValue());
		} else {
			var stby = sprintf("%3.3f", stby_rmp2_vhf3.getValue());
		}

		stby_display_rmp2.setValue(stby);
	}
}

var update_chan_sel = func(rmp_no) {
	update_active_vhf(1);
	update_active_vhf(2);
	update_active_vhf(3);

	if (rmp_no == 0) {
		var chan = chan_rmp1.getValue();
		if (chan == "vhf1") {
			update_stby_vhf(rmp_no, 1);
		} else if (chan == "vhf1") {
			update_stby_vhf(rmp_no, 2);
		} else {
			update_stby_vhf(rmp_no, 3);
		}
	} else if (rmp_no == 1) {
		var chan = chan_rmp2.getValue();
		if (chan == "vhf1") {
			update_stby_vhf(rmp_no, 1);
		} else if (chan == "vhf2") {
			update_stby_vhf(rmp_no, 2);
		} else {
			update_stby_vhf(rmp_no, 3);
		}
	} else {
# In case that a 3rd RMP is added, uncomment this
#		var chan = chan_rmp3.getValue();
#		if (chan == "vhf1") {
#			update_stby_vhf(rmp_no, 1);
#		} else if (chan == "vhf2") {
#			update_stby_vhf(rmp_no, 2);
#		} else {
#			update_stby_vhf(rmp_no, 3);
#		}
	}
}

var transfer = func(rmp_no) {

	rmp_no = rmp_no - 1;
	var sel_chan = getprop("/systems/radio/rmp[" ~ rmp_no ~ "]/sel_chan");

	if (string.match(sel_chan, "vhf[1-3]")) {
		var mod1 = int(string.replace(sel_chan, "vhf", ""));
		var mod = mod1 - 1;

		var mem = getprop("/instrumentation/comm[" ~ mod ~ "]/frequencies/selected-mhz");
		setprop("/instrumentation/comm[" ~ mod ~ "]/frequencies/selected-mhz", getprop("/systems/radio/rmp[" ~ rmp_no ~ "]/vhf" ~ mod1 ~ "-standby"));
		setprop("/systems/radio/rmp[" ~ rmp_no ~ "]/vhf" ~ mod1 ~ "-standby", mem);
	}
}


setlistener("/systems/radio/rmp[0]/vhf1-standby", func {
	update_stby_vhf(0, 1);
});

setlistener("/systems/radio/rmp[0]/vhf2-standby", func {
	update_stby_vhf(0, 2);
});

setlistener("/systems/radio/rmp[0]/vhf3-standby", func {
	update_stby_vhf(0, 3);
});

setlistener("/systems/radio/rmp[1]/vhf1-standby", func {
	update_stby_vhf(1, 1);
});

setlistener("/systems/radio/rmp[1]/vhf2-standby", func {
	update_stby_vhf(1, 2);
});

setlistener("/systems/radio/rmp[1]/vhf3-standby", func {
	update_stby_vhf(1, 3);
});

setlistener("/systems/radio/rmp[2]/vhf1-standby", func {
	update_stby_vhf(2, 1);
});

setlistener("/systems/radio/rmp[2]/vhf2-standby", func {
	update_stby_vhf(2, 2);
});

setlistener("/systems/radio/rmp[2]/vhf3-standby", func {
	update_stby_vhf(2, 3);
});

setlistener("/instrumentation/comm[0]/frequencies/selected-mhz", func {
	update_active_vhf(1);
});

setlistener("/instrumentation/comm[1]/frequencies/selected-mhz", func {
	update_active_vhf(2);
});

setlistener("/instrumentation/comm[2]/frequencies/selected-mhz", func {
	update_active_vhf(3);
});

setlistener("/systems/radio/rmp[0]/sel_chan", func {
	update_chan_sel(0);
});

setlistener("/systems/radio/rmp[1]/sel_chan", func {
	update_chan_sel(1);
});

setlistener("/systems/radio/rmp[2]/sel_chan", func {
	update_chan_sel(2);
});
