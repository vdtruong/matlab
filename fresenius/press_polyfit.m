% Pressure Polyfit Calculation

close all;

% All pressures and pressure regulatgor data rows and columns.
ven_bp_strt_row = 1;
din_strt_row    = 18;
sorb_strt_row   = 33;
ven_col         = 5;
bp_col          = 3;
din_col         = 6;
dout_col        = 7;
sorb_col        = 4;
ven_end_row     = 17;
din_end_row     = 32;
sorb_end_row    = 45;
press_reg_col   = 2;
n               = 0; % starting figure number
%--------------------------------------------------------------------------
% For Venous.
% Venous pressure data.
x = csvread('C:\Calibration\Pressure_Calibration\16-Feb-22 VV26_Press_Data 001.csv', ... 
    ven_bp_strt_row, ven_col, [ven_bp_strt_row, ven_col, ven_end_row, ven_col]);
% Pressure gage output.
y = csvread('C:\Calibration\Pressure_Calibration\16-Feb-22 VV26_Press_Data 001.csv', ...
    ven_bp_strt_row, press_reg_col, [ven_bp_strt_row, press_reg_col, ven_end_row, press_reg_col]);
% Polyfit of pressure data vs. gage output.
pVen = polyfit(x,y,5);
press_volt = 0:0.1:3.3;       % Define a uniformly spaced pressure voltage vector
y2=polyval(pVen,press_volt);  % Evaluate the polynomial at press_volt
n = n + 1;                    % increment figure number
figure(n)
plot(x,y,'o',press_volt,y2)   % Plot the fit on top of the data
xlabel('Pressure (V)')
ylabel('Pressure (mmHg)')
title('Venous Pressure 5th Order Polyfit, 16-Feb-22 VV26')
%--------------------------------------------------------------------------
% For BPout.
% BPout pressure data.
x = csvread('C:\Calibration\Pressure_Calibration\16-Feb-22 VV26_Press_Data 001.csv', ... 
    ven_bp_strt_row, bp_col, [ven_bp_strt_row, bp_col, ven_end_row, bp_col]);
% Pressure gage output.
y = csvread('C:\Calibration\Pressure_Calibration\16-Feb-22 VV26_Press_Data 001.csv', ...
    ven_bp_strt_row, press_reg_col, [ven_bp_strt_row, press_reg_col, ven_end_row, press_reg_col]);
% Polyfit of pressure data vs. gage output.
pBp = polyfit(x,y,5);
press_volt = 0:0.1:3.3;       % Define a uniformly spaced pressure voltage vector
y2=polyval(pBp,press_volt);   % Evaluate the polynomial at press_volt
n = n + 1;
figure(n)
plot(x,y,'o',press_volt,y2)   % Plot the fit on top of the data
xlabel('Pressure (V)')
ylabel('Pressure (mmHg)')
title('BPout Pressure 5th Order Polyfit, 16-Feb-22 VV26')
%--------------------------------------------------------------------------
% For DIn.
% DIn pressure data.
x = csvread('C:\Calibration\Pressure_Calibration\16-Feb-22 VV26_Press_Data 001.csv', ... 
    din_strt_row, din_col, [din_strt_row, din_col, din_end_row, din_col]);
% Pressure gage output.
y = csvread('C:\Calibration\Pressure_Calibration\16-Feb-22 VV26_Press_Data 001.csv', ...
    din_strt_row, press_reg_col, [din_strt_row, press_reg_col, din_end_row, press_reg_col]);
% Polyfit of pressure data vs. gage output.
dinp = polyfit(x,y,5);
press_volt = 0:0.1:3.3;       % Define a uniformly spaced pressure voltage vector
y2=polyval(dinp,press_volt);   % Evaluate the polynomial at press_volt
n = n + 1;
figure(n)
plot(x,y,'o',press_volt,y2)   % Plot the fit on top of the data
xlabel('Pressure (V)')
ylabel('Pressure (mmHg)')
title('DInout Pressure 5th Order Polyfit, 16-Feb-22 VV26')
%--------------------------------------------------------------------------
% For DOut.
% DOut pressure data.
x = csvread('C:\Calibration\Pressure_Calibration\16-Feb-22 VV26_Press_Data 001.csv', ... 
    din_strt_row, dout_col, [din_strt_row, dout_col, din_end_row, dout_col]);
% Pressure gage output.
y = csvread('C:\Calibration\Pressure_Calibration\16-Feb-22 VV26_Press_Data 001.csv', ...
    din_strt_row, press_reg_col, [din_strt_row, press_reg_col, din_end_row, press_reg_col]);
% Polyfit of pressure data vs. gage output.
doutp = polyfit(x,y,5);
press_volt = 0:0.1:3.3;          % Define a uniformly spaced pressure voltage vector
y2=polyval(doutp,press_volt);    % Evaluate the polynomial at press_volt
n = n + 1;
figure(n)
plot(x,y,'o',press_volt,y2)      % Plot the fit on top of the data
xlabel('Pressure (V)')
ylabel('Pressure (mmHg)')
title('DOut Pressure 5th Order Polyfit, 16-Feb-22 VV26')
%--------------------------------------------------------------------------
% For Sorbent.
% Sorbent pressure data.
x = csvread('C:\Calibration\Pressure_Calibration\16-Feb-22 VV26_Press_Data 001.csv', ... 
    sorb_strt_row, sorb_col, [sorb_strt_row, sorb_col, sorb_end_row, sorb_col]);
% Pressure gage output.
y = csvread('C:\Calibration\Pressure_Calibration\16-Feb-22 VV26_Press_Data 001.csv', ...
    sorb_strt_row, press_reg_col, [sorb_strt_row, press_reg_col, sorb_end_row, press_reg_col]);
% Polyfit of pressure data vs. gage output.
sorbp = polyfit(x,y,5);
press_volt = 0:0.1:3.3;          % Define a uniformly spaced pressure voltage vector
y2=polyval(sorbp,press_volt);    % Evaluate the polynomial at press_volt
n = n + 1;
figure(n)
plot(x,y,'o',press_volt,y2)      % Plot the fit on top of the data
xlabel('Pressure (V)')
ylabel('Pressure (mmHg)')
title('Sorbent Pressure 5th Order Polyfit, 16-Feb-22 VV26')
%--------------------------------------------------------------------------
% Check voltage output of VV26 Venous pressure with polyfit equation.
% Measured Venous pressure output, unit is in volt.
ven_volt = [0.7217, 1.0181, 1.2744, 1.5254, 1.7759, 2.0335, 2.288, 2.5458, ...
           2.8169, 2.9006, 2.9153, 2.9423, 2.9700, 2.9952, 3.0128, 3.0261, ...
           3.0454, 3.0591];
yVen=polyval(pVen,ven_volt);  % Evaluate the polynomial at press_volt
n = n + 1;
figure(n)
plot(ven_volt,yVen,'-+')       % Plot the fit on top of the data
xlabel('Venous Pressure (V)')
ylabel('Polyfit Pressure (mmHg)')
title('Venous Pressure 5th Order Polyfit, 16-Feb-22 VV26')
%---------------------------------------------------------------
% For 16-Mar-01 VV25_Press_Data 001.
% Venous pressure data.
x = csvread('C:\Calibration\Pressure_Calibration\16-Mar-01 VV25_Press_Data 001.csv', ... 
    ven_bp_strt_row, ven_col, [ven_bp_strt_row, ven_col, ven_end_row, ven_col]);
% Pressure gage output.
y = csvread('C:\Calibration\Pressure_Calibration\16-Mar-01 VV25_Press_Data 001.csv', ...
    ven_bp_strt_row, press_reg_col, [ven_bp_strt_row, press_reg_col, ven_end_row, press_reg_col]);
% Polyfit of pressure data vs. gage output.
pVen = polyfit(x,y,5);
press_volt = 0:0.1:3.3;       % Define a uniformly spaced pressure voltage vector
y2=polyval(pVen,press_volt);  % Evaluate the polynomial at press_volt
n = n + 1;
figure(n)
plot(x,y,'o',press_volt,y2)   % Plot the fit on top of the data
xlabel('Pressure (V)')
ylabel('Pressure (mmHg)')
title('Venous Pressure 5th Order Polyfit, 16-Mar-01 VV25_Press_Data 001')
%--------------------------------------------------------------------------
% For 16-Mar-01 VV25_Press_Data 001.
% BPout pressure data.
x = csvread('C:\Calibration\Pressure_Calibration\16-Mar-01 VV25_Press_Data 001.csv', ... 
    ven_bp_strt_row, bp_col, [ven_bp_strt_row, bp_col, ven_end_row, bp_col]);
% Pressure gage output.
y = csvread('C:\Calibration\Pressure_Calibration\16-Mar-01 VV25_Press_Data 001.csv', ...
    ven_bp_strt_row, press_reg_col, [ven_bp_strt_row, press_reg_col, ven_end_row, press_reg_col]);
% Polyfit of pressure data vs. gage output.
pBp = polyfit(x,y,5);
press_volt = 0:0.1:3.3;       % Define a uniformly spaced pressure voltage vector
y2=polyval(pBp,press_volt);   % Evaluate the polynomial at press_volt
n = n + 1;
figure(n)
plot(x,y,'o',press_volt,y2)   % Plot the fit on top of the data
xlabel('Pressure (V)')
ylabel('Pressure (mmHg)')
title('BPout Pressure 5th Order Polyfit, 16-Mar-01 VV25_Press_Data 001')
%--------------------------------------------------------------------------
% For 16-Mar-01 VV25_Press_Data 001.
% DIn pressure data.
x = csvread('C:\Calibration\Pressure_Calibration\16-Mar-01 VV25_Press_Data 001.csv', ... 
    din_strt_row, din_col, [din_strt_row, din_col, din_end_row, din_col]);
% Pressure gage output.
y = csvread('C:\Calibration\Pressure_Calibration\16-Mar-01 VV25_Press_Data 001.csv', ...
    din_strt_row, press_reg_col, [din_strt_row, press_reg_col, din_end_row, press_reg_col]);
% Polyfit of pressure data vs. gage output.
dinp = polyfit(x,y,5);
press_volt = 0:0.1:3.3;       % Define a uniformly spaced pressure voltage vector
y2=polyval(dinp,press_volt);   % Evaluate the polynomial at press_volt
n = n + 1;
figure(n)
plot(x,y,'o',press_volt,y2)   % Plot the fit on top of the data
xlabel('Pressure (V)')
ylabel('Pressure (mmHg)')
title('DInout Pressure 5th Order Polyfit, 16-Mar-01 VV25_Press_Data 001')
%--------------------------------------------------------------------------
% For 16-Mar-01 VV25_Press_Data 001.
% DOut pressure data.
x = csvread('C:\Calibration\Pressure_Calibration\16-Mar-01 VV25_Press_Data 001.csv', ... 
    din_strt_row, dout_col, [din_strt_row, dout_col, din_end_row, dout_col]);
% Pressure gage output.
y = csvread('C:\Calibration\Pressure_Calibration\16-Mar-01 VV25_Press_Data 001.csv', ...
    din_strt_row, press_reg_col, [din_strt_row, press_reg_col, din_end_row, press_reg_col]);
% Polyfit of pressure data vs. gage output.
doutp = polyfit(x,y,5);
press_volt = 0:0.1:3.3;          % Define a uniformly spaced pressure voltage vector
y2=polyval(doutp,press_volt);    % Evaluate the polynomial at press_volt
n = n + 1;
figure(n)
plot(x,y,'o',press_volt,y2)      % Plot the fit on top of the data
xlabel('Pressure (V)')
ylabel('Pressure (mmHg)')
title('DOut Pressure 5th Order Polyfit, 16-Mar-01 VV25_Press_Data 001')
%--------------------------------------------------------------------------
% For 16-Mar-01 VV25_Press_Data 001.
% Sorbent pressure data.
x = csvread('C:\Calibration\Pressure_Calibration\16-Mar-01 VV25_Press_Data 001.csv', ... 
    sorb_strt_row, sorb_col, [sorb_strt_row, sorb_col, sorb_end_row, sorb_col]);
% Pressure gage output.
y = csvread('C:\Calibration\Pressure_Calibration\16-Mar-01 VV25_Press_Data 001.csv', ...
    sorb_strt_row, press_reg_col, [sorb_strt_row, press_reg_col, sorb_end_row, press_reg_col]);
% Polyfit of pressure data vs. gage output.
sorbp = polyfit(x,y,5);
press_volt = 0:0.1:3.3;          % Define a uniformly spaced pressure voltage vector
y2=polyval(sorbp,press_volt);    % Evaluate the polynomial at press_volt
n = n + 1;
figure(n)
plot(x,y,'o',press_volt,y2)      % Plot the fit on top of the data
xlabel('Pressure (V)')
ylabel('Pressure (mmHg)')
title('Sorbent Pressure 5th Order Polyfit, 16-Mar-01 VV25_Press_Data 001')
%--------------------------------------------------------------------------
% For VV34 Venous, March 08, 2016.
% Venous pressure data.
x = csvread('C:\Calibration\Pressure_Calibration\16-Mar-08 VV34_Press_Data 001.csv', 1, 5,[1,5,17,5]);
% Pressure gage output.
y = csvread('C:\Calibration\Pressure_Calibration\16-Mar-08 VV34_Press_Data 001.csv', 1, 2,[1,2,17,2]);
% Polyfit of pressure data vs. gage output.
pVen = polyfit(x,y,5);
press_volt = 0:0.1:3.3;       % Define a uniformly spaced pressure voltage vector
y2=polyval(pVen,press_volt);  % Evaluate the polynomial at press_volt
n = n + 1;
figure(n)
plot(x,y,'o',press_volt,y2)   % Plot the fit on top of the data
xlabel('Pressure (V)')
ylabel('Pressure (mmHg)')
title('Venous Pressure 5th Order Polyfit, 16-Mar-08 VV34')
%--------------------------------------------------------------------------
% For VV34 BPOut, March 08, 2016.
% BPout pressure data.
x = csvread('C:\Calibration\Pressure_Calibration\16-Mar-08 VV34_Press_Data 001.csv', 1, 3,[1,3,17,3]);
% Pressure gage output.
y = csvread('C:\Calibration\Pressure_Calibration\16-Mar-08 VV34_Press_Data 001.csv', 1, 2,[1,2,17,2]);
% Polyfit of pressure data vs. gage output.
pBp = polyfit(x,y,5);
press_volt = 0:0.1:3.3;       % Define a uniformly spaced pressure voltage vector
y2=polyval(pBp,press_volt);   % Evaluate the polynomial at press_volt
n = n + 1;
figure(n)
plot(x,y,'o',press_volt,y2)   % Plot the fit on top of the data
xlabel('Pressure (V)')
ylabel('Pressure (mmHg)')
title('BPout Pressure 5th Order Polyfit, 16-Mar-08 VV34')
%---------------------------------------------------------------
% For 16-Mar-01 VV25_Press.
% Venous pressure data.
x = csvread('C:\Calibration\Pressure_Calibration\16-Mar-01 VV25_Press_Data 001.csv', 1, 5,[1,5,17,5]);
% Pressure gage output.
y = csvread('C:\Calibration\Pressure_Calibration\16-Mar-01 VV25_Press_Data 001.csv', 1, 2,[1,2,17,2]);
% Polyfit of pressure data vs. gage output.
pVen = polyfit(x,y,5);
press_volt = 0:0.1:3.3;       % Define a uniformly spaced pressure voltage vector
y2=polyval(pVen,press_volt);  % Evaluate the polynomial at press_volt
n = n + 1;
figure(n)
plot(x,y,'o',press_volt,y2)   % Plot the fit on top of the data
xlabel('Pressure (V)')
ylabel('Pressure (mmHg)')
title('Venous Pressure 5th Order Polyfit, 16-Mar-01 VV25')
%--------------------------------------------------------------------------
% For 16-Mar-01 VV25_Press.
% BPout pressure data.
x = csvread('C:\Calibration\Pressure_Calibration\16-Mar-01 VV25_Press_Data 001.csv', 1, 3,[1,3,17,3]);
% Pressure gage output.
y = csvread('C:\Calibration\Pressure_Calibration\16-Mar-01 VV25_Press_Data 001.csv', 1, 2,[1,2,17,2]);
% Polyfit of pressure data vs. gage output.
pBp = polyfit(x,y,5);
press_volt = 0:0.1:3.3;       % Define a uniformly spaced pressure voltage vector
y2=polyval(pBp,press_volt);   % Evaluate the polynomial at press_volt
figure(9)
plot(x,y,'o',press_volt,y2)   % Plot the fit on top of the data
xlabel('Pressure (V)')
ylabel('Pressure (mmHg)')
title('BPout Pressure 5th Order Polyfit, 16-Mar-01 VV25')
%---------------------------------------------------------------
% For 16-Feb-17 VV29_Press.
% Venous pressure data.
x = csvread('C:\Calibration\Pressure_Calibration\16-Feb-17 VV29_Press_Data 002.csv', 1, 5,[1,5,17,5]);
% Pressure gage output.
y = csvread('C:\Calibration\Pressure_Calibration\16-Feb-17 VV29_Press_Data 002.csv', 1, 2,[1,2,17,2]);
% Polyfit of pressure data vs. gage output.
pVen = polyfit(x,y,5);
press_volt = 0:0.1:3.3;       % Define a uniformly spaced pressure voltage vector
y2=polyval(pVen,press_volt);  % Evaluate the polynomial at press_volt
figure(10)
plot(x,y,'o',press_volt,y2)   % Plot the fit on top of the data
xlabel('Pressure (V)')
ylabel('Pressure (mmHg)')
title('Venous Pressure 5th Order Polyfit, 16-Feb-17 VV29')
%--------------------------------------------------------------------------
% For 16-Feb-17 VV29_Press.
% BPout pressure data.
x = csvread('C:\Calibration\Pressure_Calibration\16-Feb-17 VV29_Press_Data 002.csv', 1, 3,[1,3,17,3]);
% Pressure gage output.
y = csvread('C:\Calibration\Pressure_Calibration\16-Feb-17 VV29_Press_Data 002.csv', 1, 2,[1,2,17,2]);
% Polyfit of pressure data vs. gage output.
pBp = polyfit(x,y,5);
press_volt = 0:0.1:3.3;       % Define a uniformly spaced pressure voltage vector
y2=polyval(pBp,press_volt);   % Evaluate the polynomial at press_volt
figure(11)
plot(x,y,'o',press_volt,y2)   % Plot the fit on top of the data
xlabel('Pressure (V)')
ylabel('Pressure (mmHg)')
title('BPout Pressure 5th Order Polyfit, 16-Feb-17 VV29')
%---------------------------------------------------------------
% For 16-Feb-10 VV30_Press.
% Venous pressure data.
x = csvread('C:\Calibration\Pressure_Calibration\16-Feb-10 VV30_Press_Data 001.csv', 1, 5,[1,5,17,5]);
% Pressure gage output.
y = csvread('C:\Calibration\Pressure_Calibration\16-Feb-10 VV30_Press_Data 001.csv', 1, 2,[1,2,17,2]);
% Polyfit of pressure data vs. gage output.
pVen = polyfit(x,y,5);
press_volt = 0:0.1:3.3;       % Define a uniformly spaced pressure voltage vector
y2=polyval(pVen,press_volt);  % Evaluate the polynomial at press_volt
figure(12)
plot(x,y,'o',press_volt,y2)   % Plot the fit on top of the data
xlabel('Pressure (V)')
ylabel('Pressure (mmHg)')
title('Venous Pressure 5th Order Polyfit, 16-Feb-10 VV30')
%--------------------------------------------------------------------------
% For 16-Feb-10 VV30_Press.
% BPout pressure data.
x = csvread('C:\Calibration\Pressure_Calibration\16-Feb-10 VV30_Press_Data 001.csv', 1, 3,[1,3,17,3]);
% Pressure gage output.
y = csvread('C:\Calibration\Pressure_Calibration\16-Feb-10 VV30_Press_Data 001.csv', 1, 2,[1,2,17,2]);
% Polyfit of pressure data vs. gage output.
pBp = polyfit(x,y,5);
press_volt = 0:0.1:3.3;       % Define a uniformly spaced pressure voltage vector
y2=polyval(pBp,press_volt);   % Evaluate the polynomial at press_volt
figure(13)
plot(x,y,'o',press_volt,y2)   % Plot the fit on top of the data
xlabel('Pressure (V)')
ylabel('Pressure (mmHg)')
title('BPout Pressure 5th Order Polyfit, 16-Feb-10 VV30')
%---------------------------------------------------------------
% For 16-Jan-21 VV29_Press_Data 001.
% Venous pressure data.
x = csvread('C:\Calibration\Pressure_Calibration\16-Jan-21 VV29_Press_Data 001.csv', 1, 5,[1,5,17,5]);
% Pressure gage output.
y = csvread('C:\Calibration\Pressure_Calibration\16-Jan-21 VV29_Press_Data 001.csv', 1, 2,[1,2,17,2]);
% Polyfit of pressure data vs. gage output.
pVen = polyfit(x,y,5);
press_volt = 0:0.1:3.3;       % Define a uniformly spaced pressure voltage vector
y2=polyval(pVen,press_volt);  % Evaluate the polynomial at press_volt
figure(14)
plot(x,y,'o',press_volt,y2)   % Plot the fit on top of the data
xlabel('Pressure (V)')
ylabel('Pressure (mmHg)')
title('Venous Pressure 5th Order Polyfit, 16-Jan-21 VV29_Press_Data 001')
%--------------------------------------------------------------------------
% For 16-Jan-21 VV29_Press_Data 001.
% BPout pressure data.
x = csvread('C:\Calibration\Pressure_Calibration\16-Jan-21 VV29_Press_Data 001.csv', 1, 3,[1,3,17,3]);
% Pressure gage output.
y = csvread('C:\Calibration\Pressure_Calibration\16-Jan-21 VV29_Press_Data 001.csv', 1, 2,[1,2,17,2]);
% Polyfit of pressure data vs. gage output.
pBp = polyfit(x,y,5);
press_volt = 0:0.1:3.3;       % Define a uniformly spaced pressure voltage vector
y2=polyval(pBp,press_volt);   % Evaluate the polynomial at press_volt
figure(15)
plot(x,y,'o',press_volt,y2)   % Plot the fit on top of the data
xlabel('Pressure (V)')
ylabel('Pressure (mmHg)')
title('BPout Pressure 5th Order Polyfit, 16-Jan-21 VV29_Press_Data 001')
%---------------------------------------------------------------
% For 16-Jan-20 VV25_Press_Data 001.
% Venous pressure data.
x = csvread('C:\Calibration\Pressure_Calibration\16-Jan-20 VV25_Press_Data 001.csv', 1, 5,[1,5,17,5]);
% Pressure gage output.
y = csvread('C:\Calibration\Pressure_Calibration\16-Jan-20 VV25_Press_Data 001.csv', 1, 2,[1,2,17,2]);
% Polyfit of pressure data vs. gage output.
pVen = polyfit(x,y,5);
press_volt = 0:0.1:3.3;       % Define a uniformly spaced pressure voltage vector
y2=polyval(pVen,press_volt);  % Evaluate the polynomial at press_volt
figure(14)
plot(x,y,'o',press_volt,y2)   % Plot the fit on top of the data
xlabel('Pressure (V)')
ylabel('Pressure (mmHg)')
title('Venous Pressure 5th Order Polyfit, 16-Jan-20 VV25_Press_Data 001')
%--------------------------------------------------------------------------
% For 16-Jan-20 VV25_Press_Data 001.
% BPout pressure data.
x = csvread('C:\Calibration\Pressure_Calibration\16-Jan-20 VV25_Press_Data 001.csv', 1, 3,[1,3,17,3]);
% Pressure gage output.
y = csvread('C:\Calibration\Pressure_Calibration\16-Jan-20 VV25_Press_Data 001.csv', 1, 2,[1,2,17,2]);
% Polyfit of pressure data vs. gage output.
pBp = polyfit(x,y,5);
press_volt = 0:0.1:3.3;       % Define a uniformly spaced pressure voltage vector
y2=polyval(pBp,press_volt);   % Evaluate the polynomial at press_volt
figure(15)
plot(x,y,'o',press_volt,y2)   % Plot the fit on top of the data
xlabel('Pressure (V)')
ylabel('Pressure (mmHg)')
title('BPout Pressure 5th Order Polyfit, 16-Jan-20 VV25_Press_Data 001')
%---------------------------------------------------------------
% For 16-Jan-20 VV28_Press_Data 001.
% Venous pressure data.
x = csvread('C:\Calibration\Pressure_Calibration\16-Jan-20 VV28_Press_Data 001.csv', 1, 5,[1,5,17,5]);
% Pressure gage output.
y = csvread('C:\Calibration\Pressure_Calibration\16-Jan-20 VV28_Press_Data 001.csv', 1, 2,[1,2,17,2]);
% Polyfit of pressure data vs. gage output.
pVen = polyfit(x,y,5);
press_volt = 0:0.1:3.3;       % Define a uniformly spaced pressure voltage vector
y2=polyval(pVen,press_volt);  % Evaluate the polynomial at press_volt
figure(14)
plot(x,y,'o',press_volt,y2)   % Plot the fit on top of the data
xlabel('Pressure (V)')
ylabel('Pressure (mmHg)')
title('Venous Pressure 5th Order Polyfit, 16-Jan-20 VV28_Press_Data 001')
%--------------------------------------------------------------------------
% For 16-Jan-20 VV28_Press_Data 001.
% BPout pressure data.
x = csvread('C:\Calibration\Pressure_Calibration\16-Jan-20 VV28_Press_Data 001.csv', 1, 3,[1,3,17,3]);
% Pressure gage output.
y = csvread('C:\Calibration\Pressure_Calibration\16-Jan-20 VV28_Press_Data 001.csv', 1, 2,[1,2,17,2]);
% Polyfit of pressure data vs. gage output.
pBp = polyfit(x,y,5);
press_volt = 0:0.1:3.3;       % Define a uniformly spaced pressure voltage vector
y2=polyval(pBp,press_volt);   % Evaluate the polynomial at press_volt
figure(15)
plot(x,y,'o',press_volt,y2)   % Plot the fit on top of the data
xlabel('Pressure (V)')
ylabel('Pressure (mmHg)')
title('BPout Pressure 5th Order Polyfit, 16-Jan-20 VV28_Press_Data 001')
%---------------------------------------------------------------
% For 16-Jan-20 VV27_Press_Data 001.
% Venous pressure data.
x = csvread('C:\Calibration\Pressure_Calibration\16-Jan-20 VV27_Press_Data 001.csv', 1, 5,[1,5,17,5]);
% Pressure gage output.
y = csvread('C:\Calibration\Pressure_Calibration\16-Jan-20 VV27_Press_Data 001.csv', 1, 2,[1,2,17,2]);
% Polyfit of pressure data vs. gage output.
pVen = polyfit(x,y,5);
press_volt = 0:0.1:3.3;       % Define a uniformly spaced pressure voltage vector
y2=polyval(pVen,press_volt);  % Evaluate the polynomial at press_volt
figure(16)
plot(x,y,'o',press_volt,y2)   % Plot the fit on top of the data
xlabel('Pressure (V)')
ylabel('Pressure (mmHg)')
title('Venous Pressure 5th Order Polyfit, 16-Jan-20 VV27_Press_Data 001')
%--------------------------------------------------------------------------
% For 16-Jan-20 VV27_Press_Data 001.
% BPout pressure data.
x = csvread('C:\Calibration\Pressure_Calibration\16-Jan-20 VV27_Press_Data 001.csv', 1, 3,[1,3,17,3]);
% Pressure gage output.
y = csvread('C:\Calibration\Pressure_Calibration\16-Jan-20 VV27_Press_Data 001.csv', 1, 2,[1,2,17,2]);
% Polyfit of pressure data vs. gage output.
pBp = polyfit(x,y,5);
press_volt = 0:0.1:3.3;       % Define a uniformly spaced pressure voltage vector
y2=polyval(pBp,press_volt);   % Evaluate the polynomial at press_volt
figure(17)
plot(x,y,'o',press_volt,y2)   % Plot the fit on top of the data
xlabel('Pressure (V)')
ylabel('Pressure (mmHg)')
title('BPout Pressure 5th Order Polyfit, 16-Jan-20 VV27_Press_Data 001')
%---------------------------------------------------------------
% For 16-Jan-20 VV33_Press_Data 001.
% Venous pressure data.
x = csvread('C:\Calibration\Pressure_Calibration\16-Jan-20 VV33_Press_Data 001.csv', 1, 5,[1,5,17,5]);
% Pressure gage output.
y = csvread('C:\Calibration\Pressure_Calibration\16-Jan-20 VV33_Press_Data 001.csv', 1, 2,[1,2,17,2]);
% Polyfit of pressure data vs. gage output.
pVen = polyfit(x,y,5);
press_volt = 0:0.1:3.3;       % Define a uniformly spaced pressure voltage vector
y2=polyval(pVen,press_volt);  % Evaluate the polynomial at press_volt
figure(18)
plot(x,y,'o',press_volt,y2)   % Plot the fit on top of the data
xlabel('Pressure (V)')
ylabel('Pressure (mmHg)')
title('Venous Pressure 5th Order Polyfit, 16-Jan-20 VV33_Press_Data 001')
%--------------------------------------------------------------------------
% For 16-Jan-20 VV33_Press_Data 001.
% BPout pressure data.
x = csvread('C:\Calibration\Pressure_Calibration\16-Jan-20 VV33_Press_Data 001.csv', 1, 3,[1,3,17,3]);
% Pressure gage output.
y = csvread('C:\Calibration\Pressure_Calibration\16-Jan-20 VV33_Press_Data 001.csv', 1, 2,[1,2,17,2]);
% Polyfit of pressure data vs. gage output.
pBp = polyfit(x,y,5);
press_volt = 0:0.1:3.3;       % Define a uniformly spaced pressure voltage vector
y2=polyval(pBp,press_volt);   % Evaluate the polynomial at press_volt
figure(19)
plot(x,y,'o',press_volt,y2)   % Plot the fit on top of the data
xlabel('Pressure (V)')
ylabel('Pressure (mmHg)')
title('BPout Pressure 5th Order Polyfit, 16-Jan-20 VV33_Press_Data 001')
%---------------------------------------------------------------
% For 16-Jan-19 VV32_Press_Data 001.
% Venous pressure data.
x = csvread('C:\Calibration\Pressure_Calibration\16-Jan-19 VV32_Press_Data 001.csv', 1, 5,[1,5,17,5]);
% Pressure gage output.
y = csvread('C:\Calibration\Pressure_Calibration\16-Jan-19 VV32_Press_Data 001.csv', 1, 2,[1,2,17,2]);
% Polyfit of pressure data vs. gage output.
pVen = polyfit(x,y,5);
press_volt = 0:0.1:3.3;       % Define a uniformly spaced pressure voltage vector
y2=polyval(pVen,press_volt);  % Evaluate the polynomial at press_volt
figure(20)
plot(x,y,'o',press_volt,y2)   % Plot the fit on top of the data
xlabel('Pressure (V)')
ylabel('Pressure (mmHg)')
title('Venous Pressure 5th Order Polyfit, 16-Jan-19 VV32_Press_Data 001')
%--------------------------------------------------------------------------
% For 16-Jan-19 VV32_Press_Data 001.
% BPout pressure data.
x = csvread('C:\Calibration\Pressure_Calibration\16-Jan-19 VV32_Press_Data 001.csv', 1, 3,[1,3,17,3]);
% Pressure gage output.
y = csvread('C:\Calibration\Pressure_Calibration\16-Jan-19 VV32_Press_Data 001.csv', 1, 2,[1,2,17,2]);
% Polyfit of pressure data vs. gage output.
pBp = polyfit(x,y,5);
press_volt = 0:0.1:3.3;       % Define a uniformly spaced pressure voltage vector
y2=polyval(pBp,press_volt);   % Evaluate the polynomial at press_volt
figure(21)
plot(x,y,'o',press_volt,y2)   % Plot the fit on top of the data
xlabel('Pressure (V)')
ylabel('Pressure (mmHg)')
title('BPout Pressure 5th Order Polyfit, 16-Jan-19 VV32_Press_Data 001')
%---------------------------------------------------------------
% For 16-Mar-23 VV26_New_S1_Limit_Press_Data 001.
% Venous pressure data.
x = csvread('C:\Calibration\Pressure_Calibration\16-Mar-23 VV26_New_S1_Limit_Press_Data 001.csv', 1, 5,[1,5,17,5]);
% Pressure gage output.
y = csvread('C:\Calibration\Pressure_Calibration\16-Mar-23 VV26_New_S1_Limit_Press_Data 001.csv', 1, 2,[1,2,17,2]);
% Polyfit of pressure data vs. gage output.
pVen = polyfit(x,y,5);
press_volt = 0:0.1:3.3;       % Define a uniformly spaced pressure voltage vector
y2=polyval(pVen,press_volt);  % Evaluate the polynomial at press_volt
figure(22)
plot(x,y,'o',press_volt,y2)   % Plot the fit on top of the data
xlabel('Pressure (V)')
ylabel('Pressure (mmHg)')
title('Venous Pressure 5th Order Polyfit, 16-Mar-23 VV26_New_S1_Limit_Press_Data 001')
%--------------------------------------------------------------------------
% For 16-Mar-23 VV26_New_S1_Limit_Press_Data 001.
% BPout pressure data.
x = csvread('C:\Calibration\Pressure_Calibration\16-Mar-23 VV26_New_S1_Limit_Press_Data 001.csv', 1, 3,[1,3,17,3]);
% Pressure gage output.
y = csvread('C:\Calibration\Pressure_Calibration\16-Mar-23 VV26_New_S1_Limit_Press_Data 001.csv', 1, 2,[1,2,17,2]);
% Polyfit of pressure data vs. gage output.
pBp = polyfit(x,y,5);
press_volt = 0:0.1:3.3;       % Define a uniformly spaced pressure voltage vector
y2=polyval(pBp,press_volt);   % Evaluate the polynomial at press_volt
figure(23)
plot(x,y,'o',press_volt,y2)   % Plot the fit on top of the data
xlabel('Pressure (V)')
ylabel('Pressure (mmHg)')
title('BPout Pressure 5th Order Polyfit, 16-Mar-23 VV26_New_S1_Limit_Press_Data 001')
%---------------------------------------------------------------
% For 16-Jan-19 VV32_Press_Data 001.
% Venous pressure data.
x = csvread('C:\Calibration\Pressure_Calibration\16-Jan-19 VV32_Press_Data 001.csv', 1, 5,[1,5,17,5]);
% Pressure gage output.
y = csvread('C:\Calibration\Pressure_Calibration\16-Jan-19 VV32_Press_Data 001.csv', 1, 2,[1,2,17,2]);
% Polyfit of pressure data vs. gage output.
pVen = polyfit(x,y,5);
press_volt = 0:0.1:3.3;       % Define a uniformly spaced pressure voltage vector
y2=polyval(pVen,press_volt);  % Evaluate the polynomial at press_volt
figure(20)
plot(x,y,'o',press_volt,y2)   % Plot the fit on top of the data
xlabel('Pressure (V)')
ylabel('Pressure (mmHg)')
title('Venous Pressure 5th Order Polyfit, 16-Jan-19 VV32_Press_Data 001')
%--------------------------------------------------------------------------
% For 16-Jan-19 VV32_Press_Data 001.
% BPout pressure data.
x = csvread('C:\Calibration\Pressure_Calibration\16-Jan-19 VV32_Press_Data 001.csv', 1, 3,[1,3,17,3]);
% Pressure gage output.
y = csvread('C:\Calibration\Pressure_Calibration\16-Jan-19 VV32_Press_Data 001.csv', 1, 2,[1,2,17,2]);
% Polyfit of pressure data vs. gage output.
pBp = polyfit(x,y,5);
press_volt = 0:0.1:3.3;       % Define a uniformly spaced pressure voltage vector
y2=polyval(pBp,press_volt);   % Evaluate the polynomial at press_volt
figure(21)
plot(x,y,'o',press_volt,y2)   % Plot the fit on top of the data
xlabel('Pressure (V)')
ylabel('Pressure (mmHg)')
title('BPout Pressure 5th Order Polyfit, 16-Jan-19 VV32_Press_Data 001')
%---------------------------------------------------------------
% For 16-Mar-04 RD7_Press_Data 001.
% Venous pressure data.
x = csvread('C:\Calibration\Pressure_Calibration\16-Mar-04 RD7_Press_Data 001.csv', 1, 5,[1,5,17,5]);
% Pressure gage output.
y = csvread('C:\Calibration\Pressure_Calibration\16-Mar-04 RD7_Press_Data 001.csv', 1, 2,[1,2,17,2]);
% Polyfit of pressure data vs. gage output.
pVen = polyfit(x,y,5);
press_volt = 0:0.1:3.3;       % Define a uniformly spaced pressure voltage vector
y2=polyval(pVen,press_volt);  % Evaluate the polynomial at press_volt
figure(24)
plot(x,y,'o',press_volt,y2)   % Plot the fit on top of the data
xlabel('Pressure (V)')
ylabel('Pressure (mmHg)')
title('Venous Pressure 5th Order Polyfit, 16-Mar-04 RD7_Press_Data 001')
%--------------------------------------------------------------------------
% For 16-Mar-04 RD7_Press_Data 001.
% BPout pressure data.
x = csvread('C:\Calibration\Pressure_Calibration\16-Mar-04 RD7_Press_Data 001.csv', 1, 3,[1,3,17,3]);
% Pressure gage output.
y = csvread('C:\Calibration\Pressure_Calibration\16-Mar-04 RD7_Press_Data 001.csv', 1, 2,[1,2,17,2]);
% Polyfit of pressure data vs. gage output.
pBp = polyfit(x,y,5);
press_volt = 0:0.1:3.3;       % Define a uniformly spaced pressure voltage vector
y2=polyval(pBp,press_volt);   % Evaluate the polynomial at press_volt
figure(25)
plot(x,y,'o',press_volt,y2)   % Plot the fit on top of the data
xlabel('Pressure (V)')
ylabel('Pressure (mmHg)')
title('BPout Pressure 5th Order Polyfit, 16-Mar-04 RD7_Press_Data 001')
%---------------------------------------------------------------
% For 16-Mar-22 RD10_Press_Data 001.
% Venous pressure data.
x = csvread('C:\Calibration\Pressure_Calibration\16-Mar-22 RD10_Press_Data 001.csv', 1, 5,[1,5,17,5]);
% Pressure gage output.
y = csvread('C:\Calibration\Pressure_Calibration\16-Mar-22 RD10_Press_Data 001.csv', 1, 2,[1,2,17,2]);
% Polyfit of pressure data vs. gage output.
pVen = polyfit(x,y,5);
press_volt = 0:0.1:3.3;       % Define a uniformly spaced pressure voltage vector
y2=polyval(pVen,press_volt);  % Evaluate the polynomial at press_volt
figure(26)
plot(x,y,'o',press_volt,y2)   % Plot the fit on top of the data
xlabel('Pressure (V)')
ylabel('Pressure (mmHg)')
title('Venous Pressure 5th Order Polyfit, 16-Mar-22 RD10_Press_Data 001')
%--------------------------------------------------------------------------
% For 16-Mar-22 RD10_Press_Data 001.
% BPout pressure data.
x = csvread('C:\Calibration\Pressure_Calibration\16-Mar-22 RD10_Press_Data 001.csv', 1, 3,[1,3,17,3]);
% Pressure gage output.
y = csvread('C:\Calibration\Pressure_Calibration\16-Mar-22 RD10_Press_Data 001.csv', 1, 2,[1,2,17,2]);
% Polyfit of pressure data vs. gage output.
pBp = polyfit(x,y,5);
press_volt = 0:0.1:3.3;       % Define a uniformly spaced pressure voltage vector
y2=polyval(pBp,press_volt);   % Evaluate the polynomial at press_volt
figure(27)
plot(x,y,'o',press_volt,y2)   % Plot the fit on top of the data
xlabel('Pressure (V)')
ylabel('Pressure (mmHg)')
title('BPout Pressure 5th Order Polyfit, 16-Mar-22 RD10_Press_Data 001')
%---------------------------------------------------------------

% For Closing the door.
% Read data column in counts
% Start reading at row 10, column 112.
% Read up to row 38 at the same column.
% close_start_row = 10;
% close_stop_row  = 38;
% data_col        = 112;
% y_close = csvread('C:\FPGA_Design_Test\DD66_adm_step_profile\PAK\src\PAKPUCControl\tf\vv9_scr1235_16_03_11_17_26.csv', close_start_row, data_col,[close_start_row,data_col,close_stop_row,data_col]);
% % Generate the time axis
% x_close = 0:0.5:(close_stop_row - close_start_row)/2; % seconds
% figure(1);
% plot(x_close,y_close,'-m+')
% xlabel('Time (second)')
% ylabel('ADM Position (counts)')
% title('ADM Position Profile (For Closing Door)')
% 
% % For Opening the door.
% open_start_row = 68;
% open_stop_row  = 96;
% data_col       = 112;
% y_open = csvread('C:\FPGA_Design_Test\DD66_adm_step_profile\PAK\src\PAKPUCControl\tf\vv9_scr1235_16_03_11_17_26.csv', open_start_row, data_col,[open_start_row,data_col,open_stop_row,data_col]);
% % Generate the time axis
% x_open = 0:0.5:(open_stop_row - open_start_row)/2; % seconds
% figure(2);
% plot(x_open,y_open,'-m+')
% xlabel('Time (second)')
% ylabel('ADM Position (counts)')
% title('ADM Position Profile (For Opening Door)')
% 
% % Motor Steps For Closing the door.
% % This figure will show the coarse motor steps of closing the door.
% % The data is from the ADM_Controller.v test bench.
% % To get the time axis.
% close_start_row_time = 2;
% close_stop_row_time  = 29;
% data_col_time        = 0;
% x = csvread('C:\FPGA_Design_Test\DD66_adm_step_profile\PAK\src\PAKPUCControl\tf\close_door_motor_steps.csv', close_start_row_time, data_col_time,[close_start_row_time,data_col_time,close_stop_row_time,data_col_time]);
% % To get the motor steps
% close_start_row_mtr_stps = close_start_row_time;
% close_stop_row_mtr_stps  = close_stop_row_time;
% data_col_mtr_stps        = 1;
% y = csvread('C:\FPGA_Design_Test\DD66_adm_step_profile\PAK\src\PAKPUCControl\tf\close_door_motor_steps.csv', close_start_row_mtr_stps, data_col_mtr_stps,[close_start_row_mtr_stps,data_col_mtr_stps,close_stop_row_mtr_stps,data_col_mtr_stps]);
% mtr_stps_freq = 1./y;
% figure(3);
% stem(x,mtr_stps_freq,':')
% xlabel('Time (second)')
% ylabel('ADM Motor Steps (Frequency)')
% title('ADM Motor Steps Profile (For Closing Door)')
% 
% % Plot both the ADM Closing Position Profile together with the 
% % corresponding ADM Motor Steps Profile, ie, figure 1 and figure 3.
% figure(4)
% stem_handles = stem(x,mtr_stps_freq,':');
% hold on
% plot_handle = plot(x_close,y_close,'-m+');
% hold off
% legend_handles = [stem_handles(1);plot_handle];
% legend(legend_handles,'close_mtr_stps','close_pos_prof')
% xlabel('Time in secs')
% ylabel('Magnitude')
% title('Position and Motor Steps of Close Door Profiles')
% 
% % ADM Closing Position Profile and Motor Steps Profile
% % with different y scales.
% figure(5)
% [AX,H1,H2] = plotyy(x_close,y_close,x,mtr_stps_freq,'plot','stem');
% set(get(AX(1),'Ylabel'),'String','Position Profile (Counts)')
% set(get(AX(2),'Ylabel'),'String','Motor Steps Profile (Freq)') 
% xlabel('Time (sec)') 
% title('Position and Motor Steps of Close Door Profiles') 
% set(H1,'LineStyle','--')
% set(H2,'LineStyle',':') 
% 
% % This figure will show the fine motor steps of closing the door
% % where the motor speeds up.
% % The data is from the ADM_Controller.v test bench.
% % To get the time axis.
% close_middle_start_row_time = 1;
% close_middle_stop_row_time  = 30;
% data_middle_col_time        = 0;
% x_middle = csvread('C:\FPGA_Design_Test\DD66_adm_step_profile\PAK\src\PAKPUCControl\tf\close_door_motor_steps_zoom_middle.csv', 1, 0,[1,0,31,0]);
% % To get the motor steps
% close_middle_start_row_mtr_stps = close_middle_start_row_time;
% close_middle_stop_row_mtr_stps  = close_middle_stop_row_time;
% data_middle_col_mtr_stps        = 1;
% y_middle = csvread('C:\FPGA_Design_Test\DD66_adm_step_profile\PAK\src\PAKPUCControl\tf\close_door_motor_steps_zoom_middle.csv', 1, 1,[1,1,31,1]);
% mtr_stps_middle_freq = 1./y_middle;
% figure(6);
% stem(x_middle,mtr_stps_middle_freq,':')
% xlabel('Time (second)')
% ylabel('ADM Motor Steps (Frequency)')
% title('ADM Motor Steps Fast Profile (For Closing Door)')