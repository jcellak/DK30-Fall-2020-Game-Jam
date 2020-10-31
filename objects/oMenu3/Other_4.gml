/// @desc 


//LoadSave(save,oController.upgrade,FUBAR,no_save)

//FUBAR = [array_create(array_length(save)),array_create(array_length(oController.upgrade))]

//for (var i = 0; i < array_length(save); i++)
//{
//	var _save_file = save[i];
	//FUBAR = SaveFile2(_save_file,i)
	//if file_exists(_save_file) 
	//{
	//	//var _wrapper = LoadJSONFromFile(_save_file);
	//	var _buffer = buffer_load(_save_file);
	//	var _string = buffer_read(_buffer, buffer_string);
	//	buffer_delete(_buffer)
	//	var _wrapper = json_decode(_string)
	//	var _list = _wrapper[? "ROOT"];
	//	(_wrapper)
	//	for (var j = 0; j < array_length(oController.upgrade); j++)
	//	{
	//		FUBAR[i,j] = _list[? oController.upgrade[j]]
	//	}
	//	ds_map_destroy(_wrapper);
	//}
	//else 
	//{
	//	for (var k = 0; k < array_length(oController.upgrade); k++)
	//	{
	//		FUBAR[i,k] = no_save;
	//	}
	//}
//}
//var _save0 = save[0];
//if file_exists(_save0)
//{
//	var _wrapper = LoadJSONFromFile(_save0);
//	var _list = _wrapper[? "ROOT"]
//	FUBAR[0,0] = _list[? oController.upgrade[0]]
//	FUBAR[0,1] = _list[? oController.upgrade[1]]
//	FUBAR[0,2] = _list[? oController.upgrade[2]]
//	FUBAR[0,3] = _list[? oController.upgrade[3]]
//	FUBAR[0,4] = _list[? oController.upgrade[4]]
//	FUBAR[0,5] = _list[? oController.upgrade[5]]
//	FUBAR[0,6] = _list[? oController.upgrade[6]]
//	FUBAR[0,7] = _list[? oController.upgrade[7]]
//	FUBAR[0,8] = _list[? oController.upgrade[8]]
//	FUBAR[0,9] = _list[? oController.upgrade[9]]
//	FUBAR[0,10] = _list[? oController.upgrade[10]]
//	ds_map_destroy(_wrapper)
//}
//else
//{
//	for (var i = 0; i < array_length(oController.upgrade); i++)
//	{
//		FUBAR[0,i] = no_save;
//	}
//}

//LoadSave1(save,0)
//LoadSave1(save,1)
//LoadSave1(save,2)
//LoadSave1(save,3)





show_debug_message("---------")	
