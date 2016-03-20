%this script is able to read in the correct way the string that arrive from
%arduino and to put the right variable in the right place

clear all;
close all;
delete(instrfind);

%important setting variables
BaudRate=19200;%with thisvariable yu can set the baudrate of arduino
buffSize=100;
simulation_duration=60; %time in seconds



%creating an object arduino
arduino=serial('COM3','BaudRate',BaudRate);

%opening the communication with the object arduino
fopen(arduino);
%first reading to throw away
str=fscanf(arduino);
str=fscanf(arduino);
%legge e mette le variabili lette al posto giusto
str=read_MPU6050(arduino);
dt=str(1);
accel_angle_x=str(2);
accel_angle_y=str(3);
accel_angle_z=str(4);
unfiltered_gyro_angle_x=str(5);
unfiltered_gyro_angle_y=str(6);
unfiltered_gyro_angle_z=str(7);
angle_x=str(8);
angle_y=str(9);
angle_z=str(10);

%%%%% let's star the rotation cube%%%%%%%%%%

%%% Initialized the cube

xc=0; yc=0; zc=0;    % coordinated of the center
L=2;                 % cube size (length of an edge)
alpha=0.8;             % transparency (max=1=opaque)

X = [0 0 0 0 0 1; 1 0 1 1 1 1; 1 0 1 1 1 1; 0 0 0 0 0 1];
Y = [0 0 0 0 1 0; 0 1 0 0 1 1; 0 1 1 1 1 1; 0 0 1 1 1 0];
Z = [0 0 1 0 0 0; 0 0 1 0 0 0; 1 1 1 0 1 1; 1 1 1 0 1 1];

C= [0.1 0.5 0.9 0.9 0.1 0.5];   % color/face

X = L*(X-0.5) + xc;
Y = L/1.5*(Y-0.5) + yc;
Z = L/3*(Z-0.5) + zc;
V=[reshape(X,1,24); reshape(Y,1,24); reshape(Z,1,24)]; %rashape takesthe element of X and it fix them in only one coulomn (in this case)


tic; %to count the seconds




while(toc<simulation_duration) %stop after "simulation duration" seconds
    str=read_MPU6050(arduino);
    dt=str(1);
    accel_angle_x=str(2)*pi/180;
    accel_angle_y=str(3)*pi/180;
    accel_angle_z=str(4)*pi/180;
    unfiltered_gyro_angle_x=str(5)*pi/180;
    unfiltered_gyro_angle_y=str(6)*pi/180;
    unfiltered_gyro_angle_z=str(7)*pi/180;
    angle_x=str(8)*pi/180;
    angle_y=str(9)*pi/180;
    angle_z=str(10)*pi/180;
    
%     psi=accel_angle_x;
%     tetha=accel_angle_y;
%     phi=accel_angle_z;
%     yaw=psi;
%     pitch=tetha;
%     roll=phi;
%      x=[-0.5 0.5 0.5 -0.5 -0.5 -0.5 0.5 0.5 -0.5 -0.5 0.5 0.5 0.5 0.5 -0.5 -0.5; -1 -1 1 1 -1 -1 -1 1 1 -1 -1 -1 1 1 1 1;-2 -2 -2 -2 -2 2 2 2 2 2 2 -2 -2 2 2 -2];
%     xn1=[cos(accel_angle_x) 0 sin(accel_angle_x) ; 0 1 0;-sin(accel_angle_x) 0 cos(accel_angle_x)]*x; %rotazione asse x
%     xn2=[1 0 0; 0 cos(accel_angle_y) -sin(accel_angle_y); 0 sin(accel_angle_y) cos(accel_angle_y)]*xn1;
    
    
%     dcm_acc = angle2dcm( roll, pitch, yaw ) %it creates the rotation matrix [angoli di eulero -> (z,y,x)]
%     dcm_gyr = angle2dcm( unfiltered_gyro_angle_z, unfiltered_gyro_angle_y, unfiltered_gyro_angle_x) %it creates the rotation matrix [angoli di eulero -> (z,y,x)]
    dcm_filtered = angle2dcm( angle_z, angle_x, angle_y) %it creates the rotation matrix [angoli di eulero -> (z,y,x)]
% 
%     VR_acc=dcm_acc*V;
%     VR_gyr=dcm_gyr*V;
    VR_filtered=dcm_filtered*V;

%     XR_acc=reshape(VR_acc(1,:),4,6);
%     YR_acc=reshape(VR_acc(2,:),4,6);
%     ZR_acc=reshape(VR_acc(3,:),4,6);
%     
%     XR_gyr=reshape(VR_gyr(1,:),4,6);
%     YR_gyr=reshape(VR_gyr(2,:),4,6);
%     ZR_gyr=reshape(VR_gyr(3,:),4,6);
    
    XR_filtered=reshape(VR_filtered(1,:),4,6);
    YR_filtered=reshape(VR_filtered(2,:),4,6);
    ZR_filtered=reshape(VR_filtered(3,:),4,6);
%     xn=dcm*x;

    
    figure(1)
%     subplot(1,3,1)
%     fill3(XR_acc,YR_acc,ZR_acc,C,'FaceAlpha',alpha);
%     xlim([-2 2]);
%     ylim([-2 2]);
%     zlim([-2 2]);
%     box on;
%     drawnow
%     subplot(1,3,2)
% 
%     fill3(XR_gyr,YR_gyr,ZR_gyr,C,'FaceAlpha',alpha);
%     xlim([-2 2]);
%     ylim([-2 2]);
%     zlim([-2 2]);
%     box on;
%     drawnow
%     subplot(1,3,3)

    fill3(XR_filtered,YR_filtered,ZR_filtered,C,'FaceAlpha',alpha);
    xlim([-2 2]);
    ylim([-2 2]);
    zlim([-2 2]);
    box on;
    drawnow
    
    
    
%     subplot(2,1,2)
% % 
%     plot3(xn(1,:),xn(2,:),xn(3,:))
%     axis([-3, 3, -3, 3, -3, 3])
%     drawnow
end
    
close all;
delete(instrfind);


