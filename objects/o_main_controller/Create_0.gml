/// @description Initialize some variables

hp = 3;
max_hp = 3;
sapphires = 0;

event_user(0);
vol[0] = 0; //main
vol[1] = 0.5; //sfx
vol[2] = 0.5; //music

multiplayer = false;

display_set_gui_size(camera_get_view_width(view_camera[0]), camera_get_view_height(view_camera[0]));

// Start the music
audio_play_sound(a_title, 10, false);

// Get rid of Cursor
//window_set_cursor(cr_none);

// Randomize it up
randomize();