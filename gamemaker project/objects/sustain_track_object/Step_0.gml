if (frequency_slider_top.sliding == true or frequency_slider_bottom.sliding == true) {
	exit;	
}
if (position_meeting(mouse_x, mouse_y, id) == true) {
	var precise = false;
	for (var number = 0; number < 10; number += 1) {
		if (left_mash and keyboard_check(ord($"{number}")) == true) {
			precise = true;
			value = number == 0 ? 1 : number / 10;
			update = true;
			break;
		}
	}
	if (left_mash == true and precise == false) {
		var level = clamp(mouse_y, minimum, maximum);
		value = lerp(1, 0, (level - minimum) / (maximum - minimum));
		update = true;
	}
	if (right_mash == true) {
		value = 0.0;	
		update = true;
	}
}
output = lerp(low, high, value);
if ((left_mash == false and right_mash == false) and update == true) {
	with (track_link) {
		update = true;
	}
	update = false;
}