shader_set(sequence_fill_highlight) {
	with (sequence_track_object) {
		var draw_height = floor(clamp(value * height, 2, height));
		var draw_position = maximum - (draw_height);
		var color = waveform == noone ? #dbd2b8 : waveform.fill;
		draw_sprite_stretched_ext(sequence_track_fill_sprite, 0, x + 2, draw_position, 15, draw_height + 1, color, 1);
	}
	shader_reset();
}