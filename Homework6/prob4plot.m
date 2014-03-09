means = [1 1;4 4];

xVals = -3:1/100:10;
yVals = (-12.*xVals + 105)/30;

hold on;
plot(xVals,yVals,'r-');
plot(means(:,1),means(:,2),'bx','LineWidth',4);
hold off;