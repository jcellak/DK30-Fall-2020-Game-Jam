draw_sprite_shadow();
/// @description Draws the player and any additional effects
draw_self();
if (blast_charge > 0) {
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
		clamp(2 * blast_charge / global.max_charge, 0, 1)
	);
	if (blast_charge >= global.player_charge[this_player_num]) {
		if (flash_timer < 10) {
			draw_sprite_ext(
				sprite_index,
				image_index,
				x,
				y,
				image_xscale,
				image_yscale,
				image_angle,
				c_red,
				clamp(flash_timer / 10, 0, 1)
			);
		} else if (flash_timer > 20) {
			flash_timer = 0;
		}
		flash_timer++;
	}
	gpu_set_blendmode(bm_normal);
}