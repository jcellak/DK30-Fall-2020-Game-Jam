/// @description 

if (is_toggled && !is_toggled_previous) {
	//mask_index = -1;
	sprite_index = -1;
	alarm[0] = -1; // Disable Alarm
	is_toggled_previous = is_toggled;
} else if (!is_toggled && is_toggled_previous) {
	//mask_index = beam_sprite_index;
	sprite_index = beam_sprite_index;
	alarm[0] = particle_spawn_interval; // Reset Alarm
	is_toggled_previous = is_toggled;
}