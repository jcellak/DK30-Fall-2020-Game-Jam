var _on_solid = place_meeting(x, y + 1, o_solid);
if (_on_solid) {
	yspeed = 0;
} else {
	yspeed += gravity_acceleration;
}

direction_move_bounce_specific([{ 
	object_index: o_solid,
	collision_direction: Direction.omnidirectional,
	elasticity: 0,
	one_way: false
}, {
	object_index: o_x_bumper,
	collision_direction: Direction.horizontal,
	elasticity: 1,
	one_way: true
}, {
	object_index: o_y_bumper,
	collision_direction: Direction.vertical,
	elasticity: 1,
	one_way: true
}]);

// Round to avoid sub-pixel calculations (avoid floating point values)
y = round(y);
