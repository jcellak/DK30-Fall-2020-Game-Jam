/// @description Controlling the Player's state

#region Set up controls for the Player
right = keyboard_check(ord("D"));
left = keyboard_check(ord("A"));
up = keyboard_check(ord("W"));
down = keyboard_check(ord("S"));
up_release = keyboard_check_released(ord("W"));
#endregion

event_inherited();
