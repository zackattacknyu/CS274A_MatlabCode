means = [1 1;4 4];

boundsY = 0:1/10:5;
sizeBounds = size(boundsY);
numYvals = sizeBounds(2);

%for part 1
%xVals = (ones(1,numYvals))*2.5;

%for part 2
xVals = (ones(1,numYvals))*((15+2*log(4))/6);


figure
hold on;
plot(xVals,boundsY,'r-');
plot(means(:,1),means(:,2),'bx','LineWidth',4);
hold off;