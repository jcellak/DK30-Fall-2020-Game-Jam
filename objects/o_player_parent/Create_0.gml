/// @description Initialize Player Variables

state = PlayerState.moving;
max_speed = 1.5;
xspeed = 0;
yspeed = 0;
acceleration = 0.5;
gravity_acceleration = 0.25;
jump_height = -3.5;
grab_width = 8; // Distance (in pixels) from sprite origin to grabbable ledge
modules = {};
is_opponent = false;
pushed = false;
right = false;
left = false;
up = false;
down = false;
up_release = false;
this_player_num = 0;

// This is just a struct that contains all the same variables as o_player_parent
network_update = undefined;
