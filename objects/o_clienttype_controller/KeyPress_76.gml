/// @description Choose Local Play

// Not actually valid in this scenario, but it's a useful way to keep track of whether
// a client type option has been chosen.  If we accidentally use global.my_player_num in this scenario,
// we should get an array-index-out-of-bounds error.
global.my_player_num = 2;
global.is_server = true;
global.local_play = true;
global.all_players_connected = true;

instance_destroy();
