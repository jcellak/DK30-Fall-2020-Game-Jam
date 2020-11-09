/// @description Toggle Sprite, Collision, and Depth

if (is_toggled && !is_toggled_previous) {
	sprite_index = -1;
	depth = layer_get_depth("BackgroundTiles") - 1;
	is_toggled_previous = is_toggled;
} else if (!is_toggled && is_toggled_previous) {
	sprite_index = initial_sprite_index;
	depth = layer_get_depth("Obstacles");
	is_toggled_previous = is_toggled;
}