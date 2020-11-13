
enum PlayerState {
	moving,
	ledge_grab,
	door,
	hurt,
	death
}

/// @function handle_player_state_moving()
/// @description 
function handle_player_state_moving()
{
	var otherPlayerObjId = this_player_num == 0 ? o_player_2 : o_player_1;
	
	#region Using Blast
	if (blast_released && blast_charge > 0) {
		xspeed -= image_xscale * blast_charge / 10;
		var myBlast = instance_create_layer(x + sprite_width, y, "Particles", o_blast_hitbox);
		myBlast.owner_num = this_player_num;
		myBlast.image_xscale = image_xscale;
		myBlast.blast_value = blast_charge;
		myBlast.playerX = x;
		myBlast.playerY = y;
		blast_charge = 0;
		send_event_blast_created(myBlast);
	}
	#endregion
	
	#region Dash
	// Track Timers for Double Tap input
	if (right_released) {
		alarm[0] = double_tap_timer;
	} else if (left_released) {
		alarm[1] = double_tap_timer;
	}

	// Double Tap Triggered in any one specific direction
	if (modules.dash && !(alarm[3] > 0) && (alarm[0] > 0 && right_pressed || alarm[1] > 0 && left_pressed)) {
		alarm[2] = dash_duration;
		alarm[3] = dash_cooldown;
	}
	#endregion
	
	#region Vertical Movement
	// Check if Player is on the ground
	var _on_solid = place_meeting(x, y + 1, o_solid);
	var _on_cube  = place_meeting(x, y + 1, o_cube);
	var _on_platform = false;
	var _on_other_player = place_meeting(x, y + 1, otherPlayerObjId) && bbox_bottom < otherPlayerObjId.bbox_top + 2;
	with (o_platform) {
		if (place_meeting(x, y - 1, other) && !place_meeting(x, y, other)) {
			_on_platform = true;	
		}
	}
	
	if (_on_solid || _on_cube || _on_platform || _on_other_player) { // Player is on a type of solid ground
		yspeed = 0;
		jump_disabled = false;
		
		// Jumping off of solid ground
		if (modules.jump && up) {
			yspeed = jump_height;
			audio_play_sound(a_jump, 5, false);
		}
		
		// Dropping down from platform ONLY (no solid ground overlap)
		if (down && _on_platform && !_on_solid) {
			y += 1;
		}
	} else { // Player is in the air
		yspeed += gravity_acceleration;
		
		sprite_index = sprite_jump;
		image_index = (yspeed > 0);
		
		// Control the jump height
		if (up_release and yspeed < -6) {
			yspeed = -3;
		}
		
		if (modules.double && up_pressed && !jump_disabled) {
			yspeed = jump_height;
			audio_play_sound(a_jump, 5, false);
			jump_disabled = true;
			var _double_particle_l = instance_create_layer(x - 4, y + sprite_height / 2, "Particles", o_particle);
			var _double_particle_r = instance_create_layer(x + 4, y + sprite_height / 2, "Particles", o_particle);
			_double_particle_l.direction = random_range(-90, -180);
			_double_particle_r.direction = random_range(0, -90);
		}
		
		alarm[2] = 0; // No dashing in the air (for now)
		
		// TESTING: If Dash into Jump, delay deceleration until Player lands
		/*if (alarm[2] > 0) {
			alarm[2] += 1;
		}*/
	}
	
	// Check if we are about to land on a solid collision Object
	if ((place_meeting(x, y + yspeed + 1, o_solid) || place_meeting(x, y + yspeed + 1, otherPlayerObjId)) && yspeed > 0) {
		if (dedupe_step_sound == 0) {
			audio_play_sound(a_step, 6, false);
			dedupe_step_sound = 5;
		}
	}
	#endregion
	
	#region Horizontal Movement
	if (alarm[2] > 0) { // Actively Dashing - Player can't stop moving until ended
		if (alarm[2] <= 5) {
			apply_friction(dash_acceleration);
		} else {
			xspeed += (right - left) * dash_acceleration;
			xspeed = clamp(xspeed, -dash_speed, dash_speed);
			//xspeed = (right - left) * dash_speed;
			
			// Dash Particles
			if (alarm[2] % 2 == 0) {
				with (instance_create_layer(x, y + sprite_height / 2, "Particles", o_particle)) {
					image_blend = c_white;
					direction = (other.image_xscale > 0) ? random_range(90, 180) : random_range(0, 90);
				}
			}
		}
	} else { // Normal Walking Speed
		// Check for moving left or right
		if (right xor left) {
			if ((left and xspeed > -1 * max_speed) or right and xspeed < max_speed) {
				xspeed += (right - left) * acceleration;
			}
			//xspeed = clamp(xspeed, -max_speed, max_speed);
			sprite_index = sprite_walk;
			// Change direction of Sprite
			image_xscale = right ? 1 : -1;	
		} else {
			apply_friction(acceleration);
			sprite_index = sprite_idle;
		}
	}
	#endregion
	
	#region Player collision
	// Check for collision with opponent.  Because o_opponent's state is set during the Begin Step,
	// we know that the opponent will move into us first, and we can respond.
	if (!is_opponent && place_meeting(x, y, otherPlayerObjId)) {
		// Shove the player out of the opponent's collision box.
		var xDirection = sign(x - otherPlayerObjId.x);
		var xShift = abs(sprite_width) - abs(x - otherPlayerObjId.x);
		
		var yDirection = sign(y - otherPlayerObjId.y);
		var yShift = abs(sprite_height) - abs(y - otherPlayerObjId.y);
		
		if (abs(xShift) <= abs(yShift)) {
			// Shift them both apart
			while (place_meeting(x, y, otherPlayerObjId)) {
				if (!place_meeting(x + xDirection, y, o_solid)) {
					x += xDirection;
				}
				with (otherPlayerObjId) {
					if (!place_meeting(x - xDirection, y, o_solid)) {
						x -= xDirection;
					}
				}
			}
		} else {
			while (place_meeting(x, y, otherPlayerObjId)) {
				if (!place_meeting(x, y + yDirection, o_solid)) {
					y += yDirection;
				}
				with (otherPlayerObjId) {
					if (!place_meeting(x, y - yDirection, o_solid)) {
						y -= yDirection;
					}
				}
				
				// Make sure that the player on top stops falling, or they will just fall back into
				// the other player on the next frame.
				if (y <= otherPlayerObjId.y) {
					yspeed = 0;
				} else {
					otherPlayerObjId.yspeed = 0;
				}
			}
		}
	}
	#endregion
	
	jump_through_platform(o_platform);
	
	handle_push_object(o_cube);
	
	#region Hit By Blast
	var enemyBlast = instance_place(x, y, o_blast_hitbox);
	if (enemyBlast != noone and enemyBlast.owner_num != this_player_num and ds_list_find_index(enemyBlast.struck_targets, self) == -1) {
		ds_list_add(enemyBlast.struck_targets, self);
		var blastAngle = point_direction(enemyBlast.playerX, enemyBlast.playerY, x, y);
		// The following code guarantees that there is at least 30% x movement, and at *most* 30% y movement.
		var xPortion = clamp(abs(cos(blastAngle)), 0.3, 1);
		var yPortion = clamp(sin(blastAngle), -0.3, 0.3);
		xspeed += xPortion * enemyBlast.image_xscale * enemyBlast.blast_value / 5;
		yspeed += yPortion * enemyBlast.blast_value / 5;
	}
	#endregion
	
	direction_move_bounce_specific([{ 
		object_index: o_solid,
		collision_direction: Direction.omnidirectional,
		elasticity: 0,
		one_way: false
	}, {
		object_index: o_x_bumper,
		collision_direction: Direction.horizontal,
		elasticity: 0.95,
		one_way: true
	}, {
		object_index: o_y_bumper,
		collision_direction: Direction.vertical,
		elasticity: 0.95,
		one_way: true
	}]);
	
	#region Ledge grabbing
	// Check for ledge grab state
	var _falling = y - yprevious > 0;
	var _wasnt_wall = !position_meeting(x + grab_width * image_xscale, yprevious, o_solid);
	var _is_wall = position_meeting(x + grab_width * image_xscale, y, o_solid);
	
	// If the Player is falling AND y previous was NOT a wall AND current y IS a wall
	if (modules.hang && _falling && _wasnt_wall && _is_wall) {
		xspeed = 0;
		yspeed = 0;
		
		// Move against the ledge
		if (!place_meeting(x + image_xscale, y, o_solid)) {
			x += image_xscale;
		}
		
		// Check vertical position
		while (position_meeting(x + grab_width * image_xscale, y - 1, o_solid)) {
			y -= 1;
		}
		
		// Change sprite and state
		sprite_index = sprite_ledge_grab;
		state = PlayerState.ledge_grab;
		
		audio_play_sound(a_step, 6, false);
	}
	
	// Round to avoid sub-pixel calculations (avoid floating point values)
	y = round(y);
	#endregion
}

/// @function handle_player_state_ledge_grab()
/// @description 
function handle_player_state_ledge_grab()
{
	if (down) {
		state = PlayerState.moving;
	}
	
	if (up) {
		state = PlayerState.moving;
		yspeed = jump_height;
	}
}

/// @function handle_player_state_door()
/// @description 
function handle_player_state_door()
{
	if (image_alpha > 0) { // Fade out
		image_alpha -= .05;
	} else {
		/*var _transition = instance_create_layer(0, 0, "Transitions", o_transition_fade_out);
		_transition.origin_x = room_width / 2;
		_transition.origin_y = room_height / 2;*/
		
		instance_destroy();
		send_event_instance_destroyed();
		
		if (instance_number(o_player_parent) == 0) {
			if (room_exists(room_next(room))) {
				room_goto_next();
				send_event_goto_room(room_next(room));
			} else {
				room_goto(r_title);
				send_event_goto_room(r_title);
			}
		}
	}
}

/// @function handle_player_state_hurt()
/// @description 
function handle_player_state_hurt()
{
	// Check health first for death
	/*
	if (global.player_hp[player_num] <= 0) {
		state = PlayerState.death;
		return;
	}
	*/
	
	// Change direction as we fly around
	if (xspeed != 0) {
		image_xscale = sign(xspeed);
	}
	
	if (!place_meeting(x, y + 1, o_solid)) {
		yspeed += gravity_acceleration;
	} else {
		yspeed = 0;
		apply_friction(acceleration);
	}
	
	direction_move_bounce_specific([{ 
		object_index: o_solid,
		collision_direction: Direction.omnidirectional,
		elasticity: 0.25,
		one_way: false
	}, {
		object_index: o_x_bumper,
		collision_direction: Direction.horizontal,
		elasticity: 0.95,
		one_way: true
	}, {
		object_index: o_y_bumper,
		collision_direction: Direction.vertical,
		elasticity: 0.95,
		one_way: true
	}]);
	
	// Change back to the default state once they stop moving
	if (xspeed == 0 && yspeed == 0) {
		image_blend = c_white;
		state = PlayerState.moving;
	}
}

/// @function handle_player_state_death()
/// @description 
function handle_player_state_death()
{
	//room_restart();
}

/// @function handle_player_take_damage(damage);
/// @description 
function handle_player_take_damage(damage)
{
	if (state != PlayerState.hurt) {
		state = PlayerState.hurt;
		
		if (dedupe_hurt_sound == 0) {
			audio_play_sound(a_ouch, 5, false);
			dedupe_hurt_sound = 5;
		}
		
		image_blend = make_color_rgb(220, 150, 150);
		
		yspeed = -6;
		xspeed = (sign(x - other.x) * 8);
		
		direction_move_bounce_specific([{ 
			object_index: o_solid,
			collision_direction: Direction.omnidirectional,
			elasticity: 0,
			one_way: false
		}, {
			object_index: o_x_bumper,
			collision_direction: Direction.horizontal,
			elasticity: 0.95,
			one_way: true
		}, {
			object_index: o_y_bumper,
			collision_direction: Direction.vertical,
			elasticity: 0.95,
			one_way: true
		}]);
		
		global.player_hp[this_player_num] -= damage;
	}
}
