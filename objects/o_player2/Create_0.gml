/// @description Initialize Player Variables

event_inherited();

is_opponent = true;

// Place Player 1 to the left of the door and Player 2 to the right.
if (instance_exists(o_door_entrance)) {
	x = o_door_entrance.x + (global.player_num == 0 ? 0 : 32);
	y = o_door_entrance.y;
}

// Make sure these are initialized - they will be set by server updates.
right = false;
left = false;
up = false;
down = false;
up_release = false;
