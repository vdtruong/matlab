% ADM Position Profile
% Figure 1 and 2 will show the ADM position profile
% for closing and opening door respectively.

close all;

n = 0; % starting figure number

% For Closing the door.
% Read data column in counts
% Start reading at row 10, column 112.
% Read up to row 38 at the same column.
close_start_row = 10;
close_stop_row  = 38;
data_col        = 112;
y_close = csvread('C:\FPGA_Design_Test\DD66_adm_step_profile\PAK\matlab\FPGA_Design\PAKPUCControl\MATLAB\vv9_scr1235_16_03_11_17_26.csv', ... 
         close_start_row, data_col,[close_start_row,data_col,close_stop_row,data_col]);
% Generate the time axis
x_close = 0:0.5:(close_stop_row - close_start_row)/2; % seconds
n = n + 1;                    % increment figure number
figure(n)
plot(x_close,y_close,'-m+')
xlabel('Time (second)')
ylabel('ADM Position (counts)')
title('ADM Position Profile (For Closing Door)')

% For Opening the door.
open_start_row = 70;
open_stop_row  = 99;
data_col       = 112;
y_open = csvread('C:\FPGA_Design_Test\DD66_adm_step_profile\PAK\matlab\FPGA_Design\PAKPUCControl\MATLAB\vv9_scr1235_16_03_11_17_26.csv', ... 
         open_start_row, data_col,[open_start_row,data_col,open_stop_row,data_col]);
% Generate the time axis
x_open = 0:0.5:(open_stop_row - open_start_row)/2; % seconds
n = n + 1;                    % increment figure number
figure(n)
plot(x_open,y_open,'-m+')
xlabel('Time (second)')
ylabel('ADM Position (counts)')
title('ADM Position Profile (For Opening Door)')

% Motor Steps For Closing the door.
% This figure will show the coarse motor steps of closing the door.
% The data is from the ADM_Controller.v test bench.
% To get the time axis.
close_start_row_time = 2;
close_stop_row_time  = 29;
data_col_time        = 0;
x = csvread('C:\FPGA_Design_Test\DD66_adm_step_profile\PAK\matlab\FPGA_Design\PAKPUCControl\MATLAB\close_adm_motor_steps.csv', ... 
    close_start_row_time, data_col_time,[close_start_row_time,data_col_time,close_stop_row_time,data_col_time]);
% To get the motor steps
close_start_row_mtr_stps = close_start_row_time;
close_stop_row_mtr_stps  = close_stop_row_time;
data_col_mtr_stps        = 1;
y = csvread('C:\FPGA_Design_Test\DD66_adm_step_profile\PAK\matlab\FPGA_Design\PAKPUCControl\MATLAB\close_adm_motor_steps.csv', ... 
    close_start_row_mtr_stps, data_col_mtr_stps,[close_start_row_mtr_stps,data_col_mtr_stps,close_stop_row_mtr_stps,data_col_mtr_stps]);
mtr_stps_freq = 1./y;
n = n + 1;                    % increment figure number
figure(n)
stem(x,mtr_stps_freq,':')
xlabel('Time (second)')
ylabel('ADM Motor Steps (Frequency)')
title('ADM Motor Steps Profile (For Closing Door)')

% Plot both the ADM Closing Position Profile together with the 
% corresponding ADM Motor Steps Profile, ie, figure 1 and figure 3.
n = n + 1;                    % increment figure number
figure(n)
stem_handles = stem(x,mtr_stps_freq,':');
hold on
plot_handle = plot(x_close,y_close,'-m+');
hold off
legend_handles = [stem_handles(1);plot_handle];
legend(legend_handles,'close_mtr_stps','close_pos_prof')
xlabel('Time in secs')
ylabel('Magnitude')
title('Position and Motor Steps of Close Door Profiles')

% ADM Closing Position Profile and Motor Steps Profile
% with different y scales.
n = n + 1;                    % increment figure number
figure(n)
[AX,H1,H2] = plotyy(x_close,y_close,x,mtr_stps_freq,'plot','stem');
set(get(AX(1),'Ylabel'),'String','Position Profile (Counts)')
set(get(AX(2),'Ylabel'),'String','Motor Steps Profile (Freq)') 
xlabel('Time (sec)') 
title('Position and Motor Steps of Close Door Profiles') 
set(H1,'LineStyle','--')
set(H2,'LineStyle',':') 

% This figure will show the fine motor steps of closing the door
% where the motor speeds up.
% The data is from the ADM_Controller.v test bench.
% To get the time axis.
close_middle_start_row_time = 1;
close_middle_stop_row_time  = 30;
data_middle_col_time        = 0;
x_middle = csvread('C:\FPGA_Design_Test\DD66_adm_step_profile\PAK\matlab\FPGA_Design\PAKPUCControl\MATLAB\close_adm_motor_steps_zoom_middle.csv', ... 
           close_middle_start_row_time, data_middle_col_time, ...
           [close_middle_start_row_time, data_middle_col_time, ...
           close_middle_stop_row_time, data_middle_col_time]);
% To get the motor steps
close_middle_start_row_mtr_stps = close_middle_start_row_time;
close_middle_stop_row_mtr_stps  = close_middle_stop_row_time;
data_middle_col_mtr_stps        = 1;
y_middle = csvread('C:\FPGA_Design_Test\DD66_adm_step_profile\PAK\matlab\FPGA_Design\PAKPUCControl\MATLAB\close_adm_motor_steps_zoom_middle.csv', ...
           close_middle_start_row_mtr_stps, data_middle_col_mtr_stps, ...
           [close_middle_start_row_mtr_stps, data_middle_col_mtr_stps, ...
           close_middle_stop_row_mtr_stps, data_middle_col_mtr_stps]);
mtr_stps_middle_freq = 1./y_middle;
n = n + 1;                    % increment figure number
figure(n)
stem(x_middle,mtr_stps_middle_freq,':')
xlabel('Time (second)')
ylabel('ADM Motor Steps (Frequency)')
title('ADM Motor Steps Fast Profile (For Closing Door)')

% Motor Steps For Opening the door.
% This figure will show the coarse motor steps of opening the door.
% The data is from the ADM_Controller.v test bench.
% To get the time axis.
open_start_row_time = 1;
open_stop_row_time  = 25;
data_col_time       = 0;
x = csvread('C:\FPGA_Design_Test\DD66_adm_step_profile\PAK\matlab\FPGA_Design\PAKPUCControl\MATLAB\open_adm_motor_steps.csv', ... 
    open_start_row_time, data_col_time,[open_start_row_time, data_col_time, open_stop_row_time, data_col_time]);
% To get the motor steps
open_start_row_mtr_stps = open_start_row_time;
open_stop_row_mtr_stps  = open_stop_row_time;
data_col_mtr_stps       = 1;
y = csvread('C:\FPGA_Design_Test\DD66_adm_step_profile\PAK\matlab\FPGA_Design\PAKPUCControl\MATLAB\open_adm_motor_steps.csv', ... 
    open_start_row_mtr_stps, data_col_mtr_stps,[open_start_row_mtr_stps, data_col_mtr_stps, open_stop_row_mtr_stps, data_col_mtr_stps]);
mtr_stps_freq = 1./y;
n = n + 1;                    % increment figure number
figure(n)
stem(x,mtr_stps_freq,':')
xlabel('Time (second)')
ylabel('ADM Motor Steps (Frequency)')
title('ADM Motor Steps Profile (For Opening Door)')

% ADM Opening Position Profile and Motor Steps Profile
% with different y scales.
n = n + 1;                    % increment figure number
figure(n)
[AX,H1,H2] = plotyy(x_open,y_open,x,mtr_stps_freq,'plot','stem');
set(get(AX(1),'Ylabel'),'String','Position Profile (Counts)')
set(get(AX(2),'Ylabel'),'String','Motor Steps Profile (Freq)') 
xlabel('Time (sec)') 
title('Position and Motor Steps of Open Door Profiles') 
set(H1,'LineStyle','--')
set(H2,'LineStyle',':') 

% This figure will show the fine motor steps of opening the door
% where the motor speeds up near the beginning.
% The data is from the ADM_Controller.v test bench.
% To get the time axis.
open_near_beginning_start_row_time     = 1;
open_near_beginning_stop_row_time      = 13;
data_open_near_beginning_col_time  = 0;
x_open_near_beginning = csvread('C:\FPGA_Design_Test\DD66_adm_step_profile\PAK\matlab\FPGA_Design\PAKPUCControl\MATLAB\open_adm_zoom_beginning_motor_steps.csv', ... 
           open_near_beginning_start_row_time, data_open_near_beginning_col_time, ...
           [open_near_beginning_start_row_time, data_open_near_beginning_col_time, ...
           open_near_beginning_stop_row_time, data_open_near_beginning_col_time]);
% To get the motor steps
open_near_beginning_start_row_mtr_stps = open_near_beginning_start_row_time;
open_near_beginning_stop_row_mtr_stps  = open_near_beginning_stop_row_time;
data_open_near_beginning_col_mtr_stps  = 1;
y_open_near_beginning = csvread('C:\FPGA_Design_Test\DD66_adm_step_profile\PAK\matlab\FPGA_Design\PAKPUCControl\MATLAB\open_adm_zoom_beginning_motor_steps.csv', ...
           open_near_beginning_start_row_mtr_stps, data_open_near_beginning_col_mtr_stps, ...
           [open_near_beginning_start_row_mtr_stps, data_open_near_beginning_col_mtr_stps, ...
           open_near_beginning_stop_row_mtr_stps, data_open_near_beginning_col_mtr_stps]);
mtr_stps_beginning_freq = 1./y_open_near_beginning;
n = n + 1;                    % increment figure number
figure(n)
stem(x_open_near_beginning,mtr_stps_beginning_freq,':')
xlabel('Time (second)')
ylabel('ADM Motor Steps (Frequency)')
title('ADM Motor Steps Near Beginning Profile (For Opening Door)')

% This figure will show the fine motor steps of opening the door
% where the motor speeds up near the end.
% The data is from the ADM_Controller.v test bench.
% To get the time axis.
open_near_end_start_row_time = 1;
open_near_end_stop_row_time  = 90;
data_open_near_end_col_time  = 0;
x_open_near_end = csvread('C:\FPGA_Design_Test\DD66_adm_step_profile\PAK\matlab\FPGA_Design\PAKPUCControl\MATLAB\open_adm_zoom_near_end_motor_steps.csv', ... 
           open_near_end_start_row_time, data_open_near_end_col_time, ...
           [open_near_end_start_row_time, data_open_near_end_col_time, ...
           open_near_end_stop_row_time, data_open_near_end_col_time]);
% To get the motor steps
open_near_end_start_row_mtr_stps = open_near_end_start_row_time;
open_near_end_stop_row_mtr_stps  = open_near_end_stop_row_time;
data_open_near_end_col_mtr_stps  = 1;
y_open_near_end = csvread('C:\FPGA_Design_Test\DD66_adm_step_profile\PAK\matlab\FPGA_Design\PAKPUCControl\MATLAB\open_adm_zoom_near_end_motor_steps.csv', ...
           open_near_end_start_row_mtr_stps, data_open_near_end_col_mtr_stps, ...
           [open_near_end_start_row_mtr_stps, data_open_near_end_col_mtr_stps, ...
           open_near_end_stop_row_mtr_stps, data_open_near_end_col_mtr_stps]);
mtr_stps_near_end_freq = 1./y_open_near_end;
n = n + 1;                    % increment figure number
figure(n)
stem(x_open_near_end,mtr_stps_near_end_freq,':')
xlabel('Time (second)')
ylabel('ADM Motor Steps (Frequency)')
title('ADM Motor Steps Near End Profile (For Opening Door)')