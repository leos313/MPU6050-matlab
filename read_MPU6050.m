function [ out ] = read_MPU6050( arduino )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

str=fscanf(arduino);
str1=str(1:4);
stop1=NaN;

for j=5:length(str)%to find the end of the first number sent
    if str(j)=='A'
        stop1=j-2;
        break;
    end
end

dt=str2double(str(5:stop1));
stop2=NaN; %to find the first ','
for j=stop1+4:length(str)
    if str(j)==','
        stop2=j-1;
        break;
    end
end
accel_angle_x=str2double(str(stop1+6:stop2));
%to find the second ','
stop3=NaN; %to find the first ','
for j=stop2+2:length(str)
    if str(j)==','
        stop3=j-1;
        break;
    end
end
accel_angle_y=str2double(str(stop2+2:stop3));
%to find the 3° ','
stop4=NaN;
for j=stop3+2:length(str)
    if str(j)=='#'
        stop4=j-1;
        break;
    end
end
accel_angle_z=str2double(str(stop3+2:stop4));
%from stop4 it starts the second sequence corrisponding to
%unfiltered_gyro_angle_x. stop4+6 is the begging of the nest number
%with stop5 the end of next:
stop5=NaN;
for j=stop4+6:length(str)
    if str(j)==','
        stop5=j-1;
        break;
    end
end
unfiltered_gyro_angle_x=str2double(str(stop4+6:stop5));
%the same with stop6
stop6=NaN;
for j=stop5+2:length(str)
    if str(j)==','
        stop6=j-1;
        break;
    end
end
unfiltered_gyro_angle_y=str2double(str(stop5+2:stop6));
%the same with stop6
stop7=NaN;
for j=stop6+2:length(str)
    if str(j)=='#'
        stop7=j-1;
        break;
    end
end
unfiltered_gyro_angle_z=str2double(str(stop6+2:stop7));

%now it starts the last sequence. I'm doing the samethat I did with the
%others. The next numeber start from stop7+6
stop8=NaN;
for j=stop7+6:length(str)
    if str(j)==','
        stop8=j-1;
        break;
    end
end
angle_x=str2double(str(stop7+6:stop8));
%the same with stop6
stop9=NaN;
for j=stop8+2:length(str)
    if str(j)==','
        stop9=j-1;
        break;
    end
end
angle_y=str2double(str(stop8+2:stop9));
%the angle_z until the end
angle_z=str2double(str(stop9+2:length(str)));

out=[dt,accel_angle_x,accel_angle_y,accel_angle_z,unfiltered_gyro_angle_x,unfiltered_gyro_angle_y,unfiltered_gyro_angle_z,angle_x,angle_y,angle_z];





end

