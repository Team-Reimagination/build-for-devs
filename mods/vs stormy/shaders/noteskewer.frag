#pragma header
uniform float skew;
void main() {
	vec2 uv = openfl_TextureCoordv;
	uv.x += skew * (1-uv.y);
	gl_FragColor = flixel_texture2D(bitmap, uv);
}