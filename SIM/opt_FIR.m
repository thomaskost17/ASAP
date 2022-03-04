%%
 %  File: opt_FIR.m
 % 
 %  Author: Thomas Kost
 %  
 %  Date: 12 August 2021
 %  
 %  @brief optimal FIR design
 %
clear, clc, close all;

%% Filter Parameters
% Assume filter symmetric of length M+1
M = 512;
LP_gain_target = 1;
HP_gain_target = 0.1;
Fs = 100;

F_cutoff = 20;
F_width = 5;

freq = (-Fs/2:0.1:Fs/2);
d = LP_gain_target*(-F_cutoff <= freq).*(freq <= F_cutoff) +...
    HP_gain_target*((freq > (F_cutoff)) +(freq < (-F_cutoff)));
hold on;
plot(freq,d);
ylim([0 1]);

delta_p = 0.1; %tolerance on LP
delta_s = 0.05; %tolerance on SB

%% Parks Mclellan Algorithm
T = M/2+2;
L = M/2;

%space guesses out in all regions outside of cutoff region
wk = linspace(0,Fs/2 -2*F_width,T); % Initial Guess
wk = wk +(wk>F_cutoff-F_width)*2*F_width;

W = (wk <F_cutoff)+ delta_p/delta_s*(wk >= F_cutoff);
Hd = (wk < F_cutoff)*LP_gain_target + (wk >=F_cutoff)*HP_gain_target;
scatter(wk,Hd);

% Itterate
E_min = inf;
E_max = 0;
alpha = 1e-6;
itter = 0;
E = 1./W;
while(abs(E_min) < abs((1-alpha)*E_max) || ...
      abs(E_min) > abs(E_max)) && itter < 40
    
    itter = itter + 1;
    x = (0:L);
    [X,Y] = meshgrid(x,wk);
    
    A = cos(Y.*X);
    d = ((-1).^(1:T).*E)';
    Theta = [A,d];
    b_prime =pinv(Theta)*Hd';
        
    p_coeffs = b_prime(1:L+1);
    E = b_prime(T);
    % Generate polynomial and find error
    w = (0:0.001:Fs/2);
    P = sum(cos(w.*x').*p_coeffs,1);
    F_des = LP_gain_target*(-F_cutoff <= w).*(w <= F_cutoff) +...
         HP_gain_target*((w > (F_cutoff) + (w < (-F_cutoff))));
    Error = abs(P-F_des);
    
    %find T minima
    minima = zeros(1,T);
    indicies = zeros(1,T);
    for i=1:T
        [minima(i),indicies(i)] = min(Error);
        % remove for the next iteration the last smallest value:
        Error(indicies(i)) = [];
    end
    E_min = min(minima);
    E_max = max(minima);
    indicies = sort(indicies);
    wk = w(indicies);
    Hd = (wk < F_cutoff)*LP_gain_target + (wk >=F_cutoff)*HP_gain_target;

end
scatter(wk,F_des(indicies), '*');
legend("ideal", "starting freqs", "optimized freqs")
hold off;

figure();
freqz(b_prime);
