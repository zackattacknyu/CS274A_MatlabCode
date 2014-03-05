function [ accuracy ] = computeAccuracy( permutation,finalClusterAssignments,numPoints )
%COMPUTEACCURACY Computes the accuracy of the final cluster assignments
%                       for dataset 3
% permutation is the random permutation of the data that was done
%       to prevent biasing

load('labelset3.txt');
labelset3 = labelset3(permutation,:);
accuracyVector = (finalClusterAssignments==labelset3);
accuracyOne = sum(accuracyVector)/numPoints;

%flips the assignments in case that is the better one
accuracyVector = ~accuracyVector;
accuracyTwo = sum(accuracyVector)/numPoints;

accuracy = max([accuracyOne accuracyTwo]);
end

