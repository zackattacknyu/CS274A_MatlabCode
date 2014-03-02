load('dataset1.txt');
load('dataset2.txt');
load('dataset3.txt');

plot(dataset1(:,1),dataset1(:,2),'r.');
%plot(dataset2(:,1),dataset2(:,2));

%does k-means
dataset = dataset1;
k=2;
datasetSize = size(dataset);
numPoints = datasetSize(1);

randOrder = randperm(numPoints);
meanRows = randOrder(1:k);

%assign the cluster rows randomly
currentClusters = zeros(k,2);
for row = 1:k
    currentClusters(row,:) = dataset(meanRows(row),:);
end


currentClusterAssignments = zeros(numPoints,1);

for iteration = 1:3
    currentNumChanged = 0;
    cluster1Rows = [];
    cluster2Rows = [];
    
    %loop through the data points finding the closest cluster for each point
    for dataPoint = 1:numPoints
        currentMinDistance = 20;
       for cluster = 1:k
           currentDistance = norm(currentClusters(cluster,:)-dataset(dataPoint,:));
           if(currentDistance < currentMinDistance)
               if(currentClusterAssignments(dataPoint,1) ~= cluster)
                   currentClusterAssignments(dataPoint,1) = cluster;
                   currentNumChanged = currentNumChanged + 1;
               end
              currentMinDistance = currentDistance;
           end
           
       end

       if(currentClusterAssignments(dataPoint,1) == 1)
          cluster1Rows = [cluster1Rows;dataset(dataPoint,:)]; 
       elseif(currentClusterAssignments(dataPoint,1) == 2)
           cluster2Rows = [cluster2Rows;dataset(dataPoint,:)]; 
       end
    end

    
    plot(cluster1Rows(:,1),cluster1Rows(:,2),'r.',...
        cluster2Rows(:,1),cluster2Rows(:,2),'b.');
    figure
    
    %reassign the clusters
    currentClusters(1,:) = [mean(cluster1Rows(:,1)) mean(cluster1Rows(:,2))];
    currentClusters(2,:) = [mean(cluster2Rows(:,1)) mean(cluster2Rows(:,2))];
end

