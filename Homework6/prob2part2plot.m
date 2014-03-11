xVals = 1:0.01:25;
yVals1 = .5*exp(-xVals);
yVals2 = ((xVals >= 2)&(xVals<=22))*0.05*0.5;
boundsY = -0.02:1/10:0.2;
sizeBounds = size(boundsY);
numYvals = sizeBounds(2);
boundX = ones(1,numYvals);
root1 = log(20);
root2 = 22;
bound1X = boundX.*root1;
bound2X = boundX.*root2;
plot(xVals,yVals2,'g-',xVals,yVals1,'b-',bound1X,boundsY,'r--',bound2X,boundsY,'r--');
xlabel('X value');
ylabel('Probability');
title('Probability of different class labels');
legend('Class 1 Probability','Class 2 Probability','Decision Boundary');