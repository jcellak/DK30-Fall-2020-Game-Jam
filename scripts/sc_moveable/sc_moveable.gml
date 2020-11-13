enum Direction {
	horizontal,
	vertical,
	omnidirectional
}

/// @function direction_move_bounce(_collision_objects, _bounce)
/// @description Handles movement, preventing self from moving inside collidables
/// @param {real|array} _collision_objects the object indices of collidable objects
/// @param {boolean} _bounce whether the collision should be bouncy
function direction_move_bounce(_collision_objects, _bounce)
{
	var _col_objects = typeof(_collision_objects) == "array" ? _collision_objects : [_collision_objects];
	var _converted_objects = array_create(array_length(_col_objects));
	
	for (var i = 0; i < array_length(_col_objects); i++) {
		var _col_obj = _col_objects[i];
		var _conv_obj = {
			object_index: _col_obj,
			collision_direction: Direction.omnidirectional,
			elasticity: _bounce ? 0.25 : 0,
			one_way: false
		};
		
		_converted_objects[i] = _conv_obj;
	}
	
	direction_move_bounce_specific(_converted_objects);
}

/// @function direction_move_bounce_specific(_horizontal_collision_objects, _vertical_collision_objects, _bounce)
/// @description Handles movement, preventing self from moving inside collidables.  Separates x-collidables and y-collidables.
/// @param {real|array} _collision_objects a collection of structs that represent the collision properties of objects:
/*
example_collision_object = {
	/// The object index of the collision object
	object_index: real,
	/// Which direction the collision should occur in
	collision_direction: Direction,
	/// How bouncy the object is, from 0-1, 0 is not bouncy and 1 will reflect all speed with no energy loss.
	elasticity: number [0-1],
	/// Whether the object should only collide in the direction it is facing.
	one_way: boolean,
};
*/
function direction_move_bounce_specific(_collision_objects)
{
	var _col_objects = typeof(_collision_objects) == "array" ? _collision_objects : [_collision_objects];
	
	// Horizontal Collisions (had to loop these separately to fix literal *corner* cases)
	for (var i = 0; i < array_length(_col_objects); i++) {
		var _col_object = _col_objects[i];
		var _id = _col_object.object_index;
		var _direction = _col_object.collision_direction;
		var _elasticity = _col_object.elasticity;
		var _one_way = _col_object.one_way;
		
		if (_direction == Direction.horizontal || _direction == Direction.omnidirectional) {
			var _inst = instance_place(x + xspeed, y, _id);
			if (place_meeting(x + xspeed, y, _id)
			and (!_one_way or (_inst != noone and _inst.image_xscale > 0 ? x > _inst.x : x < _inst.x))) {
				while (!place_meeting(x + sign(xspeed), y, _id)) {
					x += sign(xspeed);
				
					// Check if we are past the other object already, to avoid infinite loops
					if (sign(x - _inst.x) == sign(xspeed)) {
						break;
					}
				}
		
				xspeed = -1 * (xspeed * _elasticity);
				break;
			}
		}
	}
	
	x += xspeed;
	
	// Vertical Collisions (had to loop these separately to fix literal *corner* cases)
	for (var i = 0; i < array_length(_col_objects); i++) {
		var _col_object = _col_objects[i];
		var _id = _col_object.object_index;
		var _direction = _col_object.collision_direction;
		var _elasticity = _col_object.elasticity;
		var _one_way = _col_object.one_way;
		
		// Vertical Collisions
		if (_direction == Direction.vertical || _direction == Direction.omnidirectional) {
			var _inst = instance_place(x, y + yspeed, _id);
			if (place_meeting(x, y + yspeed, _id)
			and (!_one_way or (_inst != noone and _inst.image_yscale < 0 ? y > _inst.y : y < _inst.y))) {
				while (!place_meeting(x, y + sign(yspeed), _id)) {
					y += sign(yspeed);
				
					// Check if we are past the other object already, to avoid infinite loops
					if (sign(y - _id.y) == sign(yspeed)) {
						break;
					}
				}
		
				yspeed = -1 * (yspeed * _elasticity);
				break;
			}
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
	if (place_meeting(x + _source_half_xspeed, y, _target_object) or ((left xor right) and place_meeting(x + (right - left), y, _target_object))) {
		// Retrieve exact target object that will be "pushed"
		var _instance = instance_place(x + _source_half_xspeed, y, _target_object);
		if (_instance == noone) {
			_instance = instance_place(x + (right - left), y, _target_object);
			_source_half_xspeed = (right - left) * max_speed;
		}
		_instance.xspeed = _source_half_xspeed; // Pushable object moves half of source speed
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