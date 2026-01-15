include <openscad-utilities/common.scad>
use <openscad-utilities/vessel.scad>
use <stand.scad>

name = "";
pot_d = default_pot_d();
pot_h = default_pot_h();
bar_size = default_bar_size();

stand_inner_width = pot_d;
stand_top_bar_length = top_bar_length(pot_h);
stand_corner_r = 0;

assembly(
	pot_d,
	pot_h,
	stand_inner_width,
	stand_top_bar_length,
	bar_size,
	stand_corner_r,
	show_pot = true
);

module assembly(
	pot_d,
	pot_h,
	inner_width,
	top_bar_length,
	bar_size,
	corner_r,
	show_pot = true
) {
	stand_part();
	stand_part(true);

	if (show_pot)
		translate([0, 0, bottom_bar_length(top_bar_length) + 2 * bar_size])
			color("#F9F9F9")
				vessel(d = pot_d, h = pot_h, 3, 3, 1.5, corner_r > 0 ? corner_r : 3);

	module stand_part(is_top = false) {
		rotate([270, 0, is_top ? 90 : 0])
			color("#654321")
				stand(
					pot_d,
					pot_h,
					inner_width,
					top_bar_length,
					bar_size,
					corner_r = corner_r,
					is_top = is_top
				);
	}
}
