image_index = 0;
if (position_meeting(mouse_x, mouse_y, id) == true)  {
	image_index = 1;
	if (move_window.window_moving == false) {
		if (left_mash == true) {
			image_index = 2;	
		}
		if (left_letgo == true) {
			game_end();
		}
	}
}