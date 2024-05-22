if (audio_exists(audio) == true) {
	if (audio_is_playing(audio) == false) {
		audio_free_buffer_sound(audio);
		buffer_delete(buffer);
		audio = undefined;
		buffer = undefined;
	}
}