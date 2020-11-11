/// @description Spawn a laser

var _new_beam = instance_create_layer(-24, 24 + random_range(0, 21) * 16, "Obstacles", o_beam);
with (_new_beam) {
	xspeed = 1;
}

if (alarm_1_timer > 40) alarm_1_timer -= 5;
alarm_set(1, alarm_1_timer);
