/// @description Create the Server Object

instance_create_layer(0, 0, "Instances", o_server);
global.my_player_num = 0;
global.is_server = true;
global.local_play = false;

instance_destroy();
