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

for row = 1:101,
   for col = 1:101,
       theta_1_current = theta_1(row);
       theta_2_current = theta_2(col);
       theta_3_current = 1- (theta_1_current + theta_2_current);
       
       %MAKE SURE THERE ARE NO VALUES
       %    WHERE THETA_3 < 0
       %
       %ALSO USE MESHGRID TO GENERATE THE FUNCTIONS
       
       %does the normal likelihood
       
       if(theta_3_current >= 0)
           p_theta(row,col) = theta_1_current^(alpha_1-1)*...
                theta_2_current^(alpha_2-1)*...
                theta_3_current^(alpha_3-1);
       else
           p_theta(row,col) = 0;
       end
      
       
      
      %does the log-likelihood
      %{
      p_theta(row,col) = (alpha_1-1)*log(theta_1_current)+...
          (alpha_2-1)*log(theta_2_current)+...
          (alpha_3-1)*log(theta_3_current);
      %}
      
   end
end

contour(theta_2,theta_1,p_theta)