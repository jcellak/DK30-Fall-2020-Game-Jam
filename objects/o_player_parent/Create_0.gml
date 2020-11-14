/// @description Initialize Player Variables

state = PlayerState.moving;
this_player_num = 0;
max_speed = 1.5;
xspeed = 0;
yspeed = 0;
acceleration = 0.5;
gravity_acceleration = 0.25;
grab_width = 8; // Distance (in pixels) from sprite origin to grabbable ledge
modules = {};
is_opponent = false;
pushed = false;
blast_charge = 0;
flash_timer = 0;
hurt_timer = 0;
name = "";
partner = "";
#region Controls
right = false;
right_pressed = false;
right_released = false;
left = false;
left_pressed = false;
left_released = false;
up = false;
up_pressed = false;
up_release = false;
down = false;
down_pressed = false;
blast_held = false;
blast_released = false;
#endregion

// This is just a struct that contains all the same variables as o_player_parent
network_update = undefined;

double_tap_timer = 10; // Timer (in milliseconds) until considered a "double tap" press

// Jump-specific Variables
jump_height = -3.5;
jump_disabled = false;

// Dash-specific Variables
dash_speed = 5;
dash_acceleration = 1.5;
dash_cooldown = 30;
dash_duration = 20;

// Sound de-dupers, to prevent sounds from spamming every frame.
dedupe_step_sound = 0;
dedupe_hurt_sound = 0;
