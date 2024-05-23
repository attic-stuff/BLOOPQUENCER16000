scale = 3;
window_set_size(room_width * scale, room_height * scale);
surface_resize(application_surface, room_width, room_height);
display_set_gui_size(room_width, room_height);
window_set_showborder(false);
window_center();
instance_destroy();

