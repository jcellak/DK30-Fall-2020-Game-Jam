/// @description Initialize Player Variables

event_inherited();

is_opponent = false;

// Place Player 1 to the left of the door and Player 2 to the right.
if (instance_exists(o_door_entrance)) {
	if (global.local_play) {
		x = o_door_entrance.x;
	} else {
		x = o_door_entrance.x  + (global.player_num == 1 ? 0 : abs(sprite_width));
	}
	y = o_door_entrance.y;
}
