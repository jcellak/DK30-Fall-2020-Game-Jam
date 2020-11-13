/// @desc Initialize vars

instance_create_layer(0, 0, "Transitions", o_transition_fade_in);

x_one = 30;
rob_spd = 3;
dir_one = 1;
left_one = false;

m_font = f_menu;

l_screen = 70;
r_screen = 375;
t_screen = 10;
b_screen = 182
margin = 30;
screen_w = r_screen - l_screen;
screen_h = b_screen - t_screen;
v_dist = screen_w*0.35;
