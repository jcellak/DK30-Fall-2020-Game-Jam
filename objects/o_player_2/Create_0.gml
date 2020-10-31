/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

modules = global.player_2_modules;
is_opponent = global.is_server;
this_player_num = 1;

if (global.local_play) {
	controls_right = vk_right;
	controls_left = vk_left;
	controls_up = vk_up;
	controls_down = vk_down;
	controls_up_release = vk_up;
}
