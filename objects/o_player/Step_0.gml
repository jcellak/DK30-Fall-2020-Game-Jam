/// @description Control the player
               
#region Set up controls for the Player
right = keyboard_check(vk_right) or keyboard_check(ord("D"));
left = keyboard_check(vk_left) or keyboard_check(ord("A"));
up = keyboard_check(vk_up) or keyboard_check(ord("W"));
down = keyboard_check(vk_down) or keyboard_check(ord("S"));
up_release = keyboard_check_released(vk_up) or keyboard_check_released(ord("W"));
#endregion

event_inherited();
