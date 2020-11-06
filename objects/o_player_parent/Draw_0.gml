/// @description Draws the player and any additional effects
draw_self();
if (shove_charge > 0) {
	//draw a colored sprite over our normal sprite.
	gpu_set_blendmode(bm_add);
	draw_sprite_ext(
		sprite_index,
		image_index,
		x,
		y,
		image_xscale,
		image_yscale,
		image_angle,
		c_teal,
		clamp(2 * shove_charge / global.max_charge, 0, 1)
	);
	gpu_set_blendmode(bm_normal);
}