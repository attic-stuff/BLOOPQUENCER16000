attribute vec3 in_Position;
attribute vec4 in_Colour;
attribute vec2 in_TextureCoord;

varying vec2 texturecoordinate;
varying vec4 vertexcolor;

void main()	{
	vec4 position = vec4(in_Position.xyz, 1.0);
	gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * position;
	texturecoordinate = in_TextureCoord;
	vertexcolor = in_Colour;
}
