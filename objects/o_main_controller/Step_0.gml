/// @description Begin the game
if (keyboard_check_pressed(vk_space) && room == r_title) {
	room_goto(r_stage_one);
	audio_stop_sound(a_title);
	audio_play_sound(a_cave_loop, 10, true);
}

// Change music if on the main screen for too long
if (!audio_is_playing(a_title) && !audio_is_playing(a_cave_loop)) {
	audio_play_sound(a_cave_loop, 10, true);
}