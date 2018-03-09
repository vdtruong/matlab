% The Pressure Simulation will take a raw pressure reading and simulate
% ADC, filtering, fitting and zeroing.
% 9/25/2015

% Filter Design -------------------------------------- 
% Digital filter design by Greg Gengerelli.
% To use this design, change the corner and sampling
% frequencies you want to use.  The Tf period is for
% how long you want the signal to last.

clear;
close all;
format long;

% Parameters
% Choose the corner frequency you want.
% Corner frequency of 2 Hz
Tf = 15;       % how long the signal lasts in seconds      
Ts = 0.020;    % sampling period of 20 ms
Fc = 2;        % corner frequency of 2

% Calculate frequencies from period parameters.
fs = 1/Ts;     % sampling frequency
ff = 1/Tf;   
% Calculate period from corner frequency
Tc = 1/Fc;
% Calculate radial frequencies.
Ws = 2*pi*(1/Ts);
Wc = 2*pi*Fc;
Wn = Wc/Ws;
% Calculate the filter coefficients.
[zb,za] = butter(1,Wn)
% End of Filter Design --------------------------------

% Extracting pressure data from a file -------------------------
%fid   = fopen('C:\Log_Files\rd3_els_rate_250mHz_pucs_filter_2nd_run_15_08_18_10_51.csv');
%fid   = fopen('C:\Log_Files\vv4_model_press_15_09_25_15_45_Copy.csv');
%fid   = fopen('C:\Log_Files\rd10_press_mon_15_09_30_19_14_Copy.csv');
fid   = fopen('C:\Log_Files\vv4_press_mon_15_10_02_12_52_Copy.csv');
fgetl(fid);   %skip first line
% date, time, master state, alarm state, ven mm(1), bp mm(2), dp in mm(3), dp out
% mm(4), sorb in mm(5), tmp mm(6), ven adc(7), bp adc(8), dp in adc(9), dp out adc(10)
C = textscan(fid, '%*s %*s %*s %*s %f %f %f %f %f %f %f %f %f %f', 'delimiter', ',');
fclose(fid);
% 
whos C;

% Setting constants.
m                    = 15300;  % The time in 1/2 second to monitor signal.
%[sig_lgth_1_2sec p]  = size(C{cola});        % size of signal
k                    = 4000:1:m;  % x axis length
cola                 = 7;                    %Pressure Venous in double (hextodouble) adc
colb                 = 8;                    %Pressure BP in double adc
colc                 = 9;                    %Pressure DP1 in double adc
cold                 = 10;                   %Pressure DP2 in double adc
%C{colb}(k);
% End of data extraction ---------------------------------

% Measured Response ----------------------------------------------------
yVenMeas    = C{1}(k); %C{1}(1211)   % row starts at 0
yBpMeas     = C{2}(k);
yDinMeas    = C{3}(k);
yDoutMeas   = C{4}(k);

% ADC convert a number ----------------------------------
adc16BitHalfLsb         = 0.007099151611328125;  % fixed point of 3.3/(2*65535)
nSize                   = 36; % 36 bits fixed point number
nRadix                  = 18; % 18 integer, 18 decimal
% Convert number from double to hex (fixed point)
% DPAK will convert hex to double, so we need to do the reverse here.
% This will give us the blue rectangle box hex value.
yVenDoubleToHex         = DoubleToHex(C{cola}(k),nSize,nRadix);
yBpDoubleToHex          = DoubleToHex(C{colb}(k),nSize,nRadix);
yDinDoubleToHex         = DoubleToHex(C{colc}(k),nSize,nRadix);
yDoutDoubleToHex        = DoubleToHex(C{cold}(k),nSize,nRadix);
% convert hex to decimal
yVenHexToDec            = hex2dec(yVenDoubleToHex);
%yVenBitLeftShift        = bitshift(yVenHexToDec,nRadix)
% Venous pressure in fixed point number
yVenFix                 = (TwosComplimentFromString(dec2bin(yVenHexToDec),36)*2^-18);
%yVenDec2BinLeftShift    = dec2bin(yVenHexToDec,36)
% The data from the file is already converted from a fixed point number.
% Now we just have to convert it to voltage.
% The ADC is 16 bit.
yVenFixVolt             = hex2dec(yVenDoubleToHex) * adc16BitHalfLsb * adc16BitHalfLsb;
yBpFixVolt              = hex2dec(yBpDoubleToHex) * adc16BitHalfLsb * adc16BitHalfLsb;
yDinFixVolt             = hex2dec(yDinDoubleToHex) * adc16BitHalfLsb * adc16BitHalfLsb;
yDoutFixVolt            = hex2dec(yDoutDoubleToHex) * adc16BitHalfLsb * adc16BitHalfLsb;
% End of ADC convert -------------------------------------

% Filter the signal --------------------------------------
yVenFixVoltFilt1stOrder    = filter(zb,za,yVenFixVolt);
yVenFixVoltFilt2ndOrder    = filter(zb,za,yVenFixVoltFilt1stOrder);
yVenFixVoltFilt3rdOrder    = filter(zb,za,yVenFixVoltFilt2ndOrder);
yVenFixVoltFilt4thOrder    = filter(zb,za,yVenFixVoltFilt3rdOrder);
yBpFixVoltFilt1stOrder     = filter(zb,za,yBpFixVolt);
yBpFixVoltFilt2ndOrder     = filter(zb,za,yBpFixVoltFilt1stOrder);
yBpFixVoltFilt3rdOrder     = filter(zb,za,yBpFixVoltFilt2ndOrder);
yBpFixVoltFilt4thOrder     = filter(zb,za,yBpFixVoltFilt3rdOrder);
yDinFixVoltFilt1stOrder    = filter(zb,za,yDinFixVolt);
yDinFixVoltFilt2ndOrder    = filter(zb,za,yDinFixVoltFilt1stOrder);
yDinFixVoltFilt3rdOrder    = filter(zb,za,yDinFixVoltFilt2ndOrder);
yDinFixVoltFilt4thOrder    = filter(zb,za,yDinFixVoltFilt3rdOrder);
yDoutFixVoltFilt1stOrder   = filter(zb,za,yDoutFixVolt);
yDoutFixVoltFilt2ndOrder   = filter(zb,za,yDoutFixVoltFilt1stOrder);
yDoutFixVoltFilt3rdOrder   = filter(zb,za,yDoutFixVoltFilt2ndOrder);
yDoutFixVoltFilt4thOrder   = filter(zb,za,yDoutFixVoltFilt3rdOrder);
%yVenFixVoltFilt4thOrder(k) = filter(zb,za,yVenFixVoltFilt3rdOrder)
% End of signal filter ----------------------------------

% Fit data with 5th order poly. ----------------------------
% Extract coefficients 
%fid   = fopen('C:\Calibration\Pressure_Calibration\15-Sep-01 RD10_Press_Const 001.csv');
fid   = fopen('C:\Calibration\Pressure_Calibration\15-Sep-18 VV4_Press_Const 011.csv');
fgetl(fid);   %skip first line
% date, sensor, ko(1), k1(2), k2(3), k3(4), k4(5), k5(6)
D = textscan(fid, '%*s %*s %f %f %f %f %f %f', 'delimiter', ',');
fclose(fid);
%
whos D;
% Coefficients layout
ven_row  = 1;
bp_row   = 2;
din_row  = 3;
dout_row = 4;
sorb_row = 5;
colk0 = 1;
colk1 = 2;
colk2 = 3;
colk3 = 4;
colk4 = 5;
colk5 = 6;
D{1}(ven_row); % One element
D{1};          % One column

ven_press_a5   = D{colk5}(ven_row);
ven_press_a4   = D{colk4}(ven_row);
ven_press_a3   = D{colk3}(ven_row);
ven_press_a2   = D{colk2}(ven_row);
ven_press_a1   = D{colk1}(ven_row);
ven_press_a0   = D{colk0}(ven_row);

bp_press_a5    = D{colk5}(bp_row);
bp_press_a4    = D{colk4}(bp_row);
bp_press_a3    = D{colk3}(bp_row);
bp_press_a2    = D{colk2}(bp_row);
bp_press_a1    = D{colk1}(bp_row);
bp_press_a0    = D{colk0}(bp_row);

din_press_a5   = D{colk5}(din_row);
din_press_a4   = D{colk4}(din_row);
din_press_a3   = D{colk3}(din_row);
din_press_a2   = D{colk2}(din_row);
din_press_a1   = D{colk1}(din_row);
din_press_a0   = D{colk0}(din_row);

dout_press_a5  = D{colk5}(dout_row);
dout_press_a4  = D{colk4}(dout_row);
dout_press_a3  = D{colk3}(dout_row);
dout_press_a2  = D{colk2}(dout_row);
dout_press_a1  = D{colk1}(dout_row);
dout_press_a0  = D{colk0}(dout_row);

% Fit data according to the Simulink model.
% .* is for element by element multiplication
ven_x5_a5 = (yVenFixVoltFilt4thOrder * ven_press_a5) .* yVenFixVoltFilt4thOrder .* yVenFixVoltFilt4thOrder .* yVenFixVoltFilt4thOrder .* yVenFixVoltFilt4thOrder;
ven_x4_a4 = (yVenFixVoltFilt4thOrder * ven_press_a4) .* yVenFixVoltFilt4thOrder .* yVenFixVoltFilt4thOrder .* yVenFixVoltFilt4thOrder;
ven_x3_a3 = (yVenFixVoltFilt4thOrder * ven_press_a3) .* yVenFixVoltFilt4thOrder .* yVenFixVoltFilt4thOrder;
ven_x2_a2 = (yVenFixVoltFilt4thOrder * ven_press_a2) .* yVenFixVoltFilt4thOrder;
ven_x1_a1 =  yVenFixVoltFilt4thOrder * ven_press_a1;
ven_high_order_terms = ven_x5_a5 + ven_x4_a4;
ven_mid_order_terms  = ven_x3_a3 + ven_x2_a2;
ven_low_order_terms  = ven_x1_a1 + ven_press_a0;

yVenPress = ven_high_order_terms + ven_mid_order_terms + ven_low_order_terms;
% End fit data for Venous Pressure 

bp_x5_a5 = (yBpFixVoltFilt4thOrder * bp_press_a5) .* yBpFixVoltFilt4thOrder .* yBpFixVoltFilt4thOrder .* yBpFixVoltFilt4thOrder .* yBpFixVoltFilt4thOrder;
bp_x4_a4 = (yBpFixVoltFilt4thOrder * bp_press_a4) .* yBpFixVoltFilt4thOrder .* yBpFixVoltFilt4thOrder .* yBpFixVoltFilt4thOrder;
bp_x3_a3 = (yBpFixVoltFilt4thOrder * bp_press_a3) .* yBpFixVoltFilt4thOrder .* yBpFixVoltFilt4thOrder;
bp_x2_a2 = (yBpFixVoltFilt4thOrder * bp_press_a2) .* yBpFixVoltFilt4thOrder;
bp_x1_a1 =  yBpFixVoltFilt4thOrder * bp_press_a1;
bp_high_order_terms = bp_x5_a5 + bp_x4_a4;
bp_mid_order_terms  = bp_x3_a3 + bp_x2_a2;
bp_low_order_terms  = bp_x1_a1 + bp_press_a0;

yBpPress = bp_high_order_terms + bp_mid_order_terms + bp_low_order_terms;
% End fit data for BPout Pressure 

din_x5_a5 = (yDinFixVoltFilt4thOrder * din_press_a5) .* yDinFixVoltFilt4thOrder .* yDinFixVoltFilt4thOrder .* yDinFixVoltFilt4thOrder .* yDinFixVoltFilt4thOrder;
din_x4_a4 = (yDinFixVoltFilt4thOrder * din_press_a4) .* yDinFixVoltFilt4thOrder .* yDinFixVoltFilt4thOrder .* yDinFixVoltFilt4thOrder;
din_x3_a3 = (yDinFixVoltFilt4thOrder * din_press_a3) .* yDinFixVoltFilt4thOrder .* yDinFixVoltFilt4thOrder;
din_x2_a2 = (yDinFixVoltFilt4thOrder * din_press_a2) .* yDinFixVoltFilt4thOrder;
din_x1_a1 =  yDinFixVoltFilt4thOrder * din_press_a1;
din_high_order_terms = din_x5_a5 + din_x4_a4;
din_mid_order_terms  = din_x3_a3 + din_x2_a2;
din_low_order_terms  = din_x1_a1 + din_press_a0;

yDinPress = din_high_order_terms + din_mid_order_terms + din_low_order_terms;
% End fit data for Din Pressure 

dout_x5_a5 = (yDoutFixVoltFilt4thOrder .^ 5) * dout_press_a5;
dout_x4_a4 = (yDoutFixVoltFilt4thOrder .^ 4) * dout_press_a4;
dout_x3_a3 = (yDoutFixVoltFilt4thOrder .^ 3) * dout_press_a3;
dout_x2_a2 = (yDoutFixVoltFilt4thOrder .^ 2) * dout_press_a2;
dout_x1_a1 =  yDoutFixVoltFilt4thOrder * dout_press_a1;
dout_high_order_terms = dout_x5_a5 + dout_x4_a4;
dout_mid_order_terms  = dout_x3_a3 + dout_x2_a2;
dout_low_order_terms  = dout_x1_a1 + dout_press_a0;

yDoutPress = dout_high_order_terms + dout_mid_order_terms + dout_low_order_terms;
% End fit data for Dout Pressure
% End fit data ------------------------------------------------------------

% Simulate filter with data ------------------------------
%plot(k,yVenFix,'r'); % normalized with 1 volt

% The followings are raw pressures in voltage.

figure(2);
% plot(k,yVenFixVolt,'r');
% title('Raw Ven Pressure');
% legend('Raw Ven Pressure (V)');
% xlabel('Time (Every 1/2s)');
% ylabel('Pressure (V)');

plot(k,yBpFixVolt,'r');
title('Raw BP Pressure');
legend('Raw BP Pressure (V)');
xlabel('Time (Every 1/2s)');
ylabel('Pressure (V)');

% plot(k,yDinFixVolt,'r');
% title('Raw Din Pressure');
% legend('Raw Din Pressure (V)');
% xlabel('Time (Every 1/2s)');
% ylabel('Pressure (V)');

% plot(k,yDoutFixVolt,'r');
% title('Raw Dout Pressure');
% legend('Raw Dout Pressure (V)');
% xlabel('Time (Every 1/2s)');
% ylabel('Pressure (V)');

% The followings are pressures in mmHg.
% They are measured and simulated.
figure(3);
% plot(k,yVenPress,'r',k,yVenMeas,'b');
% title('Filtered and Fitted Response');
% legend('Venous Pressure mmHg');
% xlabel('Time (1/2s)');
% ylabel('Pressure (mmHg)');

plot(k,yBpPress,'r',k,yBpMeas,'b');
title('Fitted and Measured Response');
legend('BP Sim Pressure mmHg','BP Meas Pressure mmHg');
xlabel('Time (Every 1/2s)');
ylabel('Pressure (mmHg)');

% plot(k,yDinPress,'r',k,yDinMeas,'b');
% title('Fitted and Measured Response');
% legend('Din Sim Pressure mmHg','Din Meas Pressure mmHg');
% xlabel('Time (Every 1/2s)');
% ylabel('Pressure (mmHg)');

% plot(k,yDoutPress,'r',k,yDoutMeas,'b');
% title('Fitted and Measured Response');
% legend('Dout Sim Pressure mmHg','Dout Meas Pressure mmHg');
% xlabel('Time (Every 1/2s)');
% ylabel('Pressure (mmHg)');

% The followings are the measured response in mmHg.
figure(4);
% plot(k,yVenMeas,'b');
% title('Measured Ven Response');
% legend('Meas Ven Pressure mmHg');
% xlabel('Time (Every 1/2s)');
% ylabel('Pressure (mmHg)');

plot(k,yBpMeas,'b');
title('Measured BP Response');
legend('Meas BP Pressure mmHg');
xlabel('Time (Every 1/2s)');
ylabel('Pressure (mmHg)');

% plot(k,yDinMeas,'b');
% title('Measured Din Response');
% legend('Meas Din Pressure mmHg');
% xlabel('Time (Every 1/2s)');
% ylabel('Pressure (mmHg)');

% plot(k,yDoutMeas,'b');
% title('Measured Dout Response');
% legend('Meas Dout Pressure mmHg');
% xlabel('Time (Every 1/2s)');
% ylabel('Pressure (mmHg)');