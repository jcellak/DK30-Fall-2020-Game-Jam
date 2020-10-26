/// @description Draw GUI based on the room
if (room == r_title) {
	var _title_text = "WorkingTitle";
	var _start_text = "Press space to play";
	
	draw_set_halign(fa_center);
	draw_set_font(f_title);
	draw_text_colour(room_width / 2 + 4, 24 + 6, _title_text, c_black, c_black, c_black, c_black, 1);
	draw_text_colour(room_width / 2, 24, _title_text, c_white, c_white, c_white, c_white, 1);
	
	draw_set_font(f_main);
	draw_text_colour(room_width / 2 + 1, room_height - 48 + 1, _start_text, c_black, c_black, c_black, c_black, 0.7);
	draw_text_colour(room_width / 2, room_height - 48, _start_text, c_white, c_white, c_white, c_white, 1);
}

if (room != r_title) {
	// Draw Health
	for (var _i = 1; _i <= hp; _i++) {
		draw_sprite_ext(s_heart, 0, (_i * 25) - 10, 15, 1, 1, 0, c_white, 1);
	}
	
	// Draw score
	draw_set_font(f_main);
	draw_set_halign(fa_left);
	draw_text(5, 25, "Score: " + string(sapphires));
}