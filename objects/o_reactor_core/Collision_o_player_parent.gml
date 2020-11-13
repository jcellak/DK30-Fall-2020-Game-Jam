/// @description Victory

if (global.winner == noone) {
	global.winner = other;
	var _fader = instance_create_layer(0, 0, "Transitions", o_transition_fade_out);
	_fader.max_frames = 60;
	alarm_set(1, 60);
}
