/// @description Draw GUI based on the room
if (room == r_title) {
	var _title_text = "CaveBoy";
	
	var _start_text = "2 players required";
	if (global.player_num != -1 && global.is_server) {
		if (global.all_players_connected) {
			_start_text = "Press space to play";
		} else {
			_start_text = "Waiting for a client";
		}
	} else if (global.player_num != -1 && !global.is_server) {
		_start_text = "Waiting for server";
	}
	
	draw_set_halign(fa_center);
	draw_set_font(f_title);
	draw_text_colour(room_width / 2 + 4, 24 + 6, _title_text, c_black, c_black, c_black, c_black, 1);
	draw_text_colour(room_width / 2, 24, _title_text, c_white, c_white, c_white, c_white, 1);
	
	draw_set_font(f_main);
	draw_text_colour(room_width / 2 + 1, room_height - 68 + 1, _start_text, c_black, c_black, c_black, c_black, 0.7);
	draw_text_colour(room_width / 2, room_height - 68, _start_text, c_white, c_white, c_white, c_white, 1);
}

if (room != r_title) {
	// Draw Player 1 Stats
	draw_set_font(f_main);
	draw_set_halign(fa_left);
	draw_text(5, 5, "Player 1");
	draw_text(5, 25, "HP: " + string(player_hp[0]));
	draw_text(5, 45, "Charge: " + string(player_charge[0]));
	
	// Camera width doesn't always match room width
	var camWidth = camera_get_view_width(view_camera[0]);
	// Draw Player 2 Stats
	draw_set_halign(fa_right);
	draw_text(camWidth - 5, 5, "Player 2");
	draw_text(camWidth - 5, 25, "HP: " + string(player_hp[1]));
	draw_text(camWidth - 5, 45, "Charge: " + string(player_charge[1]));
}
