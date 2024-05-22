varying vec2 texturecoordinate;
varying vec4 vertexcolor;

const vec3 outline_color = vec3(8.0, 8.0, 8.0)  / 255.0;
const vec2 surface_texel_dimension = vec2(1.0 / 308.0, 1.0 / 280.0);

void main() {
	vec4 color = texture2D(gm_BaseTexture, texturecoordinate);
	vec2 offsets[8];
	offsets[0] = vec2(1.0, 0.0);
	offsets[1] = vec2(1.0, -1.0);
	offsets[2] = vec2(0.0, -1.0);
	offsets[3] = vec2(-1.0, -1.0);
	offsets[4] = vec2(-1.0, 0.0);
	offsets[5] = vec2(-1.0, 1.0);
	offsets[6] = vec2(0.0, 1.0);
	offsets[7] = vec2(1.0, 1.0);
	float alpha = 0.0;
	for (int i = 0; i < 8; i++) {
		alpha = alpha + texture2D(gm_BaseTexture, texturecoordinate + (offsets[i] * surface_texel_dimension)).a;
	}
	if (color.a == 0.0 && alpha > 0.0) {
		color = vec4(outline_color, 1.0);
	}
	gl_FragColor = color;
}