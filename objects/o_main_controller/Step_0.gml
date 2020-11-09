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

// volume adjustments
clamp(vol[0],0,1);
clamp(vol[1],0,1);
clamp(vol[2],0,1);

show_debug_message(vol[1])
audio_sound_gain(a_title,vol[0]*vol[2],0);
audio_sound_gain(a_cave_loop,vol[0]*vol[2],0);
