function len(r,R,d)
a=R-sqrt(R^2-r^2);
alpha=asin(r/R);
[q1, q2]=arc([d-R 0],R,alpha,-alpha);
plot(q1,q2,'color','r','linewidth',2);

line([0 d-a],[r r],'color','r','linewidth',2);
line([0 0],[r -r],'color','r','linewidth',2);
line([0 d-a],[-r -r],'color','r','linewidth',2);
end