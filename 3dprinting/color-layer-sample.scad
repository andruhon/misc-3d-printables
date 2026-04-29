// Color layer combination sample
// Base: solid white layer (z = 0..0.1)
// Layer 1 (bottom): one of 4 colors per column (z = 0.1..0.2)
// Layer 2 (top):    one of 4 colors per row    (z = 0.2..0.3)
// 4x4 grid -> 16 ordered combinations of (bottom, top) colors.
//
// Multi-color FDM workflow:
//   Set render_color to 0/1/2/3 and export an STL per color, then load
//   them as parts in your slicer. Use -1 for a coloured preview in OpenSCAD.

layer_h = 0.1;
cell    = 3;     // rectangle side length in mm
n       = 4;     // number of colors

// Color indices: 0 = white, 1 = red, 2 = blue, 3 = purple
color_rgb = [
    [1.00, 1.00, 1.00],   // white
    [0.85, 0.10, 0.10],   // red
    [0.10, 0.20, 0.85],   // blue
    [0.50, 0.10, 0.60],   // purple
];

// -1 = preview all colors; 0..3 = isolate a single color for STL export.
render_color = -1;

// Geometry belonging to color c:
//   - if c == 0 (white): the full base slab
//   - bottom-layer rectangles in column c (bottom color == c, every top color)
//   - top-layer rectangles in row c (top color == c, every bottom color)
module color_part(c) {
    if (c == 0) {
        cube([n * cell, n * cell, layer_h]);
    }
    for (row = [0 : n - 1]) {
        translate([c * cell, row * cell, layer_h])
            cube([cell, cell, layer_h]);
    }
    for (col = [0 : n - 1]) {
        translate([col * cell, c * cell, 2 * layer_h])
            cube([cell, cell, layer_h]);
    }
}

if (render_color == -1) {
    for (c = [0 : n - 1]) {
        color(color_rgb[c]) color_part(c);
    }
} else {
    color_part(render_color);
}
