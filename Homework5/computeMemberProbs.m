function [ memberProbs ] = computeMemberProbs( dataset, alphaValues, K, muVector, sigmaVector )
%COMPUTEMEMBERPROBS This computes the member probabilities for the E step

datasetSize = size(dataset);
numPoints = datasetSize(1);
numDimensions = datasetSize(2);
memberProbs = zeros([numPoints K]);
pVector = zeros([numPoints K]);
for k = 1:K
    for dataPt = 1:numPoints
        diffVector = dataset(dataPt,:)-muVector(k,:);
        exponent = (diffVector/sigmaVector(:,:,k))*transpose(diffVector);
        denominator = ((2*pi)^(numDimensions/2))*...
            sqrt(det(sigmaVector(:,:,k)));
        pVector(dataPt,k) = (1/denominator)*exp(-0.5*exponent);
    end 
end
for k = 1:K
    for dataPt = 1:numPoints
        memberProbs(dataPt,k) = (pVector(dataPt,k)*alphaValues(k))/...
            (dot(pVector(dataPt,:),alphaValues));
    end 
end
end

