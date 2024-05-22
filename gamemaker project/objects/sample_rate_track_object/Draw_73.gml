var draw_height = floor(clamp(value * height, 2, height));
var draw_position = maximum - (draw_height);
draw_sprite_stretched(sample_rate_fill_sprite, 0, x, draw_position, 14, draw_height);