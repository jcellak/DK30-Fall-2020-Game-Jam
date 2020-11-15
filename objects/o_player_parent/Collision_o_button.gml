/// @description 
if (down_pressed and (global.local_play or !is_opponent)) {
	other.is_toggled = !other.is_toggled;
	send_event_toggle_button(other);
}