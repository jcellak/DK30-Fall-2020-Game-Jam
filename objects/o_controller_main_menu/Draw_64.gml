/// @description Draw GUI based on the room
var _title_text = "WorkingTitle";
var _start_text = "Press space to play";
	
draw_set_halign(fa_center);
draw_set_font(f_title);
draw_text_colour(room_width / 2 + 4, 24 + 6, _title_text, c_black, c_black, c_black, c_black, 1);
draw_text_colour(room_width / 2, 24, _title_text, c_white, c_white, c_white, c_white, 1);
	
draw_set_font(f_primary);
draw_text_colour(room_width / 2 + 1, room_height - 48 + 1, _start_text, c_black, c_black, c_black, c_black, 0.7);
draw_text_colour(room_width / 2, room_height - 48, _start_text, c_white, c_white, c_white, c_white, 1);