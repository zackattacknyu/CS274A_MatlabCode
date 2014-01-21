mu = 20;
sigma = 3;

%This is used for the plot in part 1
%numDraws = 10;

%This is used for the plot in part 2
numDraws = 1000;

data = normrnd(mu,sigma,[1 numDraws]);

gausslogL(data)