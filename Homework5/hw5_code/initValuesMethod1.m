function [ memberProbs ] = initValuesMethod1( dataset, K )
%INITVALUESMETHOD1 This computes the init parameters using method 1

datasetSize = size(dataset);
numPoints = datasetSize(1);
memberProbs = rand([numPoints K]);
memberProbs = diag(sum(transpose(memberProbs)))\memberProbs; %normalize each row

end

