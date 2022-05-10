function len(r,R,d)
a=R-sqrt(R^2-r^2);
alpha=asin(r/R);
[q1,q2]=arc([R 0],R,pi-alpha,pi+alpha);
plot(q1,q2,'color','r','linewidth',2);

line([a d d a],[r r -r -r],'color','r','linewidth',2);
end