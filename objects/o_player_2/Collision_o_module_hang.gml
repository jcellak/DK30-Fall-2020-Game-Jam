/// @description 
event_inherited();

if (global.player_2_modules.hang == false) {
	audio_play_sound(a_item_pickup, 5, false);
	global.player_2_modules.hang = true;

	with (other) {
		instance_destroy();	
	}
}
