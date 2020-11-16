/// @description Inherit parent, then draw Tutorial sprite if need be
event_inherited();

if (!global.any_remap and (global.local_play or !is_opponent)) {
	var _tutorial_trigger = instance_place(x, y, o_tutorial_trigger_p1);
	if (_tutorial_trigger != noone) {
		if (_tutorial_trigger.sprite_tutorial_image_index == 0 && !modules.jump) {
			// Don't draw tutorial for jumping unless they have the proper Module
		} 
		else if room == r_blast_1 and !modules.blast {
			// also do nothing
		} else {
			var _icon = room == r_blast_1? 8 : _tutorial_trigger.sprite_tutorial_image_index;
			draw_sprite(
				_tutorial_trigger.sprite_tutorial_index, 
				_icon, 
				x, 
				y - 24
			);
		}
	}
}
