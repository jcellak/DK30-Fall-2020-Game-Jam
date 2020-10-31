/// @desc 
x_one = random_range(30,115);
x_two = random_range(295,385);
rob_spd = 3;
dir_one = 1;
dir_two = -1;
left_one = false;
left_two = true;

main[0] = "SINGLE PLAYER";
main[1] = "MULTIPLAYER";

multiplayer[0] = "LOCAL";
multiplayer[1] = "HOST";
multiplayer[2] = "JOIN";

con[1] = "OPTIONS";
con[2] = "QUIT";
con[0] = "BACK";

play[0] = "STORY MODE";
play[1] = "ARCADE MODE";

opt[0] = "MASTER VOLUME";
opt[1] = "SFX VOLUME";
opt[2] = "MUSIC VOLUME";
opt[3] = "KEY BINDINGS";

key[0] = "LEFT";
key[1] = "RIGHT";
key[2] = "UP";
key[3] = "DOWN";

//step[0] = main;
//step[1] = multiplayer;
//step[2] = play;

l_screen = 70;
r_screen = 375;
b_screen = 182;
t_screen = 15;
margin = 30;
screen_w = r_screen-l_screen;
screen_h = b_screen-t_screen;
screen_split = (screen_w - (margin*2) - string_width(con[2]))*0.5;

cursor = 0;
cur_null = noone;
cur_committed = cur_null;
current_menu = main;
prev_menu = main
menu_items = array_length(current_menu)
exempt = menu_items;

menu_control = true;
new_key = false;
new_map = cur_null;
restore_def = array_length(key) * 2;

m_font = f_Menu;

vol_inc = 0.05;
