/// @desc Draw menu

#region Draw main
/*********************************************************************************** Draw Menu *****************************************************************/
if current_array == menu 
{
	if menu_y != menu_y_def
	{
		for (var i = 0; i < menu_items; i++)
		{
			var offset = 2;
			var txt = menu[i];
			var col
			if (menu_cursor == i)
			{
				col = c_white;
				txt = string_insert(">> ",txt,0);
			}
			else 
			{
				col = c_gray;
			}
			var xx = menu_x;
			var yy = menu_y - (menu_itemheight * (i*1.5));
			DropShadow(c_black,col,menu_font,fa_right,fa_bottom,1,1,offset,xx,yy,txt)
		}
	}
}

if (current_array != menu and current_array != noone) or back_y != back_y_def
{
	var _back = menu_cursor == back? 0 : 1;
	draw_sprite(sBackArrow,_back,back_x,back_y)
}
#endregion

#region Draw Load
/********************************************************************************** Draw Load ********************************************************************/
if current_array == load or load_x != load_x_def
{		
	for (var ii = 0; ii < array_length(oController.savkey); ii++)
	{
		var _load_dis
		var xx = load_x
		var yy = load_y - (gui_margin * (ii*7));
		var _shift = 2;
		draw_set_alpha(1);
		
		// draw text
		if menu_cursor == ii 
		{
			var col = c_black;
			if (del_mode and oController.FUBAR[ii,0] == oController.no_save) or !del_mode var _load_dis = sTextBox2
			else var _load_dis = sTextBox4
		}
		else 
		{
			var col = c_navy;
			if (del_mode and oController.FUBAR[ii,0] == oController.no_save) or !del_mode var _load_dis = sTextBox1
			else var _load_dis = sTextBox3
			//var col = c_black;
		}
		if oController.FUBAR[ii,0] == oController.no_save NineSliceBox_ext(_load_dis,xx-x_offset,yy-y_offset,xx,yy,1,1,c_gray,1);
		else NineSliceBox(_load_dis,xx-x_offset,yy-y_offset,xx,yy);
		
		//game text
		var _load_txt = load[ii];
		DropShadow(c_black,c_navy,menu_font,fa_middle,fa_top,1,1,_shift,xx-x_offset+80,yy-y_offset-15,_load_txt)
		
		//delete distinction
		if del_mode 
		{
			draw_sprite(sTrash,0,xx-(x_offset*0.35),yy-(y_offset*0.45));
			draw_sprite(sTrash,0,xx-(x_offset*0.70),yy-(y_offset*0.45));
		}
		
		//gui line
		draw_set_alpha(0.6);
		draw_set_color(col);
		draw_line(xx-x_offset+20,yy-y_offset+40,xx-30,yy-y_offset+40)
		
		if oController.FUBAR[ii,0] == oController.no_save DropShadow(c_black,c_white,fBland,fa_middle,fa_middle,1,1,2,xx-x_offset+200,yy-y_offset+120,"NEW GAME")
		else
		{
			if del_mode DropShadow(c_black,c_red,fBland,fa_middle,fa_middle,1,1,1,xx-x_offset+200,yy-y_offset+120,"DELETE SAVE")
			if oController.FUBAR[ii,0] != undefined
			{
				draw_sprite_ext(sGUI_health,sprite_get_number(sGUI_health)-1,xx-column,yy-row1,1,1,0,c_gray,0.8)
				draw_sprite(sGUI_health,oController.FUBAR[ii,0]-1,xx-column,yy-row1)
			}
			
			// draw jumps
			if oController.FUBAR[ii,2] != 0
			{
				for (var j = 0; j < oController.FUBAR[ii,2]; j++)
				{
					var _offset = 15;
					draw_set_alpha(1);
					draw_sprite(sUpgrade,0,xx-70-(j*_offset),yy-row1);
				}
				DropShadow(c_black,c_white,fBland,fa_middle,fa_middle,1,1,_shift,xx-30,yy-row1,"x" + string(oController.FUBAR[ii,2]));
			}
			
			//Draw Upgrades
			for (var k = 3; k < array_length(oController.upgrade);k++)
			{
				if oController.FUBAR[ii,k] == 1 draw_sprite_ext(sUpgrade,k,xx-column+(upgrade_width+upgrade_margin)*(k-3),yy-row2,upgrade_scale,upgrade_scale,0,c_white,1);
			} 
		}			
	}
}
#endregion

#region Draw Options
/**************************************************************************************** Draw Options ******************************************************************************/
if current_array == options or option_y != option_y_def
{
	for (var a = 0; a < array_length(options); a++)
	{
		if a < array_v //normal inputs
		{
			var offset = 2;
			var txt = options[a];
			var col
			if (menu_cursor == a)
			{
				if options[a] == menu_box_del col = no_data? c_gray : c_white;
				else col = c_white
				txt = string_insert(">> ",txt,0);
				if options[a] == menu_box_bord or options[a] == menu_box_fuls NineSliceBox(sTextBox2,xx-40,yy-80,xx-10,yy-50)
			}
			else 
			{
				if options[a] == menu_box_bord or options[a] == menu_box_fuls NineSliceBox(sTextBox1,xx-40,yy-80,xx-10,yy-50)
				if options[a] == menu_box_del col = no_data? c_black : c_gray;
				else col = c_gray;
			}
			//if i > 2 var yy = option_y - (menu_itemheight * (i-1)) - (menu_itemheight * (i*1.5));
			var yy = option_y - (menu_itemheight * (a*1.5));
			var xx = option_x;
			if a < array_v DropShadow(c_black,col,menu_font,fa_right,fa_bottom,1,1,offset,xx,yy,txt)
		
			// check boxes
			if oController.borderless and a == 2 draw_sprite(sCheck2,0,xx-15,yy-15)
			if window_get_fullscreen() and a == 3 draw_sprite(sCheck2,0,xx-15,yy-15)
		}
		else //volume sliders
		{
			var sy = slider_y[a-array_v];
			var sx = option_x;
			var _stxt = options[a];
			DropShadow(c_white,c_gray,menu_font,fa_right,fa_bottom,1,1,offset,sx,sy,_stxt);
			if menu_cursor == a 
			{
				//NineSliceBox(sTextBox2,sx-v_width,sy-10,sx,sy-10+v_height);
				draw_line_width_color(sx - 12 - v_dist, sy + 8,sx - 8, sy + 8,3,c_white,c_white)
				if key_input or v_hover == a var col1 = c_white;
				else col1 = c_black
			}
			else 
			{
				
				//NineSliceBox(sTextBox1,sx-v_width,sy-10,sx,sy-10+v_height);
				col1 = c_black;
			}
			draw_line(sx - 10 - v_dist, sy + 8,sx - 10, sy + 8);
			if sliding and menu_cursor == a and device_mouse_x_to_gui(0) < option_x -10 and device_mouse_x_to_gui(0) > option_x - 10 - v_dist
			{
				draw_sprite_ext(sAstback,0,device_mouse_x_to_gui(0),sy+8,0.3,0.3,0,col1,1);
				draw_sprite_ext(sAsteroid,0,device_mouse_x_to_gui(0),sy+8,0.25,0.25,0,c_white,1);	
			}
			else
			{
				draw_sprite_ext(sAstback,0,slider_x[a-array_v],sy+8,0.3,0.3,0,col1,1);
				draw_sprite_ext(sAsteroid,0,slider_x[a-array_v],sy+8,0.25,0.25,0,c_white,1);				
			}
		}
	}
}
#endregion

#region Draw Key Re-Mapping
/*********************************************************************************** Draw Key Re-Mapping **************************************************************************************/
if current_array == oController.maps or map_x != map_x_def
{
	for (var r = 0; r < array_length(oController.maps)*2;r++)
	{
		if menu_cursor == r var _dis = sTextBox2 
		else if r == new_map _dis = sTextBox4
		else if (r == 0 or r == array_length(oController.maps)) and oController.key[0] != noone and oController.key_alt[0] != noone //not working
		{
			 _dis = sTextBox3;
		}
		else _dis = sTextBox1
		
		if r < array_length(oController.maps)
		{
			var kx = map_x;
			var ky = map_y - (map_box_y * map_box_margin * r);
			
			NineSliceBox(_dis,kx-map_box_x,ky-map_box_y,kx,ky);
			
			DropShadow(c_white,c_gray,fMenu,fa_left,fa_bottom,1,1,1,kx-map_box_x,ky-(map_box_y)+10,"ALT")
			
			if oController.key_alt[r] == noone DropShadow(c_black,c_white,fMenu,fa_middle,fa_top,1,1,1,kx-(map_box_x*0.5),ky-(map_box_y*1.4)," ____ ")
			else DropShadow(c_black,c_white,fMenu,fa_middle,fa_top,1,1,1,kx-(map_box_x*0.5),ky-(map_box_y*1.4),KeyInputDisplay(oController.key_alt[r]));
		}
		else 
		{
			var kx = map_column;
			var ky = map_y - (map_box_y * map_box_margin * (r - array_length(oController.maps)));
			
			NineSliceBox(_dis,kx-map_box_x,ky-map_box_y,kx,ky);	
			
			DropShadow(c_white,c_gray,fMenu,fa_right,fa_bottom,1,1,1,kx,ky-(map_box_y)+(((map_box_y+map_box_margin) - font_get_size(fMenu))/2),oController.maps[r - array_length(oController.maps)])
			
			DropShadow(c_black,c_white,fMenu,fa_middle,fa_top,1,1,1,kx-(map_box_x*0.5),ky-(map_box_y*1.4),KeyInputDisplay(oController.key[r - array_length(oController.maps)]));
		}
	}
	
	if menu_cursor == restore_def NineSliceBox(sTextBox2,map_x + gui_margin,(gui_height*(1/3)),map_x+map_box_y+gui_margin,(gui_height*(2/3)));
	else NineSliceBox(sTextBox1,map_x + gui_margin,(gui_height*(1/3)),map_x+map_box_y+gui_margin,(gui_height*(2/3)));
	
	for (var m = 0; m < string_length(restore_def_dis); m++)
	{
		DropShadow(c_black,c_white,fMenu,fa_middle,fa_middle,1,1,1,map_x + gui_margin + (map_box_y*0.5),(gui_height*(1/3))+15 + (font_get_size(fBland)*m*1.6),string_char_at(restore_def_dis,m+1))
	}
}
#endregion

draw_set_alpha(1);
draw_set_color(c_black)
draw_rectangle(display_get_gui_width(),0,display_get_gui_width()+500,display_get_gui_height(),false);
draw_rectangle(0,0,-500,display_get_gui_height(),false);