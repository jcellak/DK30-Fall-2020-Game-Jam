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

/// @function jump_through_platform(_o_platform)
function jump_through_platform(_o_platform)
{
	with (_o_platform) {
		if (other.yspeed > 0) {
			if (place_meeting(x, y - other.yspeed, other) && !place_meeting(x, y, other)) {
				while (!place_meeting(x, y - 1, other)) {
					other.y += 1;
				}
				
				other.yspeed = 0;
			}
		}
	}
}

/// @function handle_push_object(_target_object)
/// @description Only modifies xspeed/yspeed of source object, no change to x/y
function handle_push_object(_target_object)
{
	// Horizontal Push
	var _source_half_xspeed = xspeed / 2;
	// If source object will collide with target object
	if (place_meeting(x + _source_half_xspeed, y, _target_object)) {
		// Retrieve exact target object that will be "pushed"
		var _instance = instance_place(x + _source_half_xspeed, y, _target_object);
		_instance.x += _source_half_xspeed; // Pushable object moves half of source speed
		xspeed = _source_half_xspeed; // Half the pushing source's speed
	}
	
	// Vertical Collisions
	if (place_meeting(x, y + yspeed, _target_object)) {
		while (!place_meeting(x, y + sign(yspeed), _target_object)) {
			y += sign(yspeed);
		}
		
		yspeed = 0;
	}
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