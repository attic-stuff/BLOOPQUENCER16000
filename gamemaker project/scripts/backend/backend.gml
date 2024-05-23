#macro selected_waveform global.waveformthatyouhaveselected
selected_waveform = sine_button;

/**
 * remaps a value between 2 points to be a value between 2 other points.
 * for example if you have a number between 0 and 10 and you want to remap it to be between 69 and 420
 * you would do value_map(number, 0, 10, 69, 420).
 * @param {real} value the value to remap
 * @param {real} left1 the lowest value in the starting range
 * @param {real} right1 the highest value in the starting range
 * @param {real} left2 the lowest value of the new range
 * @param {real} right2 the highest value of the new range
 * @returns {real}
 */
function remap(value, left1, right1, left2, right2) {
	return left2 + (value - left1) * (right2 - left2) / (right1 - left1);
}

/**
 * records a cool sound from an animcurve
 * @param {Real} sample_rate the sample rate of the sound, must be in between 8000 and 48000
 * @param {Real} frequency this is the sounds tone
 * @param {Real} gain how loud the sound is, 0 to 1
 * @param {Real} length how long the sound should be, in seconds. this is a multiplier (1 is one second, 0.3 is a third of a second, etc)
 * @param {Struct.AnimCurveChannel} waveform the animcurve channel holding the waveform
 * @returns {Id.Buffer}
 */
function bloopquencer_record_bloop(sample_rate, frequency, gain, length, waveform) {
	static total_gain = 32767;
	var period = ceil(sample_rate / frequency);
	var cycles = floor(period * frequency * length * 2);
	var volume = gain * total_gain;
	var buffer = buffer_create(0, buffer_grow, 1);
	while (true) {
		for (var iteration = 0; iteration < period; iteration += 1) {
			var p = iteration / (period - 1);
			var value = volume * animcurve_channel_evaluate(waveform, p);
			buffer_write(buffer, buffer_s16, value);
		}
		if (buffer_tell(buffer) >= cycles) {
			buffer_resize(buffer, buffer_tell(buffer));
			break;
		}
	}
	return buffer;
}

/**
 * records a noisy sound
 * @param {Real} sample_rate the sample rate of the sound, must be in between 8000 and 48000
 * @param {Real} frequency this is the sounds tone
 * @param {Real} gain how loud the sound is, 0 to 1
 * @param {Real} length how long the sound should be, in seconds. this is a multiplier (1 is one second, 0.3 is a third of a second, etc)
 * @returns {Id.Buffer}
 */
function bloopquencer_record_noise(sample_rate, frequency, gain, length) {
	static total_gain = 32767;
	var period = ceil(sample_rate / frequency);
	var cycles = floor(period * frequency * length * 2);
	var volume = gain * total_gain;
	var buffer = buffer_create(0, buffer_grow, 1);
	while (true) {
		var value = irandom_range(-volume, volume);
		repeat(period) {
			buffer_write(buffer, buffer_s16, value);
		}
		if (buffer_tell(buffer) >= cycles) {
			buffer_resize(buffer, buffer_tell(buffer));
			break;
		}
	}
	return buffer;
}

/**
 * records silence
 * @param {Real} sample_rate the sample rate of the sound, must be in between 8000 and 48000
 * @param {Real} length how long the sound should be, in seconds. this is a multiplier (1 is one second, 0.3 is a third of a second, etc)
 * @returns {Id.Buffer}
 */
function bloopquencer_record_silence(sample_rate, length) {
	var span = floor(sample_rate * (2 * length));
	var buffer = buffer_create(0, buffer_grow, 1);
	while (true) {
		var value = 0;
		repeat (span) {
			buffer_write(buffer, buffer_s16, value);
		}
		if (buffer_tell(buffer) >= span) {
			buffer_resize(buffer, buffer_tell(buffer));
			break;
		}
	}
	return buffer;
}

/**
 * turns an array of recordings into a single wav file
 * @param {Array<Id.Buffer>} recordings the array of buffers made with the recording functions
 * @param {Real} sample_rate the sample rate all of these sounds were recorded with
 * @returns {Id.Buffer}
 */
function bloopquencer_write_wave(recordings, sample_rate) {
	var sequence_size = 0;
	var sequence_count = array_length(recordings);
	var sequence_size_list = array_create(sequence_count, 0);
	for (var buffer = 0; buffer < sequence_count; buffer += 1) {
		var buffer_size = buffer_get_size(recordings[buffer]);
		sequence_size_list[buffer] = buffer_size;
		sequence_size += buffer_size;
	}
	var wave_file = buffer_create(44 + sequence_size, buffer_fixed, 1);
	buffer_write(wave_file, buffer_text, "RIFF");
	buffer_write(wave_file, buffer_u32, 36 + sequence_size);
	buffer_write(wave_file, buffer_text, "WAVE");
	buffer_write(wave_file, buffer_text, "fmt ");
	buffer_write(wave_file, buffer_u32, 16);
	buffer_write(wave_file, buffer_u16, 1);
	buffer_write(wave_file, buffer_u16, 1);
	buffer_write(wave_file, buffer_u32, sample_rate);
	buffer_write(wave_file, buffer_u32, sample_rate * 2);
	buffer_write(wave_file, buffer_u16, 2);
	buffer_write(wave_file, buffer_u16, 16);
	buffer_write(wave_file, buffer_text, "data");
	buffer_write(wave_file, buffer_u32, sequence_size);
	buffer_seek(wave_file, buffer_seek_start, 44);
	for (var buffer = 0; buffer < sequence_count; buffer += 1) {
		var buffer_size = sequence_size_list[buffer];
		var wave_file_tell = buffer_tell(wave_file);
		buffer_copy(recordings[buffer], 0, buffer_size, wave_file, wave_file_tell);
		buffer_seek(wave_file, buffer_seek_start, wave_file_tell + buffer_size);
	}
	return wave_file;
}