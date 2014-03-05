function [ numParams ] = getPkValue( K,d )
%GETPKVALUE gets the number of parameters given k and d

numParams = d*(d+1)/2; %covariance matrix
numParams = numParams + d; % mean vector
numParams = numParams + 1; % alpha value
numParams = numParams*K; %across the k clusters
end

