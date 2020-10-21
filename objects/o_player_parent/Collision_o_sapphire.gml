/// @description Increase charge
o_main_controller.player_charge[player_num] += 20;
if (o_main_controller.player_charge[player_num] >= o_main_controller.max_charge) {
	o_main_controller.player_charge[player_num] = o_main_controller.max_charge;
	// TODO: Overload the player?
}

audio_play_sound(a_item_pickup, 5, false);

with (other) {
	instance_destroy();	
}