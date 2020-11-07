
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
	
	#region Vertical movement
	// Check if Player is in the air
	var onOtherPlayer = place_meeting(x, y + 1, otherPlayerObjId) && bbox_bottom < otherPlayerObjId.bbox_top + 2;
	if (!place_meeting(x, y + 1, o_solid) && !onOtherPlayer) {
		yspeed += gravity_acceleration;
		
		// Player is in the air
		sprite_index = sprite_jump;
		image_index = (yspeed > 0);
		
		// Control the jump height
		if (up_release and yspeed < -6) {
			yspeed = -3;
		}
	} else {
		yspeed = 0;
		
		// Jumping code
		if (modules.jump && up) {
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
		sprite_index = sprite_walk;
		// Change direction of Sprite
		image_xscale = right ? 1 : -1;	
	} else {
		apply_friction(acceleration);
		sprite_index = sprite_idle;
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
	
	direction_move_bounce(o_solid, false);
	
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
	/*with (o_main_controller) {
	
	room_restart();*/
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
		
		global.player_hp[this_player_num] -= damage;
	}
}
