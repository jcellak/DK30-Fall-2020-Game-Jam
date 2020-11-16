/// @description Inherit parent, then draw Tutorial sprite if need be
event_inherited();

if (!global.any_remap) {
	var _tutorial_trigger = instance_place(x, y, o_tutorial_trigger_p2);
	if (_tutorial_trigger != noone) {
		if (_tutorial_trigger.sprite_tutorial_image_index == 4 && !modules.jump) {
			// Don't draw tutorial for jumping unless they have the proper Module
		} 
		else if room == r_blast_1 and !modules.blast {
			// also do nothing
		} else {
			var _icon = room == r_blast_1? 9 : _tutorial_trigger.sprite_tutorial_image_index;
			draw_sprite(
				_tutorial_trigger.sprite_tutorial_index, 
				_icon, 
				x, 
				y - 24
			);
		}
	}
}