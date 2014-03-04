load('dataset1.txt');
load('dataset2.txt');
load('dataset3.txt');

%plot(dataset1(:,1),dataset1(:,2),'r.');
%plot(dataset2(:,1),dataset2(:,2),'r.');
%plot(dataset3(:,1),dataset3(:,2),'r.');
dataset = dataset2;

maxiterations = 10;
r = 10;
k=3;
%{
[finalClusterRows,finalNumPointsCluster,finalClusters] = ...
    kMeansCluster(dataset,k,r,maxiterations);

figure

plot(finalClusterRows(1:finalNumPointsCluster(1),1,1),...
    finalClusterRows(1:finalNumPointsCluster(1),2,1),'r.',...
        finalClusterRows(1:finalNumPointsCluster(2),1,2),...
        finalClusterRows(1:finalNumPointsCluster(2),2,2),'g.',...
        finalClusterRows(1:finalNumPointsCluster(3),1,3),...
        finalClusterRows(1:finalNumPointsCluster(3),2,3),'b.');
%}

%randomizes the order of the operant data set
datasetSize = size(dataset);
numPoints = datasetSize(1);
dataset = dataset(randperm(numPoints),:);
K = 4;

gaussian_mixture(dataset,K,3,0.00001,100,1,3);

%calculate # of parameters
d = numDimensions;
numParams = d*(d+1)/2; %covariance matrix
numParams = numParams + d; % mean vector
numParams = numParams + 1; % alpha value
numParams = numParams*K; %across the k clusters

