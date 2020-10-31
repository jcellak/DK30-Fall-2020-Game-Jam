/// @description Enable Ledge Hang
if (!is_opponent or global.local_play) {
	
	if (modules.hang == false) {
		modules.hang = true;

		with (other) {
			instance_destroy();	
			send_event_instance_destroyed();
		}
	}

}