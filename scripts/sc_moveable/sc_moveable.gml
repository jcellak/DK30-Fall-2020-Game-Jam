/// @function direction_move_bounce(collision_objects, _bounce)
/// @description 
/// @param {real|array} _collision_objects the object indices of collidable objects
/// @param {boolean} _bounce whether the collision should be bouncy
function direction_move_bounce(_collision_objects, _bounce)
{
	var collisionObjects = typeof(_collision_objects) == "array" ? _collision_objects : [_collision_objects];
	
	// Horizontal Collisions
	for (var i = 0; i < array_length(collisionObjects); i++) {
		var collisionObject = collisionObjects[i];
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
	for (var i = 0; i < array_length(collisionObjects); i++) {
		var collisionObject = collisionObjects[i];
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