/// @description Create little lava particles
var _x = (x - sprite_width / 2) + random(sprite_width);
var _y = y - sprite_height / 2;

with (instance_create_layer(_x, _y, "Lava", o_particle)) {
	image_blend = c_yellow;
}

alarm[0] = random_range(10, 20);