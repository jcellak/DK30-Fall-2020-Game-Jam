/// @description Draw Sprite manually without collision mask if toggled off
if (sprite_index == -1) {
	draw_sprite_ext(initial_sprite_index, 0, x, y, 1, 1, 0, c_dkgray, 1);
} else {
	draw_self();
}