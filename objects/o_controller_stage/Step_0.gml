/// @desc 
/******************************************************************** Audio ************************************************************/
for (var k = 0; k < array_length(sounds); k++){
	if audio_is_playing(sounds[k]) audio_sound_gain(sounds[k],global.vol[0]*global.vol[1],0);
}
for (var a = 0; a < array_length(music); a++){
	if audio_is_playing(music[a]) audio_sound_gain(music[a],global.vol[0]*global.vol[2],0);
}

/******************************************************************** Pause Brains ******************************************************/
if keyboard_check_pressed(vk_escape) {
	global.pause = !global.pause;
	if !sprite_exists(screenshot) screenshot = sprite_create_from_surface(application_surface,0,0,view_wport,view_hport,0,0,0,0);  
}

if global.pause {
	instance_deactivate_all(1);
	left = keyboard_check_pressed(global.key_one[0]) or keyboard_check_pressed(global.key_two[0]);
	right = keyboard_check_pressed(global.key_one[1]) or keyboard_check_pressed(global.key_two[1]);
	down = keyboard_check_pressed(global.key_one[2]) or keyboard_check_pressed(global.key_two[2]);
	up = keyboard_check_pressed(global.key_one[3]) or keyboard_check_pressed(global.key_two[3]);
	menu_items = current_menu == key? 1+(array_length(current_menu)*2) : array_length(current_menu);
	back = menu_items;
	options = menu_items+1;
	quit = menu_items+2;
	exempt = options;
	con[1] = current_menu == key? con_key : con_options;

	if menu_control{

		/********************************** Key Inputs **********************************/
		if mouse_check_button_pressed(mb_any) key_input = false;
		if up {
			if cursor == 0 or (current_menu == key and (cursor == array_length(key) or cursor == restore_def)) cursor = menu_items;
			else if cursor >= menu_items cursor = current_menu == key? array_length(key)-1 : menu_items-1;
			else cursor--;
			if cursor == exempt cursor++;
		}
		if down {
			if cursor >= menu_items cursor = 0;
			else if cursor == array_length(key)-1 or cursor == (array_length(key)*2)-1 or cursor == restore_def cursor = menu_items;
			else cursor++;
			if cursor == exempt cursor++;
		}
		if right{
			if current_menu == opt and cursor < 3 and cursor >=0 {
				global.vol[cursor] = global.vol[cursor] + vol_inc >= 1? 1 : global.vol[cursor] + vol_inc;
			}
			else if current_menu == key and cursor < menu_items{
				if cursor == restore_def cursor = 0;
				else if cursor >= array_length(key) cursor = restore_def;
				else cursor += array_length(key);
			}
			else{
				if cursor < menu_items or cursor == menu_items+2 cursor = menu_items;
				else cursor++;
				if cursor == exempt cursor++;
			}
		}
		if left {
			if current_menu == opt and cursor < 3 and cursor >=0 {
				global.vol[cursor] = global.vol[cursor] - vol_inc <= 0? 0 : global.vol[cursor] - vol_inc;
			}
			else if current_menu == key and cursor < menu_items{
				if cursor < array_length(key) cursor = restore_def;
				else cursor -= array_length(key);
			}
			else{
				if cursor < menu_items cursor = current_menu == main? menu_items + 1 : menu_items;
				else if cursor == menu_items or (current_menu == main and cursor == menu_items + 1) cursor = menu_items+2;
				else cursor--;
				if cursor == exempt cursor--;
			}
		}

		if keyboard_check_pressed(vk_anykey) and !key_input{
			key_input = true;
			cursor = 0
		}

		/***************************** Mouse Inputs *********************************/
		if key_input == false cursor = cur_null;
		var mouse_y_gui = device_mouse_y_to_gui(0);
		var mouse_x_gui = device_mouse_x_to_gui(0);
		for (var i = 0; i < menu_items; i++) {
			var _mouse_vol = point_in_rectangle(mouse_x_gui,mouse_y_gui,l_screen+(margin*6),t_screen+(margin)+(margin*i)+10,l_screen+(margin*6)+v_dist+7,t_screen+(margin*2)+(margin*i));
			var _mouse_one = point_in_rectangle(mouse_x_gui,mouse_y_gui,l_screen+(margin*4),t_screen+(margin*2)+(margin*i)+5,l_screen+(margin*7)-5,t_screen+(margin*3)+(margin*i)-5);
			var _mouse_two = point_in_rectangle(mouse_x_gui,mouse_y_gui,l_screen+(margin*7),t_screen+(margin*2)+(margin*(i-array_length(key)))+5,l_screen+(margin*10),t_screen+(margin*3)+(margin*(i-array_length(key)))-5);
			var _mouse_all = point_in_rectangle(mouse_x_gui,mouse_y_gui,l_screen+margin,t_screen+(margin)+(margin*i),l_screen+(margin*6),t_screen+(margin*2)+(margin*i));

			if current_menu == opt and i < 3 var _mouse = _mouse_vol;
			else if current_menu == key {
				if i == restore_def _mouse = point_in_rectangle(mouse_x_gui,mouse_y_gui,r_screen,t_screen+(screen_h*0.5)-item_height-10,r_screen+(item_height*3),t_screen+(item_height*7)+(screen_h*0.5)-10)
				else var _mouse = i < array_length(key)? _mouse_one : _mouse_two;
			}
			else var _mouse = _mouse_all;

			if _mouse {
				cursor = i; 
				key_input = false;
			}
		}

		for (var j = 0; j < array_length(con); j++){
			if point_in_rectangle(mouse_x_gui,mouse_y_gui,l_screen+margin + (screen_split*j)-5,t_screen+10,l_screen+(margin*4) + (screen_split*j),t_screen+margin) and j != exempt-menu_items{
				cursor = j + menu_items;
				key_input = false;
			}
		}

		/************************** Select *******************************************/
		if keyboard_check_pressed(vk_enter) or mouse_check_button_pressed(mb_left) cur_committed = cursor;
		if keyboard_check_pressed(vk_backspace) and current_menu != main cur_committed = back;
	}

	// runs script for recieving new key map
	if new_key {
		cursor = new_map;
		ReMap(new_map);
	}

	if sliding != cur_null {
		global.vol[sliding] = (point_distance(l_screen+(margin*6),t_screen+(margin*2)+(margin*sliding)+5,mouse_x_gui,t_screen+(margin*2)+(margin*sliding)+5)/v_dist);
		if mouse_x_gui < l_screen+(margin*6) {
			global.vol[sliding] = 0;
			sliding = cur_null;
		}
		if mouse_x_gui > l_screen+(margin*6) + v_dist{
			global.vol[sliding] = 1;
			sliding = cur_null;
		}
		if mouse_check_button_released(mb_left) sliding = cur_null;

	}

	/************************************************************** What to do **************************************************************/
	if cur_committed != cur_null{
		if cur_committed == quit game_end();
		else{
			switch current_menu{
				case opt: {
					if cur_committed == 3 Menu_to(key);
					else if cur_committed == 4 {
						if (audio_is_playing(a_coop_track)) {
							audio_stop_sound(a_coop_track);
						}

						if (audio_is_playing(a_boss_track_edit)) {
							audio_stop_sound(a_boss_track_edit);
						}

						if (!audio_is_playing(a_two_robots)) {
							audio_play_sound(a_two_robots, 10, true);
							audio_sound_gain(a_two_robots,global.vol[0]*global.vol[2],0);
						}
						room_goto(r_title);
						send_event_goto_room(r_title);
						global.pause = false;
					}
					else if cur_committed == 5 {
						global.pause = false;
						for (var i = 0; i < 2; i++) {
							global.player_hp[i] = initial_player_state[i].hp;
							global.player_charge[i] = initial_player_state[i].charge;
							var _mods = (i == 0 ? global.player_1_modules : global.player_2_modules);
							_mods.jump = initial_player_state[i].modules.jump;
							_mods.hang = initial_player_state[i].modules.hang;
							_mods.dash = initial_player_state[i].modules.dash;
							_mods.double = initial_player_state[i].modules.double;
							_mods.blast = initial_player_state[i].modules.blast;
						}
						send_event_restart_room();
						room_restart();
					}
					else if cur_committed == back global.pause = false;
					else if key_input == false sliding = cur_committed;
				}break;
				case key:{
					if cur_committed == back Menu_to(opt); 
					else if cur_committed == restore_def Default_key_map();
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
}
else {
	if sprite_exists(screenshot) sprite_delete(screenshot);
	instance_activate_all();
}

if keyboard_check_pressed(vk_tab) and !instance_exists(o_Text) {
	new_text_box("hello!",0.75,0);
	new_text_box("how are you?",0.05,0);
	new_text_box("hope things are going well, \"insert name here\".",1.5,0);
}