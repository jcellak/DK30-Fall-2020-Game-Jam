/// @desc 
NineSliceBox_Stretch(s_text_box,x1,y1,x2,y2,background);
DrawSetText(c_black,f_primary,fa_left,fa_top,1);

var _print = string_copy(mess,1,text_progress);
var _prup = string_insert("_",_print,text_progress+1)
draw_text_ext((x1+20),y1+8,_prup,10,(x1+x2-10));
draw_set_color(c_lime);
draw_text((x1+20),y1+7,_prup)

draw_set_font(f_primary_small);
draw_text(x2-next_length-90+next_bounce,y2-15,next);
