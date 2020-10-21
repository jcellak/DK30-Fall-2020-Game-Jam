/// @description Jump
if (state == spider.idle) {
	if (instance_exists(o_player1)) {
		xspeed = sign(o_player1.x - x) * max_speed;
		yspeed = -abs(xspeed * 2);
	}
	
	direction_move_bounce(o_solid, false);
	state = spider.jump;
}