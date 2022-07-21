$fn = 100;

sphere_diameter = 25.4*4;
lens_diameter = 25.4*2;
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

z = radius_intersect(lens_radius);
translate([0,0,0])
intersection() {
    translate([0,0,-z])
    sphere(d=sphere_diameter, $fn=500);

    
    cylinder(h=sphere_diameter, d=lens_diameter);
}

translate([0,0,-base_height])
cylinder(h=base_height,d=lens_diameter);
