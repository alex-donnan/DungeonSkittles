function init_items() {
    return {
        "none": new PassiveItem(
            "none", sp_secret,
            "This item doesn't actually exist.",
            -1000, 1,
            function() {
                var player = instance_find(o_player, 0);
                if (!is_null(player)) {
                    player.timer = 0;
                }
            }
        ),
        "gyroscope": new ActiveItem(
            "Gyroscope", sp_gyroscope,
            "Left click moves the top toward the mouse. Uses RPM.",
            0.5, 5,
            function() {
                if (mouse_check_button(mb_left)) {
                    var player = instance_find(o_player, 0);
                    if (!is_null(player)) {
                        player.tilt_direction = point_direction(player.x, player.y, mouse_x, mouse_y);
                        player.timer += 0.5;
                    }
                }
            }
        ),
        "rubber_wheel": new PassiveItem(
            "Rubber Wheel", sp_rubber_wheel,
            "The top is bouncier on contact.",
            1.5, 15,
            function() {}
        ),
        "wheel_weight": new PassiveItem(
            "Wheel Weight", sp_wheel_weight,
            "A heavy weight for longer spins.",
            3, 15,
            function() {}
        ),
        "drill_tip": new PassiveItem(
            "Drill Tip", sp_drill_tip,
            "Has a chance to dig up a gem. Higher potential at higher RPM.",
            2, 30,
            function() {
                timer--;
                
                var player = instance_find(o_player, 0);
                if (!is_null(player) && timer <= 0) {
                    if (random(1) <= 0.1) {
                        instance_create_depth(
                            player.x, player.y, 0,
                            o_gem,
                            {
                                direction: random(360),
                                move_speed: 8
                            }
                        );
                    }
                    
                    timer = max(1, 5 - (4 * (player.rpm / 10000))) * game_get_speed(gamespeed_fps);
                }
            }
        ),
        "firecracker": new ActiveItem(
            "Firecracker", sp_firecracker,
            "Right click fires a single use per run rocket that returns the top to starting RPM.",
            1, 50,
            function() {
                
            }
        ),
        "deployer": new PassiveItem(
            "Deployer", sp_deployer,
            "Every 1000 spins releases a tiny top.",
            4, 100,
            function() {
                var player = instance_find(o_player, 0);
                if (!is_null(player)) {
                    timer += player.rpm / game_get_speed(gamespeed_fps);
                    if (timer > 1000) {
                        instance_create_depth(
                            player.x, player.y, 0,
                            o_tiny_top,
                            {
                                rpm: player.rpm,
                                tilt_direction: random(360)
                            }
                        )
                        timer -= 1000;
                    }
                }
            }
        ),
        "gem_cutter": new PassiveItem(
            "Gem Cutter", sp_gem_cutter,
            "Increases the value of gems collected based on RPM (up to 5)",
            2, 150,
            function() {
                
            }
        ),
        "tesla_coil": new PassiveItem(
            "Tesla Coil", sp_tesla_coil,
            "Every 2500 spins zaps a nearby enemy. Holds charge for valid targets.",
            1, 300,
            function() {
                var player = instance_find(o_player, 0);
                if (!is_null(player)) {
                    if (timer < 2500) {
                        timer += player.rpm / game_get_speed(gamespeed_fps);
                    } else {
                        var enemy = instance_nearest(player.x, player.y, o_enemy);
                        if (
                            !is_null(enemy) &&
                            point_distance(player.x, player.y, enemy.x, enemy.y) < 128 &&
                            is_null(collision_line(player.x, player.y, enemy.x, enemy.y, o_wall, false, true))
                        ) {
                            enemy.armor -= 2;
                            instance_create_depth(
                                player.x, player.y, 0,
                                o_lightning,
                                {
                                    to_x: enemy.x,
                                    to_y: enemy.y
                                }
                            );
                            timer = 0;
                        }
                    }
                }
            }
        ),
        "propeller_hat": new ActiveItem(
            "Propeller Hat", sp_propeller_hat,
            "Spacebar activates the hat to lose 25% current RPM and jump into the air.",
            -3, 250,
            function() {
                
            }
        ),
        "unstable_attractor": new PassiveItem(
            "Unstable Attractor", sp_unstable_attractor,
            "While unstable, draws the top toward interesting objects.",
            0.1, 500,
            function() {
                
            }
        ),
        "unstable_flywheel": new PassiveItem(
            "Gem Cutter", sp_unstable_flywheel,
            "While unstable, has a chance to boost RPM a small amount.",
            0.23, 500,
            function() {
                
            }
        ),
        "unstable_sawblade": new PassiveItem(
            "Gem Cutter", sp_unstable_sawblade,
            "Deals bonus damage based on time spent unstable.",
            0.3, 500,
            function() {
                
            }
        )
    };
}