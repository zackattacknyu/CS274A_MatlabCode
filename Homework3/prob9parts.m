
%{
Values to use for all of them
N = 1000;  alpha = 1; beta = 1

Values for individual calls
 p = 0.9; q = 0.02; k = 10.
 p = 0.9; q = 0.02; k = 50.
 p = 0.9; q = 0.1; k = 10.
 p = 0.9; q = 0.1; k = 50.
 p = 0.6; q = 0.02; k = 10.
 p = 0.6; q = 0.02; k = 50.
%}


N = 1000;
alpha = 1;
beta = 1;

part = 1;

if(part == 1)
    p = 0.9;
    q = 0.02;
    k = 10;
elseif(part == 2)
    p = 0.9;
    q = 0.02;
    k = 50;
elseif(part == 3)
    p = 0.9;
    q = 0.1;
    k = 10;
elseif(part == 4)
    p = 0.9;
    q = 0.1;
    k = 50;    
elseif(part == 5)
    p = 0.6;
    q = 0.02;
    k = 10;         
elseif(part == 6)
    p = 0.6;
    q = 0.02;
    k = 50;
end

trackcoins(p,q,N,alpha,beta,k)
