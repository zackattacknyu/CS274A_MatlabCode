function [ logLikelihood ] = computeLogLikelihood( dataset, alphaValues, K, muVector, sigmaVector )
%COMPUTELOGLIKELIHOOD Gets the log Likelihood of the data set given the
%                       current parameters

datasetSize = size(dataset);
numPoints = datasetSize(1);
logLikelihood = 0;
pVector = computePvector(dataset, K, muVector, sigmaVector);
for dataPt = 1:numPoints
    logLikelihood = logLikelihood + log(dot(pVector(dataPt,:),alphaValues));
end 
logLikelihood = logLikelihood/numPoints;
end

