$fn = 100;

sphere_diameter = 25.4*4;
lens_diameter = 25.4*2;
ring_thickness = 0.4 * 3;
curve_depth = 0.1;
base_height=0.5;

sphere_radius = sphere_diameter/2;
lens_radius = lens_diameter/2;

function radius_intersect(r) = sqrt(pow(sphere_radius, 2) - pow(r,2));

module ring(or, ir, h) {
    difference() {
        cylinder(h=h, r=or);
        translate([0,0,-0.001])
        cylinder(h=h+0.002, r=ir);
    }
}

for (i = [0 : ceil(lens_radius / ring_thickness)]) {
    local_radius = lens_radius - ring_thickness * i;
    
    translate([0,0,-radius_intersect(local_radius)+curve_depth])
    intersection() {
        translate([0,0,radius_intersect(local_radius)-curve_depth])
        ring(local_radius, local_radius - ring_thickness, sphere_radius);
    
        sphere(d=sphere_diameter);
    }
}

outermost_ring_height = sqrt(pow(sphere_radius, 2) - pow(lens_radius-ring_thickness,2)) - sqrt(pow(sphere_radius, 2) - pow(lens_radius,2));
translate([0,0,-sphere_radius + outermost_ring_height+curve_depth])
intersection() {
    sphere(d=sphere_diameter, $fn=500);

    translate([0,0,sphere_radius-outermost_ring_height-curve_depth])
    cylinder(h=sphere_diameter, d=sphere_diameter);
}

translate([0,0,-base_height])
cylinder(h=base_height, d=lens_diameter);
