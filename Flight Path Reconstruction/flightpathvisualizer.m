clc; clear; close all;
% Flight Path Visualizer
% Author: Jeremy Tan Zi Xiang
% Created: 27 Jul 2026

%% Data Import & Variable Assignment --------------------------------------

raw_data=readmatrix("test 2.csv");
tr = transpose(raw_data(:,1));    % [s] raw time data
ar_x = raw_data(:,2);  % [m/s^2] raw acceleration data about x-axis
ar_y = raw_data(:,3);  % [m/s^2] raw acceleration data about y-axis
ar_z = raw_data(:,4);  % [m/s^2] raw acceleration data about z-axis
pr = raw_data(:,5);    % [Pa] raw pressure data points

%% Raw Data Plots ---------------------------------------------------------

figure("Name","X-accel")
plot(tr,ar_x)
xlabel('Time (s)');
ylabel('Acceleration (m/s^2)');
title('X-axis Acceleration vs Time');
grid on;

figure("Name","Y-accel")
plot(tr,ar_y);
xlabel('Time (s)');
ylabel('Acceleration (m/s^2)');
title('Y-axis Acceleration vs Time');
grid on;

figure("Name","Z-accel")
plot(tr,ar_z);
xlabel('Time (s)');
ylabel('Acceleration (m/s^2)');
title('Z-axis Acceleration vs Time');
grid on;

figure("Name","Pressure")
plot(tr,pr,LineWidth=2);
xlabel('Time (s)');
ylabel('Pressure (Pa)');
title('Pressure vs Time');
grid on;

%% Altitude calculation ---------------------------------------------------
hr=44330.*(1-(pr./1013.25).^0.19026);
hr=hr-hr(end)+5;

%% Altitude Plot ----------------------------------------------------------
figure("Name","Altitude")
plot(tr, hr,LineWidth=2);
xlabel('Time (s)');
ylabel('Altitude (m)');
title('Altitude vs Time');
grid on;

%% interpolate variables to regular intervals -----------------------------
t = 0:0.1:244;             % [s] imposed time data with regular interval
a_x = interp1(tr,ar_x,t);
a_y = interp1(tr,ar_y,t);
a_z = interp1(tr,ar_z,t);
h = interp1(tr,hr,t);

% Remove NaN from Variables
t = t(2:end);
a_x = a_x(2:end);
a_y = a_y(2:end);
a_z = a_z(2:end);
h = h(2:end);

%% Position calculation ---------------------------------------------------
% Calculate velocity from acceleration
v_x = cumtrapz(t,a_x);
v_y = cumtrapz(t,a_y);
v_z = cumtrapz(t,a_z);

% Calculate displacement from velocity
d_x = cumtrapz(t, v_x);
d_y = cumtrapz(t, v_y);
d_z = cumtrapz(t, v_z);

%% Plot Flight Path
figure('Name','Flight Path')
hold on
plot3(d_x,d_y,h,LineWidth=2,Color='r');

[X,Y] = meshgrid(min(d_x)-20:10:max(d_x)+20,min(d_y)-20:10:max(d_y)+20); 
Z = zeros(size(X));
surf(X, Y, Z,FaceColor='#228B22',EdgeColor='#228B22'); 

[X,Z] = meshgrid(min(d_x)-20:10:max(d_x)+20,0:round(max(h))/10:round(max(h)));
Y = (min(d_y)-20)*ones(size(X));
surf(X, Y, Z,FaceColor='#80B3FF',EdgeColor='#80B3FF'); 

[Y,Z] = meshgrid(min(d_y)-20:10:max(d_y)+20,0:round(max(h))/10:round(max(h)));
X = (min(d_x)-20)*ones(size(Y));
surf(X, Y, Z,FaceColor='#87CEFA',EdgeColor='#87CEFA'); 

plot3(d_x(1),d_y(1),h(1),MarkerSize=8,MarkerFaceColor="auto");
text(d_x(1) + 0.1, d_y(1), h(1), ' Start', 'FontSize', 12, 'FontWeight', 'bold');

plot3(d_x(end),d_y(end),h(end),MarkerSize=8,MarkerFaceColor="auto");
text(d_x(end) + 0.1, d_y(end), h(end), 'End', 'FontSize', 12, 'FontWeight', 'bold');

xlabel('Longitude (m)')
ylabel('Latitude (m)')
zlabel('Altitude (m)')
grid on
rotate3d on
xlim([min(d_x)-20 max(d_x)+20]);
ylim([min(d_y)-20 max(d_y)+20]);
zlim([0 max(h)]);

hold off


