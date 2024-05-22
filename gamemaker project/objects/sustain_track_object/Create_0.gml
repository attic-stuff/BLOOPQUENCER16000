minimum = y;
maximum = bbox_bottom;
height = maximum - minimum;
low = 0.03;
high = 0.35;
output = lerp(low, high, value);
update = false;