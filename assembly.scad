include <openscad-utilities/common.scad>
use <openscad-utilities/vessel.scad>
use <openscad-utilities/arrow.scad>
use <stand.scad>

pot_d = default_pot_d();
pot_h = default_pot_h();
bar_size = default_bar_size(pot_d);

stand_inner_width = pot_d;
stand_top_bar_length = top_bar_length(pot_h);
top_bar_inner_width = inner_width(pot_d);
stand_corner_r = 0;

assembly(
	pot_d,
	pot_h,
	stand_inner_width,
	stand_top_bar_length,
    top_bar_inner_width,
	bar_size,
	stand_corner_r,
	show_pot = true,
	explode = false
);

module assembly(
	pot_d,
	pot_h,
	inner_width,
	top_bar_length,
    top_bar_inner_width,
	bar_size,
	corner_r,
	show_pot = true,
	explode = false
) {
	explode_dist = explode ? 30 : 0;

	translate([0, 0, explode_dist])
		stand_part();
	stand_part(true);
	if (explode) {
		translate([0, 0, bottom_bar_length(pot_h) + explode_dist/2])
			rotate([90, 0, 45])
				arrow(6);
	}

	if (show_pot && !explode)
		translate([0, 0, bottom_bar_length(top_bar_length) + 2 * bar_size])
			color("#F9F9F9")
				vessel(d = pot_d, h = pot_h, 3, 3, 1.5, corner_r > 0 ? corner_r : 3);

	module stand_part(is_top = false) {
		rotate([270, 0, is_top ? 90 : 0])
			color("#654321")
				stand(
					pot_d,
					pot_h,
					top_bar_inner_width,
					top_bar_length,
					bar_size,
					corner_r = corner_r,
					is_top = is_top
				);
	}
}
