function [ pVector ] = computePvector( dataset, K, muVector, sigmaVector  )
%COMPUTEPVECTOR calculates all the probabilities given the current
%               parameters

datasetSize = size(dataset);
numPoints = datasetSize(1);
numDimensions = datasetSize(2);

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


end

