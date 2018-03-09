% This script will extract the ELP motor rpm from register 0x013A.
% 01/09/2017

clear;
close all;
format long;

% Extracting data from a file -------------------------
fid   = fopen('C:\LogFiles\vv36_elp_rpm_trbsht_17_01_06_15_28_38_edited.csv');
fgetl(fid);   %skip first line
% date, time, master state, alarm state, elp rpm debug, elp rpm cmd, 
% elp rpm encdr, tp1(013a), tp2(025c), tp3(016b), tp4(0169), tp5(022d)
C = textscan(fid, '%*s %*s %*s %*s %f %f %f %f %f %f %f %f', 'delimiter', ',');
fclose(fid);
% 
whos C;

% Setting constants.
err_perc = 0.10;              % 10 percent error
nSize                   = 36; % 36 bits fixed point number
nRadix                  = 18; % 18 integer, 18 decimal
% Mask the value with 0x3FFFF.
mask_val = 262143;
% Left shift by
shift = 10;
m                    = 31600;    % data length
k                    = 200:1:m;  % start at 200,incr. by 1, go to m
col_for_3A           = 4;        % tp1
col_for_2D           = 8;        % tp5
col_for_69           = 7;        % commanded dialysate flow rate
reg_013A = C{col_for_3A}(k);     % register 0x013A
reg_022D = C{col_for_2D}(k);     % register 0x022D
reg_0169 = C{col_for_69}(k);     % register 0x0169
reg_013A(500);
size_of_reg_013A = size(reg_013A);
% Extract register 0x0136 from register 0x013A.
for n = 1:size_of_reg_013A
    get_0136 = bitand(reg_013A(n),mask_val);
    left_shift_0136 = bitshift(get_0136,shift);
    conv_0136_to_hex = dec2hex(left_shift_0136);
    dec_0136(n) = HexToDouble(conv_0136_to_hex,nSize,nRadix);
    ten_perc(n) = dec_0136(n)*err_perc;
    above_10_perc(n) = ten_perc(n) + dec_0136(n);
    below_10_perc(n) = dec_0136(n) - ten_perc(n);
    con_law_rpm(n) = reg_0169(n)*(3.4/342) + 0.2184;
end
% End of data extraction ---------------------------------

% Graph 0x0136, commanded rpm ---------------------------------------------
plot(k,dec_0136,'r',k,reg_022D,'b',k,above_10_perc,'g',k,below_10_perc,'m'); 
title('Commanded vs. Measured ELP RPM');
legend('Commanded ELP RPM (0x0136)','Measured ELP RPM (0x022D)', '10% Above Commanded RPM', '10% Below Commanded RPM');
xlabel('Time (Every 1/2s)');
ylabel('Commanded ELP RPM');
% 
% This figure shows the calculated control law rpm.
figure(2);
plot(k,con_law_rpm,'r');
title('ELP Control Law Speed');
legend('ELP Control Law Speed');
xlabel('Time (Every 1/2s)');
ylabel('ELP Control Law Speed (rpm)');
% 
% % Simulated X order filtererd data
% figure(3);
% plot(k,yAmmFixVoltFilt4thOrder,'r'); % simulated filtered
% title('Simulated Filtered Ammonia Data');
% legend('Simulated 4th Order Filtered Ammonia Data');
% xlabel('Time (Every 1/2s)');
% ylabel('SimulatedMeasured Filtered Ammonia (V)');
% 
% % The followings are Ammonia in V.
% % They are measured and simulated filtered data.
% figure(4);
% plot(k,yAmmFiltMeas,'r',k,yAmmFixVoltFilt4thOrder,'b');
% title('Measured and Simulated Filtered Data');
% legend('Measured 1st Order Data','Simulated 4th Order Data');
% xlabel('Time (1/2s)');
% ylabel('Ammonia Data (V)');