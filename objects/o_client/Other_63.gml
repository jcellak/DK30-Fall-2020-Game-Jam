/// @description IP is returned

var _id = ds_map_find_value(async_load, "id");
if (_id == ip_input) {
	if (ds_map_find_value(async_load, "status")) {
		var _ip = ds_map_find_value(async_load, "result");
        if (_ip != "") {
			network_set_config(network_config_connect_timeout, 5000);
			network_set_config(network_config_use_non_blocking_socket, 1);
			
            global.connection = network_connect(global.socket,_ip,port); //Creates a connection to our socket, server, and port.
        }
    } else {
		with (o_menu) Menu_to(multiplayer);
	}
}
