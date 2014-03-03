function [ muVector ] = computeNewMuValues( dataset,memberProbs,K )
%COMPUTENEWMUVALUES This computes the new mu Vector in the M-step 
%                   of the EM algorithm
%   
datasetSize = size(dataset);
numDimensions = datasetSize(2);
Nvector = sum(memberProbs);
muVector = zeros([K numDimensions]);
for k = 1:K
    muVector(k,:) = (sum(diag(memberProbs(:,k))*dataset))./Nvector(k);
end


end

