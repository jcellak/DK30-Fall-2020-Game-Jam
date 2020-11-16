/// @description Controlling the Player's state

#region Set up controls for the Player
if (!is_opponent or global.local_play) {
	right = keyboard_check(controls_right);
	right_pressed = keyboard_check_pressed(controls_right);
	right_released = keyboard_check_released(controls_right);
	left = keyboard_check(controls_left);
	left_pressed = keyboard_check_pressed(controls_left);
	left_released = keyboard_check_released(controls_left);
	up = keyboard_check(controls_up);
	up_pressed = keyboard_check_pressed(controls_up);
	up_release = keyboard_check_released(controls_up_release);
	down = keyboard_check(controls_down);
	down_pressed = keyboard_check_pressed(controls_down);
	blast_held = keyboard_check(controls_blast);
	blast_released = keyboard_check_released(controls_blast);
}
#endregion

#region Charging blast
if (blast_held && modules.blast) {
	if (!audio_is_playing(a_charging) and blast_charge < global.player_charge[this_player_num]) audio_play_sound(a_charging, 10, false);
	if (blast_charge + 1 == global.player_charge[this_player_num]) {
		if (!audio_is_playing(a_tink)) audio_play_sound(a_tink, 10, false);
		audio_stop_sound(a_charging);
	}
	blast_charge = clamp(blast_charge + 1, 0, global.player_charge[this_player_num]);
} else {
	audio_stop_sound(a_charging);
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

#region Dedupers
if (dedupe_step_sound > 0) dedupe_step_sound--;
if (dedupe_hurt_sound > 0) dedupe_hurt_sound--;
if (jump_timer > 0) jump_timer--;
#endregion
