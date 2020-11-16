/// @description Inherit parent, then draw Tutorial sprite if need be
event_inherited();

if (!global.any_remap) {
	var _tutorial_trigger = instance_place(x, y, o_tutorial_trigger_p2);
	if (_tutorial_trigger != noone) {
		if (_tutorial_trigger.sprite_tutorial_image_index == 4 && !modules.jump) {
			// Don't draw tutorial for jumping unless they have the proper Module
		} else {
			draw_sprite(
				_tutorial_trigger.sprite_tutorial_index, 
				_tutorial_trigger.sprite_tutorial_image_index, 
				x, 
				y - 24
			);
		}
	}
}