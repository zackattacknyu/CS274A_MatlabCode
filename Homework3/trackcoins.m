function trackcoins( p, q , N, alpha, beta, k)
%
% Simulation and Bayesian tracking for a simple "switching coin problem"
%
% Inputs:
% p: probability of heads for "coin 1"
% q: parameter of the Geometric distribution for "run length"
% N: number of coin tosses that will be simulated
% alpha: alpha parameter for the beta prior before the first coin toss
% beta: beta parameter for the beta prior before the first coin toss
% k: integer indicating the window size for "forgetting"
% simulate a sequence of coins:
pheads = p;

%sets r_1
remainingTosses = geornd(q);

%preallocating data and prob arrays
data = 1:1:N;
prob = 1:1:N;

%toss the coin
for i=1:N
    
    %find out if the probability needs to be switched
    if(remainingTosses <= 0)
        
        %sets the next r value
        remainingTosses = geornd(q);
        
        %switch the probability
        pheads = 1 - pheads;
        fprintf('\n');
    end
    
    % toss the coin
    data(i) = rand < pheads; % generates a "1" with probability pheads
    prob(i) = pheads;
    fprintf('%d ',data(i));
    
    %decrement the remaining tosses before the switch
    remainingTosses = remainingTosses - 1;
end
fprintf('\n');
% plot the coin tosses, true probabilities, and estimated posterior mean
xvalues = 1:N;
figure; plot(xvalues,data,'r.'); % plot data, the binary coin tosses (0 or 1)
hold on;
plot(xvalues,prob,'b*'); % plot the true coin probability for each turn
%plot(xvalues,mpe,'g:','linewidth',3); % plot the estimated posterior mean
axis([0 N+1 -0.1 1.1]);

