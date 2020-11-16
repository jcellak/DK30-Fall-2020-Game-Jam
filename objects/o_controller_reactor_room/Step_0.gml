/// @description Adjust volume and animations

audio_sound_gain(a_boss_track_edit,global.vol[0]*global.vol[2],0);

if (game_ended and dead_player != noone) {
	instance_create_layer(dead_player.x, dead_player.y, "Particles", o_particle);
	
	//(607, 205) is the center of the beams
	dead_player.x = lerp(dead_player.x, 607, 0.02);
	dead_player.y = lerp(dead_player.y, 205, 0.02);
	
	dead_player.image_blend = merge_color(dead_player.image_blend, c_dkgray, 0.02);
}

if (instance_exists(inst_114AAAFF) and inst_114AAAFF.is_toggled) {
	instance_destroy(inst_114AAAFF);
	instance_destroy(inst_191C6B7);
	for (var _i = 0; _i < instance_number(o_solid_disappearing); _i++) {
		var _this_block = instance_find(o_solid_disappearing, _i);
		if (_this_block != noone) {
			with (_this_block) {
				if (within(x, y, 30, 20, 140, 110)) {
					is_toggled = true;
				}
			}
		}
	}
	
	alarm_set(1, alarm_1_timer);
}
