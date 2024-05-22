minimum = y;
maximum = bbox_bottom;
height = maximum - minimum;
low = 0.0;
high = 1.0;
output = lerp(low, high, value);
update = false;