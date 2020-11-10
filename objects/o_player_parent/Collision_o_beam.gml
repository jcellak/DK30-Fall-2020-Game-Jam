/// @description Take damage
if (!is_opponent or global.local_play) {
	
	handle_player_take_damage(0);
	send_event_player_damaged(0);

}