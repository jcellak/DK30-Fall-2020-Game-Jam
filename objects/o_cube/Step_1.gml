/// @description Apply state update

if (!is_undefined(network_update) and !i_pushed and !place_meeting(network_update.x, network_update.y, o_player_parent)) {
	x = network_update.x;
	y = network_update.y;
	xspeed = network_update.xspeed;
	yspeed = network_update.yspeed;
	network_update = undefined;
}
