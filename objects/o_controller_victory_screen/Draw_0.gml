/// @description Draw victory screen

/// @desc 
image_speed = 0.3;
//draw_sprite(s_electrical,-1,60,165);
DrawSetText(c_lime,m_font,fa_left,fa_bottom,1);

draw_set_color(c_lime);

var _timer = credits_timer - 300 < 0 ? 0 : round((credits_timer - 300) / 3);
var _top = t_screen + margin;
if (abs(t_screen + margin * 24 - _timer - (_top + margin * 4)) < 5) pause_timer = true;

if (global.winner != noone) {
	if (credits_timer < 200)
		draw_text(l_screen + margin, t_screen + margin * 3, (global.winner.this_player_num == 0 ? "CATBOT" : "CYCLOPS") + " WINS!");
}

if (credits_timer >= 200 and t_screen + margin * 3 - _timer > _top) {
	DrawSetText(c_lime,f_menu_big,fa_left,fa_bottom,1);
	draw_text(l_screen + margin, t_screen + margin * 3 - _timer, "AFT3R-U");
	DrawSetText(c_lime,m_font,fa_left,fa_bottom,1);
}
if (t_screen + margin * 6 - _timer > _top and t_screen + margin * 6 - _timer < b_screen)
	draw_text(l_screen + margin, t_screen + margin * 6 - _timer, "Writing by:");
if (t_screen + margin * 7 - _timer > _top and t_screen + margin * 7 - _timer < b_screen)
	draw_text(l_screen + margin, t_screen + margin * 7 - _timer, "Maxweil");
if (t_screen + margin * 9 - _timer > _top and t_screen + margin * 9 - _timer < b_screen)
	draw_text(l_screen + margin, t_screen + margin * 9 - _timer, "Music by:");
if (t_screen + margin * 10 - _timer > _top and t_screen + margin * 10 - _timer < b_screen)
	draw_text(l_screen + margin, t_screen + margin * 10 - _timer, "Abou");
if (t_screen + margin * 11 - _timer > _top and t_screen + margin * 11 - _timer < b_screen)
	draw_text(l_screen + margin, t_screen + margin * 11 - _timer, "Jake \"Jakeapus\"");
if (t_screen + margin * 13 - _timer > _top and t_screen + margin * 13 - _timer < b_screen)
	draw_text(l_screen + margin, t_screen + margin * 13 - _timer, "Programming by:");
if (t_screen + margin * 14 - _timer > _top and t_screen + margin * 14 - _timer < b_screen)
	draw_text(l_screen + margin, t_screen + margin * 14 - _timer, "Llamakazi");
if (t_screen + margin * 15 - _timer > _top and t_screen + margin * 15 - _timer < b_screen)
	draw_text(l_screen + margin, t_screen + margin * 15 - _timer, "Caleb \"Shiro\"");
if (t_screen + margin * 16 - _timer > _top and t_screen + margin * 16 - _timer < b_screen)
	draw_text(l_screen + margin, t_screen + margin * 16 - _timer, "Ryan \"Seibukan\"");
if (t_screen + margin * 18 - _timer > _top and t_screen + margin * 18 - _timer < b_screen)
	draw_text(l_screen + margin, t_screen + margin * 18 - _timer, "Special thanks:");
if (t_screen + margin * 19 - _timer > _top and t_screen + margin * 19 - _timer < b_screen)
	draw_text(l_screen + margin, t_screen + margin * 19 - _timer, "EdwardDKings");
if (t_screen + margin * 20 - _timer > _top and t_screen + margin * 20 - _timer < b_screen and !pause_timer)
	draw_text(l_screen + margin, t_screen + margin * 20 - _timer, "Yeuo");
if (t_screen + margin * 22 - _timer > _top and t_screen + margin * 22 - _timer < b_screen) {
	DrawSetText(c_lime,f_menu_big,fa_left,fa_bottom,1);
	draw_text(l_screen + margin, t_screen + margin * 22 - _timer, "Thanks for playing!");
	DrawSetText(c_lime,m_font,fa_left,fa_bottom,1);
}

draw_line(l_screen+10,b_screen,r_screen-10,b_screen);
draw_text(l_screen + margin, b_screen + margin, "Press ESC to restart.");

draw_sprite(s_screen_crack,0,40,5);

if (global.winner != noone) {
	draw_sprite_ext(global.winner.this_player_num == 0 ? s_player_catbot_walk : s_player_cyclops_walk,-1,x_one,221,dir_one*1.5,1.5,1,c_white,1);
}

