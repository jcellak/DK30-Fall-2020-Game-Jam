/// @desc 
/*********************************************************************** Visual effects ********************************************************/
x_one += rob_spd * dir_one;
x_two += rob_spd * dir_two;
if (x_one <= (random_range(30,75)) and left_one) or (x_one >= (random_range(340,385)) and !left_one){
	dir_one = dir_one*-1;
	left_one = !left_one;
}
if (x_two <= (random_range(30,75)) and left_two) or (x_two >= (random_range(340,385)) and !left_two){
	dir_two = dir_two*-1;
	left_two = !left_two;
}

flikr_time++
if flikr_time == room_speed*0.5 {
	flikr_time = 0;
	flikr = !flikr;
}

/************************************************************************* Inputs ***************************************************************/

left = keyboard_check_pressed(o_main_controller.key_one[0]) or keyboard_check_pressed(o_main_controller.key_two[0]);
right = keyboard_check_pressed(o_main_controller.key_one[1]) or keyboard_check_pressed(o_main_controller.key_two[1]);
down = keyboard_check_pressed(o_main_controller.key_one[2]) or keyboard_check_pressed(o_main_controller.key_two[2]);
up = keyboard_check_pressed(o_main_controller.key_one[3]) or keyboard_check_pressed(o_main_controller.key_two[3]);
menu_items = current_menu == key? 1+(array_length(current_menu)*2) : array_length(current_menu);
if current_menu == main or current_menu == opt exempt = current_menu == main? menu_items : menu_items+1;
else exempt = noone;
back = menu_items;
options = menu_items+1;
quit = menu_items+2;

if menu_control{
	
	/********************************** Key Inputs **********************************/
	if keyboard_check_pressed(vk_anykey) key_input = true;
	if mouse_check_button_pressed(mb_any) key_input = false;
	if up {
		if cursor == 0 cursor = menu_items;
		else if cursor >= menu_items cursor = menu_items-1;
		else cursor--;
		if cursor == exempt cursor++;
	}
	if down {
		if cursor >= menu_items cursor = 0;
		else cursor++;
		if cursor == exempt cursor++;
	}
	if right{
		if current_menu == opt and cursor != menu_items-1 and cursor < menu_items{
			o_main_controller.vol[cursor] = o_main_controller.vol[cursor] + vol_inc >= 1? 1 : o_main_controller.vol[cursor] + vol_inc;
		}
		else if current_menu == key {
			
		}
		else{
			if cursor < menu_items or cursor == menu_items+2 cursor = /*current_menu == main? menu_items + 1 :*/ menu_items;
			//else if cursor == menu_items + 2 cursor = current_menu == main? menu_items + 1 :menu_items;
			else cursor++;
			if cursor == exempt cursor++;
		}
	}
	if left {
		if current_menu == opt and cursor != menu_items-1 and cursor < menu_items{
			o_main_controller.vol[cursor] = o_main_controller.vol[cursor] - vol_inc <= 0? 0 : o_main_controller.vol[cursor] - vol_inc;
		}
		else if current_menu == key {
			
		}
		else{
			if cursor < menu_items cursor = current_menu == main? menu_items + 1 : menu_items;
			else if cursor == menu_items or (current_menu == main and cursor == menu_items + 1) cursor = menu_items+2;
			else cursor--;
		}
	}
	
	/***************************** Mouse Inputs *********************************/
	//if key_input == false cursor = cur_null;
	var mouse_y_gui = device_mouse_y_to_gui(0);
	var mouse_x_gui = device_mouse_x_to_gui(0);
	for (var i = 0; i < menu_items; i++) {
		var _mouse_vol = point_in_rectangle(mouse_x_gui,mouse_y_gui,l_screen+(margin*6),t_screen+(margin)+(margin*i)+10,l_screen+(margin*6)+v_dist+7,t_screen+(margin*2)+(margin*i));
		var _mouse_one = point_in_rectangle(mouse_x_gui,mouse_y_gui,l_screen+(margin*4),t_screen+(margin*2)+(margin*i)+5,l_screen+(margin*7)-5,t_screen+(margin*3)+(margin*i)-5);
		var _mouse_two = point_in_rectangle(mouse_x_gui,mouse_y_gui,l_screen+(margin*7),t_screen+(margin*2)+(margin*(i-array_length(key)))+5,l_screen+(margin*10),t_screen+(margin*3)+(margin*(i-array_length(key)))-5);
		var _mouse_all = point_in_rectangle(mouse_x_gui,mouse_y_gui,l_screen+margin,t_screen+(margin)+(margin*i),l_screen+(margin*6),t_screen+(margin*2)+(margin*i));
		
		if current_menu == opt and i != menu_items - 1 var _mouse = _mouse_vol;
		else if current_menu == key var _mouse = i < array_length(key)? _mouse_one : _mouse_two;
		else var _mouse = _mouse_all;
		
		if _mouse cursor = i;
	}
	
	for (var j = 0; j < array_length(con); j++){
		if point_in_rectangle(mouse_x_gui,mouse_y_gui,l_screen+margin + (screen_split*j)-5,t_screen+10,l_screen+(margin*4) + (screen_split*j),t_screen+margin) and j != exempt-menu_items{
			cursor = j + menu_items;
			//key_input = false;
		}
	}

	/************************** Select *******************************************/
	if keyboard_check_pressed(vk_enter) or mouse_check_button_pressed(mb_left) cur_committed = cursor;
	if keyboard_check_pressed(vk_backspace) and current_menu != main cur_committed = menu_items;
}

// runs script for recieving new key map
if new_key {
	cursor = new_map;
	ReMap(new_map);
}

if sliding != cur_null {
	o_main_controller.vol[sliding] = (point_distance(l_screen+(margin*6),t_screen+(margin*2)+(margin*sliding)+5,mouse_x_gui,t_screen+(margin*2)+(margin*sliding)+5)/v_dist);
	if mouse_x_gui < l_screen+(margin*6) {
		o_main_controller.vol[sliding] = 0;
		sliding = cur_null;
	}
	if mouse_x_gui > l_screen+(margin*6) + v_dist{
		o_main_controller.vol[sliding] = 1;
		sliding = cur_null;
	}
	if mouse_check_button_released(mb_left) sliding = cur_null;
	
}

/************************************************************** What to do **************************************************************/
if cur_committed != cur_null{
	if cur_committed == options{
		prev_menu = current_menu;
		Menu_to(opt);
	}
	else if cur_committed == quit game_end();
	else{

		switch current_menu{
			case main: {
				o_main_controller.multiplayer = cur_committed == 1? true : false; 
				var _multi = cur_committed == 1? multiplayer : play;
				Menu_to(_multi)
			}break;
			case multiplayer: {
				switch cur_committed{
					case 0: 
					case 1: Menu_to(play); break;
					case 2: break;
					case back: Menu_to(main); break;
				}
			}break;
			case play:{
				switch cur_committed{
					case 0: break;
					case 1: break;
					case back:{
						var _multi = o_main_controller.multiplayer? multiplayer : main; 
						Menu_to(_multi)
					}break;
				}				
			}break;
			case opt: {
				if cur_committed == menu_items - 1 current_menu = key;
				else if cur_committed == back Menu_to(prev_menu);
				else sliding = cur_committed;
			}break;
			case key:{
				if cur_committed == back Menu_to(opt); 
				else if cur_committed == restore_def with o_main_controller event_user(0);
				else{
					if !new_key {
						new_key = true;
						keyboard_lastkey = noone;
						mouse_lastbutton = noone;	
						new_map = cur_committed;
						menu_control = false;
					}
				}				
			}break;
		}
	} 
	cur_committed = cur_null;
}
	

