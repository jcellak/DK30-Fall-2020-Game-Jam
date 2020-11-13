/// @description Stage Init
game_ended = false;
dead_player = noone;

alarm_set(0, 120);

alarm_1_timer = 180;

if (audio_is_playing(a_two_robots)) {
	audio_stop_sound(a_two_robots);
}

if (audio_is_playing(a_coop_track)) {
	audio_stop_sound(a_coop_track);
}

if (!audio_is_playing(a_boss_track_edit)) {
	audio_play_sound(a_boss_track_edit, 10, true);
}
