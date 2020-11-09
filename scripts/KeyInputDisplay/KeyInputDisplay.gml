/// @desc KeyInputDisplay(key)
/// @arg key
function KeyInputDisplay(key) {

	key_in[vk_left] = "Left";
	key_in[vk_right] = "Right";
	key_in[vk_up] = "Up";
	key_in[vk_down] = "Down";
	key_in[vk_enter] = "Enter";
	key_in[vk_escape] = "Escape";
	key_in[vk_space] = "Space";
	key_in[vk_shift] = "Shift";
	key_in[vk_control] = "Control";
	key_in[vk_alt] = "Alt";
	key_in[vk_backspace] = "Backspace";
	key_in[vk_tab] = "Tab";
	key_in[vk_home] = "Home";
	key_in[vk_end] = "End";
	key_in[vk_delete] = "Delete";
	key_in[vk_insert] = "Insert";
	key_in[vk_pageup] = "Page Up";
	key_in[vk_pagedown] = "Page Down";
	key_in[vk_pause] = "Pause";
	key_in[vk_printscreen] = "Print Screen";
	key_in[vk_f1] = "F1";
	key_in[vk_f2] = "F2";
	key_in[vk_f3] = "F3";
	key_in[vk_f4] = "F4";
	key_in[vk_f5] = "F5";
	key_in[vk_f6] = "F6";
	key_in[vk_f7] = "F7";
	key_in[vk_f8] = "F8";
	key_in[vk_f9] = "F9";
	key_in[vk_f10] = "F10";
	key_in[vk_f11] = "F11";
	key_in[vk_f12] = "F12";
	key_in[vk_numpad0] = "0 numpad";
	key_in[vk_numpad1] = "1 numpad";
	key_in[vk_numpad2] = "2 numpad";
	key_in[vk_numpad3] = "3 numpad";
	key_in[vk_numpad4] = "4 numpad";
	key_in[vk_numpad5] = "5 numpad";
	key_in[vk_numpad6] = "6 numpad";
	key_in[vk_numpad7] = "7 numpad";
	key_in[vk_numpad8] = "8 numpad";
	key_in[vk_numpad9] = "9 numpad";
	key_in[vk_multiply] = "*";
	key_in[vk_divide] = "/";
	key_in[vk_subtract] = "-";
	key_in[vk_decimal] = ".";
	key_in[ord("Q")] = "Q";
	key_in[ord("W")] = "W";
	key_in[ord("E")] = "E";
	key_in[ord("R")] = "R";
	key_in[ord("T")] = "T";
	key_in[ord("Y")] = "Y";
	key_in[ord("U")] = "U";
	key_in[ord("I")] = "I";
	key_in[ord("O")] = "O";
	key_in[ord("P")] = "P";
	key_in[ord("[")] = "[";
	key_in[ord("]")] = "]";
	key_in[ord("A")] = "A";
	key_in[ord("S")] = "S";
	key_in[ord("D")] = "D";
	key_in[ord("F")] = "F";
	key_in[ord("G")] = "G";
	key_in[ord("H")] = "H";
	key_in[ord("J")] = "J";
	key_in[ord("K")] = "K";
	key_in[ord("L")] = "L";
	key_in[ord(";")] = ";";
	//key_in[ord("'")] = "'";
	key_in[ord("Z")] = "Z";
	key_in[ord("X")] = "X";
	key_in[ord("C")] = "C";
	key_in[ord("V")] = "V";
	key_in[ord("B")] = "B";
	key_in[ord("N")] = "N";
	key_in[ord("M")] = "M";
	key_in[ord(",")] = ",";
	key_in[ord("\"")] = "\"";
	key_in[ord("/")] = "/"
	key_in[ord(".")] = "."
	key_in[ord("1")] = "1"
	key_in[ord("2")] = "2"
	key_in[ord("3")] = "3"
	key_in[ord("4")] = "4"
	key_in[ord("5")] = "5"
	key_in[ord("6")] = "6"
	key_in[ord("7")] = "7"
	key_in[ord("8")] = "8"
	key_in[ord("9")] = "9"
	key_in[ord("0")] = "0"
	key_in[ord("-")] = "-"
	key_in[ord("=")] = "="


	key_in[mb_left] = "Left Click";
	key_in[mb_right] = "Right Click";
	key_in[mb_middle] = "Middle Click";
	//key_in[mouse_wheel_up()] = "Scroll Up";
	//key_in[mouse_wheel_down()] = "Scroll Down";
	if key != noone and key != undefined and key <= 124  return key_in[key]
	else return " ____ ";



}
