load('dataset1.txt');
load('dataset2.txt');
load('dataset3.txt');

plot(dataset1(:,1),dataset1(:,2),'r.');
%plot(dataset2(:,1),dataset2(:,2),'r.');
%plot(dataset3(:,1),dataset3(:,2),'r.');


maxiterations = 10;

%does k-means
dataset = dataset1;
k=2;
datasetSize = size(dataset);
numPoints = datasetSize(1);

%randomizes the order of the operant data set
dataset = dataset(randperm(numPoints),:);

r = 3;
randOrder = randperm(numPoints);
%repeats k-means for r different starting points
for instance = 1:r
   
    meanRows = randOrder((k*instance - k + 1):(k*instance));

    %assign the cluster rows randomly
    currentClusters = zeros(k,2);
    currentClusterDistances = zeros(k,1);
    for row = 1:k
        currentClusters(row,:) = dataset(meanRows(row),:);
    end


    currentClusterAssignments = zeros(numPoints,1);


    for iteration = 1:maxiterations
        currentNumChanged = 0;
        currentSumOfSquares = 0;
        cluster1Rows = [];
        cluster2Rows = [];

        %loop through the data points finding the closest cluster for each point
        for dataPoint = 1:numPoints
           for cluster = 1:k
               currentClusterDistances(cluster) = norm(currentClusters(cluster,:)-dataset(dataPoint,:));
           end

           [currentMinDistance,bestCluster] = min(currentClusterDistances);
           currentSumOfSquares = currentSumOfSquares + currentMinDistance;

           if(bestCluster ~= currentClusterAssignments(dataPoint))
               currentClusterAssignments(dataPoint) = bestCluster;
               currentNumChanged = currentNumChanged + 1;
           end

           if(currentClusterAssignments(dataPoint) == 1)
              cluster1Rows = [cluster1Rows;dataset(dataPoint,:)]; 
           elseif(currentClusterAssignments(dataPoint) == 2)
               cluster2Rows = [cluster2Rows;dataset(dataPoint,:)]; 
           end
        end

        %it has converged
        if(currentNumChanged < 1)
           break; 
        end

        %reassign the clusters
        currentClusters(1,:) = [mean(cluster1Rows(:,1)) mean(cluster1Rows(:,2))];
        currentClusters(2,:) = [mean(cluster2Rows(:,1)) mean(cluster2Rows(:,2))];
    end

    figure
    plot(cluster1Rows(:,1),cluster1Rows(:,2),'r.',...
            cluster2Rows(:,1),cluster2Rows(:,2),'b.'); 
    
    
end

