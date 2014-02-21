%config type variables
N = 20;
numIterations = 10;
epsilon = 10^(-5);

load('HW4data.mat');

%This is used as a reference
%http://socserv.mcmaster.ca/jfox/Courses/UCLA/logistic-regression-notes.pdf

dataSize = size(features); 
numDataPoints = dataSize(1);
d = dataSize(2) + 1; %number of features
all_data = [features ones(numDataPoints,1)]; %adds the intercept term
data = all_data(1:N,:);


b0 = zeros(d,1); %initial term for convergence
b_current = b0;
%b_history = zeros(d,numIterations+1);
%b_history(:,1) = b0;

for iteration = 1:numIterations
    
    %vector of fitted response probabilities
    pVector = zeros(N,1);
    for row = 1:N
        dotProd = dot( b_current, data(row,:) );
        pVecDenom = 1 + exp(-1*dotProd);
       pVector(row) = 1/pVecDenom; 
    end

    %diffVector is the difference between y and the fitted response
    %   probabilities
    diffVector = labels(1:N,:)-pVector;

    %vMatrix is a diagonal matrix where each entry is p(1-p)
    vMatrix = diag(pVector.*(1-pVector));

    %this is X'V*X
    hessian = (data')*vMatrix*data;

    b_change = inv(hessian)*(data')*diffVector;

    b_current = b_current - b_change; 
    
    totalChange = sum(abs(b_change));
    if(totalChange < N*epsilon)
        break;
    end

end