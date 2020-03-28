function hx =  hypf(dv,theta1, theta2,x)

if dv==0
    hx= theta1 +theta2.*x ;
elseif dv==1
    hx=1;
elseif dv==2
    hx=x;
end
end