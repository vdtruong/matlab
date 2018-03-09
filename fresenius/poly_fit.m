function poly_fit(varargin)
% Enter a command like this:
% poly_fit('C:\Calibration\Pressure_Calibration\16-May-04 VV30_Press_Data 002.csv')
% to run this function.
% Read the y and x columns.
% The y column is the regulated reference pressures.
% The x column is the PAK corresponding voltages.
% We need to solve the following equation to find the polynomial fit
% coefficients: Ax=y --> x = inv(A)y.
% But we will find the inverse of A using SVD.

file_name = varargin{1};

% Close all figures.
%close all;

% All pressures and pressure regulatgor data rows and columns.
% This is for the present way of calibrating pressures, if the
% setpoints and limits should change, you need to change these contants.
ven_bp_strt_row = 1;
din_strt_row    = 18;
sorb_strt_row   = 33;
ven_col         = 5;
bp_col          = 3;
din_col         = 7;
dout_col        = 6;
sorb_col        = 4;
ven_end_row     = 17;
din_end_row     = 32;
sorb_end_row    = 45;
press_reg_col   = 2;

% Could use this for multi-dimensional matrices to solve all coefficients
% using one algorithm.
%press_mat = csvread(file_name, ... 
%    ven_bp_strt_row, press_reg_col, [ven_bp_strt_row, press_reg_col, sorb_end_row, din_col]);
%press_mat(2, ven_col - 1);

% For Venous **************************************************************
% Venous pressure data.
xv = csvread(file_name, ... 
    ven_bp_strt_row, ven_col, [ven_bp_strt_row, ven_col, ven_end_row, ven_col]);
% Pressure gage output.
yv = csvread(file_name, ...
    ven_bp_strt_row, press_reg_col, [ven_bp_strt_row, press_reg_col, ven_end_row, press_reg_col]);
yv(1); % Matlab index starts with 1 not zero.
xv(1);
[n,m] = size(yv); % y and x are arrays with 1 column

% initialize sum_xv_ip1
sum_xv_ip1 = 0;
for i = 1:n
   sum_xv_ip1 = sum_xv_ip1 + xv(i);
end
sum_xv_ip1;

% initialize sum_x_isquare
% sum_x_isquare = 0;
% for i = 1:n
%    sum_x_isquare = sum_x_isquare + x(i)*x(i);
% end
% sum_x_isquare;

% initialize sum_xv_ip2
sum_xv_ip2 = 0;
for i = 1:n
   sum_xv_ip2 = sum_xv_ip2 + power(xv(i),2);
end
sum_xv_ip2;

% initialize sum_xv_ip3
sum_xv_ip3 = 0;
for i = 1:n
   sum_xv_ip3 = sum_xv_ip3 + power(xv(i),3);
end
sum_xv_ip3;

% initialize sum_xv_ip4
sum_xv_ip4 = 0;
for i = 1:n
   sum_xv_ip4 = sum_xv_ip4 + power(xv(i),4);
end
sum_xv_ip4;

% initialize sum_xv_ip5
sum_xv_ip5 = 0;
for i = 1:n
   sum_xv_ip5 = sum_xv_ip5 + power(xv(i),5);
end
sum_xv_ip5;

% initialize sum_xv_ip6
sum_xv_ip6 = 0;
for i = 1:n
   sum_xv_ip6 = sum_xv_ip6 + power(xv(i),6);
end
sum_xv_ip6;

% initialize sum_xv_ip7
sum_xv_ip7 = 0;
for i = 1:n
   sum_xv_ip7 = sum_xv_ip7 + power(xv(i),7);
end
sum_xv_ip7;

% initialize sum_xv_ip8
sum_xv_ip8 = 0;
for i = 1:n
   sum_xv_ip8 = sum_xv_ip8 + power(xv(i),8);
end
sum_xv_ip8;

% initialize sum_xv_ip9
sum_xv_ip9 = 0;
for i = 1:n
   sum_xv_ip9 = sum_xv_ip9 + power(xv(i),9);
end
sum_xv_ip9;

% initialize sum_xv_ip10
sum_xv_ip10 = 0;
for i = 1:n
   sum_xv_ip10 = sum_xv_ip10 + power(xv(i),10);
end
sum_xv_ip10;

% initialize sum_yv_ip1
sum_yv_ip1 = 0;
for i = 1:n
   sum_yv_ip1 = sum_yv_ip1 + yv(i);
end
sum_yv_ip1;

% initialize sum_xv_ip1_yv_ip1
sum_xv_ip1_yv_ip1 = 0;
for i = 1:n
   sum_xv_ip1_yv_ip1 = sum_xv_ip1_yv_ip1 + xv(i)*yv(i);
end
sum_xv_ip1_yv_ip1;

% initialize sum_xv_ip2_yv_ip1
sum_xv_ip2_yv_ip1 = 0;
for i = 1:n
   sum_xv_ip2_yv_ip1 = sum_xv_ip2_yv_ip1 + power(xv(i),2)*yv(i);
end
sum_xv_ip2_yv_ip1;

% initialize sum_xv_ip3_yv_ip1
sum_xv_ip3_yv_ip1 = 0;
for i = 1:n
   sum_xv_ip3_yv_ip1 = sum_xv_ip3_yv_ip1 + power(xv(i),3)*yv(i);
end
sum_xv_ip3_yv_ip1;

% initialize sum_xv_ip4_yv_ip1
sum_xv_ip4_yv_ip1 = 0;
for i = 1:n
   sum_xv_ip4_yv_ip1 = sum_xv_ip4_yv_ip1 + power(xv(i),4)*yv(i);
end
sum_xv_ip4_yv_ip1;

% initialize sum_xv_ip5_yv_ip1
sum_xv_ip5_yv_ip1 = 0;
for i = 1:n
   sum_xv_ip5_yv_ip1 = sum_xv_ip5_yv_ip1 + power(xv(i),5)*yv(i);
end
sum_xv_ip5_yv_ip1;

% Preallocate matrix A.
Av = zeros(6, 6);
% Set the A matrix.
Av = [n         sum_xv_ip1 sum_xv_ip2 sum_xv_ip3 sum_xv_ip4 sum_xv_ip5; 
     sum_xv_ip1 sum_xv_ip2 sum_xv_ip3 sum_xv_ip4 sum_xv_ip5 sum_xv_ip6;
     sum_xv_ip2 sum_xv_ip3 sum_xv_ip4 sum_xv_ip5 sum_xv_ip6 sum_xv_ip7;
     sum_xv_ip3 sum_xv_ip4 sum_xv_ip5 sum_xv_ip6 sum_xv_ip7 sum_xv_ip8;
     sum_xv_ip4 sum_xv_ip5 sum_xv_ip6 sum_xv_ip7 sum_xv_ip8 sum_xv_ip9;
     sum_xv_ip5 sum_xv_ip6 sum_xv_ip7 sum_xv_ip8 sum_xv_ip9 sum_xv_ip10];

% Preallocate vector b.
bvrow = [sum_yv_ip1 sum_xv_ip1_yv_ip1 sum_xv_ip2_yv_ip1 sum_xv_ip3_yv_ip1 sum_xv_ip4_yv_ip1 sum_xv_ip5_yv_ip1]; % row
bv = bvrow.';           % column

% Taking the SVD of A.
[Uv,Sv,Vv] = svd(Av);

% Find the coefficients of the polynomial fit.

% Preallocate vector a.
avrow = [0 0 0 0 0 0]; % row
av = avrow.';          % column

% If U and V are the same,
% both equations will work.
av = Uv*(inv(Sv))*(Vv.')*bv
%av = Vv*(inv(Sv))*(Uv.')*bv;
% For Venous **************************************************************

% For BPout ***************************************************************
% BPout pressure data.
xb = csvread(file_name, ... 
    ven_bp_strt_row, bp_col, [ven_bp_strt_row, bp_col, ven_end_row, bp_col]);
% Pressure gage output.
yb = csvread(file_name, ...
    ven_bp_strt_row, press_reg_col, [ven_bp_strt_row, press_reg_col, ven_end_row, press_reg_col]);
yb(1); % Matlab index starts with 1 not zero.
xb(1);
[n,m] = size(yb); % y and x are arrays with 1 column

% initialize sum_xb_ip1
sum_xb_ip1 = 0;
for i = 1:n
   sum_xb_ip1 = sum_xb_ip1 + xb(i);
end
sum_xb_ip1;

% initialize sum_xb_ip2
sum_xb_ip2 = 0;
for i = 1:n
   sum_xb_ip2 = sum_xb_ip2 + power(xb(i),2);
end
sum_xb_ip2;

% initialize sum_xb_ip3
sum_xb_ip3 = 0;
for i = 1:n
   sum_xb_ip3 = sum_xb_ip3 + power(xb(i),3);
end
sum_xb_ip3;

% initialize sum_xb_ip4
sum_xb_ip4 = 0;
for i = 1:n
   sum_xb_ip4 = sum_xb_ip4 + power(xb(i),4);
end
sum_xb_ip4;

% initialize sum_xb_ip5
sum_xb_ip5 = 0;
for i = 1:n
   sum_xb_ip5 = sum_xb_ip5 + power(xb(i),5);
end
sum_xb_ip5;

% initialize sum_xb_ip6
sum_xb_ip6 = 0;
for i = 1:n
   sum_xb_ip6 = sum_xb_ip6 + power(xb(i),6);
end
sum_xb_ip6;

% initialize sum_xb_ip7
sum_xb_ip7 = 0;
for i = 1:n
   sum_xb_ip7 = sum_xb_ip7 + power(xb(i),7);
end
sum_xb_ip7;

% initialize sum_xb_ip8
sum_xb_ip8 = 0;
for i = 1:n
   sum_xb_ip8 = sum_xb_ip8 + power(xb(i),8);
end
sum_xb_ip8;

% initialize sum_xb_ip9
sum_xb_ip9 = 0;
for i = 1:n
   sum_xb_ip9 = sum_xb_ip9 + power(xb(i),9);
end
sum_xb_ip9;

% initialize sum_xb_ip10
sum_xb_ip10 = 0;
for i = 1:n
   sum_xb_ip10 = sum_xb_ip10 + power(xb(i),10);
end
sum_xb_ip10;

% initialize sum_yb_ip1
sum_yb_ip1 = 0;
for i = 1:n
   sum_yb_ip1 = sum_yb_ip1 + yb(i);
end
sum_yb_ip1;

% initialize sum_xb_ip1_yb_ip1
sum_xb_ip1_yb_ip1 = 0;
for i = 1:n
   sum_xb_ip1_yb_ip1 = sum_xb_ip1_yb_ip1 + xb(i)*yb(i);
end
sum_xb_ip1_yb_ip1;

% initialize sum_xb_ip2_yb_ip1
sum_xb_ip2_yb_ip1 = 0;
for i = 1:n
   sum_xb_ip2_yb_ip1 = sum_xb_ip2_yb_ip1 + power(xb(i),2)*yb(i);
end
sum_xb_ip2_yb_ip1;

% initialize sum_xb_ip3_yb_ip1
sum_xb_ip3_yb_ip1 = 0;
for i = 1:n
   sum_xb_ip3_yb_ip1 = sum_xb_ip3_yb_ip1 + power(xb(i),3)*yb(i);
end
sum_xb_ip3_yb_ip1;

% initialize sum_xb_ip4_yb_ip1
sum_xb_ip4_yb_ip1 = 0;
for i = 1:n
   sum_xb_ip4_yb_ip1 = sum_xb_ip4_yb_ip1 + power(xb(i),4)*yb(i);
end
sum_xb_ip4_yb_ip1;

% initialize sum_xb_ip5_yb_ip1
sum_xb_ip5_yb_ip1 = 0;
for i = 1:n
   sum_xb_ip5_yb_ip1 = sum_xb_ip5_yb_ip1 + power(xb(i),5)*yb(i);
end
sum_xb_ip5_yb_ip1;

% Preallocate matrix A.
Ab = zeros(6, 6);
% Could set multi pages of matrix A.
% Each for a pressure.
% Set the A matrix.
Ab = [n         sum_xb_ip1 sum_xb_ip2 sum_xb_ip3 sum_xb_ip4 sum_xb_ip5; 
     sum_xb_ip1 sum_xb_ip2 sum_xb_ip3 sum_xb_ip4 sum_xb_ip5 sum_xb_ip6;
     sum_xb_ip2 sum_xb_ip3 sum_xb_ip4 sum_xb_ip5 sum_xb_ip6 sum_xb_ip7;
     sum_xb_ip3 sum_xb_ip4 sum_xb_ip5 sum_xb_ip6 sum_xb_ip7 sum_xb_ip8;
     sum_xb_ip4 sum_xb_ip5 sum_xb_ip6 sum_xb_ip7 sum_xb_ip8 sum_xb_ip9;
     sum_xb_ip5 sum_xb_ip6 sum_xb_ip7 sum_xb_ip8 sum_xb_ip9 sum_xb_ip10];

% Preallocate vector b.
bbrow = [sum_yb_ip1 sum_xb_ip1_yb_ip1 sum_xb_ip2_yb_ip1 sum_xb_ip3_yb_ip1 sum_xb_ip4_yb_ip1 sum_xb_ip5_yb_ip1]; % row
bb = bbrow.';           % column

% Taking the SVD of A.
[Ub,Sb,Vb] = svd(Ab);

% Find the coefficients of the polynomial fit.

% Preallocate vector a.
abrow = [0 0 0 0 0 0]; % row
ab = abrow.';          % column

% If U and V are the same,
% both equations will work.
ab = Ub*(inv(Sb))*(Vb.')*bb
%av = Vv*(inv(Sv))*(Uv.')*bv;
% For BPOut ***************************************************************

%plot(x,y,'-m+')
%xlabel('Time (second)')
%ylabel('ADM Position (counts)')
%title('ADM Position vs. Time')