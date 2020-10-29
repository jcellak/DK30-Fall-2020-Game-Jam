/// @description Initialize Player Variables

event_inherited();

is_opponent = true;

// Place Player 1 to the left of the door and Player 2 to the right.
if (instance_exists(o_door_entrance)) {
	if (global.local_play) {
		x = o_door_entrance.x  + abs(sprite_width);
	} else {
		x = o_door_entrance.x + (global.player_num == 0 ? 0 : abs(sprite_width));
	}
	y = o_door_entrance.y;
}

// Make sure these are initialized - they will be set by server updates.
right = false;
left = false;
up = false;
down = false;
up_release = false;

// This is just a struct that contains all the same variables as o_opponent
network_update = undefined;
