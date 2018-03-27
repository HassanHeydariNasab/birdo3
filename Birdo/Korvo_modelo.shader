shader_type spatial;

varying vec3 color;

void vertex() {
	color = NORMAL;
	vec4 worldPos = WORLD_MATRIX[3];
	float speed = 0.5;
	float strength = 0.12;
	float detail = 0.8;
	vec2 direction = vec2(1.0, 0.0);
	float time = TIME * speed + worldPos.x + worldPos.z;
	float wind = (sin(time) + cos(time * detail)) * strength;
	//VERTEX.yz += sin(TIME*16.0)/100.0;
	VERTEX.yz += vec2(wind * direction.x, wind * direction.y)/10.0;
}
void fragment() {
	ALBEDO = (color+vec3(0.5,-0.2,2.0))/8.0;
}