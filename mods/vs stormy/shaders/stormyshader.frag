#pragma header
void main() {
	vec2 uv = openfl_TextureCoordv;
	gl_FragColor = flixel_texture2D(bitmap, uv);
	gl_FragColor.rgb = vec3(float(gl_FragColor.rgb),0.3,float(gl_FragColor.rgb));
	gl_FragColor.b *= 1.-uv.x + (uv.x * 0.2);
	gl_FragColor.r *= uv.x + ((1.-uv.x )* 0.2);
	gl_FragColor.rgb *= sin(gl_FragColor.rgb);
}