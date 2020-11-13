/// @description Destroy dead player

audio_stop_sound(a_reactor_failure);

if (dead_player != noone) {
	instance_destroy(dead_player);
	dead_player = noone;
	audio_play_sound(a_explosion, 10, false);
	audio_play_sound(a_wilhelm, 10, false);
}

instance_destroy(o_reactor_beam);
