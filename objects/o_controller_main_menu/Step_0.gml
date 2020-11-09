/// @description Begin the game
if (keyboard_check_pressed(vk_space)) {
	room_goto_next();
}

// Multi-touch particles on click/tap
if (device_mouse_check_button_pressed(0, mb_left)) {
	effect_create_above(ef_ring, device_mouse_x(0), device_mouse_y(0), 0, c_white);
}

if (keyboard_check_pressed(vk_f4)) {
	effect_create_above(ef_spark, mouse_x, mouse_y, 0, c_white);
}

if (keyboard_check_pressed(vk_f5)) {
	effect_create_above(ef_flare, mouse_x, mouse_y, 0, c_white);
}

if (keyboard_check_pressed(vk_f6)) {
	effect_create_above(ef_firework, mouse_x, mouse_y, 0, c_white);
}

if (keyboard_check_pressed(vk_f7)) {
	effect_create_above(ef_spark, mouse_x, mouse_y, 0, c_white);
}