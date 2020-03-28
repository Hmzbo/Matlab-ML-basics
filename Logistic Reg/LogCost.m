function [j,grad] = LogCost(theta,x,y,lambda)
% This function calculates and returns the value of the cost function and
% its partial derivatives
m=length(y);
j=0;
grad=zeros(size(theta,1),1);
% Value of J(theta)

j=-(1/m)*sum(y.*log(hyp(theta,x))+(1-y).*log(1-hyp(theta,x)))+...
    lambda/(2*m)*sum(theta(2:end).^2);

% Value of the gradient of J

grad(1)=(1/m).*sum(hyp(theta,x)-y);
grad(2:end)=(1/m)*sum((hyp(theta,x)-y).*x(:,2:end))'+(lambda/m)*theta(2:end);

end

