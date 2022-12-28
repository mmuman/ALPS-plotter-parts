// ALPS Plotter coil lever for MCP-40 & others
// François Revol, 2022-12-27

radius = 0.5;

top_radius = 2.5;

// The rotation of the inner key
angle = -10;

$fn = 20;

// measurements (cf. the SVG files)

E0 = 0.5;
E1 = 2;
E2 = 5.5;
D1 = 2.54;
D2 = 1.84;
A = 10;
B = 4;
C = 5;
D = 5.7;
E = 2;
F = 4.7;
G = 3.7;
H = 1.7;

// the complex shape of the base
poly = [
    [C/2-B, 0],
    [C/2-B, -C/2+A-E],
    [C/2-D, -C/2+A-E],
    [C/2-D, -C/2+A],
    [C/2 - 0.8, -C/2+A],
    [C/2, -C/2+A-3.3],
    [C/2, 0-radius]
];

translate([0,0,E0]) {
    difference() {
        union() {
            translate([0,0,-E0])
                cylinder(h = E0+E1, d = C);
            linear_extrude(height = E1)
                // funky trick:
                // https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/Tips_and_Tricks#Rounding_polygons
                offset(radius) offset(-radius) offset(-radius) offset(radius)
                    polygon(poly);
            intersection() {
                linear_extrude(height = E2)
                    offset(radius) offset(-radius) offset(-radius) offset(radius)
                        polygon([for (i = [1:4]) poly[i]]);
                translate([C/2-D+/*E/2*/0.4, -C/2+A-E/2, 0]) cylinder(h = E2, d = top_radius);
            }
        }
        translate([0,0,-E0-0.5]) intersection() {
            cylinder(h = E0+E1+1, d = D1);
            rotate([0,0,angle]) translate([0,0,E1]) cube([D1,D2,E0+E1*2], center = true);
        }
    }
}