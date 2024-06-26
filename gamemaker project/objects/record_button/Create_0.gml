image_speed = 0;
wave = undefined;
sequence_list = array_create_ext(16, function(index) {
	return instance_find(sequence_track_object, index);
});
array_sort(sequence_list, function(a, b) {
	return a.track_number - b.track_number;
});
export = function() {
	if (audio_exists(play_button.audio) == false) {
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
			wave = bloopquencer_write_wave(samples, sample_rate_track_object.output);
			var path = environment_get_variable("userprofile");
			var desktop = path + "/Desktop/";
			var file = get_save_filename_ext("*.wav", "bloopquence.wav", desktop, "save your bloopquence as a wav file!");
			if (file != "") {
				buffer_save(wave, file);
			}
			buffer_delete(wave);
		}
	}	
}