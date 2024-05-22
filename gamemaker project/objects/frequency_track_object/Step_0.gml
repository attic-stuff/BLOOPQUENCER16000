if (position_meeting(mouse_x, mouse_y, id) == true and right_tap == true) {
	with (frequency_slider_bottom) {
		output = 64;
		value = remap(output, low, high, 0, 1);
		y = maximum - (value * (maximum - minimum));
		update = true;
	}
	with(frequency_slider_top) {
		output = 1024;
		value = remap(output, low, high, 0, 1);
		y = maximum - (value * (maximum - minimum));
		update = true;
	}
}