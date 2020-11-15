/// @description Bounce
// Slow the speed over time
if (speed > 1) {
	speed -= 0.5;
}

if (lifespan > 0) {
	move_bounce_all(false);
}
