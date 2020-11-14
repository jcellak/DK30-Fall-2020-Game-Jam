/// @description Colliding with an enemy
if (!is_opponent or global.local_play) {
	
	// Check if we're above them
	var _above_enemy = y < other.y + yspeed;
	var _falling = yspeed > 0;

	if (_above_enemy && (_falling || state == PlayerState.ledge_grab)) {
		// Keep player above the enemy
		if (!place_meeting(x, yprevious, o_solid)) {
			y = yprevious;
		}
	
		// Get as close to the enemy as possible
		while (!place_meeting(x, y + 1, other)) {
			y++;
		}
	
		with (other) {
			send_event_instance_destroyed();
			instance_destroy();
		}
	
		// Bounce off the enemy
		yspeed = -(16 / 3)
		audio_play_sound(a_falling, 6, false);
	} else {
		handle_player_take_damage(0);
		send_event_player_damaged(0);
	}

}
