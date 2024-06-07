image_speed = 0;
audio = undefined;
buffer = undefined;
sequence_list = array_create_ext(16, function(index) {
	return instance_find(sequence_track_object, index);
});
array_sort(sequence_list, function(a, b) {
	return a.track_number - b.track_number;
});

save = function() {
	var card = {
		sample_rate : sample_rate_track_object.value,
		frequency_low : frequency_slider_bottom.output,
		frequency_high : frequency_slider_top.output,
		sequence_tracks : array_create_ext(16, function(index) {
			var track = save_bloopquence.sequence_list[index];
			var data = {
				track_number : track.track_number,
				waveform : track.waveform != noone ? track.waveform.button_number : noone,
				value : track.value,
				gain : track.gain_fader.value,
				sustain : track.sustain_fader.value
			}
			return data
		})
	}
	var json = json_stringify(card, true);
	var byte_length = string_byte_length(json);
	var buffer = buffer_create(byte_length, buffer_fixed, 1);
	buffer_write(buffer, buffer_text, json);
	var path = environment_get_variable("userprofile");
	var desktop = path + "/Desktop/";
	var file = get_save_filename_ext("*.bloopquence", "*.bloopquence", desktop, "save your bloopquence to work on later!");
	if (file != "") {
		buffer_save(buffer, file);	
	}
	buffer_delete(buffer);	
}