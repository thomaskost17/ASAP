%%
 %  File: adaptive_notch_filter.m
 % 
 %  Author: Thomas Kost
 %  
 %  Date: 12 August 2021
 %  
 %  @brief adaptive notch filter using Least Mean Squares Adaptive Filter
 %
clear, clc, close all;

%% Create signal
freq = 50;
duty = 50;
dt = 0.001;
time = 10;
N = 1/dt*time;
fs = 1/dt;  
t = (0:dt:time-dt);
x = square(2*pi*freq*t, duty);
x = x.*(x>0);

f = fft(hanning(N)'.*x);

%% Introduce Noise
snr =25;
% add tone
start_tone = 10;
end_tone = 150;
varying_tone = sin(2.*pi.*(((1:N).*(end_tone-start_tone)/N)+start_tone).*t);
x_hat = x + varying_tone;

x_hat = awgn(x_hat, snr);
f_hat = fft(x_hat);

%% Plot Inputs
figure();
subplot(2,2,1);
plot(t,x);
title("True Square Wave")
xlim([0 0.1]);
xlabel("Time (s)");
ylabel("x(t)");
subplot(2,2,2);
plot(linspace(-fs/2,fs/2,N),fftshift(abs(f)));
title("True Square Wave Spectrum")
xlabel("w (Hz)");
ylabel("X(jw)");
subplot(2,2,3);
plot(t,x_hat);
title("Noisy Square Wave")
xlabel("Time (s)");
ylabel("~x(t)");
xlim([0 0.1]);
subplot(2,2,4);
plot(linspace(-fs/2,fs/2,N),fftshift(abs(f_hat)));
xlabel("w (Hz)");
ylabel("~X(jw)");
title("Noisy Square Wave Spectrum")

%% Create Filter
window_len = 50;
U = 0.1;
h = zeros(2,window_len);
X = [cos(2*pi*(fs/2)*(1:window_len)*dt);
     sin(2*pi*(fs/2)*(1:window_len)*dt)];

%% Filter Data
overlap = 0.5;
i =1;
while(i<N-window_len)
    d = x_hat(i:i+window_len-1); %read in signal
    
    i = i + overlap*window_len;
end
%% Plot Results

%% Error Metrics


