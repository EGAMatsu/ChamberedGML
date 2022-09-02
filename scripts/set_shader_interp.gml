#define set_shader_interp
///set_shader_interp( sprite )

if (sprite_get_width(argument0) > 24)
{
shader_set(shd_interp);

shader_set_uniform_f(u_interp_texture_w, sprite_get_width(argument[0]));
shader_set_uniform_f(u_interp_texture_h, sprite_get_height(argument[0]));
}

#define shaders_init
globalvar u_ref_refmap, u_ref_refamount,  u_ref_texture_w,u_ref_texture_h, u_ref_texture_w2,u_ref_texture_h2;

u_ref_refmap = shader_get_sampler_index(shd_ref_interp, "RefMap");
u_ref_refamount = shader_get_uniform(shd_ref_interp, "ref_amount");
u_ref_texture_w = shader_get_uniform(shd_ref_interp, "texture_w");
u_ref_texture_h = shader_get_uniform(shd_ref_interp, "texture_h");
u_ref_texture_w2 = shader_get_uniform(shd_ref_interp, "texture_w2");
u_ref_texture_h2 = shader_get_uniform(shd_ref_interp, "texture_h2");


globalvar u_refmap_reftex,u_refmap_refmap, u_refmap_refamount,  u_refmap_texture_w,u_refmap_texture_h, u_refmap_texture_w2,
u_refmap_texture_h2, u_refmap_texture_w3,u_refmap_texture_h3;

u_refmap_reftex = shader_get_sampler_index(shd_ref_interp_map, "Ref_Tex");
u_refmap_refmap = shader_get_sampler_index(shd_ref_interp_map, "Ref_Map");

u_refmap_refamount = shader_get_uniform(shd_ref_interp_map, "ref_amount");
u_refmap_texture_w = shader_get_uniform(shd_ref_interp_map, "texture_w");
u_refmap_texture_h = shader_get_uniform(shd_ref_interp_map, "texture_h");
u_refmap_texture_w2 = shader_get_uniform(shd_ref_interp_map, "texture_w2");
u_refmap_texture_h2 = shader_get_uniform(shd_ref_interp_map, "texture_h2");
u_refmap_texture_w3 = shader_get_uniform(shd_ref_interp_map, "texture_w3");
u_refmap_texture_h3 = shader_get_uniform(shd_ref_interp_map, "texture_h3");


globalvar u_interp_texture_w, u_interp_texture_h;

u_interp_texture_w = shader_get_uniform(shd_interp, "texture_w");
u_interp_texture_h = shader_get_uniform(shd_interp, "texture_h");

/*
globalvar u_interp2d_texture_w, u_interp2d_texture_h;

u_interp2d_texture_w = shader_get_uniform(shd_interp2d, "texture_w");
u_interp2d_texture_h = shader_get_uniform(shd_interp2d, "texture_h");*/