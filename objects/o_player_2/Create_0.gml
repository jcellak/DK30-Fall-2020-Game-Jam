/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

modules = global.player_2_modules;
is_opponent = global.is_server;
this_player_num = 1;

if (global.local_play) {
	controls_left = global.key_two[0];
	controls_right = global.key_two[1];
	controls_down = global.key_two[2];
	controls_up = global.key_two[3];
	controls_up_release = global.key_two[3];
	controls_blast = global.key_two[4];
}
