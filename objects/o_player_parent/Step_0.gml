/// @description Controlling the Player's state

#region Set up controls for the Player
right = keyboard_check(controls_right);
left = keyboard_check(controls_left);
up = keyboard_check(controls_up);
down = keyboard_check(controls_down);
up_release = keyboard_check_released(controls_up_release);
#endregion

#region State Machine
switch (state) {
	case player.moving:
		handle_player_state_moving();
		break;
	case player.ledge_grab:
		handle_player_state_ledge_grab();
		break;
	case player.door:
		handle_player_state_door();
		break;
	case player.hurt:
		handle_player_state_hurt();
		break;
	case player.death:
		handle_player_state_death();
		break;
}
#endregion