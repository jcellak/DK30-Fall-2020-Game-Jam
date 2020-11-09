/// @desc 
image_speed = 0.1;
//draw_sprite(s_electrical,-1,60,165);

draw_set_color(c_lime);
draw_set_alpha(1);
draw_set_halign(fa_left);
draw_set_valign(fa_bottom);
draw_set_font(m_font);
draw_line(l_screen+10,t_screen+(margin),r_screen-10,t_screen+(margin));
var _col = make_color_rgb(0,15,2);
var _flk = flikr? "_" : " ";

for (var i = 0; i < array_length(current_menu); i ++)
{
	if current_menu == key{
		draw_text(l_screen+margin,t_screen+(margin*3)+(margin*i),key[i]);
		draw_text(l_screen+(margin*4),t_screen+(margin*2),"PLAYER 1");
		draw_text(r_screen-(margin*2),t_screen+(margin*2),"PLAYER 2");
		draw_line(l_screen+(margin*4),t_screen+(margin*2)+(margin*i),r_screen-5,t_screen+(margin*2)+(margin*i));
		draw_line(l_screen+(margin*7),t_screen+(margin*2),l_screen+(margin*7),t_screen+(margin*6));
		if i == cursor{
			draw_set_color(c_lime);
			draw_rectangle(l_screen+(margin*4),t_screen+(margin*2)+(margin*i)+5,l_screen+(margin*7)-5,t_screen+(margin*3)+(margin*i)-5,false);
			draw_text((r_screen-(margin*2)),t_screen+(margin*3)+(margin*i)-5,KeyInputDisplay(o_main_controller.key_two[i]));
			draw_set_color(_col);
			draw_text(t_screen+(margin*7),t_screen+(margin*3)+(margin*i)-5,KeyInputDisplay(o_main_controller.key_one[i]));
		}
		else if i == cursor - array_length(key){
			draw_set_color(c_lime);
			draw_rectangle(l_screen+(margin*7)+5,t_screen+(margin*2)+(margin*i)+5,l_screen+(margin*10),t_screen+(margin*3)+(margin*i)-5,false);
			draw_text(t_screen+(margin*7),t_screen+(margin*3)+(margin*i)-5,KeyInputDisplay(o_main_controller.key_one[i]));
			draw_set_color(_col);
			draw_text((r_screen-(margin*2)),t_screen+(margin*3)+(margin*i)-5,KeyInputDisplay(o_main_controller.key_two[i]));
		}
		else{
			draw_set_color(c_lime);
			draw_text(t_screen+(margin*7),t_screen+(margin*3)+(margin*i)-5,KeyInputDisplay(o_main_controller.key_one[i]));
			draw_text((r_screen-(margin*2)),t_screen+(margin*3)+(margin*i)-5,KeyInputDisplay(o_main_controller.key_two[i]));
		}
		draw_set_color(c_lime);
	}
	else {
		if current_menu == opt and i != menu_items-1 {
			draw_rectangle(l_screen+(margin*6),t_screen+(margin)+(margin*i)+10,l_screen+(margin*6)+v_dist+7,t_screen+(margin*2)+(margin*i),true);
			var _volchk = cursor != i? false : true;
			draw_rectangle(l_screen+(margin*6)+(v_dist*o_main_controller.vol[i]),t_screen+(margin)+(margin*i)+10,l_screen+(margin*6)+(v_dist*o_main_controller.vol[i])+7,t_screen+(margin*2)+(margin*i),_volchk);
			var _txt = current_menu[i];
		}
		else var _txt = cursor == i? string_insert(_flk,current_menu[i],1) : current_menu[i];
		draw_text(l_screen+margin,t_screen+(margin*2)+(margin*i),_txt);
	}
}
for (var j = 0; j < array_length(con); j++)
{
	var _con = cursor == j+menu_items? string_insert(_flk,con[j],1) : con[j];
	if exempt == menu_items + 1 and j == 1 {
		draw_rectangle(l_screen+margin + (screen_split*j)-5,t_screen+5,l_screen+margin + (screen_split*j)+string_width(con[j])+5,t_screen+11+string_height(con[j]),false);
		draw_set_color(_col);
	}
	else draw_set_color(c_lime);
	if exempt != menu_items or j != 0 draw_text(l_screen+margin + (screen_split*j),t_screen+margin,_con);
}


draw_sprite_ext(s_robot1,0,x_one,170,dir_one*0.7,0.7,1,c_white,1);
draw_sprite_ext(s_robot2,0,x_two,170,dir_two*0.7,0.7,1,c_white,1);