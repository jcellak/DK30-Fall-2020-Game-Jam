/// @description 
// TODO: migrate to new menu
/*if (keyboard_check_pressed(vk_space) && global.my_player_num != -1 && global.all_players_connected) {
	if (global.local_play) {
		room_goto_next();
	} else if (global.is_server) {
		room_goto_next();
		send_event_goto_room(room_next(room));
	}
}*/


audio_sound_gain(a_two_robots,global.vol[0]*global.vol[2],0);
audio_sound_gain(a_item_pickup,global.vol[0]*global.vol[1],0);
audio_sound_gain(a_jump,global.vol[0]*global.vol[1],0);
audio_sound_gain(a_jump_1,global.vol[0]*global.vol[1],0);
audio_sound_gain(a_jump_2,global.vol[0]*global.vol[1],0);
audio_sound_gain(a_ouch,global.vol[0]*global.vol[1],0);
