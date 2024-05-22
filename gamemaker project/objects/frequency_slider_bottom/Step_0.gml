image_index = 0;
if (position_meeting(mouse_x, mouse_y, id) == true) {
	image_index = 1;
	if (left_tap == true and sliding == false) {
		offset = mouse_y - y;
		sliding = true;
		update = true;
	}
}

if (sliding == true) {
	image_index = 1;
	y = clamp(mouse_y - offset, frequency_slider_top.bbox_bottom + 8 + sprite_yoffset, maximum);
	value = lerp(1, 0, (bbox_bottom - minimum) / (maximum - minimum));
	output = floor(lerp(low, high, value));
}
if (left_mash == false or position_meeting(mouse_x, mouse_y, frequency_track_object) == false) {
	sliding = false;
	if (update == true) {
		with (sequence_track_object) {
			if (waveform != noone) {
				low = frequency_slider_bottom.output;
				high = frequency_slider_top.output;
				output = floor(lerp(frequency_slider_bottom.output, frequency_slider_top.output, value));	
			}
			update = true;
		}
	}
	update =  false;
}