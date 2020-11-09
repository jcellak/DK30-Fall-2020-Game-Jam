/// @description Create little particles

// X and Y origin of "spark" particles generated
// Assumes sprite origin is @ middle center
var _x = x;// + sprite_width / 2;
var _y = y;// + sprite_height / 2;

with (instance_create_layer(_x, _y, "Particles", o_particle)) {
	//var _color = $6FD7E7;
	//image_blend = make_color_hsv(188, 51, 90);
}

alarm[0] = particle_spawn_interval;