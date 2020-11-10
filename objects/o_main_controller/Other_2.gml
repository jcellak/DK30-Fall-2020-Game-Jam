/// @desc 
PlayerModules = function() constructor
{
	jump = false;
	hang = false;
	push = false;
	crouch = false;
	double = false;
	jetpack = false;
	blast = true;
}

event_user(0);
vol[0] = 0; //main
vol[1] = 0.5; //sfx
vol[2] = 0.5; //music

global.multiplayer = false;
global.all_players_connected = false;
global.my_player_num = -1;
global.is_server = false;
global.local_play = true;

global.player_1_modules = new PlayerModules();
global.player_2_modules = new PlayerModules();

global.max_hp = 100;
global.max_charge = 180;
global.player_hp = [global.max_hp, global.max_hp];
global.player_charge = [60,60];

global.pause = false;
