probPart = 2;

if(probPart == 1)
    r_1 = 8;
    r_2 = 1;
    r_3 = 1;
elseif(probPart == 2)
    r_1 = 1;
    r_2 = 18;
    r_3 = 1;   
end

%The code here will be used as a model
%   http://www.mathworks.com/help/matlab/ref/contour.html

theta_1 = linspace(0,1);
theta_2 = linspace(0,1);
[THETA_1,THETA_2] = meshgrid(theta_1,theta_2);
THETA_3 = 1-(THETA_1+THETA_2);
sizeVector = size(THETA_3);
THETA_3(THETA_3<0) = 0;

for part = 1:4,
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
   
    P_THETA = (THETA_1.^(r_1 + alpha_1-1))...
        .*(THETA_2.^(r_2 + alpha_2-1))...
        .*(THETA_3.^(r_3 + alpha_3-1));
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
    
    subplot(2,2,part);
    contour(THETA_1,THETA_2,P_THETA)
    title(strcat('(alpha_1,alpha_2,alpha_3) = (',num2str(alpha_1),',',...
        num2str(alpha_2),',',num2str(alpha_3),')'));
    xlabel('theta_1');
    ylabel('theta_2');
    
    beta = alpha_1 + alpha_2 + alpha_3 + r_1 + r_2 + r_3;
    mean_alpha1 = (alpha_1+r_1)/beta;
    mean_alpha2 = (alpha_2+r_2)/beta;
    mean_alpha3 = (alpha_3+r_3)/beta;

    var_alpha1 = (alpha_1+r_1)*(beta - (alpha_1+r_1))/(beta^2*(beta+1));
    var_alpha2 = (alpha_2+r_2)*(beta - (alpha_2+r_2))/(beta^2*(beta+1));
    var_alpha3 = (alpha_3+r_3)*(beta - (alpha_3+r_3))/(beta^2*(beta+1));
    
    meanVec = [mean_alpha1 mean_alpha2 mean_alpha3]
    varianceVec = [var_alpha1 var_alpha2 var_alpha3]
    
end



