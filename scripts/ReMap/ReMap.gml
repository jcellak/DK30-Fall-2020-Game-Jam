///@desc ReMap(new map)
///@arg newmap
function ReMap(argument0) {

	var new_map = argument0
	show_debug_message("new key")
	if (keyboard_check_pressed(vk_anykey) or mouse_check_button_pressed(mb_any)) 
	{
		var _last_key = keyboard_check(vk_anykey)? keyboard_lastkey : mouse_lastbutton;
		if _last_key != noone and _last_key < 124
		{
			if new_map >= array_length(key) 
			{
				global.key_two[new_map-array_length(key)] = _last_key
			}
			else if new_map >= 0 and new_map < array_length(key) 
			{
				global.key_one[new_map] = _last_key;	
			}
			
			//check for other maps
			for (var w = 0; w < array_length(key); w++)
			{
				if new_map >= 0 
				{
					if new_map < array_length(key)  
					{
						if global.key_one[new_map] == global.key_one[w] and w != new_map global.key_one[w] = noone;
						if global.key_one[new_map] == global.key_two[w] global.key_two[w] = noone;
					}
					else  
					{
						if global.key_two[new_map - array_length(key)] == global.key_two[w] and w != new_map  - array_length(key) global.key_two[w] = noone;
						if global.key_two[new_map - array_length(key)] == global.key_one[w] global.key_one[w] = noone;
					}
				}
			}
			new_key = false;
			menu_control = true;
			show_debug_message("new key off")
		}
	}


}