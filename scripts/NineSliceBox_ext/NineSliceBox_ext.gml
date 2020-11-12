/// @desc NineSliceBox_ext(sprite, x1, y1, x2, y2, xscale, yscale, col, alpha);
/// @arg sprite
/// @arg x1
/// @arg y1
/// @arg x2
/// @arg y2
/// @arg xscale
/// @arg yscale
/// @arg col
/// @arg alpha
function NineSliceBox_ext(argument0, argument1, argument2, argument3, argument4, argument5, argument6, argument7, argument8) {

	var _size = sprite_get_width(argument0)/3;
	var _x1 = argument1;
	var _y1 = argument2;
	var _x2 = argument3;
	var _y2 = argument4;
	var _xscale = argument5
	var _yscale = argument6
	var _col = argument7
	var _alpha = argument8
	var _w = _x2 - _x1;
	var _h = _y2 - _y1;
	var _columns = _w div _size;
	var _rows = _h div _size;

	//Corners
	//top left
	draw_sprite_part_ext(argument0,0,0,0,_size,_size,_x1,_y1,_xscale,_yscale,_col,_alpha);
	//top right
	draw_sprite_part_ext(argument0,0,_size*2,0,_size,_size,_x1+(_columns*_size),_y1,_xscale,_yscale,_col,_alpha);
	//bottom left
	draw_sprite_part_ext(argument0,0,0,_size*2,_size,_size,_x1,_y1+(_rows*_size),_xscale,_yscale,_col,_alpha);
	//bottom right
	draw_sprite_part_ext(argument0,0,_size*2,_size*2,_size,_size,_x1+(_columns*_size),_y1+(_rows*_size),_xscale,_yscale,_col,_alpha);

	//Edges
	for (var i = 1; i < (_rows); i++)
	{
		//left edge
		draw_sprite_part_ext(argument0, 0, 0, _size, _size, _size, _x1, _y1+(i*_size),_xscale,_yscale,_col,_alpha);
		//right edge
		draw_sprite_part_ext(argument0, 0, _size*2, _size, _size, _size, _x1+(_columns*_size), _y1+(i*_size),_xscale,_yscale,_col,_alpha);
	}
	for (var i = 1; i < (_columns); i++)
	{
		//top edge
		draw_sprite_part_ext(argument0, 0, _size, 0, _size, _size, _x1+(i*_size), _y1,_xscale,_yscale,_col,_alpha);
		//bottom edge
		draw_sprite_part_ext(argument0, 0, _size, _size*2, _size, _size, _x1+(i*_size), _y1+(_rows*_size),_xscale,_yscale,_col,_alpha);
	}

	//Middle
	for (var i = 1; i < _columns; i++)
	{
		for (var j = 1; j < _rows; j++)
		{
			draw_sprite_part_ext(argument0, 0, _size, _size, _size, _size, _x1 + (i*_size), _y1 + (j*_size),_xscale,_yscale,_col,_alpha);
		}
	}





}
