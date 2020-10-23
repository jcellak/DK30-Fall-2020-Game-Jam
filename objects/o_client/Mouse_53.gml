/// @description Dummy event
///Create a click, send it to the server.
instance_create_layer(mouse_x, mouse_y, "Instances", o_click_dummy);

//Write the click to the buffer.
buffer_seek(global.buffer, buffer_seek_start, 0); //Checks the beginning of the buffer
buffer_write(global.buffer, buffer_u8, EventType.left_click); //Writes our ID to an unsigned positive 8-Bit integer (0-256) to our buffer. [Our buffer looks like: 1]
buffer_write(global.buffer, buffer_u16, mouse_x); //Writes our mouse_x to an unsigned positive 16-Bit integer (0-65,535) to our buffer. [Our buffer looks like: 1, mouse_x]
buffer_write(global.buffer, buffer_u16, mouse_y); //Writes our mouse_y to an unsigned positive 16-Bit integer (0-65,535) to our buffer. [Our buffer looks like: 1, mouse_x, mouse_y]

//Send the buffer to the server
//We need to tell it which socket to connect to, which buffer to use, and what buffer size we are using.
network_send_packet(global.socket, global.buffer, buffer_tell(global.buffer)) //Buffer_tell is going to return the size of the buffer.
