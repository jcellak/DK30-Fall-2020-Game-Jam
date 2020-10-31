/// @function draw_sprite_outlined
/// @param sprite
/// @param subimg
/// @param x
/// @param y
/// @param xscale
/// @param yscale
/// @param angle
/// @param color
/// @param outline_color
function draw_sprite_outlined(sprite, subimg, x, y, xscale, yscale, angle, color, outline_color)
{
	d3d_set_fog(true, outline_color, 0, 1);
	draw_sprite_ext(sprite, subimg, x - xscale, y, xscale, yscale, angle, c_white, 1);
	draw_sprite_ext(sprite, subimg, x + xscale, y, xscale, yscale, angle, c_white, 1);
	draw_sprite_ext(sprite, subimg, x, y - yscale, xscale, yscale, angle, c_white, 1);
	draw_sprite_ext(sprite, subimg, x, y + yscale, xscale, yscale, angle, c_white, 1);
	d3d_set_fog(0, 0, 0, 0);
	draw_sprite_ext(sprite, subimg, x, y, xscale, yscale, angle, color, 1);
}

/// @function draw_sprite_shadow
/// @param direction
/// @param distance
/// @param scale
/// @param color
/// @param alpha
/// @description Draws the shadow of a sprite
/// Using the calling object's x, y, image_angle, sprite_index & image_index
function draw_sprite_shadow(direction, distance, scale, color, alpha)
{
	/*
	 * Example use:
	 * draw_sprite_shadow(270, 3, 1, c_black, 0.5);
	 * draw_self();
	 */
	var _xx = x + lengthdir_x(distance, direction);
	var _yy = y + lengthdir_y(distance, direction);
	d3d_set_fog(true, color, 0, 1);
	draw_sprite_ext(sprite_index, image_index, _xx, _yy, scale, scale, image_angle, c_white, alpha);
	d3d_set_fog(0, 0, 0, 0);
}

/// @function draw_text_outlined
/// @param x
/// @param y
/// @param string
/// @param color
/// @param outline_color
function draw_text_outlined(x, y, string, color, outline_color)
{
	draw_set_color(outline_color);
	draw_text(x - 1, y, string_hash_to_newline(string));
	draw_text(x + 1, y, string_hash_to_newline(string));
	draw_text(x, y - 1, string_hash_to_newline(string));
	draw_text(x, y + 1, string_hash_to_newline(string));
	draw_set_color(color);
	draw_text(x, y, string_hash_to_newline(string));
	draw_set_color(c_white);
}

/// @function draw_text_shadow
/// @param x
/// @param y
/// @param string
/// @param color
/// @param shadow_color
/// @param shadow_alpha
function draw_text_shadow(x, y, string, color, shadow_color, shadow_alpha)
{
	// Draw shadow
	draw_set_color(shadow_color);
	draw_set_alpha(shadow_alpha);
	draw_text(x + 1, y + 1, string_hash_to_newline(string));

	// Draw Text
	draw_set_color(color);
	draw_set_alpha(1);
	draw_text(x, y, string_hash_to_newline(string));
	draw_set_color(c_white);
}

/// @function draw_text_shadow_ext
/// @param x
/// @param y
/// @param string
/// @param color
/// @param shadow_color
/// @param shadow_direction
/// @param shadow_distance
/// @param shadow_alpha
function draw_text_shadow_ext(x, y, string, color, shadow_color, shadow_direction, shadow_distance, shadow_alpha)
{
	// Draw text shadow
	draw_set_color(shadow_color);
	draw_set_alpha(shadow_alpha);
	var shadow_x = x + lengthdir_x(shadow_distance, shadow_direction);
	var shadow_y = y + lengthdir_y(shadow_distance, shadow_direction);
	draw_text(shadow_x, shadow_y, string_hash_to_newline(string));

	// Draw text
	draw_set_color(color);
	draw_set_alpha(1);
	draw_text(x, y, string_hash_to_newline(string));
	draw_set_color(c_white);
}

/// @function draw_sprite_nine_slice_box
/// @param _sprite The nine slice sprite to draw
/// @param _x The x coordinate of where to draw the sprite
/// @param _y The y coordinate of where to draw the sprite
/// @param _w Width of the UI box to draw in pixels
/// @param _h Height of the UI box to draw in pixels
/// @param _a Alpha
function draw_sprite_nine_slice_box(_sprite, _x, _y, _w, _h, _a)
{
	var _size = sprite_get_width(_sprite) / 3;
	
	// MIDDLE SLICE
	draw_sprite_part_ext(_sprite, 0, _size, _size, 1, 1, _x+_size, _y+_size, _w-(_size*2), _h-(_size*2), c_white, _a);
	
	// CORNER SLICES
	// top left
	draw_sprite_part_ext(_sprite, 0, 0, 0, _size, _size, _x, _y, 1, 1, c_white, _a);
	// top right
	draw_sprite_part_ext(_sprite, 0, _size*2, 0, _size, _size, _x+_w-_size, _y, 1, 1, c_white, _a);
	// bottom left
	draw_sprite_part_ext(_sprite, 0, 0, _size*2, _size, _size, _x, _y+_h-_size, 1, 1, c_white, _a);
	// bottom right
	draw_sprite_part_ext(_sprite, 0, _size*2, _size*2, _size, _size, _x+_w-_size, _y+_h-_size, 1, 1, c_white, _a);
	
	// EDGE SLICES
	// left edge
	draw_sprite_part_ext(_sprite, 0, 0, _size, _size, 1, _x, _y+_size, 1, _h-(_size*2), c_white, _a);
	// right edge
	draw_sprite_part_ext(_sprite, 0, _size*2, _size, _size, 1, _x+_w-_size, _y+_size, 1, _h-(_size*2), c_white, _a);
	// top edge
	draw_sprite_part_ext(_sprite, 0, _size, 0, 1, _size, _x+_size, _y, _w-(_size*2), 1, c_white, _a);
	// bottom edge
	draw_sprite_part_ext(_sprite, 0, _size, _size*2, 1, _size, _x+_size, _y+_h-(_size), _w-(_size*2), 1, c_white, _a);
}
