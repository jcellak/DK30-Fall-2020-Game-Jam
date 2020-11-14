/// @desc 
/*********************************************************************** Visual effects ********************************************************/
x_one += rob_spd;
if (x_one > room_width + 16) x_one = -16;

if (!pause_timer) credits_timer++;

if (!audio_is_playing(a_ending) and !audio_is_playing(a_victory_jingle)) {
	audio_play_sound(a_ending, 10, true);
}
