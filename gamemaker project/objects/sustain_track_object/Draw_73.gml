var draw_height = floor(clamp(value * height, 2, height));
var draw_position = maximum - (draw_height);
draw_sprite_stretched(gain_fill_sprite, 0, x + 2, draw_position, 15, draw_height + 1);