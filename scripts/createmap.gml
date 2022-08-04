///createmap(image);
var img, w, h, cell_w, cell_h, surf, i, j, col, obj; // init vars
global.mapIsGen = false;
//https://chrisanselmo.com/gmcolor/

d3d_end();
d3d_set_culling(0);
d3d_set_fog(0, c_black, -8, 90);

d3d_light_enable(0, false);
d3d_light_enable(1, false);

draw_set_alpha_test(true);
draw_set_alpha_test_ref_value(128);

var playColor;
playColor = make_colour_hsv(40,240,120);

img = argument0;

w = sprite_get_width(img); // image width
h = sprite_get_height(img); // image height

// cell size in which objects will "snap" to
cell_w = floor(room_width / w);
cell_h = floor(room_height / h);

surf = surface_create(w, h); // create a surface

surface_set_target(surf); // set the surface target
draw_sprite(img, 0, 0, 0); // draw the image to the surface
surface_reset_target(); // reset the surface target

for (i = 0; i < w; i++) { // cycle through width of image
    for (j = 0; j < h; j++) { // cycle through height of image
        // get the pixel color at the given coordinates (SLOW FUNCTION, use graciously)
        col = surface_getpixel(surf, i, j);
        obj = noone; // object to create at coordinates

        switch (col) {
            case ($ffffff): //Main Wall
                obj = wallMain;
                break;
            case ($ffff00): //Breakable Wall
            if (global.ObjectInteractableStatusX[i,global.currentRoom]==true || global.ObjectInteractableStatusY[j,global.currentRoom]==true)
            {
                obj = wallBreakable;
            }
                break;
            case ($9e009e): //Ladder Down
                obj = ladderDownObject;
                break;
            case ($ff66ff): //Ladder Up
                obj = ladderUpObject;
                break;
            case ($4C4C4C): //Cell Door Shut
            if (global.ObjectInteractableStatusX[i,global.currentRoom]==true || global.ObjectInteractableStatusY[j,global.currentRoom]==true)
            {
                obj = wallCellFront;
            } else
            {
                obj = wallCellFront_Broken;
            }
                break;
            case ($023aff): //Torch
                obj = torchObject;
                break;
            case ($0055aa): //Balls
                obj = wallBall;
                break;
            case ($00ffff): //Player
                obj = playerObject;
                break;
            case (0):
                break;
        }

        // if there is a color match, create the associated object at the given coordinates (px * grid)
        if (obj != noone) {
            instance_create(i * cell_w, j * cell_h, obj);
        }
    }
}

surface_free(surf); // free the surface from memory

global.mapIsGen = true;
