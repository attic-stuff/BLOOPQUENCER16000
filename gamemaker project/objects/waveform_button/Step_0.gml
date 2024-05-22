if (frequency_slider_top.sliding == true or frequency_slider_bottom.sliding == true) {
	exit;	
}
image_index = 0;
if (position_meeting(mouse_x, mouse_y, id) == true and selected == false) {
	image_index = 1;
	if (left_tap == true) {
		image_index = 2;	
	}
	if (left_letgo == true) {
		with (object_index) {
			selected = false;	
		}
		selected_waveform = id;
		selected = true;
	}
}
if (selected == true) {
	image_index = 2;	
}