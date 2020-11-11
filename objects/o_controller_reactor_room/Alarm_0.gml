/// @description Start the stage

for (var _i = 0; _i < instance_number(o_solid_disappearing); _i++) {
	var _this_block = instance_find(o_solid_disappearing, _i);
	if (_this_block != noone) {
		with (_this_block) {
			if (within(x, y, 50, 20, 140, 110)) {
				is_toggled = true;
			}
		}
	}
}

alarm_set(1, alarm_1_timer);
