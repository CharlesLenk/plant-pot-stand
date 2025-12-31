include <openscad-utilities/common.scad>

default_bar_size = 7.5;

function default_bar_size() = default_bar_size;
function top_bar_length(pot_h) = 0.85 * top_bar_length;
function bottom_bar_length(top_bar_length) = 0.3 * top_bar_length;

module stand(
    pot_d,
    pot_h,
	inner_width,
    top_bar_length,
    bar_size,
    corner_r = 0,
    is_top = true
) {
    inner_width = is_undef(inner_width) ? pot_d : inner_width;
    top_bar_length = is_undef(top_bar_length) ? top_bar_length(pot_h) : top_bar_length;
    bar_size = is_undef(bar_size) ? default_bar_size : bar_size;

	edge_d = 2;
    bottom_length = bottom_bar_length(top_bar_length);
	bottom_corner_r = min(corner_r, bottom_length - edge_d/2);
	is_square_stand = corner_r == 0;
	inner_cube_width = is_square_stand ? inner_width + 2 * bar_size : 
        max(3 * bar_size, min(inner_width - 2 * corner_r, inner_width - 2 * bottom_corner_r));
    notch_offset = 0.5;

	translate([0, -bar_size - bottom_length]) {
		difference() {
			union() {
				leg();
				rotate([0, 180, 0]) leg();
				rounded_cube([inner_cube_width, 2 * bar_size, bar_size], d = edge_d, center = true);
			}
			translate([-bar_size/2, is_top ? -bar_size - notch_offset/2 : -notch_offset/2, -bar_size/2]) {
				fix_preview()
                    cube([bar_size, bar_size + notch_offset, bar_size]);
			}
		}
	}

	module leg() {
		curve_with_rounded_end(corner_r, inner_width/2, top_bar_length);
		rotate(180) curve_with_rounded_end(bottom_corner_r, inner_width/2, bottom_length);
	}

	module curve_with_rounded_end(inner_r, width, length) {
		width = (width - inner_r) < 0 ? 0 : width - inner_r;
		length = (length - inner_r) < 0 ? 0 : length - inner_r;

		if(is_square_stand) {
			translate([inner_width/2 + bar_size/2, 0]) {
				rotate([90, 0, 0]) {
					rounded_cube(
						[bar_size, bar_size, 2 * bar_size],
						d = edge_d, top_d = 0, bottom_d = 0, center = true
					);
				}
			}
		}

		translate([width, -inner_r - bar_size, -bar_size/2])
			rotate_extrude(angle = 90)
				translate([inner_r, 0, 0])
                    rounded_square([bar_size, bar_size], 2);
                    
		translate([0, -bar_size, bar_size/2])
			rotate([0, 90, 0])
				rounded_cube([bar_size, bar_size, width], d = edge_d, top_d = 0, bottom_d = 0);

		translate([inner_r + width, -length - inner_r - bar_size, bar_size/2])
			rotate([-90, 0, 0])
				rounded_cube([bar_size, bar_size, length], d = edge_d, top_d = 0, bottom_d = edge_d);
	}
}
