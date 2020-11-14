/// @description Increase Charge

if ((!is_opponent or global.local_play) and global.player_charge[this_player_num] < global.max_charge) {
	global.player_charge[this_player_num] += 10;
	if (global.player_charge[this_player_num] >= global.max_charge) {
		global.player_charge[this_player_num] = global.max_charge;
		// TODO: Overload the player?
	}

	audio_play_sound(a_item_pickup, 5, false);

	with (other) {
		send_event_instance_destroyed();
		instance_destroy();	
	}
	
}
