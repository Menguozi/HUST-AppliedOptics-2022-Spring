% º¯Êý£º»­Í¸¾µ×éºÏ
function lens(h,R1,R2,d)
a=R1-sqrt(R1^2-h^2);
alpha=asin(h/R1);
[q1, q2]=arc([R1 0],R1,pi-alpha,pi+alpha);
plot(q1,q2,'color','r','linewidth',2);

line([a d],[h h],'color','r','linewidth',2);
line([d d],[h -h],'color','r','linewidth',2);
line([a d],[-h -h],'color','r','linewidth',2);

hold on;

alpha=asin(h/R2);
[q1, q2]=arc([d+1+R2 0],R2,pi-alpha,pi+alpha);
plot(q1,q2,'color','r','linewidth',2);

b=R2-sqrt(R2^2-h^2);
line([d+1+b 2*d+1],[h h],'color','r','linewidth',2);
line([2*d+1 2*d+1],[h -h],'color','r','linewidth',2);
line([d+1+b 2*d+1],[-h -h],'color','r','linewidth',2);
end