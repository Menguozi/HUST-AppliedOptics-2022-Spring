R=63.206;
d=7.2;
r=16;
n1=1.0;
n2=1.51680;
n3=1.0;
EFL=116;
y0=0;
u0=EFL;
v0=EFL+d;
yy0=0;

figure(1)
title('Optic System Layout')
len(16,R,d);

N=33;
deltax=zeros(1,N);
deltay=zeros(1,N);
syms x1 x2
f1=R^2-(x2^2+(x1-R)^2);
f2=0*x2+x1-d;

a=-16;
b=16;
for i=a:1:b
    p1=[-100,i];% 光线起始点 Ray starting point
    
    % 第一面 First face
    k=n1*[1,0];% 入射光线法向量
    p=p1;% 
    F1=@(x)[k(1)*(x(2)-p(2))-k(2)*(x(1)-p(1));R^2-(x(2)^2+(x(1)-R)^2)];% 入射光线方程，折射面方程
    p2=fsolve(F1,[0,y0]);% 联立方程组数值法求解入射点
    
    w=double(subs(gradient(f1),[x1 x2],p2));% 
    w=w/sqrt(w'*w);%标准化
    G1=k*w;%
    G2=sqrt(n2^2-n1^2+G1^2);% 
    k=k+(G2-G1)*w';% 折射光线法向量
    p=p2;
    F2=@(x)[k(1)*(x(2)-p(2))-k(2)*(x(1)-p(1));0*x(2)+x(1)-d];
    p3=fsolve(F2,[d y0]);
    
    I=atan(k(2)/k(1));
    U=asin(sin(I)*n2/n3);
    k=n3*[cos(U),sin(U)];
    x0=v0;%p4位置初始化
    p4=[x0,k(2)*(x0-p3(1))/k(1)+p3(2)];
    
    deltay(i+17)=p4(2)-yy0;
    deltax(i+17)=-p3(2)*k(1)/k(2)+p3(1)-v0;%收集数据
    
    line([p1(1) p2(1) p3(1) p4(1)],[p1(2) p2(2) p3(2) p4(2)]);
end
clc;
max(deltay)
figure(2)
title('spot diagrams')
for j=1:1:17
    i=-pi:pi/12:pi;
    y=abs(deltay(j))*sin(i);
    x=abs(deltay(j))*cos(i);
    scatter(x,y,'+','b');
    hold on;
end
