draw_sprite_ext(sprite_index, 0, x, y, image_xscale, image_yscale, 0, c_white, image_alpha);

shader_set(sh_graph);
    shader_set_uniform_f(
        shader_get_uniform(sh_graph, "start_rpm"),
        o_control.player_stats.start_rpm
    );
    
    shader_set_uniform_f(
        shader_get_uniform(sh_graph, "half_life"),
        o_control.player_stats.half_life
    );
    
    shader_set_uniform_f(
        shader_get_uniform(sh_graph, "radius"),
        o_control.player_stats.radius
    );
    
    shader_set_uniform_f(
        shader_get_uniform(sh_graph, "weight"),
        o_control.player_stats.weight / 1000
    );
    
    shader_set_uniform_f(
        shader_get_uniform(sh_graph, "height"),
        o_control.player_stats.height
    );
    
    shader_set_uniform_f(
        shader_get_uniform(sh_graph, "size"),
        width-6, height-6
    );
    
    draw_rectangle_colour(x + 3, y + 3, x + width - 3, y + height - 5, c_black, c_black, c_black, c_black, false);
shader_reset();