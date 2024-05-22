if (toggle_information == 1) {
	if (surface_exists(information_surface) == false) {
		information_surface = surface_create(room_width, room_height);
	}
	surface_set_target(information_surface) {
		draw_clear_alpha(#000000, 0);
		var mouseover = instance_position(mouse_x, mouse_y, [ gain_track_object, sustain_track_object, sequence_track_object, sample_rate_track_object, frequency_slider_bottom, frequency_slider_top ]);
		if (mouseover != noone) {
			var text = $"{mouseover.output}";
			var text_half_width = string_width(text) * 0.5;
			var text_x = floor(clamp(mouse_x - text_half_width, 0,room_width - text_half_width));
			var text_y = floor(clamp(mouse_y - 12, 0, room_height));
			var text_color = #dbd2b8;
			draw_text_color(text_x, text_y, text, text_color, text_color, text_color, text_color, 1);
		}
		surface_reset_target();
	}
	shader_set(information_outline) {
		draw_surface(information_surface, 0, 0);
		shader_reset();
	}
}