/// @description Initialize Player Variables

event_inherited();

is_opponent = false;

// Place Player 1 to the left of the door and Player 2 to the right.
if (instance_exists(o_door_entrance)) {
	x = o_door_entrance.x;
	y = o_door_entrance.y;
}
