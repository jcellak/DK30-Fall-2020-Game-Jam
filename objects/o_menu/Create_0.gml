/// @desc 
x_one = random_range(30,115);
x_two = random_range(295,385);
rob_spd = 3;
dir_one = 1;
dir_two = -1;
left_one = false;
left_two = true;
flikr = true;
flikr_time = 0;

//title[0] = [];

main[0] = "SINGLE PLAYER";
main[1] = "MULTIPLAYER";

multiplayer[0] = "LOCAL";
multiplayer[1] = "JOIN";
multiplayer[2] = "HOST";

con_options = "OPTIONS";
con_key = "CONTROLS";
con[1] = con_options;
con[2] = "QUIT";
con[0] = "BACK";

play[0] = "STORY MODE";
play[1] = "ARCADE MODE";

opt[0] = "MASTER VOLUME";
opt[1] = "SFX VOLUME";
opt[2] = "MUSIC VOLUME";
opt[3] = con_key;

key[0] = "LEFT";
key[1] = "RIGHT";
key[2] = "UP";
key[3] = "DOWN";
key[4] = "USE";

menu_waiting = [];
menu_connect = [];

menu_start_multiplayer[0] = "START GAME";

m_font = f_menu;
def_key = "RESTORE DEFAULT";
item_height = font_get_size(m_font)+2;

l_screen = 70;
r_screen = 375;
t_screen = 10;
b_screen = 182
margin = 30;
screen_w = r_screen-l_screen;
screen_h = b_screen - t_screen;
screen_split = (screen_w - (margin*2) - string_width(con[2]))*0.5;
v_dist = screen_w*0.35;

cursor = 0;
cur_null = noone;
cur_committed = cur_null;
current_menu = multiplayer;
prev_menu = current_menu;
menu_items = array_length(current_menu)
exempt = menu_items;
key_input = true;
sliding = cur_null;

menu_control = true;
new_key = false;
new_map = cur_null;
restore_def = array_length(key) * 2;

vol_inc = 0.05;
