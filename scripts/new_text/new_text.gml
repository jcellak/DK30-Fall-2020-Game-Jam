// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

//box is the frame in the text box sprite
//currently only one frame so use 0 till that changes

function new_text_box(message_input,text_sp,box){
	var _obj;
	if instance_exists(o_Text) _obj = o_text_queued;
	else _obj = o_Text;
	
	with instance_create_layer(0,0,"Controllers",_obj){
		mess = message_input;
		if instance_exists(other) origin_inst = other.id 
		else origin_inst = noone;
		background = box;
		text_speed = text_sp;
	}
}