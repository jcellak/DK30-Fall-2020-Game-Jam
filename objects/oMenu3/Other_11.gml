/// @desc slider x and y
for (var t = 0; t < array_length(oController.v_slider); t++)
{
	slider_x[t] = option_x - 10 - v_dist + (oController.v_slider[t]*v_dist);
	slider_y[t] = menu_top_alt - (menu_itemheight * (t*3.5)) - (gui_margin*(2.5));
	clamp(slider_x[t],option_x-10-v_dist,option_x-10);
}