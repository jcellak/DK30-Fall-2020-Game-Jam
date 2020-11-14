/// @desc 
image_speed = 0.3;
//draw_sprite(s_electrical,-1,60,165);
DrawSetText(c_lime,m_font,fa_left,fa_bottom,1)

draw_line(l_screen+10,t_screen+(margin),r_screen-10,t_screen+(margin));
var _col = make_color_rgb(0,15,2);
var _flk = flikr? "_" : " ";

//if current_menu == title{
//	draw_text(l_screen,t_screen,"AFT3R-U:")
//	draw_set_font(f_title_small);
//	var _title = string_insert(_flk,"RELUCTANT ROBOTS",1)
//	draw_text(l_screen,t_screen+50,_title);
//}
//else {
	for (var i = 0; i < array_length(current_menu); i ++)
	{
		if current_menu == key{
			draw_text(l_screen+margin,t_screen+(margin*3)+(margin*i),key[i]);
			draw_text(l_screen+(margin*4),t_screen+(margin*2),"PLAYER 1");
			draw_text(l_screen+(margin*7),t_screen+(margin*2),"PLAYER 2");
			draw_line(l_screen+(margin*4),t_screen+(margin*2)+(margin*i),r_screen-5,t_screen+(margin*2)+(margin*i));
			draw_line(l_screen+(margin*7),t_screen+(margin*2),l_screen+(margin*7),t_screen+(margin*2)+(margin*(i+1)));
			if i == cursor{
				draw_set_color(c_lime);
				draw_rectangle(l_screen+(margin*4),t_screen+(margin*2)+(margin*i)+5,l_screen+(margin*7)-5,t_screen+(margin*3)+(margin*i)-5,false);
				draw_text((r_screen-(margin*2)),t_screen+(margin*3)+(margin*i)-5,KeyInputDisplay(global.key_two[i]));
				draw_set_color(_col);
				draw_text(t_screen+(margin*7),t_screen+(margin*3)+(margin*i)-5,KeyInputDisplay(global.key_one[i]));
			}
			else if i == cursor - array_length(key){
				draw_set_color(c_lime);
				draw_rectangle(l_screen+(margin*7)+5,t_screen+(margin*2)+(margin*i)+5,l_screen+(margin*10),t_screen+(margin*3)+(margin*i)-5,false);
				draw_text(t_screen+(margin*7),t_screen+(margin*3)+(margin*i)-5,KeyInputDisplay(global.key_one[i]));
				draw_set_color(_col);
				draw_text((r_screen-(margin*2)),t_screen+(margin*3)+(margin*i)-5,KeyInputDisplay(global.key_two[i]));
			}
			else{
				draw_set_color(c_lime);
				draw_text(t_screen+(margin*7),t_screen+(margin*3)+(margin*i)-5,KeyInputDisplay(global.key_one[i]));
				draw_text((r_screen-(margin*2)),t_screen+(margin*3)+(margin*i)-5,KeyInputDisplay(global.key_two[i]));
			}
			draw_set_color(c_lime);
		}
		else if current_menu != title {
			if current_menu == opt and i != menu_items-1 {
				draw_rectangle(l_screen+(margin*6),t_screen+(margin)+(margin*i)+10,l_screen+(margin*6)+v_dist+7,t_screen+(margin*2)+(margin*i),true);
				var _volchk = cursor != i? false : true;
				draw_rectangle(l_screen+(margin*6)+(v_dist*global.vol[i]),t_screen+(margin)+(margin*i)+10,l_screen+(margin*6)+(v_dist*global.vol[i])+7,t_screen+(margin*2)+(margin*i),_volchk);
				var _txt = current_menu[i];
			}
			else var _txt = cursor == i? string_insert(_flk,current_menu[i],1) : current_menu[i];
			draw_text(l_screen+margin,t_screen+(margin*2)+(margin*i),_txt);
		}
	}

	if current_menu == key {
		if cursor == restore_def{
			var _def = _col;
			var _defchk = false;
		}
		else {
			var _def = c_lime;
			var _defchk = true;
		}
		draw_set_color(c_lime);
		draw_rectangle(r_screen,t_screen+(screen_h*0.5)-item_height-10,r_screen+(item_height*3),t_screen+(item_height*7)+(screen_h*0.5)-10,_defchk);
		draw_set_color(_def);
		for (var k = 0; k < 7;k++){
			draw_text(r_screen+5,t_screen+(screen_h*0.5)+(item_height*k),string_char_at(def_key,k+1));
			draw_text(r_screen+20,t_screen+(screen_h*0.5)+(item_height*k),string_char_at(def_key,k+9));
		}
		draw_set_color(c_lime);
	}


	if (current_menu == menu_waiting) {
		draw_text(l_screen + margin, t_screen + margin * 2, "WAITING FOR PLAYER 2");
	}

	if (current_menu == menu_connect) {
		var _connection_text = "CONNECTING...";
	
		if (global.connection != noone) {
			if (global.connection >= 0) {
				_connection_text = "WAITING FOR HOST";
			} else {
				_connection_text = "CONNECTION FAILED";
			}
		}
		draw_text(l_screen + margin, t_screen + margin * 2, _connection_text);
	}


	for (var j = 0; j < array_length(con); j++)
	{
		var _con = cursor == j+menu_items? string_insert(_flk,con[j],1) : con[j];
		if exempt == menu_items + 1 and j == 1 {
			draw_rectangle(l_screen+margin + (screen_split*j)-5,t_screen+10,l_screen+margin + (screen_split*j)+string_width(con[j])+5,t_screen+11+string_height(con[j])+1,false);
			draw_set_color(_col);
		}
		else draw_set_color(c_lime);
		if exempt != menu_items or j != 0 draw_text(l_screen+margin + (screen_split*j),t_screen+margin,_con);
	}
//}

draw_sprite(s_screen_crack,0,40,5);

draw_sprite_ext(s_player_catbot_walk,-1,x_one,221,dir_one*1.5,1.5,1,c_white,1);
draw_sprite_ext(s_player_cyclops_walk,-1,x_two,221,dir_two*1.5,1.5,1,c_white,1);