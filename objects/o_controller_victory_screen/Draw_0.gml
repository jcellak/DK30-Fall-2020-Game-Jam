/// @description Draw victory screen

/// @desc 
image_speed = 0.3;
//draw_sprite(s_electrical,-1,60,165);
DrawSetText(c_lime,m_font,fa_left,fa_bottom,1)

draw_line(l_screen+10,t_screen+(margin),r_screen-10,t_screen+(margin));

draw_set_color(c_lime);

if (global.winner != noone) {
	draw_text(l_screen + margin, t_screen + margin, (global.winner.this_player_num == 0 ? "Catbot" : "Cyclops") + " Wins!");
}

draw_text(l_screen + margin, t_screen + margin * 2, "Press ESC to restart.");

draw_sprite(s_screen_crack,0,40,5);

if (global.winner != noone) {
	draw_sprite_ext(global.winner.this_player_num == 0 ? s_player_catbot_walk : s_player_cyclops_walk,-1,x_one,221,dir_one*1.5,1.5,1,c_white,1);
}

