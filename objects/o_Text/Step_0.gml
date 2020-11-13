/// @desc 
lerp_progress += (1 - lerp_progress) / 50;
text_progress += text_speed;

x1 = lerp(x1,x1_target,lerp_progress);
x2 = lerp(x2,x2_target,lerp_progress);

if keyboard_check_pressed(global.key_one[4]) or keyboard_check_pressed(global.key_two[4]) {
	var _message_length = string_length(mess);
	if (text_progress >= _message_length) {
		if instance_exists(o_text_queued) with o_text_queued ticket--;
		instance_destroy();
	}
	else {
		if text_progress > 2 text_progress = _message_length;
	}
}
