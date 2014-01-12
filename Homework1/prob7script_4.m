n1 = 200;
n2 = 200;
mu1 = [0 0];
mu2 = [2 2];
cov1 = [1 0.9; 0.9 1];
cov2 = [1 -0.9; -0.9 1];
result = twogaussian(n1,mu1,cov1,n2,mu2,cov2)