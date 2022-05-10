R1=164.81;% 第一面曲率半径
R2=102.1;% 第二面曲率半径
d=7;% 透镜厚度
r=16;% 孔径（半径）
n1=1.0;% 空气折射率
n2=1.51680;% BK7玻璃透镜对d波长光折射率
n3=1.0;% 空气折射率
EFL=116+2*d+1;% 有效焦距长度
y0=0;% 光轴纵坐标
v0=EFL;% 像面横坐标
yy0=0;

figure(1)
lens(16,R1,R2,d);
line([v0 v0],[5 -5],'color','r','linewidth',2);
title('Optic System Layout')
s1="(R1="+R1+"mm, R2="+R2+"mm)";
xlabel(s1);

N=33;
deltax=zeros(1,N);
deltay=zeros(1,N);
syms x1 x2
f1=R1^2-(x2^2+(x1-R1)^2);% C1面轨迹方程
f2=0*x2+x1-d;% C2面轨迹方程
f3=R2^2-(x2^2+(x1-d-1-R2)^2);% C3面轨迹方程
f4=0*x2+x1-d-1-d;% C4面轨迹方程

a=-16;
b=16;
for i=a:1:b
    p1=[0,i];% 光线出发点
    
    k=n1*[1,0];% 入射光线法向量
    % 联立入射光线和C1面轨迹方程数值法求解C1面投射点
    p=p1;
    F1=@(x)[k(1)*(x(2)-p(2))-k(2)*(x(1)-p(1));R1^2-(x(2)^2+(x(1)-R1)^2)];
    p2=fsolve(F1,[0,y0]);% C1面投射点
    
    w=double(subs(gradient(f1),[x1 x2],p2));% C1面投射点法向量
    w=w/sqrt(w'*w);% 标准化
    G1=k*w;
    G2=sqrt(n2^2-n1^2+G1^2);
    k=k+(G2-G1)*w';% C1面出射光线法向量
    % 联立C1面折射光线和C2面轨迹方程数值法求解C2面投射点
    p=p2;
    F2=@(x)[k(1)*(x(2)-p(2))-k(2)*(x(1)-p(1));0*x(2)+x(1)-d];
    p3=fsolve(F2,[d y0]);% C2面投射点
    
    I=atan(k(2)/k(1));% C2面入射角
    U=asin(sin(I)*n2/n3);% C2面折射角
    k=n3*[cos(U),sin(U)];% C2面折射光线法向量
    % 联立C2面折射光线和C3面轨迹方程数值法求解C3面投射点
    p=p3;
    F3=@(x)[k(1)*(x(2)-p(2))-k(2)*(x(1)-p(1));R2^2-(x(2)^2+(x(1)-R2-1-d)^2)];
    p4=fsolve(F3,[1+d y0]);% C3面投射点
    
    e=double(subs(gradient(f3),[x1 x2],p4));% C3面投射点法向量
    e=e/sqrt(e'*e);%标准化
    G1=k*e;
    G2=sqrt(n2^2-n1^2+G1^2);
    k=k+(G2-G1)*e';% C3面折射光线法向量
    % 联立C3面折射光线和C4面轨迹方程数值法求解C4面投射点
    p=p4;
    F4=@(x)[k(1)*(x(2)-p(2))-k(2)*(x(1)-p(1));0*x(2)+x(1)-d-1-d];
    p5=fsolve(F4,[2*d+1 y0]);
    clc;
    
    I=atan(k(2)/k(1));% C4面入射角
    U=asin(sin(I)*n2/n3);% C4面折射角
    k=n3*[cos(U),sin(U)];% C4面折射光线法向量
    x0=v0;%p4位置初始化
    p6=[x0,k(2)*(x0-p5(1))/k(1)+p5(2)];
    deltay(i+17)=p6(2)-yy0;
    deltax(i+17)=-p5(2)*k(1)/k(2)+p5(1)-v0;%收集数据
    
    line([p1(1) p2(1) p3(1) p4(1) p5(1) p6(1)],[p1(2) p2(2) p3(2) p4(2) p5(2) p6(2)]);
end
deltay=deltay*1000;
max(deltay)
figure(2)
for j=1:1:17
    i=-pi:pi/12:pi;
    x=abs(deltay(j))*sin(i);
    y=abs(deltay(j))*cos(i);
    scatter(x,y,'+','red');
    hold on;
end
title("Spot Diagram");
s2="Geometrical radius = "+max(deltay)+"um";
xlabel(s2)
