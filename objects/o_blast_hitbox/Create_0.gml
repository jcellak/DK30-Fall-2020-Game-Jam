/// @description Initialize

// Create a list of things that have been hit already, so we don't hit them twice.
struck_targets = ds_list_create();

// Set the Blast to end after 3 frames.
alarm_set(0, 3);
