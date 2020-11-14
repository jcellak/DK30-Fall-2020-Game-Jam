/// @desc 
lerp_progress += (1 - lerp_progress) / 50;
text_progress += text_speed;

x1 = lerp(x1,x1_target,lerp_progress);
x2 = lerp(x2,x2_target,lerp_progress);

if next_plus next_bounce += bounce_sp;
else next_bounce -= bounce_sp;

if next_bounce >= next_bounce_var next_plus = false;
else if next_bounce <= -next_bounce_var next_plus = true;

var _message_length = string_length(mess);

if keyboard_check_pressed(vk_enter) or mouse_check_button_pressed(mb_left) {
	if (text_progress >= _message_length) {
		if instance_exists(o_text_queued) with o_text_queued ticket--;
		instance_destroy();
	}
	else {
		if text_progress > 2 text_progress = _message_length;
	}
}

if (text_progress >= _message_length) time++;
if time >= room_speed * 4 {
		if instance_exists(o_text_queued) with o_text_queued ticket--;
		instance_destroy();
}
