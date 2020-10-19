/// @function handle_player_state_moving()
/// @description 
function handle_player_state_moving()
{
	// Set Player Sprite on x movement
	if (xspeed == 0) {
		if (player_num == 1) {
			sprite_index = s_player_idle;
		} else {
			sprite_index = s_player_idle_2;
		}
	} else {
		if (player_num == 1) {
			sprite_index = s_player_walk;
		} else {
			sprite_index = s_player_walk_2;
		}
	}
	
	// Check if Player is on the ground
	if (!place_meeting(x, y + 1, o_solid)) {
		yspeed += gravity_acceleration;
		
		// Player is in the air
		if (player_num == 1) {
			sprite_index = s_player_jump;
		} else {
			sprite_index = s_player_jump_2;
		}
		image_index = (yspeed > 0);
		
		// Control the jump height
		if (up_release and yspeed < -6) {
			yspeed = -3;
		}
	} else {
		yspeed = 0;
		
		// Jumping code
		if (up) {
			yspeed = jump_height;
			audio_play_sound(a_jump, 5, false);
		}
	}
	
	// Change direction of Sprite
	if (xspeed != 0) {
		image_xscale = sign(xspeed);	
	}
	
	// Check for moving left or right
	if (right or left) {
		xspeed += (right - left) * acceleration;
		xspeed = clamp(xspeed, -max_speed, max_speed);
	} else {
		apply_friction(acceleration);
	}
	
	// Check if we are about to land on a solid collision Object
	if (place_meeting(x, y + yspeed + 1, o_solid) && yspeed > 0) {
		audio_play_sound(a_step, 6, false);
	}
	
	direction_move_bounce(o_solid, false);
	
	// Check for ledge grab state
	var _falling = y - yprevious > 0;
	var _wasnt_wall = !position_meeting(x + grab_width * image_xscale, yprevious, o_solid);
	var _is_wall = position_meeting(x + grab_width * image_xscale, y, o_solid);
	
	// If the Player is falling AND y previous was NOT a wall AND current y IS a wall
	if (_falling && _wasnt_wall && _is_wall) {
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
		if (player_num == 1) {
			sprite_index = s_player_ledge_grab;
		} else {
			sprite_index = s_player_ledge_grab_2;
		}
		state = player.ledge_grab;
		
		audio_play_sound(a_step, 6, false);
	}
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
	if (player_num == 1) {
		sprite_index = s_player_exit;
	} else {
		sprite_index = s_player_exit_2;
	}
	
	if (image_alpha > 0) { // Fade out
		image_alpha -= .05;
	} else {
		room_goto_next();
	}
}

/// @function handle_player_state_hurt()
/// @description 
function handle_player_state_hurt()
{
	// Check health first for death
	if (o_main_controller.hp <= 0) {
		state = player.death;
		return;
	}
	
	if (player_num == 1) {
		sprite_index = s_player_hurt;
	} else {
		sprite_index = s_player_hurt_2;
	}
	
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
	with (o_main_controller) {
		hp = max_hp;
		sapphires = 0;
	}
		
	room_restart();
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
		
		if (instance_exists(o_main_controller)) {
			o_main_controller.hp -= 1;
		}
	}
}