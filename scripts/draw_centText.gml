///draw_centText(mapName);
var mapName;
mapName = argument0;
draw_set_halign(fa_center);
draw_set_valign(fa_center);

var halfSize = (120 * (window_get_width()/window_get_height()))/2;

    draw_set_color($333333);
    draw_text(halfSize,91/2+1,mapName);
    draw_set_color($ccffff);
    draw_text(halfSize,91/2,mapName);

draw_set_halign(fa_left);
draw_set_valign(fa_top);
