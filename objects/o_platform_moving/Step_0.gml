/// @description Handle Platform Movement
if (is_vertical) {
	#region Vertical Platform Movement
	if (y < yorigin - max_distances_from_origin[0] || y > yorigin + max_distances_from_origin[1]) {
		platform_direction *= -1;
	}
	
	yspeed = platform_direction * yspeed;
	#endregion
	
	#region Move Player along with Vertical Platform
	with (o_player_parent) {
		if (!place_meeting(x, y + other.yspeed, o_solid)) {
			if (place_meeting(x, y + abs(other.yspeed), other) && !place_meeting(x, y, other)) {
				y += other.yspeed;
			}
		}
	}
	#endregion
	
	y += yspeed;
} else {
	#region Horizonal Platform Movement
	if (x < xorigin - max_distances_from_origin[0] || x > xorigin + max_distances_from_origin[1]) {
		platform_direction *= -1;
	}
	
	xspeed = platform_direction * xspeed;
	#endregion
	
	#region Move Player along with Horizontal Platform
	with (o_player_parent) {
		if (!place_meeting(x + other.xspeed, y, o_solid)) {
			if (place_meeting(x, y + 1, other) && !place_meeting(x, y, other)) {
				x += other.xspeed;	
			}
		}
	}
	#endregion
	
	x += xspeed;
}