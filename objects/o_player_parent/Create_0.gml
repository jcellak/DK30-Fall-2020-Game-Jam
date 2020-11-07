/// @description Initialize Player Variables

state = PlayerState.moving;
this_player_num = 0;
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
blast_charge = 0;
flash_timer = 0;

#region Controls
right = false;
left = false;
up = false;
down = false;
up_release = false;
blast_held = false;
blast_released = false;
#endregion

// This is just a struct that contains all the same variables as o_player_parent
network_update = undefined;
