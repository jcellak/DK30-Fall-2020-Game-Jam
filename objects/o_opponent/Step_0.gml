/// @description Set up controls if Local

#region Set up controls
if (global.local_play) {
	right = keyboard_check(vk_right);
	left = keyboard_check(vk_left);
	up = keyboard_check(vk_up);
	down = keyboard_check(vk_down);
	up_release = keyboard_check_released(vk_up);
}
#endregion

// Inherit the parent event
event_inherited();
