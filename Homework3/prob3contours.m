%{

1. alpha_1 = alpha_2 = alpha_3 = 1.
2. alpha_1 = alpha_2 = alpha_3 = 10.
3. alpha_1 = alpha_2 = alpha_3 = 0.1.
4. alpha_1 = 8; alpha_2 = 1; alpha_3 = 1

%}

theta_1 = 0:1/100:1;
theta_2 = 0:1/100:1;
%{
%For Part 4
alpha_1 = 8;
alpha_2 = 1;
alpha_3 = 1;

%For Part 3
alpha_1 = 0.1;
alpha_2 = 0.1;
alpha_3 = 0.1;
%}
%For Part 2
alpha_1 = 10;
alpha_2 = 10;
alpha_3 = 10;
%{
%For Part 1
alpha_1 = 1;
alpha_2 = 1;
alpha_3 = 1;
%}
p_theta = eye(101);

%for Part 1 Data
r_1 = 8;
r_2 = 1;
r_3 = 1;

%for Part 2 Data
%{
r_1 = 1;
r_2 = 18;
r_3 = 1;
%}
for row = 1:101,
   for col = 1:101,
       theta_1_current = theta_1(row);
       theta_2_current = theta_2(col);
       theta_3_current = 1- (theta_1_current + theta_2_current);
       
       %does the normal likelihood
       %{
      p_theta(row,col) = theta_1_current^(alpha_1-1)*...
          theta_2_current^(alpha_2-1)*...
          theta_3_current^(alpha_3-1);
       %}
      
      %does the log-likelihood
      p_theta(row,col) = (r_1 + alpha_1-1)*log(theta_1_current)+...
          (r_2 + alpha_2-1)*log(theta_2_current)+...
          (r_3 + alpha_3-1)*log(theta_3_current);
      
   end
end

contour(theta_2,theta_1,p_theta)