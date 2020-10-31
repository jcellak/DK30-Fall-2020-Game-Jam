/// @desc 
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


left = keyboard_check_pressed(o_main_controller.key_one[0]) or keyboard_check_pressed(o_main_controller.key_two[0]);
right = keyboard_check_pressed(o_main_controller.key_one[1]) or keyboard_check_pressed(o_main_controller.key_two[1]);
down = keyboard_check_pressed(o_main_controller.key_one[2]) or keyboard_check_pressed(o_main_controller.key_two[2]);
up = keyboard_check_pressed(o_main_controller.key_one[3]) or keyboard_check_pressed(o_main_controller.key_two[3]);
menu_items = /*current_menu == key? 1+(array_length(current_menu)*2) : */array_length(current_menu);
if current_menu == main or current_menu == opt exempt = current_menu == main? menu_items : menu_items+1;
else exempt = noone;
back = menu_items;
options = menu_items+1;
quit = menu_items+2;

if menu_control{
	if up {
		if cursor == 0 cursor = /*current_menu == main? menu_items + 1 : */menu_items;
		else if cursor >= menu_items cursor = menu_items-1;
		else cursor--;
		if cursor == exempt cursor++;
	}
	if down {
		if cursor >= menu_items cursor = 0;
		else cursor++;
		if cursor == exempt /*menu_items and current_menu == main*/ cursor++;
	}
	if right{
		if current_menu == opt and cursor != menu_items-1 and cursor < menu_items{
			o_main_controller.vol[cursor] = o_main_controller.vol[cursor] + vol_inc >= 1? 1 : o_main_controller.vol[cursor] + vol_inc;
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
		else{
			if cursor < menu_items cursor = current_menu == main? menu_items + 1 : menu_items;
			else if cursor == menu_items or (current_menu == main and cursor == menu_items + 1) cursor = menu_items+2;
			else cursor--;
		}
	}

	if keyboard_check_pressed(vk_enter) cur_committed = cursor;
	if keyboard_check_pressed(vk_backspace) and current_menu != main cur_committed = menu_items;
}

if new_key {
	cursor = new_map;
	ReMap(new_map);
}

if cur_committed != cur_null{
	if cur_committed == options{
		prev_menu = current_menu;
		Menu_to(opt);
	}
	
	//if cur_committed == options current_menu = opt;
	else if cur_committed == quit game_end();
	else{
		
	//switch cur_committed{
		//case back: current_menu = current_menu == opt? prev_menu; break;
		//case options: current_menu = opt; break;
		//case quit: game_end() break;
		//default: {
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
	
	
show_debug_message(prev_menu)