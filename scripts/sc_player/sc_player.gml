
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
	var otherPlayerObjId = is_opponent ? o_player : o_opponent;
	
	#region Vertical movement
	// Check if Player is in the air
	if (!place_meeting(x, y + 1, o_solid) && !place_meeting(x, y + 1, otherPlayerObjId)) {
		yspeed += gravity_acceleration;
		
		// Player is in the air
		if (is_opponent) {
			sprite_index = s_player_jump_2;
		} else {
			sprite_index = s_player_jump;
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
	
	// Check if we are about to land on a solid collision Object
	if ((place_meeting(x, y + yspeed + 1, o_solid) || place_meeting(x, y + yspeed + 1, otherPlayerObjId)) && yspeed > 0) {
		audio_play_sound(a_step, 6, false);
	}
	#endregion
	
	#region Horizontal movement
	// Check for moving left or right
	if (right or left) {
		xspeed += (right - left) * acceleration;
		xspeed = clamp(xspeed, -max_speed, max_speed);
	} else {
		apply_friction(acceleration);
	}
	#endregion
	
	#region Player collision
	// Check for collision with opponent.  Because o_opponent's state is set during the Begin Step,
	// we know that the opponent will move into us first, and we can respond.
	if (!is_opponent && place_meeting(x, y, o_opponent)) {
		// Shove the player out of the opponent's collision box.
		var xDirection = sign(x - o_opponent.x);
		var xShift = abs(sprite_width) - abs(x - o_opponent.x);
		
		var yDirection = sign(y - o_opponent.y);
		var yShift = abs(sprite_height) - abs(y - o_opponent.y);
		
		if (abs(xShift) <= abs(yShift)) {
			// Shift them both apart
			while (place_meeting(x, y, o_opponent)) {
				x += xDirection;
				o_opponent.x -= xDirection;
			}
		} else {
			// Move the one on top upwards
			while (place_meeting(x, y, o_opponent)) {
				if (yDirection <= 0) {
					y -= 1;
				} else {
					o_opponent.y -= 1;
				}
			}
		}
	}
	#endregion
	
	#region Set Player Sprite on x movement
	if (xspeed == 0) {
		if (is_opponent) {
			sprite_index = s_player_idle_2;
		} else {
			sprite_index = s_player_idle;
		}
	} else {
		if (is_opponent) {
			sprite_index = s_player_walk_2;
		} else {
			sprite_index = s_player_walk;
		}
	}
	
	// Change direction of Sprite
	if (xspeed != 0) {
		image_xscale = sign(xspeed);	
	}
	#endregion
	
	direction_move_bounce(o_solid, false);
	
	#region Ledge grabbing
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
		if (is_opponent) {
			sprite_index = s_player_ledge_grab_2;
		} else {
			sprite_index = s_player_ledge_grab;
		}
		state = PlayerState.ledge_grab;
		
		audio_play_sound(a_step, 6, false);
	}
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
	if (is_opponent) {
		sprite_index = s_player_exit_2;
	} else {
		sprite_index = s_player_exit;
	}
	
	if (image_alpha > 0) { // Fade out
		image_alpha -= .05;
	} else {
		// Temporary measure in order to continue the game if a player is "dead", for playtesting.
		with (o_main_controller) {
			for (var i = 0; i < 1; i++) {
				if (player_hp[i] <= 0) {
					player_hp[i] = max_hp;
					player_charge[i] = 0;
				}
			}
		}
		
		room_goto_next();
	}
}

/// @function handle_player_state_hurt()
/// @description 
function handle_player_state_hurt()
{
	// Check health first for death
	if (o_main_controller.player_hp[is_opponent ? 1 : 0] <= 0) {
		state = PlayerState.death;
		return;
	}
	
	if (is_opponent) {
		sprite_index = s_player_hurt_2;
	} else {
		sprite_index = s_player_hurt;
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
		state = PlayerState.moving;
	}
}

/// @function handle_player_state_death()
/// @description 
function handle_player_state_death()
{
	visible = false;
	instance_deactivate_object(self);
	var playerNum = global.player_num;
	if (global.local_play) {
		playerNum = is_opponent ? 1 : 0;
	}
	
	with(o_main_controller) {
		player_hp[playerNum] = 0;
		player_charge[playerNum] = 0;
		
		var bothPlayersDead = player_hp[0] <= 0 and player_hp[1] <= 0;
		
		if (bothPlayersDead) {
			player_hp[0] = max_hp;
			player_hp[1] = max_hp;
			room_restart();
		}
	}
}

/// @function handle_player_take_damage(damage);
/// @description 
function handle_player_take_damage(damage)
{
	if (state != PlayerState.hurt) {
		state = PlayerState.hurt;
		
		audio_play_sound(a_ouch, 5, false);
		
		image_blend = make_color_rgb(220, 150, 150);
		
		yspeed = -6;
		xspeed = (sign(x - other.x) * 8);
		
		direction_move_bounce(o_solid, false);
		
		var playerNum = global.player_num;
		if (global.local_play) {
			playerNum = is_opponent ? 1 : 0;
		}
		with (o_main_controller) {
			player_hp[playerNum] = clamp(player_hp[playerNum] - damage, 0, max_hp);
		}
	}
}
