function [theta_op,Theta,J] = GradDesc(alpha,X,y,max_it)
% This functio perform the gradient descent algorithm and returns the
% solution as well as the history of calculations of theta and J(theta)
m=length(y);
Theta=zeros(3,1); theta_op=zeros(3,1); i=1;
Tol=10^-10; error=1; lambda=0;
[J,~]=LogCost(theta_op,X,y,lambda);

while (i<max_it) %&& (error>Tol)
%[~,grad]=LogCost(theta_op,X,y);  
theta_op=theta_op-(alpha/m)*sum((hyp(theta_op,X)-y).*X)';
Theta=[Theta theta_op];
[j,~]=LogCost(theta_op,X,y,lambda);
J=[J j];
error=abs(J(i+1)-J(i));
i=i+1;
end

end

