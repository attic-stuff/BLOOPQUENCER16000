if (frequency_slider_top.sliding == true or frequency_slider_bottom.sliding == true) {
	exit;	
}
if (position_meeting(mouse_x, mouse_y, id) == true) {
	if (left_mash == true) {
		if (gain_fader.value == 0) {
			gain_fader.value = 0.5;	
		}
		waveform = selected_waveform;
		low = frequency_slider_bottom.output;
		high = frequency_slider_top.output;
		var level = clamp(mouse_y, minimum, maximum);
		value = lerp(1, 0, (level - minimum) / (maximum - minimum));
		update = true;
	}
	if (right_mash == true) {
		waveform = noone;
		low = 0;
		high = 4069;
		value = 0;
		update = true;
	}
}
output = floor(lerp(low, high, value));
if ((left_mash == false and right_mash == false) and update == true) {
	if (buffer_exists(sample) == true) {
		buffer_delete(sample);
		sample = undefined;
	}
	if (waveform != noone) {
		if (waveform == noise_button) {
			sample = bloopquencer_record_noise(sample_rate_track_object.output, output, gain_fader.output, sustain_fader.output);	
		} else {	
			sample = bloopquencer_record_bloop(sample_rate_track_object.output, output, gain_fader.output, sustain_fader.output, waveform.output);	
		}
	} else {
		sample = bloopquencer_record_silence(sample_rate_track_object.output, sustain_fader.output);
	}
	update = false;
}