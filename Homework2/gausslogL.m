function [] = gausslogL(data)
%GAUSSLOGL Plots log-likelihood as function of mu and sigma
%   This generates a figure with two plots
%       The left plot is log-likelihood as a function of mu
%       The right plot is log-likelihood as a function of sigma
%   The data used for the liklihood estimate comes from input data

sizeData = size(data);
numDraws = sizeData(2);

minNum = min(data);
maxNum = max(data);
varData = var(data);
meanData = mean(data);

%min and max of sigma in the x-axis of its log-likelihood graph
minSigma = 0.1;
maxSigma = sqrt(varData)*5;

%generates the plot of mu versus log-likelihood
muValues = minNum:1/100:maxNum; %x-axis
sizeMu = size(muValues);
numMuValues = sizeMu(2);
summationVector = [];
for index = 1:numMuValues,
    summation = sum((data - muValues(index)).^2); %computes sum[(x_i - mu)^2]
    summationVector = [summationVector summation]; 
end
logLike_mu = (-numDraws/2)*log(2*pi*varData) - (1/(2*varData)).*summationVector;
subplot(1,2,1)
plot(muValues,logLike_mu)

%generates the plot of sigma versus log-likelihood
sigmaValues = minSigma:1/100:maxSigma;
varValues = sigmaValues.^2;
summationTerms = (data - meanData).^2;
summationValue = sum(summationTerms);
logLike_sigma = (-numDraws/2)*log(2*pi.*varValues)-(summationValue./(2.*varValues));
subplot(1,2,2)
plot(sigmaValues,logLike_sigma)

end

