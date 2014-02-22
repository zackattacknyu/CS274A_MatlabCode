%config type variables
N = 100;
numIterations = 100;
epsilon = 10^(-5);
load('HW4data.mat');

dataSize = size(features); 
numDataPoints = dataSize(1);
d = dataSize(2) + 1; %number of features
all_data = [features ones(numDataPoints,1)]; %adds the intercept term
data = all_data(1:N,:);
minError = N*epsilon;
test_data = all_data(1001:2000,:);


b0 = zeros(d,1); %initial term for convergence
b_current = b0;
%b_history = zeros(d,numIterations+1);
%b_history(:,1) = b0;
trainingAccuracy = zeros(numIterations,1);
testAccuracy = zeros(numIterations,1);

for iteration = 1:numIterations
    
    %vector of fitted response probabilities
    pVector = zeros(N,1);
    for row = 1:N
        currentDataRow = data(row,:);
        dotProd = dot( b_current, currentDataRow );
        pVecDenom = 1 + exp(-1*dotProd);
        pVector(row) = 1/pVecDenom; 
    end

    %diffVector is the difference between y and the fitted response
    %   probabilities
    diffVector = labels(1:N,:)-pVector;

    %vMatrix is a diagonal matrix where each entry is p(1-p)
    vMatrix = diag(pVector.*(1-pVector));

    %this is X'V*X
    hessian = (transpose(data))*vMatrix*data;

    b_change = inv(hessian)*(transpose(data))*diffVector;
    
    b_current = b_current + b_change; 
    
    %find the classification accuracy for training data
    numAccurate = 0;
    currentClassification = 0;
    for row = 1:N
        currentDataRow = data(row,:);
        if( dot(currentDataRow,b_current) > 0)
           currentClassification = 1; 
        else
           currentClassification = 0;
        end
        if(labels(row) == currentClassification)
           numAccurate = numAccurate + 1; 
        end
    end
    currentAccuracy = numAccurate/N;
    trainingAccuracy(iteration) = currentAccuracy;
    
    %find the classification accuracy for test data
    numAccurate = 0;
    currentClassification = 0;
    for row = 1:1000
        currentDataRow = test_data(row,:);
        if( dot(currentDataRow,b_current) > 0)
           currentClassification = 1; 
        else
           currentClassification = 0;
        end
        if(labels(row + 1000) == currentClassification)
           numAccurate = numAccurate + 1; 
        end
    end
    currentAccuracy = numAccurate/(1000);
    testAccuracy(iteration) = currentAccuracy;
    
    
    totalChange = sum(abs(b_change));
    if(totalChange < minError)
        break;
    end

end