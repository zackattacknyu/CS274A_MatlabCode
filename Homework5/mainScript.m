clear all
algorithm = 2;
datasetNum = 3;
findBestInitMethodFlag = 0;

maxiterations = 10;
r = 10;

load('dataset1.txt');
load('dataset2.txt');
load('dataset3.txt');

if(datasetNum == 1)
    dataset = dataset1;
    K = 2;
    EM_init_method = 3;
elseif(datasetNum == 2)
    dataset = dataset2;
    K = 3;
    EM_init_method = 1;
elseif(datasetNum == 3)
    dataset = dataset3;
    K = 2;
    EM_init_method = 1;
end

%randomizes the order of the operant data set
datasetSize = size(dataset);
numPoints = datasetSize(1);
numDimensions = datasetSize(2);
randomPerm = randperm(numPoints);
dataset = dataset(randomPerm,:);

if(algorithm == 1) %k-means cluster
    
    [finalClusterRows,finalNumPointsCluster,finalClusters,finalClusterAssignments] = ...
    kMeansCluster(dataset,K,r,maxiterations,1);
    
    if(datasetNum == 3)
        accuracy = computeAccuracy(randomPerm,finalClusterAssignments,numPoints);
    end

    figure

    plotClusters(finalClusterRows,finalNumPointsCluster,K,finalClusters);
    
elseif(algorithm == 2) %EM algorithm

    if(findBestInitMethodFlag)
        
        likelihoodValues = ones(1,3);
        for method = 1:3
            [~,~,likelihoodValues(method)] = gaussian_mixture(dataset,K,method,0.00001,100,1,3);
        end
        [bestLikelihood,bestMethod] = max(likelihoodValues);
        
    else
        
        [~,~,~,finalAssignments] = gaussian_mixture(dataset,K,EM_init_method,0.00001,100,1,3);

        if(datasetNum == 3)    
            accuracy = computeAccuracy(randomPerm,finalAssignments,numPoints);
        end
        
    end
    
    
    
elseif(algorithm == 3) %find best K using BIC
    
    endK = 5;

    bicValues = ones(1,endK);
    bicValues = bicValues*(-inf);
    likelihoods = zeros(1,endK);
    
    %gets the values for K=1
    currentLikelihood = computeLogLikelihood(dataset,1,1,mean(dataset),cov(dataset));
    numParams = getPkValue(1,numDimensions);
    bicValues(1) = currentLikelihood - (numParams/2)*log(numPoints);
    likelihoods(1) = currentLikelihood;

    for K = 2:endK
        [~,~,currentLikelihood] = gaussian_mixture(dataset,K,3,10^(-4),100,0,3);
        numParams = getPkValue(K,numDimensions);
        bicValues(K) = currentLikelihood - (numParams/2)*log(numPoints);
        likelihoods(K) = currentLikelihood;
    end

    [bestBIC,bestKval] = max(bicValues);

end









