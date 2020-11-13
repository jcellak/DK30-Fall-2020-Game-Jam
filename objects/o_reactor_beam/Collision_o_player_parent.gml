/// @description End the game
if (!o_controller_reactor_room.game_ended) {
	var _player_dummy = other.this_player_num == 0 ? o_catbot_dummy : o_cyclops_dummy;
	with (o_controller_reactor_room) {
		dead_player = instance_create_layer(other.x, other.y, "DeadPlayer", _player_dummy);
		game_ended = true;
		event_user(0);
	}
	instance_destroy(other);
}
