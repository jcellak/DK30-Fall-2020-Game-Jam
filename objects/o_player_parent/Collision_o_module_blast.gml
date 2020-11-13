/// @description Enable Blast
event_inherited();

if (modules.blast == false) {
	modules.blast = true;

	with (other) {
		instance_destroy();	
	}
}
