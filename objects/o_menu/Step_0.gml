/// @desc 
/*********************************************************************** Visual effects ********************************************************/
x_one += rob_spd * dir_one;
x_two += rob_spd * dir_two;
if (x_one <= (random_range(30,75)) and left_one) or (x_one >= (random_range(340,385)) and !left_one){
	dir_one = dir_one*-1;
	left_one = !left_one;
}
if (x_two <= (random_range(30,75)) and left_two) or (x_two >= (random_range(340,385)) and !left_two){
	dir_two = dir_two*-1;
	left_two = !left_two;
}

flikr_time++
if flikr_time == room_speed*0.5 {
	flikr_time = 0;
	flikr = !flikr;
}

Menu_Function(false);
	

