/// @description Enable Jump
if (!is_opponent or global.local_play) {
	
	if (modules.jump == false) {
		modules.jump = true;

		with (other) {
			instance_destroy();	
			send_event_instance_destroyed();
		}
	}

}
