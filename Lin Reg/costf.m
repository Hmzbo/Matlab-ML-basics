function r= costf(dv,t1,t2,x,y)

l=length(x);
s=0;
if dv==0
    for i=1:l
        s= s + (hypf(dv,t1,t2,x(i))-y(i))^2;
    end
    r=0.5*(1/l)*s;

elseif dv ==1
    for i=1:l
        s= s + hypf(dv,t1,t2,x(i))*(hypf(0,t1,t2,x(i))-y(i));
    end
    r=(1/l)*s;
elseif dv ==2
    for i=1:l
        s=s + hypf(dv,t1,t2,x(i))*(hypf(0,t1,t2,x(i))-y(i));
    end
    r=(1/l)*s;
end
