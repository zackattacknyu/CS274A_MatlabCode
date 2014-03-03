function [ Nvector,alphaValues ] = computeNewAlphaValues( numPoints, memberProbs )
%COMPUTENEWALPHAVALUES computes new alpha values for M-step

Nvector = sum(memberProbs);
alphaValues = Nvector./numPoints;


end

