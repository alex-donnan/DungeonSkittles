draw_sprite(sp_shadow, 0, x, y);

var base_y = 0;
for (var i = 1; i < armor; i++) {
    draw_sprite(sp_enemy_armor, 0, x, y - base_y);
    base_y += 4;
}
draw_sprite(sp_enemy, 0, x, y - base_y);