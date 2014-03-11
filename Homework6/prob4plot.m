means = [1 1;4 4];

boundsY = 0:1/10:5;
sizeBounds = size(boundsY);
numYvals = sizeBounds(2);
xVals = (ones(1,numYvals))*2.5;

figure
hold on;
plot(xVals,boundsY,'r-');
plot(means(:,1),means(:,2),'bx','LineWidth',4);
hold off;


%figures out the numbers for part 2
%{
logPc_1 = 0.8;
logPc_2 = 0.2;
v = -2*(logPc_2 - logPc_1);
mu1 = [1;1];
mu2 = [4;4];
covMat = [1 1;1 4];
uVal = v - transpose(mu2)*covMat*mu2 + transpose(mu1)*covMat*mu1;
mu0 = mu1-mu2;
m1 = transpose(mu0)*covMat;
m2 = covMat*mu0;
wVector = m1 + transpose(m2);
w0vector = -1*uVal;

xVals2 = -3:1/100:10;
yVals2 = -(wVector(1).*xVals + w0vector)/wVector(2);

figure;
hold on;
plot(xVals2,yVals2,'r-');
plot(xVals,yVals,'g-');
plot(means(:,1),means(:,2),'bx','LineWidth',4);
hold off;
%}