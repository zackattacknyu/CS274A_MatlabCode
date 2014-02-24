%config type variables
N = 50;
numIterations = 50;
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
trainingAccuracy = [];
testAccuracy = [];

trainingLogLikelihood = [];
testLogLikelihood = [];

firstWeight = [0];
secondWeight = [0];
lastWeight = [0];


%get the initial accuracies
trainingAccuracy = [trainingAccuracy getAccuracy(data(1:N,:),labels(1:N),b_current)];
testAccuracy = [testAccuracy getAccuracy(test_data(1:1000,:),labels(1001:2000),b_current)];

%get the initial log likelihoods
trainingLogLikelihood = [trainingLogLikelihood getLogLikelihood(data(1:N,:),labels(1:N),b_current)];
testLogLikelihood = [testLogLikelihood getLogLikelihood(test_data(1:1000,:),labels(1001:2000),b_current)];
iterationNumbers = [0];

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
    
    %if it is nearly singular, then the function has converged
    if(det(hessian) < epsilon)
       break; 
    end
    
    b_change = inv(hessian)*(transpose(data))*diffVector;
    
    b_current = b_current + b_change; 
    
    %find the classification accuracy for training data
    trainingAccuracy = [trainingAccuracy getAccuracy(data(1:N,:),labels(1:N),b_current)];
    
    %find the classification accuracy for test data
    testAccuracy = [testAccuracy getAccuracy(test_data(1:1000,:),labels(1001:2000),b_current)];
    
    trainingLogLikelihood = [trainingLogLikelihood getLogLikelihood(data(1:N,:),labels(1:N),b_current)];
    
    testLogLikelihood = [testLogLikelihood getLogLikelihood(test_data(1:1000,:),labels(1001:2000),b_current)];
    
    %make vector for iteration numbers to be used in plotting
    iterationNumbers = [iterationNumbers iteration];
    
    firstWeight = [firstWeight b_current(1)];
    secondWeight = [secondWeight b_current(2)];
    lastWeight = [lastWeight b_current(d)];
    
    totalChange = sum(abs(b_change));
    if(totalChange < minError)
        break;
    end

end

subplot(1,3,1);
plot(iterationNumbers,trainingAccuracy,'g',iterationNumbers,testAccuracy,'r');
title('Classification Error during different iterations');
xlabel('Iteration Number');
ylabel('Accuracy of Classifier');
legend('Training Data Accuracy','Test Data Accuracy');

subplot(1,3,2);
plot(iterationNumbers,trainingLogLikelihood,'g',iterationNumbers,testLogLikelihood,'r');
title('Log Likelihood during different iterations');
xlabel('Iteration Number');
ylabel('Log-Likelihood');
legend('Training Data Log Likelihood','Test Data Log Likelihood');

subplot(1,3,3);
plot(iterationNumbers,firstWeight,'g',iterationNumbers,secondWeight,'r',iterationNumbers,lastWeight,'b');
title('Weights during different iterations');
xlabel('Iteration Number');
ylabel('Weight Value');
legend('First Weight','Second Weight','Last Weight');
