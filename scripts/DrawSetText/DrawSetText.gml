/// @desc DrawSetText(color,font,halign,valign)
/// @arg color
/// @arg font
/// @arg halign
/// @arg valign
/// @arg alpha
function DrawSetText(argument0, argument1, argument2, argument3, argument4) {

	//Allows one line setup of major text drawing vars
	//Requiring all four prvents silly coders from forgetting one
	//And therefore creating a dumb dependency on other event calls
 
	draw_set_color(argument0);
	draw_set_font(argument1);
	draw_set_halign(argument2);
	draw_set_valign(argument3);
	draw_set_alpha(argument4);


}
