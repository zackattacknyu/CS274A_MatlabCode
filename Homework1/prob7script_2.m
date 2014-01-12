n1 = 200;
n2 = 200;
mu1 = [0 0];
mu2 = [2 2];
cov1 = [1 0; 0 1];
cov2 = [5 0; 0 1];
result = twogaussian(n1,mu1,cov1,n2,mu2,cov2)