#version 330

uniform vec2 uResolution;
uniform float uTime;

const float zoom = 100;
const float yTrans = 0.1;
const float xTrans = -0.767;

const int iterAmt = 12;
const vec3 color1 = vec3(0.149,0.141,0.912);
const vec3 color2 = vec3(1.000,0.833,0.224);

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
    	gl_FragColor = vec4(1.0);
    	return;
    }
   
    vec2 c = (normFragCoord / zoom) + vec2(xTrans, yTrans);
    vec2 z = vec2(0);
    int count;
    for(count = 0; count < iterAmt; count++) {
    	vec2 zSq = vec2(pow(z.x, 2.) + (pow(z.y, 2.)*-1), 2*z.x*z.y);
    
    	vec2 res = zSq + c;
    	float magnitude = distance(res, vec2(0));
    	
    	if(magnitude > 2) break;
    	z = res;
    }
    
    vec3 color = mix(color1, color2, count / iterAmt);
    gl_FragColor = vec4(color, 1.0);
}