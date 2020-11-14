/// @description Stage Init
instance_create_layer(0, 0, "Transitions", o_transition_fade_in);

Sound_list();
Music_list();

if (audio_is_playing(a_two_robots)) {
	audio_stop_sound(a_two_robots);
}

if (!audio_is_playing(a_coop_track)) {
	audio_play_sound(a_coop_track, 10, true);
}

con_options = "OPTIONS";
con_key = "CONTROLS";
con[1] = con_options;
con[2] = "QUIT";
con[0] = "BACK";

opt[0] = "MASTER VOLUME";
opt[1] = "SFX VOLUME";
opt[2] = "MUSIC VOLUME";
opt[3] = con_key;
opt[4] = "MAIN MENU";
opt[5] = "RESTART LEVEL";

key[0] = "LEFT";
key[1] = "RIGHT";
key[2] = "DOWN";
key[3] = "UP";
key[4] = "USE";

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
gui_split = display_get_gui_width()*.5

flikr = true;
flikr_time = 0;

cursor = 0;
cur_null = noone;
cur_committed = cur_null;
current_menu = opt;

menu_items = array_length(current_menu)
exempt = menu_items+1;
key_input = true;
sliding = cur_null;

menu_control = true;
new_key = false;
new_map = cur_null;
restore_def = array_length(key) * 2;

vol_inc = 0.05; 

screenshot = noone;

initial_player_state = [{}, {}];

for (var i = 0; i < 2; i++) {
	initial_player_state[i].hp = global.player_hp[i];
	initial_player_state[i].charge = global.player_charge[i];
	var _mods = (i == 0 ? global.player_1_modules : global.player_2_modules);
	initial_player_state[i].modules = {
		jump: _mods.jump,
		hang: _mods.hang,
		dash: _mods.dash,
		double: _mods.double,
		blast: _mods.blast
	};
}
global.player_2_modules.dash = true;
global.player_1_modules.double = true;

