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

%randomizes the order of the operant data set
dataset = dataset(randperm(numPoints),:);

%method 1
K = 2;
memberProbs = initValuesMethod1(dataset,K);
datasetSize = size(dataset);
numPoints = datasetSize(1);
numDimensions = datasetSize(2);

%init M step
alphaValues = computeNewAlphaValues(numPoints,memberProbs);
muVector = computeNewMuValues(dataset,memberProbs,K);
sigmaVector = computeNewSigmaValues(dataset,memberProbs,K,muVector);

firstLikelihood = computeLogLikelihood( dataset, alphaValues, K...
        , muVector, sigmaVector );
previousLikelihood = 0;
maxiterations = 400;
likelihoods = zeros(1,maxiterations);
for iteration = 1:maxiterations
    
    %does the E-step
    memberProbs = computeMemberProbs(dataset,alphaValues,K,...
        muVector,sigmaVector);
    
    %does the M-step
    alphaValues = computeNewAlphaValues(numPoints,memberProbs);
    muVector = computeNewMuValues(dataset,memberProbs,K);
    sigmaVector = computeNewSigmaValues(dataset,memberProbs,K,muVector);

    currentLikelihood = computeLogLikelihood( dataset, alphaValues, K...
        , muVector, sigmaVector );
    
    likelihoods(iteration) = currentLikelihood;
    
    %possible converge criteria
    if( abs(currentLikelihood-previousLikelihood) < 0.00001*(abs(currentLikelihood-firstLikelihood)) )
       break; 
    end
    
    previousLikelihood = currentLikelihood;
end

likelihoods = likelihoods(1:iteration);

plot(likelihoods);

