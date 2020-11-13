/// @desc 
NineSliceBox_Stretch(s_text_box,x1,y1,x2,y2,background);
DrawSetText(c_black,f_primary,fa_center,fa_top,1);

var _print = string_copy(mess,1,text_progress);
draw_text((x1+x2)*.5,y1+8,_print);
draw_set_color(c_lime);
draw_text((x1+x2)*.5,y1+7,_print)

draw_set_font(f_primary_small);
draw_text(x2-next_length-50+next_bounce,y2-15,next);
