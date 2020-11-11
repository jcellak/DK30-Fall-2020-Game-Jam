/// @description Initialize Global Variables and Game Setup

PlayerModules = function() constructor
{
	jump = true;
	hang = true;
	dash = true;
	double = true;
	blast = true;
}

event_user(0);
vol[0] = 0; //main
vol[1] = 0.5; //sfx
vol[2] = 0.5; //music

multiplayer = false;
pause_menu = false;

global.player_1_modules = new PlayerModules();
global.player_2_modules = new PlayerModules();

global.max_hp = 100;
global.max_charge = 180;
global.player_hp = [global.max_hp, global.max_hp];
global.player_charge = [60,60];

global.multiplayer = false;
global.all_players_connected = false;
global.my_player_num = -1;
global.is_server = false;
global.local_play = true;

global.pause = false;

// Start the music
audio_master_gain(0.05);
if (!audio_is_playing(a_cave_loop)) {
	audio_play_sound(a_cave_loop, 10, true);
}

// Get rid of Cursor
//window_set_cursor(cr_none);

randomize(); // Generate a random seed for this runtime

var _game_width = camera_get_view_width(view_camera[0]);
var _game_height = camera_get_view_height(view_camera[0]);
	
// Scale "Draw GUI" Events to camera/game width/height
display_set_gui_size(_game_width, _game_height);