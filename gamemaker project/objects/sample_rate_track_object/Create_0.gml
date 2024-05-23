minimum = y;
maximum = bbox_bottom - 1;
height = maximum - minimum;
low = 8000;
high = 44100;
value = remap(16000, low, high, 0, 1);
output = lerp(low, high, value);
update = false;