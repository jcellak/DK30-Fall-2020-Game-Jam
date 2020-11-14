/// @desc 
draw_set_font(f_menu_small)
draw_sprite(s_score,0,gui_split,0)
draw_sprite(s_battery,0,gui_split-35,14);
draw_sprite(s_battery,0,gui_split+36,14);
var _battery1 = string(((global.player_charge[0])/10)-4)
var _battery2 = string(((global.player_charge[1])/10)-4)
draw_text(gui_split-45,38,_battery1 + "/8");
draw_text(gui_split+25,38,_battery2 + "/8");
if global.player_1_modules.double draw_sprite_ext(s_score_jump,0,gui_split-20,7,1,1,0,c_white,1);
if global.player_2_modules.double draw_sprite_ext(s_score_jump,0,gui_split+20,7,-1,1,0,c_white,1);
if global.player_1_modules.dash draw_sprite_ext(s_score_dash,0,gui_split-5,10,-1,1,0,c_white,1);
if global.player_2_modules.dash draw_sprite_ext(s_score_dash,0,gui_split+5,10,1,1,0,c_white,1);
