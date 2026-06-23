if (!active) exit;
  
draw_sprite_ext(sprite_index, 0, x, y, image_xscale, image_yscale, 0, c_white, image_alpha);

graph_surface = surface_check(
    graph_surface,
    width, height,
    function() {
        draw_clear_alpha(c_black, 0);
        
        shader_set(sh_graph);
            shader_set_uniform_f(
                shader_get_uniform(sh_graph, "start_rpm"),
                start_rpm
            );
            
            shader_set_uniform_f(
                shader_get_uniform(sh_graph, "half_life"),
                half_life
            );
            
            shader_set_uniform_f(
                shader_get_uniform(sh_graph, "radius"),
                radius
            );
            
            shader_set_uniform_f(
                shader_get_uniform(sh_graph, "weight"),
                weight / 1000
            );
            
            shader_set_uniform_f(
                shader_get_uniform(sh_graph, "height"),
                cm_height
            );
            
            shader_set_uniform_f(
                shader_get_uniform(sh_graph, "size"),
                width, height
            );
            
            shader_set_uniform_f(
                shader_get_uniform(sh_graph, "max_size"),
                max_width, max_height
            );
            
            draw_primitive_begin_texture(pr_trianglelist, -1);
                draw_vertex_texture(0, 0, 0, 1);
                draw_vertex_texture(width, 0, 1, 1);
                draw_vertex_texture(width, height, 1, 0);
        
                draw_vertex_texture(width, height, 1, 0);
                draw_vertex_texture(0, height, 0, 0);
                draw_vertex_texture(0, 0, 0, 1);
            draw_primitive_end();
        shader_reset();
    },
    true
);

draw_surface_stretched(graph_surface, x+3, y+3, width-6, height-8);