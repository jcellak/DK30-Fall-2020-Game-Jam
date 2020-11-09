/// @description Set random image speed
image_speed = random_range(1, 1.5);
alarm[0] = particle_spawn_interval;
alarm[1] = -1; // Set to enable intermittent on/off status
sprite_index = beam_sprite_index;