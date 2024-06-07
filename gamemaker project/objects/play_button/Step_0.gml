if (frequency_slider_top.sliding == true or frequency_slider_bottom.sliding == true) {
	exit;	
}
image_index = 0;
if (position_meeting(mouse_x, mouse_y, id) == true) {
	image_index = 1;
	if (left_mash == true) {
		image_index = 2;	
	}
	if (left_letgo == true) {
		playback();
	}
}

if (file_operation = 0b00001) {
	playback();	
}