syms x;
y = piecewise(x<-3,-1,-3<x<0,0,0<x<3,3*x,x>3,exp(-2.5*x));
fplot(x,y);
grid on