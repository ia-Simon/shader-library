#version 330

uniform vec2 uResolution;
uniform float uTime;

const float zoom = 200;
const float yTrans = 0.25;
const float xTrans = -0.9024;
const uint iterAmt = 1000u;

const uint colorAmt = 10u;
const vec3[colorAmt] colors = vec3[](
	vec3(0.988,0.012,0.012),
	vec3(0.988,0.435,0.012),
	vec3(0.988,0.694,0.012),
	vec3(0.988,0.941,0.012),
	vec3(0.694,0.988,0.012),
	vec3(0.482,0.988,0.012),
	vec3(0.012,0.988,0.059),
	vec3(0.012,0.988,0.533),
	vec3(0.012,0.988,0.776),
	vec3(0.012,0.663,0.988)
);

void main()
{	
    float mx = max(uResolution.x, uResolution.y);
    vec2 normFragCoord = gl_FragCoord.xy - (uResolution.xy / 2.);
    
  	if (
  		normFragCoord == vec2(0)
  		|| normFragCoord == vec2(0,1)
  		|| normFragCoord == vec2(0,2)
  		|| normFragCoord == vec2(0,-1)
  		|| normFragCoord == vec2(0,-2)
  		|| normFragCoord == vec2(1,0)
  		|| normFragCoord == vec2(2,0)
  		|| normFragCoord == vec2(-1,0)
  		|| normFragCoord == vec2(-2,0)
  	) {
    	gl_FragColor = vec4(0.2, 0.2, 1.0, 1.0);
    	return;
    }
   
    vec2 c = (normFragCoord / zoom) + vec2(xTrans, yTrans);
    vec2 z = vec2(0);
    uint count;
    for(count = 0u; count < iterAmt; count++) {
    	vec2 zSq = vec2(pow(z.x, 2.) + (pow(z.y, 2.)*-1), 2*z.x*z.y);
    
    	vec2 res = zSq + c;
    	float magnitude = distance(res, vec2(0));
    	
    	if(magnitude > 2) break;
    	z = res;
    }
    
    vec3 color = count == iterAmt 
    	? vec3(0.012)
    	: colors[uint(mod(count, colorAmt))];
    gl_FragColor = vec4(color, 1.0);
}