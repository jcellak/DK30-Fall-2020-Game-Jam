/// @description Move to the next level
if (!is_opponent or global.local_play) {
	
	if (up and other.visible == true) {
		y = yprevious;
		state = PlayerState.door;
		audio_play_sound(a_exit, 4, false);
		audio_stop_sound(a_jump);
	}

}