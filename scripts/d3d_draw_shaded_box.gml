///d3d_draw_shaded_box(x1,y1,z1,x2,y2,z2,texid,hrepeat,vrepeat);
var x1,y1,z2,x2,y2,z2,texid,hrepeat,vrepeat,currColor;

var darkness = 1.5;

x1 = argument[0];
y1 = argument[1];
z1 = argument[2];

x2 = argument[3];
y2 = argument[4];
z2 = argument[5];

texid = argument[6];
hrepeat = argument[7];
vrepeat = argument[8];

currColor = draw_get_colour();

draw_set_color(currColor);
d3d_draw_wall(x1,y2,z1,x1,y1,z2,texid,hrepeat,vrepeat);
d3d_draw_wall(x2,y1,z1,x2,y2,z2,texid,hrepeat,vrepeat);
draw_set_color(make_colour_rgb(color_get_red(currColor)/darkness,color_get_green(currColor)/darkness,color_get_blue(currColor)/darkness));
d3d_draw_wall(x1,y1,z1,x2,y1,z2,texid,hrepeat,vrepeat);
d3d_draw_wall(x2,y2,z1,x1,y2,z2,texid,hrepeat,vrepeat);
draw_set_color(currColor);
