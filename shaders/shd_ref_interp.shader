//
// Simple passthrough vertex shader
//
attribute vec3 in_Position;                  // (x,y,z)
attribute vec3 in_Normal;                    // (x,y,z)
attribute vec4 in_Colour;                    // (r,g,b,a)
attribute vec2 in_TextureCoord;              // (u,v)

varying vec2 v_vTexcoord;
varying vec4 v_vColour;
varying vec3 v_vNormal;
varying vec2 v_vRefTexcoord;



void main()
{
    vec4 object_space_pos = vec4( in_Position.x, in_Position.y, in_Position.z, 1.0);
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * object_space_pos;
    
    v_vColour = in_Colour;

    v_vNormal = normalize(gm_Matrices[MATRIX_WORLD] * vec4(in_Normal, 0.0)).xyz;

    vec2 muv = vec2( ( gm_Matrices[MATRIX_VIEW] * vec4(v_vNormal, 0.0)).xy )*0.5 + vec2(0.5,0.5);
    v_vRefTexcoord = vec2(muv.x, 1.0-muv.y);
    v_vTexcoord = in_TextureCoord;
    
}

//######################_==_YOYO_SHADER_MARKER_==_######################@~//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;
varying vec3 v_vNormal;
varying vec2 v_vRefTexcoord;

uniform sampler2D RefMap;
uniform float ref_amount;

// texture info
uniform float texture_w;
uniform float texture_h;
uniform float texture_w2;
uniform float texture_h2;

ivec2 denorm2idx(vec2 d_uv)
{
    return ivec2(floor(d_uv));
}


vec2 norm2denorm(sampler2D tex, vec2 uv, vec2 size)
{
    return uv * size - 0.5;
}

ivec2 norm2idx(sampler2D tex, vec2 uv, vec2 size)
{
    return denorm2idx( norm2denorm(tex, uv, size) );
}

vec2 idx2norm(sampler2D tex, ivec2 idx ,vec2 size)
{
    vec2 denorm_uv = vec2(idx) + 0.5;
    return denorm_uv / size;
}

vec4 texel_fetch(sampler2D tex, ivec2 idx, vec2 size)
{
    vec2 uv = idx2norm(tex, idx, size);
    return texture2D(tex, uv);
}

/*
 * Unlike Nintendo's documentation, the N64 does not use
 * the 3 closest texels.
 * The texel grid is triangulated:
 *
 *     0 .. 1        0 .. 1
 *   0 +----+      0 +----+
 *     |   /|        |\   |
 *   . |  / |        | \  |
 *   . | /  |        |  \ |
 *     |/   |        |   \|
 *   1 +----+      1 +----+
 *
 * If the sampled point falls above the diagonal,
 * The top triangle is used; otherwise, it's the bottom.
 */

 vec4 texture_3point( sampler2D tex, vec2 uv, vec2 size){
 	vec2 denorm_uv = norm2denorm(tex, uv, size);
    ivec2 idx_low = denorm2idx(denorm_uv);
    vec2 ratio = denorm_uv - vec2(idx_low);
	

	#define FLIP_DIAGONAL

	#ifndef FLIP_DIAGONAL
    // this uses one diagonal orientation
			#if 0
			// using conditional, might not be optimal
		    bool lower_flag = 1.0 < ratio.s + ratio.t;
		    ivec2 corner0 = lower_flag ? ivec2(1, 1) : ivec2(0, 0);
		    #else
		    // using step() function, might be faster
		    int lower_flag = int(step(1.0, ratio.s + ratio.t));
		    ivec2 corner0 = ivec2(lower_flag, lower_flag);
	    #endif
	    ivec2 corner1 = ivec2(0, 1);
	    ivec2 corner2 = ivec2(1, 0);
	#else
	    // orient the triangulated mesh diagonals the other way
	    #if 0
		    bool lower_flag = ratio.s - ratio.t > 0.0;
		    ivec2 corner0 = lower_flag ? ivec2(1, 0) : ivec2(0, 1);
		    #else
		    int lower_flag = int(step(0.0, ratio.s - ratio.t));
		    ivec2 corner0 = ivec2(lower_flag, 1 - lower_flag);
	    #endif
	    ivec2 corner1 = ivec2(0, 0);
	    ivec2 corner2 = ivec2(1, 1);
	#endif
    ivec2 idx0 = idx_low + corner0;
    ivec2 idx1 = idx_low + corner1;
    ivec2 idx2 = idx_low + corner2;

    vec4 t0 = texel_fetch(tex, idx0, size);
    vec4 t1 = texel_fetch(tex, idx1, size);
    vec4 t2 = texel_fetch(tex, idx2, size);

    // This is standard (Crammer's rule) barycentric coordinates calculation.
    vec2 v0 = vec2(corner1 - corner0);
    vec2 v1 = vec2(corner2 - corner0);
    vec2 v2 = ratio   - vec2(corner0);
    float den = v0.x * v1.y - v1.x * v0.y;
    /*
     * Note: the abs() here is necessary because we don't guarantee
     * the proper order of vertices, so some signed areas are negative.
     * But since we only interpolate inside the triangle, the areas
     * are guaranteed to be positive, if we did the math more carefully.
     */
    float lambda1 = abs((v2.x * v1.y - v1.x * v2.y) / den);
    float lambda2 = abs((v0.x * v2.y - v2.x * v0.y) / den);
    float lambda0 = 1.0 - lambda1 - lambda2;

    return lambda0*t0 + lambda1*t1 + lambda2*t2;
 }

void main()
{
    vec4 dif_col = texture_3point( gm_BaseTexture, v_vTexcoord, vec2(texture_w,texture_h) );
    vec4 ref_col = texture_3point( RefMap, v_vRefTexcoord, vec2(texture_w2,texture_h2) );

    // final value mixing diffuse and reflective
    vec4 final = vec4(mix(dif_col.rgb,ref_col.rgb,(ref_col.a* ref_amount) ),   dif_col.a);


    gl_FragColor = v_vColour * final;
}
