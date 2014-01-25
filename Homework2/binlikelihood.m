function [] = binlikelihood(rValue,nValue)
%BINLIKELIHOOD Plots the likelihood function for the binary distribution
%   This plots the parameter p, the probability, on the x-axis
%   The y axis is the likelihood
%   The equation is L(p) = p^r * (1-p)^(n-r)

pValues = [0:1/1000:1];
L_Values = (pValues.^rValue).*((1-pValues).^(nValue-rValue));
plot(pValues,L_Values);
xlabel('Value of parameter p');
ylabel('Likelihood of Data');
title('Plot of p versus likelihood');

end

