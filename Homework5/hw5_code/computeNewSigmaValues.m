function [ sigmaVector ] = computeNewSigmaValues( dataset,memberProbs,K,muVector,epsilon )
%COMPUTENEWSIGMAVALUES computes the new sigma matrices in the M-step
%   

datasetSize = size(dataset);
numPoints = datasetSize(1);
numDimensions = datasetSize(2);
Nvector = sum(memberProbs);

sigmaVector = zeros([numDimensions numDimensions K]);
for k = 1:K
    currentSigmaVector = zeros([numDimensions numDimensions]);
    for dataPt = 1:numPoints
        diffVector = dataset(dataPt,:)-muVector(k,:);
        currentSigmaVector = currentSigmaVector + ...
            (transpose(diffVector)*diffVector).*memberProbs(dataPt,k);
    end
    currentSigmaVector = currentSigmaVector./Nvector(k);
    for diagEntry = 1:numDimensions
        threshold = epsilon*var(dataset(:,diagEntry));
       if(currentSigmaVector(diagEntry,diagEntry) < threshold)
           currentSigmaVector(diagEntry,diagEntry) = threshold;
       end
    end
   sigmaVector(:,:,k) = currentSigmaVector;  
end

end

