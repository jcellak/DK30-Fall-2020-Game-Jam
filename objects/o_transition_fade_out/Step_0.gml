/// @description Destroy self
current_frame++;

if (current_frame > max_frames) {
    instance_destroy(); // The transition has finished so destroy it
}

