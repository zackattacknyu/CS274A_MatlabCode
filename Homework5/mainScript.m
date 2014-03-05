load('dataset1.txt');
load('dataset2.txt');
load('dataset3.txt');

%plot(dataset1(:,1),dataset1(:,2),'r.');
%plot(dataset2(:,1),dataset2(:,2),'r.');
%plot(dataset3(:,1),dataset3(:,2),'r.');
datasetNum = 3;
if(datasetNum == 1)
    dataset = dataset1;
elseif(datasetNum == 2)
    dataset = dataset2;
elseif(datasetNum == 3)
    dataset = dataset3;
end

%randomizes the order of the operant data set
datasetSize = size(dataset);
numPoints = datasetSize(1);
numDimensions = datasetSize(2);
dataset = dataset(randperm(numPoints),:);

maxiterations = 10;
r = 10;
k=2;

[finalClusterRows,finalNumPointsCluster,finalClusters,finalClusterAssignments] = ...
    kMeansCluster(dataset,k,r,maxiterations);

if(datasetNum == 3)
    load('labelset3.txt');
    accuracyVector = (finalClusterAssignments==labelset3);
    accuracy = sum(accuracyVector)/numPoints;
end

figure

plotClusters(finalClusterRows,finalNumPointsCluster,k);
break;


K = 2;
endK = 5;

bicValues = ones(1,endK);
bicValues = bicValues*(-inf);
likelihoods = zeros(1,endK);

if(datasetNum == 3)
    method = 1;
    [~,~,~,finalAssignments] = gaussian_mixture(dataset,K,method,0.00001,100,1,3);
    load('labelset3.txt');
    accuracyVector = (finalAssignments==labelset3);
    accuracy = sum(accuracyVector)/numPoints;
end


%{
likelihoodValues = ones(1,3);
for method = 1:3
    [~,~,likelihoodValues(method)] = gaussian_mixture(dataset,K,method,0.00001,100,1,3);
end
[bestLikelihood,bestMethod] = max(likelihoodValues);
%}

%{
%gets the values for K=1
currentLikelihood = computeLogLikelihood(dataset,1,1,mean(dataset),cov(dataset));
numParams = getPkValue(1,numDimensions);
bicValues(1) = currentLikelihood - (numParams/2)*log(numPoints);
likelihoods(1) = currentLikelihood;

for K = 2:endK
    [~,~,currentLikelihood] = gaussian_mixture(dataset,K,3,0.00001,100,0,3);
    numParams = getPkValue(K,numDimensions);
    bicValues(K) = currentLikelihood - (numParams/2)*log(numPoints);
    likelihood(K) = currentLikelihood;
end

[bestBIC,bestKval] = max(bicValues);
%}


