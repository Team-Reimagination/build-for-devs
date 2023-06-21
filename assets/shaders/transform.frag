#pragma header
void main()
{
    // Normalized pixel coordinates (from 0 to 1)
    vec2 uv = openfl_TextureCoordv;
    // Time varying pixel color
    vec4 col = flixel_texture2D(bitmap, uv);
	vec2 reverseUV = uv * openfl_TextureSize;
    if (reverseUV.x > 5. * (openfl_TextureSize.x/1280) && reverseUV.x < 10. * (openfl_TextureSize.x/1280) || reverseUV.y > 5. * (openfl_TextureSize.y/720) && reverseUV.y < 10. * (openfl_TextureSize.y/720) || reverseUV.x > openfl_TextureSize.x - 10. * (openfl_TextureSize.x/1280) && reverseUV.x < openfl_TextureSize.x - 5. * (openfl_TextureSize.x/1280) || reverseUV.y > openfl_TextureSize.y - 10. * (openfl_TextureSize.y/720) && reverseUV.y < openfl_TextureSize.y - 5. * (openfl_TextureSize.y/720)) 
        col.rgb = vec3(1.);
    if (uv.x < 0.03 || uv.x > 0.97)
        if (uv.y > 0.495 && uv.y < 0.515 || uv.y > 0. && uv.y < 0.025 || uv.y > 0.985 && uv.y < 1.) col.rgb = vec3(.3);
	if (uv.x > 0.495 && uv.x < 0.515) 
		if (uv.y > 0.985 && uv.y < 1. || uv.y > 0. && uv.y < 0.025) col.rgb = vec3(.3);
    // Output to screen
    gl_FragColor = col;
}