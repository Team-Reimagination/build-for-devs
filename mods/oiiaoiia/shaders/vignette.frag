#pragma header
void main() {
	vec2 uv = openfl_TextureCoordv;
	gl_FragColor = texture2D(bitmap, uv);
	gl_FragColor.rgb -= vec3(abs(uv.x - 0.5) + abs(uv.y - 0.5));
}