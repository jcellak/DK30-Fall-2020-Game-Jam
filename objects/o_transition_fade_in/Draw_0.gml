/// @description Draw the transitions
if (current_frame > 0) {
    // Fade from 1 to 0 alpha
    draw_set_colour(c_black);
    draw_set_alpha(1 - EaseInQuad(current_frame, 0, 1, max_frames));
    draw_rectangle(0, 0, room_width, room_height, false);
    draw_set_alpha(1);
}