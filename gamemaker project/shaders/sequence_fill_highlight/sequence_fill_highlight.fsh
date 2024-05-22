varying vec2 texturecoordinate;
varying vec4 vertexcolor;

void main() {
	vec4 color = texture2D(gm_BaseTexture, texturecoordinate);
	color.rgb = mix(color.rgb, vertexcolor.rgb, float(color.r == 1.0));
	gl_FragColor = color;
}