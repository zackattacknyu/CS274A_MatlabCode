xVals = -4:1/100:9;
equ1Vals = exp((-1.*xVals.^2)/2)/(2*sqrt(2*pi));
equ2Vals = exp((-1.*(xVals-3).^2)/6)/(2*sqrt(6*pi));
plot(xVals,equ1Vals,xVals,equ2Vals);