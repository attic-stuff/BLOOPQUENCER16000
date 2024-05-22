if (keyboard_check_pressed(ord("T")) == true) {
	show_tutorial = 1 - show_tutorial;
	if (show_tutorial == 1)  {
		texturegroup_load("tutorialgroup", true);
		instance_deactivate_all(true);
		instance_activate_object(mouse_input);
	} else {
		texturegroup_unload("tutorialgroup");
		instance_activate_all();
	}
}

if (show_tutorial == 1) {
	if (left_tap == true) {
		current_slide =  current_slide < slide_count ? current_slide + 1 : 0;
	}
	if (right_tap == true) {
		current_slide =  current_slide > 0 ? current_slide - 1 : slide_count;
	}
}