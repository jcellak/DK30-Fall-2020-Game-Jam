/// @description Initialize our client

var type = network_socket_tcp; //Defines a TCP Socket For Our Client (Use UDP for LAN, but that needs a different configuration)
var ip = get_string("Which IP address do you want to connect to?",""); //Creates an IP Address to connect to. Replace with server IP Address
var port = 25653; //Connects to port 25653. Make sure client and server use the same port.
global.socket = network_create_socket(type); //Creates a Socket using the type we defined above. Use network_create_socket_ext for LAN.
global.connection = network_connect(global.socket,ip,port); //Creates a connection to our socket, server, and port.

//Send Information To The Server.
var size = 1024; //Has a size of 1024 bytes (1MB)
var type = buffer_fixed; //Defines a Fixed Buffer, It does not change
var alignment = 1; //Sets the alignment to 1, commonly used for strings.  See buffer_create
global.buffer = buffer_create(size,type,alignment); //Creates our buffer.
