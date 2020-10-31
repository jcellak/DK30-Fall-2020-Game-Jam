/// @description Controlling the Player's state

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
