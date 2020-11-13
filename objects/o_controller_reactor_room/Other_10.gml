/// @description End game events

game_ended = true;

alarm_set(2, 180);
audio_play_sound(a_reactor_failure, 9, false);
