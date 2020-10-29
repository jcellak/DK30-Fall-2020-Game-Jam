/// @description Draw instructions

///Draws our instructions on the bottom of the screen
draw_set_alpha(1);
draw_set_color(c_black);
draw_set_font(f_small);
draw_set_halign(fa_left);
var camHeight = camera_get_view_height(view_camera[0]);
draw_text(0, camHeight - 40, "S = Create Server, C = Create Client,");
draw_text(0, camHeight - 20, "L = Local Multiplayer, ESC = End Game");
