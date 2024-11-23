clc; clear; close all; 
x = [2000 2000 1600 1600 2000]*1e-3; % [m]
y = [500  -500  500    0  500]*1e-3; % [m]
z = [1600 1600  900  900 1600]*1e-3; % [m]
t = [0 3 6 8 10]; % Polynomial time intervals
enablePlotting = true; % Change this to toggle plotting

[TX,RX,matsize] = pathGen(t,x);
[TY,RY,matsize] = pathGen(t,y);
[TZ,RZ,matsize] = pathGen(t,z);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

coeffx = TX\RX;
coeffy = TY\RY;
coeffz = TZ\RZ;
% x coefficients
ax = coeffx(1:5);
bx = coeffx(6:9);
cx = coeffx(10:13);
dx = coeffx(14:18);
% y coefficients
ay = coeffy(1:5);
by = coeffy(6:9);
cy = coeffy(10:13);
dy = coeffy(14:18);
% z coefficients
az = coeffz(1:5);
bz = coeffz(6:9);
cz = coeffz(10:13);
dz = coeffz(14:18);

step = 1e-4;
% x Time Sampling
tsamp1x = t(1) : step : t(2);
tsamp2x = t(2) : step : t(3);
tsamp3x = t(3) : step : t(4);
tsamp4x = t(4) : step : t(5);
% y Time Sampling
tsamp1y = t(1) : step : t(2);
tsamp2y = t(2) : step : t(3);
tsamp3y = t(3) : step : t(4);
tsamp4y = t(4) : step : t(5);
% z Time Sampling
tsamp1z = t(1) : step : t(2);
tsamp2z = t(2) : step : t(3);
tsamp3z = t(3) : step : t(4);
tsamp4z = t(4) : step : t(5);

    % Pos, Vel, Acc Sampling
for i = 1:length(tsamp1x)
    xsamp1(i) =  F4(tsamp1x(i))*    ax;
    vxsamp1(i) = F4Dot(tsamp1x(i))* ax;
    axsamp1(i) = F4DDot(tsamp1x(i))*ax;

    ysamp1(i) =  F4(tsamp1y(i))*    ay;
    vysamp1(i) = F4Dot(tsamp1y(i))* ay;
    aysamp1(i) = F4DDot(tsamp1y(i))*ay;

    zsamp1(i) =  F4(tsamp1z(i))*    az;
    vzsamp1(i) = F4Dot(tsamp1z(i))* az;
    azsamp1(i) = F4DDot(tsamp1z(i))*az;
end
for i = 1:length(tsamp2x)
    xsamp2(i) =  F3(tsamp2x(i))*    bx;
    vxsamp2(i) = F3Dot(tsamp2x(i))* bx;
    axsamp2(i) = F3DDot(tsamp2x(i))*bx;

    ysamp2(i) =      F3(tsamp2y(i))*  by;
    vysamp2(i) =  F3Dot(tsamp2y(i))*  by;
    aysamp2(i) = F3DDot(tsamp2y(i))*  by;

    zsamp2(i) =      F3(tsamp2z(i))*  bz;
    vzsamp2(i) =  F3Dot(tsamp2z(i))*  bz;
    azsamp2(i) = F3DDot(tsamp2z(i))*  bz;
end
for i = 1:length(tsamp3x)
     xsamp3(i) =     F3(tsamp3x(i))*   cx;
    vxsamp3(i) =  F3Dot(tsamp3x(i))*   cx;
    axsamp3(i) = F3DDot(tsamp3x(i))*   cx;

     ysamp3(i) =     F3(tsamp3y(i))*   cy;
    vysamp3(i) =  F3Dot(tsamp3y(i))*   cy;
    aysamp3(i) = F3DDot(tsamp3y(i))*   cy;

     zsamp3(i) =     F3(tsamp3z(i))*   cz;
    vzsamp3(i) =  F3Dot(tsamp3z(i))*   cz;
    azsamp3(i) = F3DDot(tsamp3z(i))*   cz;
end
for i = 1:length(tsamp4x)
     xsamp4(i) =     F4(tsamp4x(i))*   dx;
    vxsamp4(i) =  F4Dot(tsamp4x(i))*   dx;
    axsamp4(i) = F4DDot(tsamp4x(i))*   dx;

     ysamp4(i) =     F4(tsamp4y(i))*   dy;
    vysamp4(i) =  F4Dot(tsamp4y(i))*   dy;
    aysamp4(i) = F4DDot(tsamp4y(i))*   dy;

     zsamp4(i) =     F4(tsamp4z(i))*   dz;
    vzsamp4(i) =  F4Dot(tsamp4z(i))*   dz;
    azsamp4(i) = F4DDot(tsamp4z(i))*   dz;
end

if enablePlotting
    % Line Width of all plots
    lW = 1.8;

    % Position
    figure
    plot3(x,y,z,'ok', 'LineWidth', lW)
    hold on
    plot3(xsamp1,ysamp1,zsamp1, 'LineWidth',lW, 'Color','#D95319')
    plot3(xsamp2,ysamp2,zsamp2, 'LineWidth',lW, 'Color','#EDB120')
    plot3(xsamp3,ysamp3,zsamp3, 'LineWidth',lW, 'Color','#99C164')
    plot3(xsamp4,ysamp4,zsamp4, 'LineWidth',lW, 'Color','#77BFFF')
    legend('Points','$P_1(t)$','$P_2(t)$','$P_3(t)$','$P_4(t)$', ...
        'interpreter', 'latex')
    set(gca, 'FontSize', 14);
    lgd = legend;
    lgd.FontSize = 14;
    title("Position")
    xlabel("x [m]")
    ylabel("y [m]")
    zlabel("z [m]")
    
    % Velocity
    figure
    subplot(1,2,1)
    plot3(vxsamp1,vysamp1,vzsamp1, 'LineWidth',lW, 'Color','#D95319')
    hold on
    plot3(vxsamp2,vysamp2,vzsamp2, 'LineWidth',lW, 'Color','#EDB120')
    plot3(vxsamp3,vysamp3,vzsamp3, 'LineWidth',lW, 'Color','#99C164')
    plot3(vxsamp4,vysamp4,vzsamp4, 'LineWidth',lW, 'Color','#77BFFF')
    legend('$\dot{P}_1(t)$','$\dot{P}_2(t)$','$\dot{P}_3(t)$',...
        '$\dot{P}_4(t)$', 'interpreter', 'latex')
    set(gca, 'FontSize', 14);
    lgd = legend;
    lgd.FontSize = 14;
    title("Velocity")
    xlabel("x [m/s]")
    ylabel("y [m/s]")
    zlabel("z [m/s]")
    
    % Acceleration
    subplot(1,2,2)
    plot3(axsamp1,aysamp1,azsamp1, 'LineWidth',lW, 'Color','#D95319')
    hold on
    plot3(axsamp2,aysamp2,azsamp2, 'LineWidth',lW, 'Color','#EDB120')
    plot3(axsamp3,aysamp3,azsamp3, 'LineWidth',lW, 'Color','#99C164')
    plot3(axsamp4,aysamp4,azsamp4, 'LineWidth',lW, 'Color','#77BFFF')
    legend('$\ddot{P}_1(t)$','$\ddot{P}_2(t)$','$\ddot{P}_3(t)$',...
        '$\ddot{P}_4(t)$', 'interpreter', 'latex')
    set(gca, 'FontSize', 14);
    lgd = legend;
    lgd.FontSize = 14;
    title("Acceleration")
    xlabel("x [m/s^2]")
    ylabel("y [m/s^2]")
    zlabel("z [m/s^2]")
end


function [LL,RR,matsize] = pathGen(t,val)
    if (length(t) ~= length(val))
        error("Array lengths of position and time do not match")
    end
    pointNum = length(t);
    matsize = 6 + (pointNum-2)*4;
    LL = zeros(matsize, matsize);
    RR = zeros(matsize,1);
    i = 1;
    m = 1;
    index = 1;
    LL(i,index:index+4) = F4(t(m));   RR(i) = val(m);   i=i+1; 
    LL(i,index:index+4) = F4Dot(t(m));                  i=i+1;
    LL(i,index:index+4) = F4DDot(t(m));                 i=i+1;
    m=m+1;
    LL(i,index:index+4) = F4(t(m));   RR(i) = val(m);   i=i+1;
    
    if pointNum < 3
        error("Too few points")
    end

    if pointNum == 3
        [LL,RR,index,i,m]= middleSec(LL,RR,"3",index,i,m,t,val);
    else
        for n = 1:pointNum-2
            if n == 1
                [LL,RR,index,i,m]= middleSec(LL,RR,"first",index,i,m,t,val);
            elseif n == pointNum-2
                [LL,RR,index,i,m]= middleSec(LL,RR,"last",index,i,m,t,val);
                break
            else
                [LL,RR,index,i,m]= middleSec(LL,RR,"middle",index,i,m,t,val);
            end
        end
    end
    index
    LL(i,index:index+4) = F4(t(m));     RR(i) = val(m); i=i+1;
    LL(i,index:index+4) = F4Dot(t(m));                i=i+1;
    LL(i,index:index+4) = F4DDot(t(m));

end
function [LL,RR,index,i,m] = middleSec(LL,RR,pos,index,i,m,t,val) 
    if pos == "first"
        LL(i,index:index+4) = F4(t(m));      LL(5,index+5:index+8) = -F3(t(m)); i=i+1;
        LL(i,index:index+4) = F4Dot(t(m));   LL(6,index+5:index+8) = -F3Dot(t(m)); i=i+1;
        LL(i,index:index+4) = F4DDot(t(m));  LL(7,index+5:index+8) = -F3DDot(t(m)); i=i+1;
        index = index + 5;
        m=m+1;
    elseif pos == "last"
        LL(i,index:index+3) = F3(t(m));      RR(i) = val(m); i=i+1;
        LL(i,index:index+3) = F3(t(m));      LL(i,index+4:index+8) = -F4(t(m)); i=i+1;
        LL(i,index:index+3) = F3Dot(t(m));   LL(i,index+4:index+8) = -F4Dot(t(m)); i=i+1;
        LL(i,index:index+3) = F3DDot(t(m));  LL(i,index+4:index+8) = -F4DDot(t(m)); i=i+1;
        index = index + 4;
        m=m+1;
    elseif pos == "3"
        LL(i,index:index+4) = F4(t(m));           LL(i,index+5:index+9) = -F4(t(m));     i=i+1; 
        LL(i,index:index+4) = F4Dot(t(m));        LL(i,index+5:index+9) = -F4Dot(t(m));  i=i+1; 
        LL(i,index:index+4) = F4DDot(t(m));       LL(i,index+5:index+9) = -F4DDot(t(m)); i=i+1; 
        index = index + 5;
        m=m+1;
    else % middle
        LL(i,index:index+3) = F3(t(m));      RR(i) = val(m); i=i+1;
        LL(i,index:index+3) = F3(t(m));           LL(i,index+4:index+7) = -F3(t(m));     i=i+1; 
        LL(i,index:index+3) = F3Dot(t(m));        LL(i,index+4:index+7) = -F3Dot(t(m));  i=i+1; 
        LL(i,index:index+3) = F3DDot(t(m));       LL(i,index+4:index+7) = -F3DDot(t(m)); i=i+1; 
        index = index + 4;
        m=m+1;
    end
end

function [out] = F4(t) 
out =   [1   t    t.^2    t.^3     t.^4];
end

function [out] = F4Dot(t)
out =   [0   1    2*t    3*t.^2   4*t.^3];
end

function [out] = F4DDot(t)
out = [0   0    2      6*t     12*t.^2];
end

function [out] = F3(t) 
out =   [1   t    t.^2    t.^3];
end

function [out] = F3Dot(t)
out =   [0   1    2*t    3*t.^2];
end

function [out] = F3DDot(t)
out = [0   0    2      6*t];
end