%{

1. alpha_1 = alpha_2 = alpha_3 = 1.
2. alpha_1 = alpha_2 = alpha_3 = 10.
3. alpha_1 = alpha_2 = alpha_3 = 0.1.
4. alpha_1 = 8; alpha_2 = 1; alpha_3 = 1

%}

part = 4;

if(part == 4)
    alpha_1 = 8;
    alpha_2 = 1;
    alpha_3 = 1;
elseif(part == 3)
    alpha_1 = 0.1;
    alpha_2 = 0.1;
    alpha_3 = 0.1;    
elseif(part == 2)
    alpha_1 = 10;
    alpha_2 = 10;
    alpha_3 = 10;
elseif(part == 1)
    alpha_1 = 1;
    alpha_2 = 1;
    alpha_3 = 1;
end

%The code from this web site was used as a model
%   http://www.mathworks.com/help/matlab/ref/contour.html
%

%generates the theta_1, theta_2 matrices to be used in computation
theta_1 = linspace(0,1);
theta_2 = linspace(0,1);
[THETA_1,THETA_2] = meshgrid(theta_1,theta_2);

%generates the theta_3 matrix
THETA_3 = 1-(THETA_1+THETA_2);
sizeVector = size(THETA_3);
THETA_3(THETA_3<0) = 0; %ensures negative values are not used

%calculates out p_theta
P_THETA = (THETA_1.^(alpha_1-1))...
    .*(THETA_2.^(alpha_2-1))...
    .*(THETA_3.^(alpha_3-1));

%In Matlab, 0^0 = 1, however if theta_1, theta_2, or theta_3 = 0
%   then we want the probability to be zero, 
%   so we ensure that it occurs with this loop
%   over all the matrix elements
for row = 1:sizeVector(1),
   for col = 1:sizeVector(2),
       
       if(THETA_1(row,col) <= 0)
         P_THETA(row,col) = 0; 
       end
       
      if(THETA_2(row,col) <= 0)
         P_THETA(row,col) = 0; 
      end
      
      if(THETA_3(row,col) <= 0)
         P_THETA(row,col) = 0; 
      end
   end
end

%calculates the mean and variance of the prior
beta = alpha_1 + alpha_2 + alpha_3;

mean_alpha1 = alpha_1/beta;
mean_alpha2 = alpha_2/beta;
mean_alpha3 = alpha_3/beta;

var_alpha1 = alpha_1*(beta - alpha_1)/(beta^2*(beta+1));
var_alpha2 = alpha_2*(beta - alpha_2)/(beta^2*(beta+1));
var_alpha3 = alpha_3*(beta - alpha_3)/(beta^2*(beta+1));


%plot out the contours for p_theta
contour(THETA_1,THETA_2,P_THETA)