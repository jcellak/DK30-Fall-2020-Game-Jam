/// @description Increase charge
var playerNum = global.player_num;
if (global.local_play) {
	playerNum = is_opponent ? 1 : 0;
}

o_main_controller.player_charge[playerNum] += 20;
if (o_main_controller.player_charge[playerNum] >= o_main_controller.max_charge) {
	o_main_controller.player_charge[playerNum] = o_main_controller.max_charge;
	// TODO: Overload the player?
}

send_event_player_pickup(other.object_index);

audio_play_sound(a_item_pickup, 5, false);

with (other) {
	send_event_instance_destroyed();
	instance_destroy();
}
