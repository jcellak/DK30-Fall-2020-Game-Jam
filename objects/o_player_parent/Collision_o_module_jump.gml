/// @description Enable Jump
event_inherited();

if (modules.jump == false) {
	modules.jump = true;

	with (other) {
		instance_destroy();	
	}
}
