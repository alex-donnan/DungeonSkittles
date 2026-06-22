function Statistics() constructor {
    inventory = new Inventory();
    
    // Upgrades
    start_rpm = 500;
    half_life = start_rpm / 20;
    weight = 2;
    height = 0.1;
    radius = 2;
    move_influence = 1.2;
    move_speed = 2;
    
    // Random stats
    play_time = 0;
    run_count = 0;
    
    damage_done = 0;
    gems_collected = 0;
    items_collected = 0;
    
    distance_travelled = 0;
    bounces = 0;
}