/// @description Initialize our Server
var type = network_socket_tcp; //Creates a TCP Socket. The server can use network_socket_tcp, network_socket_udp, or network_socket_bluetooth.
//network_socket_tcp is more reliable and stable. TCP checks for errors in the packets. TCP is a connection based protocol.
//network_socket_udp is faster than tcp, but has a probability of dropping packets. UDP is a broadcast based protocol.
//network_socket_bluetooth is currently not supported natively but I it's stable and fast for a broadcast based protocol.
var port = 25653; //Will run the server on port 25653.
max_clients = 1; //Sets our max clients to 1.
server = network_create_server(type,port,max_clients); //Creates our server on the network and returns an id of server.
global.socket = noone; //Creates a null socket, since we don't have a socket yet.

var size = 1024; //Has a size of 1024 bytes (1MB)
var type = buffer_fixed; //Defines a Fixed Buffer, It does not change
var alignment = 1; //Sets the alignment to 1, commonly used for strings.  See buffer_create
global.buffer = buffer_create(size,type,alignment); //Creates our buffer.
