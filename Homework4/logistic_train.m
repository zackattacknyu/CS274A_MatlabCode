function [weights] = logistic_train(data,labels,epsilon,maxiterations)
% [weights] = logistic_train(data,labels,epsilon,maxiterations)
%
% code to train a logistic regression classifier using the Newton method
%
% INPUTS:
%   data = n x (d+1) matrix with n samples and d features, where
%           column d+1 is all ones (corresponding to the intercept term)
%   labels = n x 1 vector of class labels (taking values 0 or 1)
%   epsilon = optional argument specifying the convergence
%            criterion - if the change in the absolute difference in
%           predictions, from one iteration to the next, summed across
%           training examples, is less than n * epsilon, then halt
%           (if unspecified, use a default value of 10ˆ-5)
%   maxiterations = optional argument that specifies the
%           maximum number of iterations to execute (useful when
%           debugging in case your code is not converging correctly!)
%           (if unspecified can be set to a number like 1000)
%
% OUTPUT:
%   weights = (d+1) x 1 vector of weights where the weights
%           correspond to the columns of "data"

%config type variables
N = 20;

%TODO: Set default values
%
dataSize = size(data); 
numDataPoints = dataSize(1);
d = dataSize(2) + 1; %number of features
all_data = [data ones(numDataPoints,1)]; %adds the intercept term
data = all_data(1:N,:);
minError = N*epsilon;
test_data = all_data(1001:2000,:);

b0 = zeros(d,1); %initial term for convergence
b_current = b0;

trainingAccuracy = ones(1,maxiterations);
testAccuracy = ones(1,maxiterations);
trainingLogLikelihood = ones(1,maxiterations);
testLogLikelihood = ones(1,maxiterations);
firstWeight = ones(1,maxiterations);
secondWeight = ones(1,maxiterations);
lastWeight = ones(1,maxiterations);
iterationNumbers = ones(1,maxiterations);
numIterations = 0;

for iteration = 1:maxiterations
    
    %vector of fitted response probabilities
    dotProdVector = data(1:N,:)*b_current;
    pVector = 1./(1+exp(-1.*dotProdVector));
    
    %diffVector is the difference between y and the fitted response
    %   probabilities
    diffVector = labels(1:N,:)-pVector;

    %vMatrix is a diagonal matrix where each entry is p(1-p)
    vMatrix = diag(pVector.*(1-pVector));

    %this is X'V*X
    hessian = (transpose(data))*vMatrix*data;
    
    b_change = hessian\(transpose(data))*diffVector;
    
    b_current = b_current + b_change; 
    
    %find the classification accuracy for training data
    trainingAccuracy(iteration) = getAccuracy(data(1:N,:),labels(1:N),b_current);
    
    %find the classification accuracy for test data
    testAccuracy(iteration) = getAccuracy(test_data(1:1000,:),labels(1001:2000),b_current);
    
    trainingLogLikelihood(iteration) = getLogLikelihood(data(1:N,:),labels(1:N),b_current);
    
    testLogLikelihood(iteration) = getLogLikelihood(test_data(1:1000,:),labels(1001:2000),b_current);
    
    %make vector for iteration numbers to be used in plotting
    iterationNumbers(iteration) = iteration;
    
    firstWeight(iteration) = b_current(1);
    secondWeight(iteration) = b_current(2);
    lastWeight(iteration) = b_current(d);
    
    numIterations = numIterations + 1;
    
    dotProdVector_new = data(1:N,:)*b_current;
    pVector_new = 1./(1+exp(-1.*dotProdVector_new));
    totalChange = sum(abs(pVector_new-pVector));
    if(totalChange < minError)
        break;
    end

end

trainingAccuracy = trainingAccuracy(1,1:numIterations);   
testAccuracy = testAccuracy(1,1:numIterations);
trainingLogLikelihood = trainingLogLikelihood(1,1:numIterations);
testLogLikelihood = testLogLikelihood(1,1:numIterations);
iterationNumbers = iterationNumbers(1,1:numIterations);
firstWeight = firstWeight(1,1:numIterations);
secondWeight = secondWeight(1,1:numIterations);
lastWeight = lastWeight(1,1:numIterations);

weights = b_current;

figure
plot(iterationNumbers,trainingAccuracy,'g',iterationNumbers,testAccuracy,'r');
title('Classification Error during different iterations');
xlabel('Iteration Number');
ylabel('Accuracy of Classifier');
legend('Training Data Accuracy','Test Data Accuracy');

figure
plot(iterationNumbers,trainingLogLikelihood,'g',iterationNumbers,testLogLikelihood,'r');
title('Log Likelihood during different iterations');
xlabel('Iteration Number');
ylabel('Log-Likelihood');
legend('Training Data Log Likelihood','Test Data Log Likelihood');

figure
plot(iterationNumbers,firstWeight,'g',iterationNumbers,secondWeight,'r',iterationNumbers,lastWeight,'b');
title('Weights during different iterations');
xlabel('Iteration Number');
ylabel('Weight Value');
legend('First Weight','Second Weight','Last Weight');

end

