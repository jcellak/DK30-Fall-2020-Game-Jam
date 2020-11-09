/// @description Enable Dash
event_inherited();

if (modules.dash == false) {
	modules.dash = true;

	with (other) {
		instance_destroy();	
	}
}
