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

[finalClusterRows,finalNumPointsCluster,finalClusters] = ...
    kMeansCluster(dataset,k,r,maxiterations);

figure
%{
plot(finalClusterRows(1:finalNumPointsCluster(1),1,1),...
    finalClusterRows(1:finalNumPointsCluster(1),2,1),'.',...
        finalClusterRows(1:finalNumPointsCluster(2),1,2),...
        finalClusterRows(1:finalNumPointsCluster(1),2,2),'o');
%}

%randomizes the order of the operant data set
dataset = dataset(randperm(numPoints),:);
datasetSize = size(dataset);
numPoints = datasetSize(1);
numDimensions = datasetSize(2);
K = 2;

method = 3;

if(method == 1)
    
    %method 1, random membership probabilities
    
    memberProbs = initValuesMethod1(dataset,K);
    %init M step
    alphaValues = computeNewAlphaValues(numPoints,memberProbs);
    muVector = computeNewMuValues(dataset,memberProbs,K);
    sigmaVector = computeNewSigmaValues(dataset,memberProbs,K,muVector);
    
elseif(method == 2)
   
    %method 2, random points for the means
    randOrder = randperm(numPoints);
    muVector = dataset(randOrder(1:K),:);
    overallCov = cov(dataset);
    sigmaVector = zeros([numDimensions numDimensions K]);
    for k = 1:K
       sigmaVector(:,:,k) = overallCov; 
    end
    alphaValues = rand([1 K]);
    alphaValues = alphaValues./sum(alphaValues);
    
elseif(method == 3)
    
    %put the 3rd method code here
    muVector = finalClusters;
    overallCov = cov(dataset);
    sigmaVector = zeros([numDimensions numDimensions K]);
    for k = 1:K
       sigmaVector(:,:,k) = overallCov; 
    end
    alphaValues = rand([1 K]);
    alphaValues = alphaValues./sum(alphaValues);
    
end

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

