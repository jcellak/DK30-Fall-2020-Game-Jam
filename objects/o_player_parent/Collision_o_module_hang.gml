/// @description Enable Ledge Hang
event_inherited();

if (modules.hang == false) {
	modules.hang = true;

	with (other) {
		instance_destroy();	
	}
}