/// @description Destroy self when off screen.

if (y > room_height) {
	instance_destroy();
}

if (lifespan > 0) {
	lifespan--;
}
