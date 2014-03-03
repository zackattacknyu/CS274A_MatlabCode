load('dataset1.txt');
load('dataset2.txt');
load('dataset3.txt');

%plot(dataset1(:,1),dataset1(:,2),'r.');
%plot(dataset2(:,1),dataset2(:,2),'r.');
%plot(dataset3(:,1),dataset3(:,2),'r.');



dataset = dataset1;
k=2;
maxiterations = 10;
r = 10;

%{
UNCOMMENT AFTER EM IS CODED
[finalCluster1Rows, finalCluster2Rows] = kMeansCluster(dataset,k,r,maxiterations);

figure
plot(finalCluster1Rows(:,1),finalCluster1Rows(:,2),'.',...
        finalCluster2Rows(:,1),finalCluster2Rows(:,2),'o');

%}

%method 1
K = 2;
datasetSize = size(dataset);
numPoints = datasetSize(1);
memberProbs = rand([numPoints K]);
memberProbs = diag(sum(transpose(memberProbs)))\memberProbs; %normalize each row
Nvector = sum(memberProbs);
alphaValues = Nvector./numPoints;
