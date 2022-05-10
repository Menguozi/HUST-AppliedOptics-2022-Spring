a=50;
b=200;
step=10;
N=(b-a)/step+1;
[X,Y] = meshgrid(a:step:b);
Z=zeros(N,N);
for i=1:1:N
    for j=1:1:N
        Z(i,j)=f(X(i,j),Y(i,j));
    end
end
contour3(X,Y,Z,50);
[r,c]=find(Z==min(min(Z)));
C1=X(r,c)
C2=Y(r,c)
min_geo=Z(r,c)

% step=1;
% N=11;
% [X,Y] = meshgrid(165:1:175,95:1:105);
% Z=zeros(N,N);
% for i=1:1:N
%     for j=1:1:N
%         Z(i,j)=f(X(i,j),Y(i,j));
%     end
% end
% contour3(X,Y,Z,50);
% [r,c]=find(Z==min(min(Z)));
% C1=X(r,c)
% C2=Y(r,c)
% min_geo=Z(r,c)

% step=0.1;
% N=11;
% [X,Y] = meshgrid(164.5:0.1:165.5,101.5:0.1:102.5);
% Z=zeros(N,N);
% for i=1:1:N
%     for j=1:1:N
%         Z(i,j)=f(X(i,j),Y(i,j));
%     end
% end
% contour3(X,Y,Z,50);
% [r,c]=find(Z==min(min(Z)));
% C1=X(r,c)
% C2=Y(r,c)
% min_geo=Z(r,c)

% step=0.01;
% N=11;
% [X,Y] = meshgrid(164.75:0.01:164.85,102.05:0.01:102.15);
% Z=zeros(N,N);
% for i=1:1:N
%     for j=1:1:N
%         Z(i,j)=f(X(i,j),Y(i,j));
%     end
% end
% contour3(X,Y,Z,50);
% [r,c]=find(Z==min(min(Z)));
% C1=X(r,c)
% C2=Y(r,c)
% min_geo=Z(r,c)