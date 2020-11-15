/// @description Send state update if pushed

if (i_pushed) {
	send_event_cube_position();
	i_pushed = false;
}
