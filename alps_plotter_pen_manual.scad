// Used to generate the various pictures for the user manual

/* [Hidden] */
// we need more faces on such a small piece
$fa=6;
$fs=0.1;

// overriden by command line in the Makefile
STEP = 00;

holder_colors = ["black", "blue", "green", "red"];

ink_colors = ["black", "blue", "green", "red"];

echo(str("Building user manual picture ", STEP));

module balltip() {
    color("gold") union() {
        sphere(0.2);
        cylinder(h = 2, d1 = 0.5, d2 = 2.2);
        translate([0,0,2]) cylinder(h = 8, d = 2.2);
    }
};

module inktube(length=20, ink="blue", level=80) {
    union() {
        color(ink, 0.9)
            cylinder(h = length * level / 100, d2 = 2.2);
        color("lightgrey", 0.6) difference() {
            cylinder(h = length, d = 3);
            translate([0,0,-0.1]) cylinder(h = length + 1, d = 2.2);
        }
    }
};

// The manual cover
if (STEP == 0) {
    color("lightgrey") {
        include <alps_plotter_pen_cutting_jig.scad>;
    }
    for (i = [0:3]) {
        translate([-i*1+$t,-30+10*i, 0]) rotate ([0,-90,0]) {
            translate([0,0,5.4]) color(holder_colors[i]) {
                include <alps_plotter_pen.scad>;
            }
            translate([0,0,0]) balltip();
            translate([0,0,8]) inktube(length=12.3, ink=ink_colors[i], level=93);
        };
    }
}

if (STEP >= 1 && STEP < 3 || STEP >= 7 && STEP < 9) {
    color("lightgrey") {
        include <alps_plotter_pen_cutting_jig.scad>;
    }
}

if (STEP == 1 || STEP == 2) {
    translate([7.5,10.5,3]) rotate([0,90,0]) {
        translate([0,0,0]) balltip();
        translate([0,0,8]) inktube(length=35);
    }
}

if (STEP == 1) {
    translate([30,5,10]) color("black")
        linear_extrude(height = 0.1)
            text("\u2190", font = "DejaVu Sans", size=16);
}

if (STEP == 2) {
    // blade
    translate([27.7,-22,6]) rotate([-8,0,0]) color("red", 0.8)
        difference() {
            cube([0.2, 50, 10]);
            translate([-0.1,55,-5]) rotate([55,0,0])
                cube([0.4, 10, 30]);
            translate([-0.1,10,0]) rotate([135,0,0])
                cube([0.4, 18, 12]);
        }
    translate([38,-8,3]) rotate([0,0,80]) rotate([90,0,0]) {
        color("white") linear_extrude(height = 0.2) offset(0.1)
            text("\u21B5", font = "DejaVu Sans", size=16);
        color("black") translate([0,0,0.1]) linear_extrude(height = 0.2)
            text("\u21B5", font = "DejaVu Sans", size=16);
    }
}

if (STEP == 3 || STEP == 4) {
    translate([0,10.5,3]) rotate([0,90,0]) {
        translate([0,0,8]) inktube(length=35);
    }
}

if (STEP == 3) {
    // some tissue
    translate([4,0,0]) {
        rotate([0,5,2]) {
            color("White") cube([1, 20, 20]);
            // naive ink stain
            translate([0,6,4]) color("blue", 0.7) minkowski() {
                cube([1.2, 3, 2]);
                sphere(0.5);
            }
        }
    }
    translate([10,10,10]) color("black")
        linear_extrude(height = 0.1)
            text("\u2194", font = "DejaVu Sans", size=16);
    translate([40,0,10]) rotate([80,0,90])
        color("black") translate([0,0,0.1]) linear_extrude(height = 0.2)
            text("\u21BB", font = "DejaVu Sans", size=16);
}

if (STEP == 4) {
    // hot glue gun
    translate([8,10,10]) rotate([-20,10,0]) color("gold") union() {
        cylinder(h = 4, d1 = 1, d2 = 5);
        translate([0,0,4]) cylinder(h = 3, d = 5);
    }
    // hot glue
    translate([8,10,4]) color("LightYellow") hull() {
        sphere(3);
        translate([0,0,5]) sphere(0.5);
    }
    translate([40,0,10]) rotate([80,0,90])
        color("black") translate([0,0,0.1]) linear_extrude(height = 0.2)
            text("\u21BB", font = "DejaVu Sans", size=16);
}

if (STEP == 5) {
    translate([7.5,10.5,3]) rotate([0,90,0]) {
        translate([0,0,0]) balltip();
        translate([0,0,8]) inktube(length=10, level=104);
    }
    // some tissue
    translate([32,0,0]) {
        rotate([0,5,2]) {
            color("White") cube([1, 10, 10]);
            // naive ink stain
            translate([0,6,4]) color("darkblue", 0.7) minkowski() {
                cube([1.2, 3, 2]);
                sphere(0.5);
            }
        }
    }
    translate([4,10,10]) color("black")
        linear_extrude(height = 0.1)
            text("\u2194", font = "DejaVu Sans", size=16);
    translate([33,0,10]) rotate([80,0,90])
        color("black") translate([0,0,0.1]) linear_extrude(height = 0.2)
            text("\u21BB", font = "DejaVu Sans", size=16);
    translate([7.5,10.5,3]+[32,0,24]) rotate([0,90,0]) {
        translate([0,0,0]) balltip();
        translate([0,0,8]) inktube(length=10, level=85);
    }
    translate([58,8,28]) rotate([50,0,0]) color("red") difference() {
        circle(5);
        circle(4);
    }
    translate([42,10,5]) rotate([90,0,0]) color("black")
        linear_extrude(height = 0.1)
            text("\u26A0", font = "DejaVu Sans", size=16);
}

if (STEP == 6) {
    translate([7.5,10.5,3]) rotate([0,90,0]) {
        translate([0,0,0]) balltip();
        translate([0,0,8]) inktube(length=10, level=90);
    }
    translate([15+7.5,10.5,3]) rotate ([0,90,0]) {
        translate([0,0,5.4]) color(holder_colors[1]) {
            include <alps_plotter_pen.scad>;
        }
    }
    translate([5,18,00]) color("black")
        linear_extrude(height = 0.1)
            text("\u2192", font = "DejaVu Sans", size=16);
}

if (STEP == 7 || STEP == 8) {
    s7 = STEP == 7;
    rotate([0,s7?-8:0,0]) {
        translate([2.5,4,3]) rotate([0,90,0]) {
            translate([0,0,0]) balltip();
            translate([0,0,8]) inktube(length=10, level=90);
        }
        translate([s7?2:0+2.5,4,3]) rotate ([0,90,0]) {
            translate([0,0,5.4]) color(holder_colors[1]) {
                include <alps_plotter_pen.scad>;
            }
        }
    }
}
if (STEP == 7) {
    translate([8,8,10]) rotate([80,0,0]) color("black")
        linear_extrude(height = 0.1)
            text("\u2199\u2193", font = "DejaVu Sans", size=16);
}
if (STEP == 8) {
    translate([17,-8,-2]) rotate([80,0,80]) {
        color("white") linear_extrude(height = 0.2) offset(0.1)
            text("\u21BA", font = "DejaVu Sans", size=16);
        color("black") translate([0,0,0.1]) linear_extrude(height = 0.2)
            text("\u21BA", font = "DejaVu Sans", size=16);
    }
    translate([-3,-15,0]) rotate([0,0,0]) color("black")
        linear_extrude(height = 0.1)
            text("\u21AE", font = "DejaVu Sans", size=16);
}
