xVals = -4:1/100:9;
equ1Vals = exp((-1.*xVals.^2)/2)/(2*sqrt(2*pi));
equ2Vals = exp((-1.*(xVals-3).^2)/6)/(2*sqrt(6*pi));
a = -2;
b = -6;
c = 9 - 3*log(3);
disc = b^2-4*a*c;
root1 = (-b + sqrt(disc))/(2*a);
root2 = (-b - sqrt(disc))/(2*a);
boundsY = 0:1/10:0.2;
sizeBounds = size(boundsY);
numYvals = sizeBounds(2);
boundX = ones(1,numYvals);
bound1X = boundX.*root1;
bound2X = boundX.*root2;
plot(xVals,equ1Vals,'g-',xVals,equ2Vals,'b-',bound1X,boundsY,'r--',bound2X,boundsY,'r--');