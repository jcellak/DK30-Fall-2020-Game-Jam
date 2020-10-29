/// @description Cleanup

///Destroys our socket and buffer to free memory
network_destroy(global.socket);
buffer_delete(global.buffer);
