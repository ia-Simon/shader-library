#version 330

uniform vec2 uResolution;
uniform float uTime;


void main()
{	
    vec2 p=(FC.xy*2.-r)/r.y/.7,d=vec2(-1,1),c=p*mat2(1,1,d/(.1+5./dot(5.*p-d,5.*p-d))),v=c;v*=mat2(cos(log(length(v))+t*.2+vec4(0,33,11,0)))*5.;for(float i;i++<9.;o+=sin(v.xyyx)+1.)v+=.7*sin(v.yx*i+t)/i+.5;o=1.-exp(-exp(c.x*vec4(.6,-.4,-1,0))/o/(.1+.1*pow(length(sin(v/.3)*.2+c*vec2(1,2))-1.,2.))/(1.+7.*exp(.3*c.y-dot(c,c)))/(.03+abs(length(p)-.7))*.2);
}
