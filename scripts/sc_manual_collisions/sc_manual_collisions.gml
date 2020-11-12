/// @description mouse_over()
/// Returns true if cursor is within object's bounding box
function mouse_over()
{
	return (mouse_x >= bbox_left &&
	        mouse_x <= bbox_right &&
	        mouse_y >= bbox_top &&
	        mouse_y <= bbox_bottom);
}

/// @description within()
/// @param _x
/// @param _y
/// @param _x1
/// @param _y1
/// @param _x2
/// @param _y2
/// Returns true If x/y is within x1/x2/y1/y2
function within(_x, _y, _x1, _y1, _x2, _y2)
{
	if (_x >= _x1 && _x <= _x2 && _y >= _y1 && _y <= _y2) {
		return true;
	}
	
	return false;
}