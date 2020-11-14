/// @description Stage Init
game_ended = false;
dead_player = noone;

alarm_set(0, 120);

alarm_1_timer = 180;

Music_list();

for (var i = 0; i < array_length(music); i++) {
	audio_stop_sound(music[i]);
}

if (!audio_is_playing(a_boss_track_edit)) {
	audio_play_sound(a_boss_track_edit, 10, true);
}
