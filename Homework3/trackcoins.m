function trackcoins( p, q , N, alpha, beta, k)
%
% Simulation and Bayesian tracking for a simple "switching coin problem"
%
% Inputs:
% p: probability of heads for "coin 1"
% q: parameter of the Geometric distribution for "run length"
% N: number of coin tosses that will be simulated
% alpha: alpha parameter for the beta prior before the first coin tossHomework 3: CS 274A, Probabilistic Learning: Winter 2014 7
% beta: beta parameter for the beta prior before the first coin toss
% k: integer indicating the window size for "forgetting"
%
% HW3, CS 274A Winter 2014, Prof. Padhraic Smyth
% simulate a sequence of coins:
pheads = p;
for i=1:N
% toss the coin
data(i) = rand < pheads; % generates a "1" with probability pheads
prob(i) = pheads;
fprintf('%d',data(i));
% switch coins or not?
%.....your code goes here for the rest of this function......
% (its convenient to put in an fprintf(’\n’); whenever the coins switch)
end
fprintf('\n');
% plot the coin tosses, true probabilities, and estimated posterior mean
xvalues = 1:N;
figure; plot(xvalues,data,'r.'); % plot data, the binary coin tosses (0 or 1)
hold on;
plot(xvalues,prob,'b*'); % plot the true coin probability for each turn
plot(xvalues,mpe,'g:','linewidth',3); % plot the estimated posterior mean
axis([0 N+1 -0.1 1.1]);

