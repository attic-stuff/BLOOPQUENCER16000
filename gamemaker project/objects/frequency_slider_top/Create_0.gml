image_speed = 0;
offset = 0;
low = 20;
high = 4096;
minimum = frequency_track_object.y;
maximum = frequency_track_object.bbox_bottom;
update = false;
sliding = false;
output = 1024;
value = remap(output, low, high, 0, 1);
y = maximum - (value * (maximum - minimum));
depth = -1;