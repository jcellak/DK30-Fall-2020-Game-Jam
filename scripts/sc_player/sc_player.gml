/// @function handle_player_state_moving()
/// @description 
function handle_player_state_moving()
{
	// Set Player Sprite on x movement
	if (xspeed == 0) {
		sprite_index = sprite_idle;
	} else {
		sprite_index = sprite_walk;
	}
	
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
	
	// Check if Player is on the ground
	var _on_solid = place_meeting(x, y + 1, o_solid);
	var _on_cube  = place_meeting(x, y + 1, o_cube);
	var _on_platform = false;
	with (o_platform) {
		if (place_meeting(x, y - 1, other) && !place_meeting(x, y, other)) {
			_on_platform = true;	
		}
	}
	
	if (_on_solid || _on_cube || _on_platform) { // Player is on a type of solid ground
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
	
	// Change direction of Sprite
	if (xspeed != 0) {
		image_xscale = sign(xspeed);	
	}
	
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
		if (right or left) { // Check for moving left or right
			xspeed += (right - left) * acceleration;
			xspeed = clamp(xspeed, -max_speed, max_speed);
		} else {
			apply_friction(acceleration);
		}
	}
	
	// Check if we are about to land on a solid collision Object
	/*if (place_meeting(x, y + yspeed + 1, o_solid) && yspeed > 0) {
		audio_play_sound(a_step, 6, false);
	}*/
	
	jump_through_platform(o_platform);
	
	handle_push_object(o_cube);
	
	direction_move_bounce(o_solid, false);
	
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
		state = player.ledge_grab;
		
		audio_play_sound(a_step, 6, false);
	}
	
	// Round to avoid sub-pixel calculations (avoid floating point values)
	y = round(y);
}

/// @function handle_player_state_ledge_grab()
/// @description 
function handle_player_state_ledge_grab()
{
	if (down) {
		state = player.moving;
	}
	
	if (up) {
		state = player.moving;
		yspeed = jump_height;
	}
}

/// @function handle_player_state_door()
/// @description 
function handle_player_state_door()
{
	//sprite_index = s_player_exit;
	
	if (image_alpha > 0) { // Fade out
		image_alpha -= .05;
	} else {
		/*var _transition = instance_create_layer(0, 0, "Transitions", o_transition_fade_out);
		_transition.origin_x = room_width / 2;
		_transition.origin_y = room_height / 2;*/
		
		instance_destroy();
		
		if (instance_number(o_player_parent) == 0) {
			if (room_exists(room_next(room))) {
				room_goto_next();
			} else {
				room_goto(r_title);
			}
		}
	}
}

/// @function handle_player_state_hurt()
/// @description 
function handle_player_state_hurt()
{
	// Check health first for death
	/*if (o_main_controller.hp <= 0) {
		state = player.death;
		return;
	}*/
	
	//sprite_index = s_player_hurt;
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
	
	direction_move_bounce(o_solid, true);
	
	// Change back to the default state once they stop moving
	if (xspeed == 0 && yspeed == 0) {
		image_blend = c_white;
		state = player.moving;
	}
}

/// @function handle_player_state_death()
/// @description 
function handle_player_state_death()
{
	/*with (o_main_controller) {
		hp = max_hp;
		sapphires = 0;
	}
		
	room_restart();*/
}

/// @function handle_player_take_damage();
/// @description 
function handle_player_take_damage()
{
	if (state != player.hurt) {
		state = player.hurt;
		
		audio_play_sound(a_ouch, 5, false);
		
		image_blend = make_color_rgb(220, 150, 150);
		
		yspeed = -6;
		xspeed = (sign(x - other.x) * 8);
		
		direction_move_bounce(o_solid, false);
		
		/*if (instance_exists(o_main_controller)) {
			o_main_controller.hp -= 1;
		}*/
	}
}