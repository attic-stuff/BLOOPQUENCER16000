image_index = 0;
if (position_meeting(mouse_x, mouse_y, id) == true)  {
	image_index = 1;
	if (left_tap == true) {
		window_moving = true;
		correction_x = mouse_x - x;
		correction_y = mouse_y - y;
	}
}
if (window_moving == true) {
	image_index = 2;
	var scale = window_get_width() / room_width;
	var window_x = display_mouse_get_x() - ((x + correction_x) * scale);
	var window_y = display_mouse_get_y() - ((y + correction_y) * scale);
	window_set_position(window_x, window_y);
	if (left_mash == false) {
		window_moving = false;
	}
}