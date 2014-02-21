function [weights] = logistic_train(data,labels,epsilon,maxiterations)
% [weights] = logistic_train(data,labels,epsilon,maxiterations)
%
% code to train a logistic regression classifier using the Newton method
%
% INPUTS:
%   data = n x (d+1) matrix with n samples and d features, where
%           column d+1 is all ones (corresponding to the intercept term)
%   labels = n x 1 vector of class labels (taking values 0 or 1)
%   epsilon = optional argument specifying the convergence
%            criterion - if the change in the absolute difference in
%           predictions, from one iteration to the next, summed across
%           training examples, is less than n * epsilon, then halt
%           (if unspecified, use a default value of 10ˆ-5)
%   maxiterations = optional argument that specifies the
%           maximum number of iterations to execute (useful when
%           debugging in case your code is not converging correctly!)
%           (if unspecified can be set to a number like 1000)
%
% OUTPUT:
%   weights = (d+1) x 1 vector of weights where the weights
%           correspond to the columns of "data"

%Using equations 17.4.28 and 17.4.30 for the code

load('HW4data.mat')

end

