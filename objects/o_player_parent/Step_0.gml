/// @description Controlling the Player's state

#region Set up controls for the Player
if (!is_opponent or global.local_play) {
	right = keyboard_check(controls_right);
	left = keyboard_check(controls_left);
	up = keyboard_check(controls_up);
	down = keyboard_check(controls_down);
	up_release = keyboard_check_released(controls_up_release);
	shove_held = keyboard_check(controls_shove);
	shove_released = keyboard_check_released(controls_shove);
}
#endregion

#region Charging shove
if (shove_held && modules.shove) {
	shove_charge = clamp(shove_charge + 1, 0, global.player_charge[this_player_num]);
}
#endregion

#region State Machine
switch (state) {
	case PlayerState.moving:
		handle_player_state_moving();
		break;
	case PlayerState.ledge_grab:
		handle_player_state_ledge_grab();
		break;
	case PlayerState.door:
		handle_player_state_door();
		break;
	case PlayerState.hurt:
		handle_player_state_hurt();
		break;
	case PlayerState.death:
		handle_player_state_death();
		break;
}
#endregion
