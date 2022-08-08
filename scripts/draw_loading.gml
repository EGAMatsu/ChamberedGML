///draw_loading(mapName);
var mapName, langToForce;
mapName = argument0;
draw_set_halign(fa_center);
draw_set_valign(fa_center);

langToForce = "ja";

var halfSize = (120 * (window_get_width()/window_get_height()))/2;

switch (os_get_language())
//switch (langToForce)
{
    case "ja":
    
    draw_set_color($333333);
    draw_text(halfSize,91/2+1,mapName+"へのさん入");
    draw_set_color($ccffff);
    draw_text(halfSize,91/2,mapName+"へのさん入");
    
    break;
    case "es":
    
    draw_set_color($333333);
    draw_text(halfSize,91/2+1,"Entrando "+mapName);
    draw_set_color($ccffff);
    draw_text(halfSize,91/2,"Entrando "+mapName);
    
    break;
    case "en":
    
    draw_set_color($333333);
    draw_text(halfSize,91/2+1,"Entering The "+mapName);
    draw_set_color($ccffff);
    draw_text(halfSize,91/2,"Entering The "+mapName);
    
    break;
    case "it":
    
    draw_set_color($333333);
    draw_text(halfSize,91/2+1,"Entrare Nella "+mapName);
    draw_set_color($ccffff);
    draw_text(halfSize,91/2,"Entrare Nella "+mapName);
    
    break;
    case "fr":
    
    draw_set_color($333333);
    draw_text(halfSize,91/2+1,"Entrer Dans Les "+mapName);
    draw_set_color($ccffff);
    draw_text(halfSize,91/2,"Entrer Dans Les "+mapName);
    
    break;
    default:
    
    draw_set_color($333333);
    draw_text(halfSize,91/2+1,"Entering The "+mapName);
    draw_set_color($ccffff);
    draw_text(halfSize,91/2,"Entering The "+mapName);
    
    break;
}

draw_set_halign(fa_left);
draw_set_valign(fa_top);
