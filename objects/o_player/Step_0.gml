/// @description Controlling the Player's state

#region Set up controls for the Player
right = keyboard_check(vk_right);
left = keyboard_check(vk_left);
up = keyboard_check(vk_up);
down = keyboard_check(vk_down);
up_release = keyboard_check_released(vk_up);
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