var _on_solid = place_meeting(x, y + 1, o_solid);
if (_on_solid) {
	yspeed = 0;
} else {
	yspeed += gravity_acceleration;
}

direction_move_bounce(o_solid, false);

// Round to avoid sub-pixel calculations (avoid floating point values)
y = round(y);