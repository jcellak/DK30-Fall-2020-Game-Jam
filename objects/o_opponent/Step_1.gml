/// @description Runs before the main step

// If there's a queued player state update, apply it and clear the queue.
// I put this in Begin Step to ensure that there is a logical timing on when state updates occur,
// otherwise they are at the mercy of the async nature of networking.
if (!global.local_play && network_update != undefined) {
	state = network_update.state;
	x = network_update.x;
	y = network_update.y;
	xspeed = network_update.xspeed;
	yspeed = network_update.yspeed;
	acceleration = network_update.acceleration;
	right = network_update.right;
	left = network_update.left;
	up = network_update.up;
	down = network_update.down;
	up_release = network_update.up_release;
	pushed = network_update.pushed;
	
	var opponentNum = 1 - global.player_num;
	
	o_main_controller.player_hp[opponentNum] = network_update.hp;
	o_main_controller.player_charge[opponentNum] = network_update.charge;
	
	network_update = undefined;
}
