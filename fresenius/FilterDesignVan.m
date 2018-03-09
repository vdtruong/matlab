% Digital filter design by Greg Gengerelli.
% To use this design, change the corner and sampling
% frequencies you want to use.  The Tf period is for
% how long you want the signal to last.

clear;
close all;
format long;

% Parameters
% Choose the corner frequency you want.
% Corner frequency of 250 mHz
Tf = 5      % how long the signal lasts          
Ts = 0.500  % sampling period
Fc = 0.5    % corner frequency
% Corner frequency of 250 mHz
%Tf = 20           
%Ts = 0.500  % sampling period
%Fc = 0.25   % corner frequency
% Corner frequency of 10 mHz
%Tf = 10           
%Ts = 0.500  % sampling period
%Fc = 0.01   % corner frequency
% Sampling period of 50 Hz
%Ts = 20E-3  % sampling period
%Fc = 2      % corner frequency
%Tf = 10     
% Sampling period of
% Ts = 200E-3;%250E-6;
% Fc = 0.1;
% Tf = 10;
% Sampling period of
% Ts = 0.2;
% Fc = 0.01;
% Tf = 100;

% Calculate frequencies from period parameters.
fs = 1/Ts   % sampling frequency
ff = 1/Tf   
% Calculate period from frequency
Tc = 1/Fc
% Calculate radial frequencies.
Ws = 2*pi*(1/Ts)
Wc = 2*pi*Fc
Wn = Wc/Ws
% Calculate the filter coefficients.
[zb,za] = butter(1,Wn)
% Returns the pole, zero and gain.
[z,p,k] = butter(1,Wn)
%freqz(zb,za)
zplane(z,p)


%STEP INPUT RESPONSE
x = linspace(0,Tf,floor(Tf/Ts));
nsize = size(x);
y = ones(nsize(2));

figure(2);
yFilt = filter(zb,za,y);
plot(x,y,'b',x,yFilt,'r+');
title('Step Response');
legend('Vin','Vout');
xlabel('Time (s)');
ylabel('Voltage (V)');

b = [1];
a = [1/Wc 1];
w = logspace(-2,2);
h = freqs(b,a,w);
mag = abs(h);
mag = 20*log10(mag);
phase = angle(h);
phase = (360/(2*pi))*phase;
f = w/(2*pi);

%ANALOG FEQUENCY RESPONSE
figure(gcf+1);
subplot(2,1,1)
semilogx(f,mag);grid on;
title(strcat('RC Filter Analog Response - ',Fc,'Hz'));
xlabel('Frequency Hz');
ylabel('Magnitude dB');
subplot(2,1,2)
semilogx(f,phase);grid on;
xlabel('Frequency Hz');
ylabel('Phase Degrees');







