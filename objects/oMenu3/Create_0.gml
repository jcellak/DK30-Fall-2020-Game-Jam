/// @desc GUI/vars/Menu setup

gui_width = display_get_gui_width();
gui_height = display_get_gui_height();
gui_margin = 32;

x_offset = 400;
y_offset = ((gui_height - (gui_margin*2))/4)-gui_margin;
l_column = gui_width-x_offset-gui_margin;
//l_col_def = l_column;
back_x = 50;
back_y = -(sprite_get_height(sBackArrow) +10)
back_y_def= back_y
back_y_target = 50;

restore_def = (array_length(oController.maps)*2);
restore_def_dis = "Restore Default";
back = - 1;
menu_com_null = back - 1;

key_input = true;
del_mode = false;

menu_speed = 15; // lower is faster
menu_font = fMenu;
menu_itemheight = font_get_size(fMenu);

menu_committed = menu_com_null;
menu_control = true;

row1 = 125;
row2 = 50;
column = 360;
upgrade_scale = 0.72;
upgrade_width = sprite_get_width(sUpgrade)*upgrade_scale;
upgrade_margin = 0;

v_dist = 230;
v_hover = noone;
v_height = 35;
v_inc = 0.05;

alter_v[2] = false; // main volume
alter_v[1]= false; // sfx volume
alter_v[0] = false; // music volume

menu_x = gui_width - gui_margin;
menu_y = gui_height + 250;
menu_y_def = menu_y;
menu_y_target = gui_height - gui_margin;

load_x = gui_width + 450;
load_x_def = load_x
load_x_target = load_x;
load_y_init = (gui_height-(gui_margin*2.5)) + ((array_length(oController.savkey)-4)*y_offset) + gui_margin;
load_y = load_y_init;

menu_box_fuls = "FULLSCREEN     ";
menu_box_bord = "BORDERLESS     ";//5 spaces
menu_box_del = "DELETE SAVE";
options[6] = "MAIN AUDIO";
options[5] = "SFX AUDIO";
options[4] = "MUSIC AUDIO";
options[3] = menu_box_fuls;
options[2] = menu_box_bord;
options[1] = "CONTROLS";
options[0] = menu_box_del;

array_v = 4;
option_dist = ((array_length(options))*menu_itemheight*2.8)
option_x = gui_width - gui_margin;
option_y = -option_dist - gui_margin;
option_y_def = option_y;
option_y_target = option_y;
menu_top_alt = option_y - ((menu_itemheight * 1.5) * array_v);
event_user(1);

map_x = gui_width + 500;
map_y = gui_height - 10;
map_x_def = map_x;
map_x_target = map_x;
map_box_margin = 2;
map_box_y = (map_y-gui_margin)/(array_length(oController.maps)*map_box_margin);
map_x_event = gui_width - (gui_margin*2) - map_box_y;
map_box_x = (map_x_event - l_column)*0.4//x_offset*0.4;

new_key = false;
new_map = menu_com_null
map_column = map_x - (((x_offset) - (map_box_x *2)) + map_box_x);

menu[3] = global.save != -1? "CONTINUE" : "NEW GAME";
menu[2] = "LOAD GAME";
menu[1] = "OPTIONS";
menu[0] = "QUIT";

current_array = menu
menu_items = array_length(menu);
menu_cursor = array_length(menu)-1;

for (var i = 0; i < array_length(oController.savkey); i++)
{
	var _loadisplay = string_insert((array_length(oController.savkey) - i), "Game ", 6);
	load[i] = _loadisplay;
}

//load[3] = "Game 1";
//load[2] = "Game 2";
//load[1] = "Game 3";
//load[0] = "Game 4";

sliding = false;
no_data = false;
