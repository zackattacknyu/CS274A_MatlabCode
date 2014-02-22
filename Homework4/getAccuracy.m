function [ accuracy ] = getAccuracy( featureData,labelData,currentWeights )
%GETACCURACY gets the accuracy of the classification model
%   Detailed explanation goes here

numAccurate = 0;
dataSize = size(featureData);
numRows = dataSize(1);

for row = 1:numRows
    currentDataRow = featureData(row,:);
    if( dot(currentDataRow,currentWeights) > 0)
       currentClassification = 1; 
    else
       currentClassification = 0;
    end
    if(labelData(row) == currentClassification)
       numAccurate = numAccurate + 1; 
    end
end
accuracy = numAccurate/numRows;

end

