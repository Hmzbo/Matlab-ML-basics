%%%%%%%% Linear Regression Univariable Using Gradient Descent Alg. %%%%%%%%
% clear all
clf
clc
% Dataset of house prices 

% x is the area of the house in square foot
% x=[1000 1100 1100 1100 1200 1200 1300 1300 1300 1400 1400 1400 1400 ... 
%    1500 1500 1600 1600 1600 1700 1700 1800 1800 1900 1900 1900 2000 ...
%    2000 2100 2100 2200 2300];
% Scaling the data: (x-mean(x))/range(x)

% y is the price of the house in 1000$
% y=[210 250 265 240 290 300 320 325 322 380 360 395 410 590 615 700 ...
%    695 720 795 812 880 872 950 967 988 1060 1090 1190 1198 1350 1550];

% Dataset of salary estimation with respect to year of experience
D = csvread('Salary_Data.csv');
x=D(:,1); y=D(:,2);

% Data Scaling
xs=(x-mean(x))/(max(x)-min(x));

Maxit=500;                                                                  % Max nbr of Iteration
THETA=zeros(Maxit,2);                                                       % Storage of (theta_1,theta_2)for each 
                                                                            % iteration

%Data distribution figure
% figure(1)
% scatter(xr,y)

%%%%%%%%%%%%% Gradient Descent %%%%%%%%%%%%%

% Initialization
theta1=1; theta2=1;                                                         % Initialization of theta_1, theta2  
Tol=10^-6; j=1;                                                             % Tol: Tolerance var, j: Ite. counter
alpha=0.6;                                                                  % alpha: learning coefficient                       
init_cost=costf(0,theta1,theta2,xs,y);                                      % Initial cost function value
err=1;                                                                      % Error inititalization

% Set up of the figure to represent the evolution of the GD
figure(1)
set(gcf, 'Position',  [100, 100, 1700, 450])
 
while norm(err)-Tol>0 && j<Maxit+1
    
    theta1_save=theta1; theta2_save=theta2; 
    theta1_temp=theta1-alpha*costf(1,theta1,theta2,xs,y);
    theta2_temp=theta2-alpha*costf(2,theta1,theta2,xs,y);
    theta1=theta1_temp;
    theta2=theta2_temp;
    THETA(j,:)=[theta1,theta2];
    ty=costf(0,theta1,theta2,xs,y);
    err=ty-init_cost;                                                       % Error calculation
    init_cost=ty;
    
    % Plotting of the evolution of the costfunction in every iteration
    figure(1)
    subplot(1,3,1)
    title('Cost function value on (\theta_1,\theta_2) evolution')
    plot(log(j),log(ty),'b.')
    hold on
    % pause(0.1)
    
    % Plotting of the updated hypothesis function "hypf" in each iteration
    subplot(1,3,2)
    title('Evolution of the hyp. function with respect to each iteration')
    scatter(xs,y)
    hold on
    xx=floor(min(xs)):0.2:ceil(max(xs));
    yy=hypf(0,theta1,theta2,xx);
    plot(xx,yy)
    hold off                                                                % Overwrite the previous hyp. fun.
     %pause(0.2)                    
    
    % Plotting of the evolution of the error in every iteration
    subplot(1,3,3)
    title('Evolution of the error with respect to each iteration')
    plot(log(j),log(norm(err)),'r.')
    hold on
    % pause(0.1)
    j=j+1;
end

NbrIt=j-1                                                                   %Total nbr of ite. until conv.

% Plot of the contour of the cost fun. with the calculated steps of the GD
figure(2)                                                                   % Creation of a new figure
title('Evolution of the GD output with respect to each iteration')
view(2)                                                                     % Vertical Point Of View

step=(max(THETA(:,1))+max(THETA(:,2)))/1000;
t1=linspace(min(THETA(:,1))-10*step,max(THETA(:,1))+10*step,step);
t2=linspace(min(THETA(:,2))-10*step,max(THETA(:,2))+10*step,step);          % Generation of the grid
z=zeros(length(t1));
[T1,T2]=meshgrid(t1,t2);

for j=1:length(t1)                                                          % Calculation of the cost fun.
    for k=1:length(t1)
        z(j,k)=costf(0,t1(k),t2(j),xs,y);
    end 
end
contour3(T1,T2,z,50)                                                        % Contour plot of the cost fun.
hold on
for k=1:NbrIt                                                               % Plotting of the GD steps.
    view(2)
   plot3(THETA(k,1),THETA(k,2),costf(0,THETA(k,1),THETA(k,2),xs,y),'xb');
end

figure(3)                                                                   % plotting of the results after de-scaling the data
scatter(x,y)
hold on
xx=linspace(floor(min(xs)),ceil(max(xs)),11);
plot((xx.*(max(x)-min(x)))+mean(x),yy)

% Calculation of the analytical solution (normal equation)

X=[ones(size(x,1),1),xs];
Ana_Theta= (X'*X)\(X'*y);
NumAnaErr=0.5*norm(Ana_Theta-[THETA(NbrIt,1);THETA(NbrIt,2)])


% Plotting of analytic solution VS Calculated solution
T=[Ana_Theta,[THETA(NbrIt,1);THETA(NbrIt,2)]];
step2=(max(T(1,:))+max(T(2,:)))/100;
t11=linspace(min(T(1,:))-0.5*step,max(T(1,:))+0.5*step,step);
t22=linspace(min(T(2,:))-0.5*step,max(T(2,:))+0.5*step,step);         
z=zeros(length(t11));
[TT1,TT2]=meshgrid(t11,t22);                                                 % Generation of the grid
for j=1:length(t11)                                                          % Calculation of the cost fun.
    for k=1:length(t11)
        z(j,k)=costf(0,t11(k),t22(j),xs,y);
    end 
end

figure (4)
contour3(TT1,TT2,z,50)
hold on

Z=[costf(0,T(1,1),T(2,1),xs,y);costf(0,T(1,2),T(2,2),xs,y)];
plot3(T(1,1),T(2,1),Z(1),'g*')
plot3(T(1,2),T(2,2),Z(2),'r*')
legend('cost function contour','Analytic solution','Calculated solution')