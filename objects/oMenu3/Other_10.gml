/// @desc go back
if current_array != menu
{
	if current_array == maps current_array = options;
	else current_array = menu;
	menu_committed = menu_com_null;
	menu_items = array_length(current_array);
	menu_cursor = menu_items - 1;
}
