/// @description Manually check for collisions before parent event

// Manually check for collisions with Player/Cubes/etc.
if (place_meeting(x, y, o_player_parent) || place_meeting(x, y, o_cube)) {
	is_toggled = true;
} else {
	is_toggled = false;
}

// Inherit the parent event
event_inherited();