load('dataset1.txt');
load('dataset2.txt');
load('dataset3.txt');

%plot(dataset1(:,1),dataset1(:,2),'r.');
%plot(dataset2(:,1),dataset2(:,2),'r.');
%plot(dataset3(:,1),dataset3(:,2),'r.');
dataset = dataset2;

maxiterations = 10;
r = 10;
k=2;
%{
[finalClusterRows,finalNumPointsCluster,finalClusters] = ...
    kMeansCluster(dataset,k,r,maxiterations);

figure

if(k == 2)
   plot(finalClusterRows(1:finalNumPointsCluster(1),1,1),...
    finalClusterRows(1:finalNumPointsCluster(1),2,1),'r.',...
        finalClusterRows(1:finalNumPointsCluster(2),1,2),...
        finalClusterRows(1:finalNumPointsCluster(2),2,2),'go');
elseif(k == 3)
    plot(finalClusterRows(1:finalNumPointsCluster(1),1,1),...
    finalClusterRows(1:finalNumPointsCluster(1),2,1),'r.',...
        finalClusterRows(1:finalNumPointsCluster(2),1,2),...
        finalClusterRows(1:finalNumPointsCluster(2),2,2),'go',...
        finalClusterRows(1:finalNumPointsCluster(3),1,3),...
        finalClusterRows(1:finalNumPointsCluster(3),2,3),'bx');
end
%}

%randomizes the order of the operant data set
datasetSize = size(dataset);
numPoints = datasetSize(1);
numDimensions = datasetSize(2);
dataset = dataset(randperm(numPoints),:);
K = 3;
endK = 5;

bicValues = ones(1,endK);
bicValues = bicValues*(-inf);

%gets the values for K=1
currentLikelihood = computeLogLikelihood(dataset,1,1,mean(dataset),cov(dataset));
numParams = getPkValue(1,numDimensions);
bicValues(1) = currentLikelihood - (numParams/2)*log(numPoints);

likelihoodValues = ones(1,3);
for method = 1:3
    [~,~,likelihoodValues(method)] = gaussian_mixture(dataset,K,method,0.00001,100,1,3);
end
[bestLikelihood,bestMethod] = max(likelihoodValues);

break;
for K = 2:endK
    [~,~,currentLikelihood] = gaussian_mixture(dataset,K,3,0.00001,100,1,3);
    numParams = getPkValue(K,numDimensions);
    bicValues(K) = currentLikelihood - (numParams/2)*log(numPoints);
end

[bestBIC,bestKval] = max(bicValues);



