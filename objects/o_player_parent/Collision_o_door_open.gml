/// @description Move to the next level
if (!instance_exists(o_Text)) {
	if (!is_opponent or global.local_play) {
		var _other_player = this_player_num == 0 ? o_player_2 : o_player_1;
		with (_other_player) {
			var _this_player = this_player_num == 0 ? o_player_2 : o_player_1;
			if (place_meeting(x, y, o_door_open)) {
				y = yprevious;
				state = PlayerState.door;
				if (!audio_is_playing(a_exit)) audio_play_sound(a_exit, 4, false);
				audio_stop_sound(a_jump);
				with (_this_player) {
					y = yprevious;
					state = PlayerState.door;
				}
			}
		}
	}
}