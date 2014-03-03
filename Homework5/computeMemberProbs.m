function [ memberProbs ] = computeMemberProbs( dataset, alphaValues, K, muVector, sigmaVector )
%COMPUTEMEMBERPROBS This computes the member probabilities for the E step

datasetSize = size(dataset);
numPoints = datasetSize(1);
memberProbs = zeros([numPoints K]);
pVector = computePvector(dataset, K, muVector, sigmaVector);
for k = 1:K
    for dataPt = 1:numPoints
        memberProbs(dataPt,k) = (pVector(dataPt,k)*alphaValues(k))/...
            (dot(pVector(dataPt,:),alphaValues));
    end 
end
end

