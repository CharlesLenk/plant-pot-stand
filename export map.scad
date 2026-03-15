include <openscad-utilities/common.scad>
use <pot.scad>
use <stand.scad>

name = "";
pot_d = default_pot_d();
pot_h = default_pot_h();
bar_size = default_bar_size(pot_d);
corner_r = 0;

is_top = name == "stand_top";

rotate(is_top ? 180 : 0)
    stand(
        pot_d = pot_d,
        pot_h = pot_h,
        bar_size = bar_size,
        corner_r = corner_r,
        is_top = is_top
    );
