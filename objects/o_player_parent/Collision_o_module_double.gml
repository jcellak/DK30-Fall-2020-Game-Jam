/// @description Enable Double Jump
event_inherited();

if (modules.double == false) {
	modules.double = true;

	with (other) {
		instance_destroy();	
	}
}
