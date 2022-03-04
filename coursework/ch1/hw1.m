%%
 %  File: Homework_1.m
 % 
 %  Author: Thomas Kost
 %  
 %  Date: 26 January 2022
 %  
 %  @brief homework 1 matlab comparison of optimal and subotpimal
 %  estimators
 %
 clc, clear all, close all;
 
 %% B: Optimal MSEE performance
 
 noise_variance = 1;
 N = 10;
 p = [0.1 0.3 0.5 0.8];
 x_hat = zeros(length(p),N);
 
 for i = 1:length(p)
     x = bpsk(p(i),1);
    for j = 1:N
        y = randn(1,j)*noise_variance + x;
        x_hat(i,j) = tanh(sum(y)/noise_variance);
    end
 end
 optimal_estimation_performance =figure();
 plot(repmat([1:N],length(p),1)',x_hat')
 legend("p = 0.1", "p=0.3", "p=0.5", "p=0.8");
 
 %% C: Suboptimal Estimator Performance
 N = 300;
 x_hat_sub = zeros(length(p),N);

  for i = 1:length(p)
     x = bpsk(p(i),1);
    for j = 1:N
        y = randn(1,j)*noise_variance + x;
        x_hat_sub(i,j) = mean(y);
    end
  end
 suboptimal_estimation_performance =figure();
 plot(repmat([1:N],length(p),1)',x_hat_sub')
 legend("p = 0.1", "p=0.3", "p=0.5", "p=0.8");
 

 
 %% D: Performance Comparison
 p_fixed = 0.5;
 N = 10;
 num_experiments = 1000;
 x_hat_N = 0;
 x_hat_dec = 0;
 x_hat_N_av = 0;
 x_hat_sign = 0;
 for i = 1:num_experiments
        x = bpsk(p_fixed,1);
        y = randn(1,N)*noise_variance + x;
        x_hat_N = x_hat_N + norm(x - tanh(sum(y)/noise_variance))^2;
        x_hat_dec = x_hat_dec +norm(x - sign(tanh(sum(y)/noise_variance)))^2;
        x_hat_N_av = x_hat_N_av + norm(x - mean(y))^2;
        x_hat_sign = x_hat_sign + norm(x - sign(mean(y)))^2;
 end
x_hat_N = x_hat_N/num_experiments;
 x_hat_dec = x_hat_dec/num_experiments;
 x_hat_N_av = x_hat_N_av/num_experiments;
 x_hat_sign = x_hat_sign/num_experiments;
 
 disp("Showing Variances for each Estimator:")
 disp(['X_hat_N: ', num2str(x_hat_N)]);
 disp(['X_hat_dec: ', num2str(x_hat_dec)]);
 disp(['X_hat_N_av: ', num2str(x_hat_N_av)]);
 disp(['X_hat_sign: ', num2str(x_hat_sign)]);