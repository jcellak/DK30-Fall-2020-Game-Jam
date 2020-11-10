/// @description Begin the game
if (keyboard_check_pressed(vk_space) && global.my_player_num != -1 && global.all_players_connected) {
	if (global.local_play) {
		room_goto_next();
	} else if (global.is_server) {
		room_goto_next();
		send_event_goto_room(room_next(room));
	}
}
