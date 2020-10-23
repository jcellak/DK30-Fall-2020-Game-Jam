/// @description Initialize some variables

global.all_players_connected = false;
global.player_num = -1;
global.is_server = false;

max_hp = 100;
max_charge = 100;
player_hp = [max_hp, max_hp];
player_charge = [0, 0];

display_set_gui_size(camera_get_view_width(view_camera[0]), camera_get_view_height(view_camera[0]));

// Start the music
audio_master_gain(0.05);
//audio_play_sound(a_title, 10, false);

// Get rid of Cursor
//window_set_cursor(cr_none);

// Randomize it up
randomize();
