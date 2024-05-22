minimum = y;
maximum = bbox_bottom;
height = maximum - minimum;
low = 0;
high = 4096;
value = 0;
output = lerp(low, high, value);
waveform = noone;
var link = id;
sustain_fader = instance_create_depth(x, 180, depth, sustain_track_object, {
	track_link : link,
	value : 0
});
gain_fader = instance_create_depth(x, 232, depth, gain_track_object, {
	track_link : link,
	value : 0.35
});
update = false;
sample = bloopquencer_record_silence(sample_rate_track_object.output, 0.03);