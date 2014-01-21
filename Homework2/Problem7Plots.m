mu = 20;
sigma = 3;
numDraws = 1000;
data = normrnd(mu,sigma,[1 numDraws]);

minNum = min(data);
maxNum = max(data);
varData = var(data);
maxSigma = sqrt(varData)*5;
meanData = mean(data);

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
plot(muValues,logLike_mu);

%generates the plot of sigma versus log-likelihood
sigmaValues = 0.1:1/100:maxSigma;
varValues = sigmaValues.^2;
summationTerms = (data - meanData).^2;
summationValue = sum(summationTerms);
logLike_sigma = (-numDraws/2)*log(2*pi.*varValues)-(summationValue./(2.*varValues));
plot(sigmaValues,logLike_sigma);