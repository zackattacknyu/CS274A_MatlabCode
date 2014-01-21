%{
value k   num Customers
0           12
1           15
2           16
3           8
4           5
5           1   
6           2
7           1
8           0
9           1

%}

numCusts = [12 15 16 8 5 1 2 1 0 1];
kValues = [0 1 2 3 4 5 6 7 8 9];

xValues = [];
for index = 1:1:10,
    for xInd = 1:1:numCusts(index),
       xValues = [xValues kValues(index)];
    end
end

%This denotes N, K and Q where
%   N is the total number of customers
%   K is equal to the sum of the x's
%   Q is the sum of the logs of the factorials of x
bigN = sum(numCusts);
bigK = sum(xValues);
bigQ = sum(log(factorial(xValues)));

%This plots the likelihood versus the p value for the geometric
%   distribution
pValues = [0:1/100:1];
lValues_p = bigN*log(1-pValues) + bigK*log(pValues); 
plot(pValues,lValues_p);

%This plots the likelihood versus the lambda value for the poisson
%   distribution
lambdaValues = [0:1/100:10];
lValues_lambda = -bigN*lambdaValues + bigK*log(lambdaValues) - bigQ
plot(lambdaValues,lValues_lambda)

bestLambda = bigK/bigN;
best_pValues = bigK/(bigN + bigK);