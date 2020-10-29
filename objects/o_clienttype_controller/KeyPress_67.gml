/// @description Create the Client Object

instance_create_layer(0, 0, "Instances", o_client);
global.player_num = 1;
global.is_server = false;
global.local_play = false;

instance_destroy();
