image_speed = 0;
audio = undefined;
buffer = undefined;
sequence_list = array_create_ext(16, function(index) {
	return instance_find(sequence_track_object, index);
});
array_sort(sequence_list, function(a, b) {
	return a.track_number - b.track_number;
});
button_list = array_create_ext(9, function(index) {
	return instance_find(waveform_button, index);
});
array_sort(button_list, function(a, b) {
	return a.button_number - b.button_number;
});
load = function() {
	try {
		var path = environment_get_variable("userprofile");
		var desktop = path + "/Desktop/";
		var file = get_open_filename_ext("*.bloopquence", "*.bloopquence", desktop, "open a bloopquence you were working on earlier and want to play with some more!");
		if (file !=  "") {
			var buffer = buffer_load(file);
			var json = buffer_read(buffer,  buffer_text);
			var card = json_parse(json);
				
			with (sample_rate_track_object ) {
				value = card.sample_rate;
				output = floor(lerp(low, high, value));
			}
			with (frequency_slider_bottom)  {
				output = card.frequency_low;
				value = remap(output, low, high, 0, 1);
				y = maximum - (value * (maximum - minimum));	
			}

			with (frequency_slider_top)  {
				output = card.frequency_high;
				value = remap(output, low, high, 0, 1);
				y = maximum - (value * (maximum - minimum));	
			}	
			for (var track = 0; track <  16; track += 1) {
				var this = card.sequence_tracks[track];
				var identity = sequence_list[this.track_number];
				with (identity) {
					with (gain_fader) {
						value = this.gain;
						output = lerp(low, high, value);
					}
					with (sustain_fader) {
						value = this.sustain;
						output = lerp(low, high, value);
					}
					low = frequency_slider_bottom.output;
					high = frequency_slider_top.output;
					value = this.value;
					output = floor(lerp(low, high, value));
					if (this.waveform == noone) {
						waveform = noone;	
					} else {
						waveform = other.button_list[this.waveform];	
					}						
					update = true;
				}
			}
			buffer_delete(buffer);
		}
	} catch (message) {
		exit;
	}	
}