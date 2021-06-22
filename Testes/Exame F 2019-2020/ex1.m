function ex1()
clear all
close all
gama=2;
for n=1: 1e4
    x(n)=fex1(gama);     
end
[hx,xh]=hist(x,20);
hx=hx/(sum(hx)*(xh(2)-xh(1)));
xp=linspace(0,1,100);
px=(gama+1)*xp.^gama;
plot(xh,hx,'+',xp,px,'r-')
ylabel('pX'); xlabel('x')
end

function x=fex1(gama)
x=rand(1)^(1/(gama+1));
end
 