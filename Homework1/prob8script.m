%4 different values of n for the problem
%n = 100;
%n = 1000;
%n = 10000;
n = 100000;

%rand(1,n) will generate the X_i's for a particular y
%they are summed up and then the result is divided by n to obtain Y
Y = [];
for j=1:1000
    Y = [Y sum(rand(1,n))*(1/n)];
end
%plot the histogram of the Y vector
histData = hist(Y,30);
bar(histData)