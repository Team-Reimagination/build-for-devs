uniform float iTime;
#pragma header
void main() {
	vec2 uv = openfl_TextureCoordv;
	gl_FragColor = flixel_texture2D(bitmap, uv);
	uv.x += sin((floor(uv.y * 100) / 50)*60.0+iTime)/((1.5-float(gl_FragColor.rgb)) * 500);
	gl_FragColor = flixel_texture2D(bitmap, uv);
}