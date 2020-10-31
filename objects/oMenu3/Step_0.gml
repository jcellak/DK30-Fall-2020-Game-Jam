/// @desc menu control

//ease in
menu_y += ((menu_y_target - menu_y)/menu_speed);
load_x += ((load_x_target - load_x)/menu_speed);
option_y += ((option_y_target - option_y)/menu_speed);
map_x += ((map_x_target - map_x)/menu_speed);
back_y += ((back_y_target - back_y)/menu_speed);

#region Main menu
/************************************************************************************** Main Menu ****************************************************************************************************/
if current_array == menu
{
	if menu_committed != menu_com_null 
	{
		switch menu_committed
		{
			case 3: // continue or new game
			{
				menu_control = false;
				current_array = noone;
				if global.save == -1
				{
					Slide_Transition(TRANS_MODE.NEXT);
					global.save = array_length(oController.savkey) - 1;
				}
				else 
				{
					SaveFile(SAVEGAME,oController.savkey[global.save]);
				}
			}
			break;
			case 2: 
			{
				menu_to(load); 
				load_y = load_y_init;
			}break;
			case 1: menu_to(options); break;
			case 0: game_end(); break;
		}
		ScreenShake(4,30);
		menu_committed = menu_com_null;
	}
/************************************** menu boundaries ****************************/
	menu_top = menu_y_target - ((menu_itemheight * 1.6) * menu_items); 
	menu_y_target = gui_height - gui_margin;
	menu_bot = menu_y_target;
	menu_items = array_length(current_array);
	back_y_target = back_y_def
}
else 
{
	menu_y_target = menu_y_def;
	back_y_target = current_array != noone? 50 : back_y_def
}

// check for existing save data
var _no_data = true
for( var p = 0; p < array_length(oController.savkey); p++)
{
	if oController.FUBAR[p,0] != oController.no_save _no_data = false;
}
if _no_data 
{
	//if file_exists(SAVEFILE) file_delete(SAVEFILE);
	if current_array == load and del_mode menu_to(options);
	no_data = true;
}
else no_data = false;

menu[3] = global.save != -1? "CONTINUE" : "NEW GAME";
#endregion

#region Load Screen
/****************************************************************************************** Load Screen *****************************************************************************************************/
if current_array == load
{
	if menu_committed != menu_com_null 
	{ 
		if del_mode
		{
			if menu_committed == back 
			{
				menu_to(options);
				del_mode = false;
			}
			else
			{
				if oController.FUBAR[menu_committed,0] != oController.no_save
				{
					OverwriteData(SAVEGAME,oController.no_save,oController.no_save,oController.savkey[menu_committed])
					oController.FUBAR[menu_committed,0] = oController.no_save;
					if global.save == menu_committed 
					{
						//if file_exists(SAVEFILE) file_delete(SAVEFILE);
						var _ch = false
						for (var s = 0; s < array_length(oController.savkey); s++)
						{
							if oController.FUBAR[s,0] != oController.no_save 
							{
								_ch = true;
								global.save = s;
							}
						}
						if _ch == false	global.save = -1;
						//else 
						//{
						//	var file;
						//	file = file_text_open_write(SAVEFILE);
						//	file_text_write_real(file,global.save);
						//	file_text_close(file);	
						//}
					}
				}
			}		
		}
		else
		{
			if menu_committed == back menu_to(menu);
			else
			{
				SaveFile(SAVEGAME,oController.savkey[menu_committed]);
				global.save = menu_committed;
				//RecentSave();
				current_array = noone;
				menu_control = false;
			}
		}
		ScreenShake(4,30);
		menu_committed = menu_com_null;
	}
/************************************** menu boundaries ****************************/
	//load_y = load_y_init
	menu_top = gui_margin// - 50;
	load_x_target = gui_width-gui_margin;
	menu_bot = gui_height - 50;
	menu_items = array_length(current_array);
}
else load_x_target = load_x_def;

//define key map boundary
map_column = map_x - (((map_x_event - l_column) - (map_box_x *2)) + map_box_x);
#endregion

#region Options Screen
/************************************************************************************** Options Menu ********************************************************************************************/
menu_top_alt = option_y - ((menu_itemheight * 1.5) * array_v);

if current_array == options
{
	if menu_committed != menu_com_null  
	{	
		switch menu_committed
		{
			case 3: window_set_fullscreen(!window_get_fullscreen());break;
			case 2: oController.borderless = !oController.borderless; break;
			case 1: menu_to(oController.maps); break;//menu_control = false; 
			case 0: 
			{
				if !no_data
				{
					del_mode = true;
					menu_to(load);
				}
			}
			break;
			case back: 
			{
				SavePref();
				menu_to(menu);
			}
			break;
		}
		
		if menu_committed >= (array_v) and !key_input //and v_hover > array_length(options) - (array_v+1)
		{
			alter_v[menu_committed-array_v] = true;
			sliding = true;
		}
		else 
		{
			menu_committed = menu_com_null;
			ScreenShake(4,30);
		}
		//if menu_committed < array_length(options) - (array_v-1) menu_committed = menu_com_null; 
	}
/************************************** menu boundaries ****************************/
	var _slider = key_right - key_left;
	if _slider != 0 and menu_cursor >= array_v
	{
		oController.v_slider[menu_cursor-array_v] = _slider > 0? min(oController.v_slider[menu_cursor-array_v] + v_inc*_slider,1) : max(oController.v_slider[menu_cursor-array_v] + v_inc * _slider,0);
	}
	menu_top = menu_top_alt - (menu_itemheight * (3.5)) - (gui_margin*(array_length(options)));
	option_y_target = option_dist + gui_margin;
	menu_bot = option_y_target;
	
	if sliding 
	{
		menu_cursor = menu_committed;
		if device_mouse_x_to_gui(0) < option_x -10 and device_mouse_x_to_gui(0) > option_x - v_dist -10
		{
			oController.v_slider[menu_cursor-array_v] = 1-(point_distance(option_x-10,slider_y[menu_cursor-array_v],device_mouse_x_to_gui(0),slider_y[menu_cursor-array_v])/v_dist);
		}
		
		if mouse_check_button_released(mb_left) 
		{
			if alter_v[1] 
			{
				audio_play_sound(oController.sfx_test,2,false);
				audio_sound_gain(oController.sfx_test,oController.sfx_volume,0);
			}
			alter_v[menu_committed-array_v] = false;
			sliding = false;
			menu_committed = menu_com_null;
		}
	}
	menu_items = array_length(current_array);
}
else option_y_target = option_y_def;

/**************************************************** Sliding ***********************************************************/
event_user(1);	//slider x and y

#endregion

#region Player Input
if menu_control 
{
/***************************************************************************************** Player Input *****************************************************************************/

	key_left = keyboard_check_pressed(vk_left) or keyboard_check_pressed(ord("A"));
	key_right = keyboard_check_pressed(vk_right) or keyboard_check_pressed(ord("D")); 
/***************************************************************** Key Input *********************************************************************/
	if keyboard_check_pressed(vk_up) or keyboard_check_pressed(ord("W")) or gamepad_button_check_pressed(0,gp_padu) or mouse_wheel_up() // or outUp
	{
		if key_input
		{
			if menu_cursor >= menu_items menu_cursor = menu_items - 1;
			menu_cursor++;
			if menu_cursor >= menu_items menu_cursor = 0;
		}
		else
		{
			key_input = true;
			menu_cursor = array_length(current_array) - 1;
		}
	}
	
	if keyboard_check_pressed(vk_down) or keyboard_check_pressed(ord("S")) or keyboard_check_pressed(vk_tab) or gamepad_button_check_pressed(0,gp_padd) or mouse_wheel_down() // or outDown                                                                  
	{
		if key_input
		{
			if menu_cursor >= menu_items menu_cursor = menu_items;
			menu_cursor--;
			if (menu_cursor < 0) menu_cursor = menu_items - 1;
		}
		else
		{
			key_input = true;
			menu_cursor = array_length(current_array) - 1;			
		}
	}
	if current_array == oController.maps 
	{
		if key_right 
		{
			if menu_cursor < array_length(oController.maps) and menu_cursor >= 0 menu_cursor = restore_def;
			else if menu_cursor >= array_length(oController.maps) and menu_cursor < (array_length(oController.maps)*2) menu_cursor -= array_length(oController.maps);
			else if menu_cursor = restore_def menu_cursor = (array_length(oController.maps)*2) - 1;
		}
		if key_left
		{
			if menu_cursor < array_length(oController.maps) and menu_cursor >= 0 menu_cursor += array_length(oController.maps); 
			else if menu_cursor >= array_length(oController.maps) and menu_cursor < (array_length(oController.maps)*2) menu_cursor = restore_def;
			else if menu_cursor = restore_def menu_cursor = (array_length(oController.maps)) - 1;
		}
		//if key_right or key_left menu_cursor = menu_cursor < array_length(oController.maps) ? menu_cursor + array_length(oController.maps) : menu_cursor - array_length(oController.maps); // if i add more rows will need to change this
	}
/****************************************************************** Mouse Input ******************************************************************/
	var mouse_y_gui = device_mouse_y_to_gui(0);
	var mouse_x_gui = device_mouse_x_to_gui(0);
	if  point_in_rectangle(mouse_x_gui,mouse_y_gui,l_column,menu_top,gui_width-gui_margin,menu_bot) 
	{
		key_input = false;
		switch current_array
		{
			case menu: menu_cursor = (menu_y - mouse_y_gui) div (menu_itemheight * 1.7); break;
			case load: menu_cursor = (load_y - mouse_y_gui) div (y_offset+(gui_margin)); break;
			case options: 
			{
				if mouse_y_gui > menu_top_alt and !sliding
				{
					menu_cursor = (option_y - mouse_y_gui) div (menu_itemheight * 1.8); 
					clamp(menu_cursor,0,array_v-1);
					//show_debug_message((option_y - mouse_y_gui))
				}
				else 
				{
					for (var a = 0; a < array_length(options) - array_v; a++)
					{
						if point_in_rectangle(mouse_x_gui,mouse_y_gui, option_x-x_offset-50, slider_y[a] - v_height + (gui_margin), gui_width, slider_y[a] + (gui_margin)) and !sliding menu_cursor = a + array_v;
					}				
				}
				if menu_cursor >= array_v and menu_cursor < menu_items and point_in_circle(mouse_x_gui,mouse_y_gui,slider_x[menu_cursor-array_v],slider_y[menu_cursor-array_v],15) v_hover = menu_cursor;
				else if !sliding v_hover = noone;
			}
			break;
			case oController.maps:
			{
				if !new_key
				{
					for (var b = 0; b < array_length(oController.maps)*2; b++)
					{
						if point_in_rectangle(mouse_x_gui,mouse_y_gui,l_column,(map_y - (map_box_y * map_box_margin * (b-array_length(oController.maps))))-map_box_y,map_column,(map_y - (map_box_y * map_box_margin * (b-array_length(oController.maps))))) menu_cursor = b;
						if point_in_rectangle(mouse_x_gui,mouse_y_gui,map_x-map_box_x,(map_y - (map_box_y * map_box_margin * b))-map_box_y,map_x,map_y - (map_box_y * map_box_margin * b)) menu_cursor = b;
					}				
					if point_in_rectangle(mouse_x_gui,mouse_y_gui,map_x + gui_margin,(gui_height*(1/3)),map_x+map_box_y+gui_margin,(gui_height*(2/3))) menu_cursor = restore_def;
				}
			}
			break;
		} 
	}
	
/******************* back *********************/
	else if current_array != menu and point_in_rectangle(mouse_x_gui,mouse_y_gui,back_x,back_y,back_x+sprite_get_width(sBackArrow),back_y+sprite_get_height(sBackArrow))// mouse_y_gui > 50 and mouse_y_gui < 150 and mouse_x_gui > 50 and mouse_x_gui < 250 
	{
		menu_cursor = back;
		key_input = false;
	}
	else if !key_input and !sliding and !new_key menu_cursor = menu_com_null;
	
	if keyboard_check_pressed(vk_backspace) or keyboard_check_pressed(vk_escape)
	{
		menu_committed = back;
		//menu_to(menu);
	}
	
/********************************************************************* Enter *******************************************************************/
	if menu_cursor <= (menu_items) and menu_cursor > menu_com_null
	{
		if (keyboard_check_pressed(vk_enter) or gamepad_button_check_pressed(0,gp_face1)) or (mouse_check_button_pressed(mb_left) and key_input = false)
		{
			//if current_array == options and menu_cursor < array_v ScreenShake(4,30);
			menu_committed = menu_cursor;
		}
	}

//key input checks
	if mouse_check_button_pressed(mb_left) key_input = false;
	if keyboard_check_pressed(vk_anykey) key_input = true;
}
#endregion

#region Key Re-mapping Screen
/****************************************************************************************** Key Mapping **********************************************************************************/
if new_key //and map_timer > 2//and menu_committed != menu_com_null
{
	new_map = menu_cursor;
	ReMap(menu_cursor);
	//menu_control = true;
}
else new_map = menu_com_null;

if current_array == oController.maps
{
	if menu_committed != menu_com_null 
	{
		switch menu_committed
		{
			case back:
			{
				if oController.key[0] != noone or oController.key_alt[0] != noone
				{
					SaveKeyMap();
					menu_to(options);
				}
			}
			break;
			case restore_def: 
			{
				with oController event_user(2); 
			}
			break;
			default:
			{
				if oController.controller == 0 and !new_key
				{
					new_key = true;
					keyboard_lastkey = noone;
					mouse_lastbutton = noone;	
				
					new_map = menu_committed
					menu_control = false;
				}			
			}
			break;
		}
		ScreenShake(4,30);
		menu_committed = menu_com_null;
	}
/************************************** menu boundaries ****************************/
	menu_top = gui_margin;
	map_x_target = map_x_event;
	menu_bot = map_y;
	menu_items = (array_length(current_array)*2)+1;
}
else map_x_target = map_x_def;
#endregion


