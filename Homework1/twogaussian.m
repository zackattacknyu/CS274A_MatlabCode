function [data1, data2] = twogaussian(n1,mu1,cov1,n2,mu2,cov2,plotflag);
% [data1, data2] = twogaussian(n1,mu1,sigma1,n2,mu2,sigma2);
%
%  This is a template for a function to simulate data from 2 Gaussian 
%  densities in d dimensions and to plot the data in the first 2 dimensions
%
%                                    Homework 1, CS 274A, January 2014
%
% INPUTS:
%          n1, n2: two integers, size of data set 1 and 2 respectively
%        mu1, mu2: two vectors of dimension 1 x d, means
%                  for data set 1 and 2
%      cov1, cov2: two matrices of dimension d x d, covariance
%                  matrices for data set 1 and 2 respectively
%        plotflag: set to 1 to display the figure, 0 otherwise
%
% OUTPUTS:
%    data1:  n1 x d matrix of data for data set 1
%    data2:  n2 x d matrix of data for data set 2

if nargin<7
  plotflag = 1 % turn on plotting by default if input "plotflag" is not specified
end

% Error checking.....
% check that the dimensionality of the mu's and sigma's are consistent
d1 = length(mu1); d2 = length(mu2);
  if (d1~=d2) error('means are of different lengths');  end;
d = length(mu1);   % d is the dimensionality of the data
[d1 d2] = size(cov1);
  if (d1~=d2) error('cov1 is a non-square covariance matrix'); end;
  if (d1~=d) error('cov1 is of different dimensionality to mu1'); end;     
[d1 d2] = size(cov2);
  if (d1~=d2) error('cov2 is a non-square covariance matrix'); end;
  if (d1~=d) error('cov2 is of different dimensionality to mu2'); end;

% Call the function mvnrnd.m to generate the two data sets
data1 = mvnrnd(mu1,cov1,n1);
data2 = mvnrnd(mu2,cov2,n2);
   
% Now plot the two data sets as a two-dimensional scatter plot
% if d = 2: plot dimension1 on the xaxis and dimension 2 on the
% yaxis. Plot the points from data1 as green dots 'g.', and the
% points from data2 as red dots 'r.'.
if plotflag==1
   figure  % open a figure window
   plot(data1(:,1),data1(:,2),'g+')     % now plot data1
   %axis([-6 6 -6 6]);  % fix the lengths of the axes
   hold on;               % hold the figure to overlay a 2nd plot
   plot(data2(:,1),data2(:,2),'ro')     % now plot data 2
   xlabel('Dimension 1');
   ylabel('Dimension 2');
   title('Simulation of data from two Gaussians in two dimensions');
   plot_gauss_parameters(mu1,cov1,1,2,'g');  % plot covariance ellipse for data 1
   plot_gauss_parameters(mu2,cov2,1,2,'r');  % plot covariance ellipse for data 2
end

