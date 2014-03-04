load('dataset1.txt');
load('dataset2.txt');
load('dataset3.txt');

%plot(dataset1(:,1),dataset1(:,2),'r.');
%plot(dataset2(:,1),dataset2(:,2),'r.');
%plot(dataset3(:,1),dataset3(:,2),'r.');



dataset = dataset1;

%{
maxiterations = 10;
r = 10;
[finalClusterRows,finalNumPointsCluster,finalClusters] = ...
    kMeansCluster(dataset,k,r,maxiterations);

figure

plot(finalClusterRows(1:finalNumPointsCluster(1),1,1),...
    finalClusterRows(1:finalNumPointsCluster(1),2,1),'.',...
        finalClusterRows(1:finalNumPointsCluster(2),1,2),...
        finalClusterRows(1:finalNumPointsCluster(1),2,2),'o');
%}

%randomizes the order of the operant data set
datasetSize = size(dataset);
numPoints = datasetSize(1);
dataset = dataset(randperm(numPoints),:);
K = 2;

gaussian_mixture(dataset,K,3,0.00001,100,1,3);
