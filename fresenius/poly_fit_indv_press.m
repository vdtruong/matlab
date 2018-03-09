% Read the y and x columns.
% The y column is the regulated reference pressure.
% The x column is the PAK corresponding voltage.
% We need to do a least squares regression fit with
% these data sets.
% Data for DOut.
y = csvread('C:\Calibration\Pressure_Calibration\16-May-04 VV30_Press_Data 002.csv', 18, 2,[18,2,32,2]);
x = csvread('C:\Calibration\Pressure_Calibration\16-May-04 VV30_Press_Data 002.csv', 18, 6,[18,6,32,6]);
y(1); % Matlab index starts with 1 not zero.
x(1);
[n,m] = size(y); % y and x are arrays with 1 column

% initialize sum_x_ip1
sum_x_ip1 = 0;
for i = 1:n
   sum_x_ip1 = sum_x_ip1 + x(i);
end
sum_x_ip1;

% initialize sum_x_isquare
% sum_x_isquare = 0;
% for i = 1:n
%    sum_x_isquare = sum_x_isquare + x(i)*x(i);
% end
% sum_x_isquare;

% initialize sum_x_ip2
sum_x_ip2 = 0;
for i = 1:n
   sum_x_ip2 = sum_x_ip2 + power(x(i),2);
end
sum_x_ip2;

% initialize sum_x_ip3
sum_x_ip3 = 0;
for i = 1:n
   sum_x_ip3 = sum_x_ip3 + power(x(i),3);
end
sum_x_ip3;

% initialize sum_x_ip4
sum_x_ip4 = 0;
for i = 1:n
   sum_x_ip4 = sum_x_ip4 + power(x(i),4);
end
sum_x_ip4;

% initialize sum_x_ip5
sum_x_ip5 = 0;
for i = 1:n
   sum_x_ip5 = sum_x_ip5 + power(x(i),5);
end
sum_x_ip5;

% initialize sum_x_ip6
sum_x_ip6 = 0;
for i = 1:n
   sum_x_ip6 = sum_x_ip6 + power(x(i),6);
end
sum_x_ip6;

% initialize sum_x_ip7
sum_x_ip7 = 0;
for i = 1:n
   sum_x_ip7 = sum_x_ip7 + power(x(i),7);
end
sum_x_ip7;

% initialize sum_x_ip8
sum_x_ip8 = 0;
for i = 1:n
   sum_x_ip8 = sum_x_ip8 + power(x(i),8);
end
sum_x_ip8;

% initialize sum_x_ip9
sum_x_ip9 = 0;
for i = 1:n
   sum_x_ip9 = sum_x_ip9 + power(x(i),9);
end
sum_x_ip9;

% initialize sum_x_ip10
sum_x_ip10 = 0;
for i = 1:n
   sum_x_ip10 = sum_x_ip10 + power(x(i),10);
end
sum_x_ip10;

% initialize sum_y_ip1
sum_y_ip1 = 0;
for i = 1:n
   sum_y_ip1 = sum_y_ip1 + y(i);
end
sum_y_ip1;

% initialize sum_x_ip1_y_ip1
sum_x_ip1_y_ip1 = 0;
for i = 1:n
   sum_x_ip1_y_ip1 = sum_x_ip1_y_ip1 + x(i)*y(i);
end
sum_x_ip1_y_ip1;

% initialize sum_x_ip2_y_ip1
sum_x_ip2_y_ip1 = 0;
for i = 1:n
   sum_x_ip2_y_ip1 = sum_x_ip2_y_ip1 + power(x(i),2)*y(i);
end
sum_x_ip2_y_ip1;

% initialize sum_x_ip3_y_ip1
sum_x_ip3_y_ip1 = 0;
for i = 1:n
   sum_x_ip3_y_ip1 = sum_x_ip3_y_ip1 + power(x(i),3)*y(i);
end
sum_x_ip3_y_ip1;

% initialize sum_x_ip4_y_ip1
sum_x_ip4_y_ip1 = 0;
for i = 1:n
   sum_x_ip4_y_ip1 = sum_x_ip4_y_ip1 + power(x(i),4)*y(i);
end
sum_x_ip4_y_ip1;

% initialize sum_x_ip5_y_ip1
sum_x_ip5_y_ip1 = 0;
for i = 1:n
   sum_x_ip5_y_ip1 = sum_x_ip5_y_ip1 + power(x(i),5)*y(i);
end
sum_x_ip5_y_ip1;

% Preallocate matrix A.
A = zeros(6, 6);
% Set the A matrix.
A = [n         sum_x_ip1 sum_x_ip2 sum_x_ip3 sum_x_ip4 sum_x_ip5; 
     sum_x_ip1 sum_x_ip2 sum_x_ip3 sum_x_ip4 sum_x_ip5 sum_x_ip6;
     sum_x_ip2 sum_x_ip3 sum_x_ip4 sum_x_ip5 sum_x_ip6 sum_x_ip7;
     sum_x_ip3 sum_x_ip4 sum_x_ip5 sum_x_ip6 sum_x_ip7 sum_x_ip8;
     sum_x_ip4 sum_x_ip5 sum_x_ip6 sum_x_ip7 sum_x_ip8 sum_x_ip9;
     sum_x_ip5 sum_x_ip6 sum_x_ip7 sum_x_ip8 sum_x_ip9 sum_x_ip10];

% Preallocate vector b.
brow = [sum_y_ip1 sum_x_ip1_y_ip1 sum_x_ip2_y_ip1 sum_x_ip3_y_ip1 sum_x_ip4_y_ip1 sum_x_ip5_y_ip1]; % row
b = brow.'           % column

% Taking the SVD of A.
[U,S,V] = svd(A);

% Find the coefficients of the polynomial fit.

% Preallocate vector a.
arow = [0 0 0 0 0 0]; % row
a = brow.';           % column

a = U*(inv(S))*(V.')*b;
a = V*(inv(S))*(U.')*b
%plot(x,y,'-m+')
%xlabel('Time (second)')
%ylabel('ADM Position (counts)')
%title('ADM Position vs. Time')