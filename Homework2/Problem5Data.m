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
pValues = 1/100:1/100:1;
lValues_p = bigN*log(1-pValues) + bigK*log(pValues); 

plot(pValues,lValues_p);
xlabel('Value of p');
ylabel('log-likelihood');
title('Graph of log-likelihood for the Geometric Distribution');

%This plots the likelihood versus the lambda value for the poisson
%   distribution
lambdaValues = 1/100:1/100:10;
lValues_lambda = -bigN*lambdaValues + bigK*log(lambdaValues) - bigQ;

plot(lambdaValues,lValues_lambda);
xlabel('Value of lambda');
ylabel('log-likelihood');
title('Graph of log-likelihood for the Poisson Distribution');

bestLambda = bigK/bigN;
best_pValue = bigK/(bigN + bigK);

%the rest of this is used for part 5

%this adds 10 to the end to the x axis will go from 0 to 10
kValues = [kValues 10]
numCusts = [numCusts 0];

%this gets the regular probability distribution
prob_kValues = [];
for index = 1:1:11,
   prob_k = numCusts(index)/bigN;
   prob_kValues = [prob_kValues prob_k];
end

%this is the geometric probability distribution
prob_geom = (1-best_pValue)*(best_pValue.^kValues);
prob_poisson = exp(-1*bestLambda)*(bestLambda.^kValues)./(factorial(kValues));

plot(kValues,prob_kValues,'o',kValues,prob_geom,'r-',kValues,prob_poisson,'g--');
legend('Empirical Probability','Geometric Distribution Probability','Poisson Distribution Probablity');
xlabel('Value of k');
ylabel('Probability');
title('Graph of Probability versus k for differerent distributions');
