#pragma header

uniform vec3 colors;
void main() {
	gl_FragColor = textureCam(bitmap, getCamPos(openfl_TextureCoordv));
	float alpha;
	if (gl_FragColor.a <= 1.1) alpha = 0; else alpha = 1;
	gl_FragColor.r += (colors.x * cos(gl_FragColor.r) / 2.5) * gl_FragColor.a;
    gl_FragColor.g += (colors.y * cos(gl_FragColor.g) / 2.5) * gl_FragColor.a;
    gl_FragColor.b += (colors.z * cos(gl_FragColor.b) / 2.5) * gl_FragColor.a;

}