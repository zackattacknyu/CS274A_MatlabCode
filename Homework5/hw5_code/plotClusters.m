function [] = plotClusters( clusterRows, numPointsCluster, K, muVector, sigmaVector )
%PLOTEMCLUSTERS this plots the clusters
%
%If muVector and sigmaVector are specified, then 
%   the corresponding Gaussian is plotted

if(nargin > 4)
    gaussianFlag = 1;
else 
    gaussianFlag = 0;
end

hold on
if(K == 2)
    if(gaussianFlag)
        plot_gauss_parameters(muVector(1,:),sigmaVector(:,:,1),1,2,'r');
        plot_gauss_parameters(muVector(2,:),sigmaVector(:,:,2),1,2,'g');    
    end
    plot(clusterRows(1:numPointsCluster(1),1,1),...
        clusterRows(1:numPointsCluster(1),2,1),'r.',...
        clusterRows(1:numPointsCluster(2),1,2),...
        clusterRows(1:numPointsCluster(2),2,2),'go');
elseif(K == 3)
    if(gaussianFlag)
        plot_gauss_parameters(muVector(1,:),sigmaVector(:,:,1),1,2,'r');
        plot_gauss_parameters(muVector(2,:),sigmaVector(:,:,2),1,2,'g');
        plot_gauss_parameters(muVector(3,:),sigmaVector(:,:,3),1,2,'b');
    end
    plot(clusterRows(1:numPointsCluster(1),1,1),...
        clusterRows(1:numPointsCluster(1),2,1),'r.',...
        clusterRows(1:numPointsCluster(2),1,2),...
        clusterRows(1:numPointsCluster(2),2,2),'go',...
        clusterRows(1:numPointsCluster(3),1,3),...
        clusterRows(1:numPointsCluster(3),2,3),'bx');
end

if(gaussianFlag == 0)
    plot(muVector(:,1),muVector(:,2),'k+','LineWidth',3); %plots the cluster centers
end

hold off

end

