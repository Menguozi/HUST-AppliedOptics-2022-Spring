function [x y]=arc(a,R,alpha,beta)
phi=linspace(alpha,beta);
x=a(1)+R*cos(phi);
y=a(2)+R*sin(phi);
end
