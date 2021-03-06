function [ finalClusterRows, finalNumPointsCluster, finalClusters,finalClusterAssignments] = kMeansCluster( dataset, k, r, maxiterations ,plotflag )
%KMEANSCLUSTER Does k-means clustering of the dataset
%   
if(nargin < 5)
   plotflag = 0; 
end

datasetSize = size(dataset);
numPoints = datasetSize(1);
numDimensions = datasetSize(2);

%repeats k-means for r different starting points
randOrder = randperm(numPoints);
currentMinSumOfSquares = inf;
for instance = 1:r
   
    meanRows = randOrder((k*instance - k + 1):(k*instance));

    %assign the cluster rows randomly
    currentClusters = zeros(k,numDimensions);
    currentClusterDistances = zeros(k,1);
    for row = 1:k
        currentClusters(row,:) = dataset(meanRows(row),:);
    end

    currentClusterAssignments = zeros(numPoints,1);
    currentSumOfSquaresArray = zeros(1,maxiterations);
    for iteration = 1:maxiterations
        currentNumChanged = 0;
        currentSumOfSquares = 0;
        numPointsCluster = zeros(1,k);
        clusterRows = zeros(numPoints,numDimensions,k);

        %loop through the data points finding the closest cluster for each point
        for dataPoint = 1:numPoints
           for cluster = 1:k
               currentClusterDistances(cluster) = (norm(currentClusters(cluster,:)-dataset(dataPoint,:)))^2;
           end

           [currentMinDistance,bestCluster] = min(currentClusterDistances);
           currentSumOfSquares = currentSumOfSquares + currentMinDistance;

           if(bestCluster ~= currentClusterAssignments(dataPoint))
               currentClusterAssignments(dataPoint) = bestCluster;
               currentNumChanged = currentNumChanged + 1;
           end
           
           numPointsCluster(bestCluster) = numPointsCluster(bestCluster) + 1;
           
           clusterRows( numPointsCluster(bestCluster) , : , bestCluster) = dataset(dataPoint,:);

        end
        
        currentSumOfSquaresArray(iteration) = currentSumOfSquares/numPoints;
        
        %it has converged
        if(currentNumChanged < 1)
           break; 
        end

        %reassign the clusters
        for cluster = 1:k
            for dimension = 1:numDimensions
                currentClusters(cluster,dimension) =...
                    mean( clusterRows( 1:numPointsCluster(cluster) ,...
                    dimension,cluster) );
            end
        end

    end

    currentSumOfSquaresArray = currentSumOfSquaresArray(1:iteration);
    if(currentSumOfSquares < currentMinSumOfSquares)
        finalClusterRows = clusterRows;
        finalNumPointsCluster = numPointsCluster;
        finalClusters = currentClusters;
        finalClusterAssignments = currentClusterAssignments;
        finalSumOfSquaresArray = currentSumOfSquaresArray;
    end 
    
end

if(plotflag)
    figure
    plot(finalSumOfSquaresArray);
    xlabel('Iteration Number');
    ylabel('Sum of Squared Error');
    title('Plot of Squared Error vs Iteration Number');
end


end

