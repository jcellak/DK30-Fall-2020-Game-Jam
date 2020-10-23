/// @description Handle incoming data

///Check for clients and data.
var type_event = async_load[? "type"]; //Grabbing the type from async_load using an accessor, then store that value in type_event
switch (type_event){
    case network_type_connect: //If our type_event is equal to network_type_connect. If someone tries to connect.
        //Add the client to the socket variable - When using multiple clients, use a data structure. This is a single client.
        if (global.socket == noone){ //If No one is connected yet.
            global.socket = async_load[? "socket"]; //Returns the socket from async_load using an accessor. Then store it in the socket.
			global.all_players_connected = true;
			audio_play_sound(a_item_pickup, 6, false);
        }
        break; //Break out of the switch event.
       
    case network_type_disconnect: //If someone tries to disconnect.
        //Remove the client from the socket variable
		audio_play_sound(a_ouch, 6, false);
        global.socket = noone
		global.all_players_connected = false;
        break;
       
    case network_type_data: //If we are receiving data
        //Handle the data.
        var buffer = async_load[? "buffer"]; //Create a temporary buffer.
        buffer_seek(buffer,buffer_seek_start,0) //Looks at the beginning of the buffer.
        audio_play_sound(a_jump, 6, false);
		network_received_packet(buffer); //Executes our script scr_recieved_packet, and pass the buffer to our script.
        break;
}