clear; close all; clc;

% theta_n = 26;%deg
% theta_e = 10.5;%deg
% e = 10; % nozzle expansion ratio
theta_ns = [23,26,29,30,31];
theta_es = [13, 10.5, 9, 8.5, 7.8];
es = [5,10,20,30,50];
%half_cone_angle = 15;
half_cone_angle = 18;
Rt = 0.2; %m

for i=1:5    
    subplot(5,1,i);
    theta_n = theta_ns(i);%deg
    theta_e = theta_es(i);%deg
    e = es(i); % nozzle expansion ratio
   
    L_N = 0.8*((sqrt(e)-1)*Rt/tan(deg2rad(half_cone_angle)));
    Re = sqrt(e)*Rt;
    
    % entrant section
    theta = deg2rad(-135:5:-90);
    x = 1.5*Rt*cos(theta);
    y = 1.5*Rt*sin(theta)+1.5*Rt+Rt;
    plot(x,y);
    hold on;
    % exit section
    theta = deg2rad(linspace(-90,theta_n-90,10));
    x = 0.382*Rt*cos(theta);
    y = 0.382*Rt*sin(theta)+0.382*Rt+Rt;
    plot(x,y);
    
    % bell section
    Nx = x(end);
    Ny = y(end);
    Ex = L_N;
    Ey = Re;
    m1 = tan(deg2rad(theta_n));
    m2 = tan(deg2rad(theta_e));
    C1 = Ny-m1*Nx;
    C2 = Ey-m2*Ex;
    Qx = (C2-C1)/(m1-m2);
    Qy = (m1*C2-m2*C1)/(m1-m2);
    
    t = linspace(0,1,20);
    x = (1-t).^2*Nx+2*(1-t).*t*Qx+t.^2*Ex;
    y = (1-t).^2*Ny+2*(1-t).*t*Qy+t.^2*Ey;
    plot(x,y);
    title(sprintf('Nozzle expansion ratio: %d',e));
    xlim([-0.2 3]);
%     ylim([0 0.7]);
end
sgtitle('80% Bell nozzle design');

big;



