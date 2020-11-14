/// @description Initialize Global Variables and Game Setup

PlayerModules = function() constructor
{
	jump = true;
	hang = false;
	dash = false;
	double = false;
	blast = false;
}

Default_key_map();

global.vol[0] = 0.25; //main
global.vol[1] = 0.5; //sfx
global.vol[2] = 0.5; //music

global.player_1_modules = new PlayerModules();
global.player_2_modules = new PlayerModules();

global.max_hp = 100;
global.max_charge = 120;
global.player_hp = [global.max_hp, global.max_hp];
global.player_charge = [40,40];

reset_network_state();

global.pause = false;
global.winner = noone;

// Start the music

if (!audio_is_playing(a_two_robots)) {
	audio_play_sound(a_two_robots, 10, true);
	audio_sound_gain(a_two_robots,global.vol[0]*global.vol[2],0);
}

// Get rid of Cursor
//window_set_cursor(cr_none);

randomize(); // Generate a random seed for this runtime

var _game_width = camera_get_view_width(view_camera[0]);
var _game_height = camera_get_view_height(view_camera[0]);
	
// Scale "Draw GUI" Events to camera/game width/height
display_set_gui_size(_game_width, _game_height);

instance_destroy(o_client);
instance_destroy(o_server);
