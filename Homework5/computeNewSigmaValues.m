function [ sigmaVector ] = computeNewSigmaValues( dataset,memberProbs,K,muVector )
%COMPUTENEWSIGMAVALUES computes the new sigma matrices in the M-step
%   

datasetSize = size(dataset);
numPoints = datasetSize(1);
numDimensions = datasetSize(2);
Nvector = sum(memberProbs);

sigmaVector = zeros([numDimensions numDimensions K]);
for k = 1:K
    currentSum = zeros([numDimensions numDimensions]);
    for dataPt = 1:numPoints
        diffVector = dataset(dataPt,:)-muVector(k,:);
        currentSum = currentSum + (transpose(diffVector)*diffVector).*memberProbs(dataPt,k);
    end
   sigmaVector(:,:,k) = currentSum./Nvector(k);  
end

end

