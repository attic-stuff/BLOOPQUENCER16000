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
		if (audio_exists(audio) == false) {
			var samples = [];
			var scrub = true;
			for (var iteration = 15; iteration > -1; iteration -= 1) {
				if (scrub == true) {
					if (sequence_list[iteration].waveform == noone) {
						continue;
					} else {
						scrub = false;	
					}
				}
				if (scrub == false) {
					array_insert(samples, 0, sequence_list[iteration].sample);
				}
			}
			if (array_length(samples) > 0) {
				buffer = bloopquencer_write_wave(samples, sample_rate_track_object.output);
				audio =	audio_create_buffer_sound(buffer, buffer_s16, sample_rate_track_object.output, 44, buffer_get_size(buffer) - 44, audio_mono);
				audio_play_sound(audio, 1, false);
			}
		}
	}
}