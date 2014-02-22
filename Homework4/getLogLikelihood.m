function [ logLikelihood ] = getAccuracy( featureData,labelData,currentWeights )
%GETACCURACY gets the log-likelihood of the classification model
%   Detailed explanation goes here

logLikelihood = 0;
dataSize = size(featureData);
numRows = dataSize(1);

for row = 1:numRows
    currentDataRow = featureData(row,:);
    dotProd = dot(currentDataRow,currentWeights);
    logLikelihood = logLikelihood + labelData(row)*dotProd - log(1 + exp(dotProd));
end
end

