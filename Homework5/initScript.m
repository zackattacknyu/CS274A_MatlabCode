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
numDimensions = datasetSize(2);
memberProbs = rand([numPoints K]);
memberProbs = diag(sum(transpose(memberProbs)))\memberProbs; %normalize each row
Nvector = sum(memberProbs);
alphaValues = Nvector./numPoints;

%init M step
muVector = zeros([K numDimensions]);
for k = 1:K
    muVector(k,:) = (sum(diag(memberProbs(:,k))*dataset))./Nvector(k);
end
sigmaVector = zeros([numDimensions numDimensions K]);
for k = 1:K
    currentSum = zeros([numDimensions numDimensions]);
    for dataPt = 1:numPoints
        diffVector = dataset(dataPt,:)-muVector(k,:);
        currentSum = currentSum + (transpose(diffVector)*diffVector).*memberProbs(dataPt,k);
    end
   sigmaVector(:,:,k) = currentSum./Nvector(k);  
end
