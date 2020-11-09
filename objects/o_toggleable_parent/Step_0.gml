/// @description Toggle On/Off execution only once per trigger on Step

var _toggle_trigger = false;
if (is_toggled && !is_toggled_previous) {
	image_index = toggled_image_index;
	_toggle_trigger = true;
} else if (!is_toggled && is_toggled_previous) {
	image_index = initial_image_index;
	_toggle_trigger = true;
}

if (_toggle_trigger) {
	var _target_instances_length = array_length(target_instances);
	for (var _i = 0; _i < _target_instances_length; _i++) {
		var _target_instance = instance_find(target_instances[_i], 0);
		if (_target_instance != noone) {
			_target_instance.is_toggled = !_target_instance.is_toggled;
		}
	}
	
	is_toggled_previous = is_toggled;
}