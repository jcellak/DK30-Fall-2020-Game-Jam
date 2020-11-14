/// @description Spawn a laser
if (!game_ended and (global.local_play or global.is_server)) {
	var _beam_pos = random_range(0, 20) * 16 + 24;
	var _new_beam = instance_create_layer(-24, _beam_pos, "Obstacles", o_beam);
	_new_beam.xspeed = 1;
	var _new_beam_2 = instance_create_layer(-24, _beam_pos + 16, "Obstacles", o_beam);
	_new_beam_2.xspeed = 1;
	
	send_event_beam_created(_beam_pos);

	if (alarm_1_timer > 40) alarm_1_timer -= 5;
	alarm_set(1, alarm_1_timer);
}
