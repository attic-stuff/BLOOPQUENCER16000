image_index = 0;
if (position_meeting(mouse_x, mouse_y, id) == true)  {
	image_index = 1;
	if (move_window.window_moving == false) {
		if (left_mash == true) {
			image_index = 2;	
		}
		if (left_letgo == true) {
			window_scale = window_scale + job;
			if (window_scale > maximum) {
				window_scale = minimum;	
			}
			if (window_scale < minimum) {
				window_scale = maximum;
			}
			var current_window_x = window_get_x();
			var current_window_y = window_get_y();
			var new_width = room_width * window_scale;
			var new_height = room_height * window_scale;
			window_set_size(new_width, new_height);
			surface_resize(application_surface, room_width, room_height);
			display_set_gui_size(room_width, room_height);
			current_window_x = clamp(current_window_x, 0, display_get_width() - new_width);
			current_window_y = clamp(current_window_y, 0, display_get_height() - new_height);
			window_set_position(current_window_x, current_window_y);	
		}
	}
} 