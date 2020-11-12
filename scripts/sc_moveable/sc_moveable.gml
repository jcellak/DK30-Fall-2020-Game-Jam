/// @function direction_move_bounce(_collision_objects, _bounce)
/// @description Handles movement, preventing self from moving inside collidables
/// @param {real|array} _collision_objects the object indices of collidable objects
/// @param {boolean} _bounce whether the collision should be bouncy
function direction_move_bounce(_collision_objects, _bounce)
{
	direction_move_bounce_specific(_collision_objects, _collision_objects, _bounce);
}

/// @function direction_move_bounce_specific(_horizontal_collision_objects, _vertical_collision_objects, _bounce)
/// @description Handles movement, preventing self from moving inside collidables.  Separates x-collidables and y-collidables.
/// @param {real|array} _horizontal_collision_objects the object indices of x-direction collidable objects
/// @param {real|array} _vertical_collision_objects the object indices of y-direction collidable objects
/// @param {boolean} _bounce whether the collision should be bouncy
function direction_move_bounce_specific(_horizontal_collision_objects, _vertical_collision_objects, _bounce)
{
	var hCollisionObjects = typeof(_horizontal_collision_objects) == "array" ? _horizontal_collision_objects : [_horizontal_collision_objects];
	var vCollisionObjects = typeof(_vertical_collision_objects) == "array" ? _vertical_collision_objects : [_vertical_collision_objects];
	
	// Horizontal Collisions
	for (var i = 0; i < array_length(hCollisionObjects); i++) {
		var collisionObject = hCollisionObjects[i];
		if (place_meeting(x + xspeed, y, collisionObject)) {
			while (!place_meeting(x + sign(xspeed), y, collisionObject)) {
				x += sign(xspeed);
				
				// Check if we are past the other object already, to avoid infinite loops
				if (sign(x - collisionObject.x) == sign(xspeed)) {
					break;
				}
			}
		
			if (_bounce) {
				xspeed = -(xspeed / 4);
			} else {
				xspeed = 0;
			}
			break;
		}
	}
	
	x += xspeed;
	
	// Vertical Collisions
	for (var i = 0; i < array_length(vCollisionObjects); i++) {
		var collisionObject = vCollisionObjects[i];
		if (place_meeting(x, y + yspeed, collisionObject)) {
			while (!place_meeting(x, y + sign(yspeed), collisionObject)) {
				y += sign(yspeed);
				
				// Check if we are past the other object already, to avoid infinite loops
				if (sign(y - collisionObject.y) == sign(yspeed)) {
					break;
				}
			}
		
			if (_bounce) {
				yspeed = -(yspeed / 4);
				if (abs(yspeed) < 2) {
					yspeed = 0;
				}
			} else {
				yspeed = 0;
			}
			break;
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
			xspeed -= _amount * sign(xspeed);
		} else {
			xspeed = 0;
		}
	}
}