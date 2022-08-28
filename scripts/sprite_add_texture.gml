///sprite_add_texture(fname);
var texture = sprite_add(argument0,1,0,0,0,0);
var cell = 8;
var width = sprite_get_width(texture) / cell;
var height = sprite_get_height(texture) / cell;

var surface = surface_create(sprite_get_width(texture), sprite_get_height(texture));
surface_set_target(surface) {
  draw_clear_alpha(c_white, 0.0);
  draw_sprite(texture, 0, 0, 0);
  surface_reset_target();
}

textureArray = texture;

var index = 0;
for (var i = 0; i < cell; i++) {
  for (var j = 0; j < cell; j++) {
    //pack[index] = sprite_create_from_surface(surface, i * 16, j * 16, 16, 16, false, false, 0, 0);
    if (i == 0 && j == 0)
    {
    textureArray = sprite_create_from_surface(surface, j*width, i*height, width, height, 0, 0, 0, 0);
    } else
    {
    sprite_add_from_surface(textureArray, surface, j*width, i*height, width, height, 0, 0);
    }
    //index += 1;
  }
}

surface_free(surface);
sprite_delete(texture);

return textureArray;

