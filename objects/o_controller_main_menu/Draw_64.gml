/// @description Draw GUI based on the room

var _title_text = "WorkingTitle";
	
var _start_text = "2 players required";
if (global.my_player_num != -1 && global.is_server) {
	if (global.all_players_connected) {
		_start_text = "Press space to play";
	} else {
		_start_text = "Waiting for a client";
	}
} else if (global.my_player_num != -1 && !global.is_server) {
	_start_text = "Waiting for server";
}
	
draw_set_halign(fa_center);
draw_set_font(f_title);
draw_text_colour(room_width / 2 + 4, 24 + 6, _title_text, c_black, c_black, c_black, c_black, 1);
draw_text_colour(room_width / 2, 24, _title_text, c_white, c_white, c_white, c_white, 1);

draw_set_font(f_primary);
draw_text_colour(room_width / 2 + 1, room_height - 68 + 1, _start_text, c_black, c_black, c_black, c_black, 0.7);
draw_text_colour(room_width / 2, room_height - 68, _start_text, c_white, c_white, c_white, c_white, 1);
