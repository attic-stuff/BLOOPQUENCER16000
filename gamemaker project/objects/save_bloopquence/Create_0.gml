image_speed = 0;
audio = undefined;
buffer = undefined;
sequence_list = array_create_ext(16, function(index) {
	return instance_find(sequence_track_object, index);
});
array_sort(sequence_list, function(a, b) {
	return a.track_number - b.track_number;
});

