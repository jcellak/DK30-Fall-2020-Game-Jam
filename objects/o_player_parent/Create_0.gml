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