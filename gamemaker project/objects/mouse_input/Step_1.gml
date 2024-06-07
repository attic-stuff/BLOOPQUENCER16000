tap_left = mouse_check_button_pressed(mb_left);
mash_left = mouse_check_button(mb_left);
letgo_left = mouse_check_button_released(mb_left);
tap_right = mouse_check_button_pressed(mb_right);
mash_right = mouse_check_button(mb_right);

var bloop = keyboard_check_pressed(vk_space);
var modifier = keyboard_check(vk_control);
var save = keyboard_check_pressed(ord("S"));
var export = keyboard_check_pressed(ord("E"));
var load = keyboard_check_pressed(ord("L"));
file_operation = (bloop * 1) | (export * 2) | (save * 4) | (load * 8) | (modifier * 16);