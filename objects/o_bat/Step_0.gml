/// @description Execute the state

switch (state) {
	#region Bat Idle
	case bat.idle:
		image_index = s_bat_idle;
		if (instance_exists(o_player)) {
			var _distance = point_distance(x, y, o_player.x, o_player.y);
			if (_distance < sight) {
				state = bat.chase;
			}
		}
	break;
	#endregion
	#region Bat Chase
	case bat.chase:
		if (instance_exists(o_player)) {
			var _direction = point_direction(x, y, o_player.x, o_player.y);
			xspeed = lengthdir_x(max_speed, _direction);
			yspeed = lengthdir_y(max_speed, _direction);
			sprite_index = s_bat_fly;
			if (xspeed != 0) {
				image_xscale = sign(xspeed);
			}
			
			direction_move_bounce(o_solid, false);
		}
	break;
	#endregion
}