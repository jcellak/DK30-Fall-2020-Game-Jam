/// @description Increase charge
o_main_controller.player_charge[global.player_num] += 20;
if (o_main_controller.player_charge[global.player_num] >= o_main_controller.max_charge) {
	o_main_controller.player_charge[global.player_num] = o_main_controller.max_charge;
	// TODO: Overload the player?
}

send_event_player_pickup(other.object_index);

audio_play_sound(a_item_pickup, 5, false);

with (other) {
	send_event_instance_destroyed();
	instance_destroy();
}
