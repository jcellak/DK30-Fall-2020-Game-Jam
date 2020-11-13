/// @desc 
x1 = (display_get_gui_width() * .5);
y1 = display_get_gui_height() - 70;
x2 = x1;
y2 = display_get_gui_height()-10;

x1_target = 10;
x2_target = display_get_gui_width()-10;

lerp_progress = 0;
text_progress = 0;
time = 0;

next_bounce = 0;
next_bounce_var = 8;
next_plus = true;
bounce_sp = 0.3;

next = "press enter to proceed>>";
next_length = string_length(next);