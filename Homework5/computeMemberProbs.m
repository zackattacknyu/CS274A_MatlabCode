function [ memberProbs , clusterRows, numPointsCluster ] = computeMemberProbs( dataset, alphaValues, K, muVector, sigmaVector )
%COMPUTEMEMBERPROBS This computes the member probabilities for the E step

datasetSize = size(dataset);
numPoints = datasetSize(1);
memberProbs = zeros([numPoints K]);
pVector = computePvector(dataset, K, muVector, sigmaVector);

clusterRows = zeros(numPoints,2,K);
numPointsCluster = zeros(1,K);

for k = 1:K
    for dataPt = 1:numPoints
        memberProbs(dataPt,k) = (pVector(dataPt,k)*alphaValues(k))/...
            (dot(pVector(dataPt,:),alphaValues));
    end
end

for dataPoint = 1:numPoints
    [~,bestCluster] = max(memberProbs(dataPoint,:));
    numPointsCluster(bestCluster) = numPointsCluster(bestCluster) + 1;
    clusterRows( numPointsCluster(bestCluster) , : , bestCluster) = dataset(dataPoint,:);
end
                   
end

