/// @description Controlling the Player's state

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