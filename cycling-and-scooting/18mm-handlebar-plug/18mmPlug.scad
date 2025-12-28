testRadius = 18.5 / 2;
targetDiameter = 17;
targetRadius = targetDiameter / 2;
originalDiameter = 16;
scale = targetDiameter / originalDiameter;

// Test cylinder
// cylinder(34, testRadius, testRadius);

/*translate([0, 0, 17]) scale(scale) {
        import("plug.stl", center = true);
}*/
difference() {
    translate([0, 0, 17]) scale(scale) {
        import("plug.stl", center = true);
    }
    linear_extrude(0.5) {
        import("vykeen-fan-art.svg", center = true);
        // scale([3,3,3]) { import("Black_Skull_icon.svg", center = true); }
        // scale([0.07,0.07,0.07]) { import("Alien01.svg", center = true); }
    }
}
//import("Alien01.svg", center = true);