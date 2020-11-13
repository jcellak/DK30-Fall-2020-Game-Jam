// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function Default_key_map(){
	global.key_two[0] = vk_left; //player one left
	global.key_two[1] = vk_right; //player one right
	global.key_two[2] = vk_down; //player one down
	global.key_two[3] = vk_up; //player one up
	global.key_two[4] = vk_shift; //player one use

	global.key_one[0] = ord("A"); //player two right
	global.key_one[1] = ord("D"); //player two left
	global.key_one[2] = ord("S"); //player two down
	global.key_one[3] = ord("W"); //player two up
	global.key_one[4] = vk_space; //player two use
}