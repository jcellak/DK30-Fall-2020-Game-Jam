/// @function direction_move_bounce(collision_object)
/// @description 
/// @param {index} _collision_object
/// @param {boolean} _bounce
function direction_move_bounce(_collision_object, _bounce)
{
	// Horizontal Collisions
	if (place_meeting(x + xspeed, y, _collision_object)) {
		while (!place_meeting(x + sign(xspeed), y, _collision_object)) {
			x += sign(xspeed);
		}
		
		if (_bounce) {
			xspeed = -(xspeed / 4);
		} else {
			xspeed = 0;
		}
	}
	
	x += xspeed;
	
	// Vertical Collisions
	if (place_meeting(x, y + yspeed, _collision_object)) {
		while (!place_meeting(x, y + sign(yspeed), _collision_object)) {
			y += sign(yspeed);
		}
		
		if (_bounce) {
			yspeed = -(yspeed / 4);
			if (abs(yspeed) < 2) {
				yspeed = 0;
			}
		} else {
			yspeed = 0;
		}
	}
	
	y += yspeed;
}


/// @function apply_friction(amount)
/// @description 
/// @param {real} amount
function apply_friction(_amount)
{
	// First check to see if we're moving
	if (xspeed != 0) {
		if (abs(xspeed) - _amount > 0) {
			xspeed -= _amount * image_xscale;
		} else {
			xspeed = 0;
		}
	}
}