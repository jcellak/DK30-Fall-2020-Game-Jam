/// @description Adjust volume and animations

audio_sound_gain(a_boss_track_edit,global.vol[0]*global.vol[2],0);

if (game_ended and dead_player != noone) {
	instance_create_layer(dead_player.x, dead_player.y, "Particles", o_particle);
	
	//(607, 205) is the center of the beams
	dead_player.x = lerp(dead_player.x, 607, 0.02);
	dead_player.y = lerp(dead_player.y, 205, 0.02);
	
	dead_player.image_blend = merge_color(dead_player.image_blend, c_dkgray, 0.02);
}
