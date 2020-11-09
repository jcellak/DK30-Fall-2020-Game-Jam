/// @description Initialize Player Variables

enum player {
	moving,
	ledge_grab,
	door,
	hurt,
	death
}

state = player.moving;
max_speed = 1.5;
xspeed = 0;
yspeed = 0;
acceleration = 0.5;
gravity_acceleration = 0.25;
grab_width = 8; // Distance (in pixels) from sprite origin to grabbable ledge
modules = {};

double_tap_timer = 10; // Timer (in milliseconds) until considered a "double tap" press

// Jump-specific Variables
jump_height = -3.5;
jump_disabled = false;

// Dash-specific Variables
dash_speed = 5;
dash_acceleration = 1.5;
dash_cooldown = 30;
dash_duration = 20;