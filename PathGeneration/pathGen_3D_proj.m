clc; clear; close all; 
x = [2000e-3 2000e-3 1600e-3 1600e-3 2000e-3]; %m
y = [500e-3 -500e-3 500e-3 0 500e-3]; %m
z = [1600e-3 1600e-3 900e-3 900e-3 1600e-3]; %m
t = [0 1 2 3 4]; %s, unsure how this is found
enablePlotting = false; % Change this to toggle plotting

TX = zeros(5,5);
RX = zeros(5,1);
TY = zeros(14,14);
RY = zeros(5,1);
TZ = zeros(14,14);
RZ = zeros(5,1);

[TX,RX,matsize] = pathGen(t,x);
[TY,RY,matsize] = pathGen(t,y);
[TZ,RZ,matsize] = pathGen(t,z);
%matsize
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

coeffx = TX\RX;
coeffy = TY\RY;
coeffz = TZ\RZ;
%x coefficients
ax = coeffx(1:5);
bx = coeffx(6:9);
cx = coeffx(10:13);
dx = coeffx(14:18);
%ex = coeffx(18:22);
%y
ay = coeffy(1:5);
by = coeffy(6:9);
cy = coeffy(10:13);
dy = coeffy(14:18);
% ey = coeffy(18:22);
%z
az = coeffz(1:5);
bz = coeffz(6:9);
cz = coeffz(10:13);
dz = coeffz(14:18);
% ez = coeffz(18:22);
% save("coefficients_all.mat","ax","bx","cx","dx", ...
%                         "ay","by","cy","dy", ...
%                         "az","bz","cz","dz")

% save("coefficients_x.mat","coeffx")
% save("coefficients_y.mat","coeffy")
% save("coefficients_z.mat","coeffz")

% step = 1e-4;
% time = t(1) : step : t(end);
% coeffData.coeffs = [coeffx, coeffy, coeffz];
% coeffData.dummyTime = time;
% save("coefficients.mat","coeffData")

%x time sampling
tsamp1x = linspace(t(1),t(2),100);
tsamp2x = linspace(t(2),t(3),100);
tsamp3x = linspace(t(3),t(4),100);
tsamp4x = linspace(t(4),t(5),100);
% tsamp5x = linspace(t(5),t(6),100);
%y
tsamp1y = linspace(t(1),t(2),100);
tsamp2y = linspace(t(2),t(3),100);
tsamp3y = linspace(t(3),t(4),100);
tsamp4y = linspace(t(4),t(5),100);
% tsamp5y = linspace(t(5),t(6),100);
%z
tsamp1z = linspace(t(1),t(2),100);
tsamp2z = linspace(t(2),t(3),100);
tsamp3z = linspace(t(3),t(4),100);
tsamp4z = linspace(t(4),t(5),100);
% tsamp5z = linspace(t(5),t(6),100);



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

% for i = 1:length(tsamp5x)
%      xsamp5(i) =     F4(tsamp5x(i))*   ex;
%     vxsamp5(i) =  F4Dot(tsamp5x(i))*   ex;
%     axsamp5(i) = F4DDot(tsamp5x(i))*   ex;
% 
%      ysamp5(i) =     F4(tsamp5y(i))*   ey;
%     vysamp5(i) =  F4Dot(tsamp5y(i))*   ey;
%     aysamp5(i) = F4DDot(tsamp5y(i))*   ey;
% 
%      zsamp5(i) =     F4(tsamp5z(i))*   ez;
%     vzsamp5(i) =  F4Dot(tsamp5z(i))*   ez;
%     azsamp5(i) = F4DDot(tsamp5z(i))*   ez;
% end

if enablePlotting
    %plot(t,x,'o')
    figure
    plot3(x,y,z,'o')
    hold on
    plot3(xsamp1,ysamp1,zsamp1,'--')
    plot3(xsamp2,ysamp2,zsamp2,'--')
    plot3(xsamp3,ysamp3,zsamp3,'--')
    plot3(xsamp4,ysamp4,zsamp4,'--')
    % plot3(xsamp5,ysamp5,zsamp5,'--')
    legend('Points','t1','t2','t3','t4')
    title("position")
    xlabel("X [m]")
    ylabel("Y [m]")
    zlabel("Z [m]")
    
    figure
    %plot3(x,y,z,'o')
    plot3(vxsamp1,vysamp1,vzsamp1,'--')
    hold on
    plot3(vxsamp2,vysamp2,vzsamp2,'--')
    plot3(vxsamp3,vysamp3,vzsamp3,'--')
    plot3(vxsamp4,vysamp4,vzsamp4,'--')
    % plot3(vxsamp5,vysamp5,vzsamp5,'--')
    legend('vt1','vt2','vt3','vt4')
    title("Velocity")
    xlabel("X [m/s]")
    ylabel("Y [m/s]")
    zlabel("Z [m/s]")
    
    figure
    plot3(axsamp1,aysamp1,azsamp1,'.')
    hold on
    plot3(axsamp2,aysamp2,azsamp2,'.')
    plot3(axsamp3,aysamp3,azsamp3,'.')
    plot3(axsamp4,aysamp4,azsamp4,'.')
    % plot3(axsamp5,aysamp5,azsamp5,'.')
    legend('at1','at2','at3','at4')
    title("Acceleration")
    xlabel("X [m/s^2]")
    ylabel("Y [m/s^2]")
    zlabel("Z [m/s^2]")
    
    
    %plot(tsamp1,asamp1,'.')
    %plot(tsamp2,asamp2,'.')
    %plot(tsamp3,asamp3,'.')
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
    LL(i,index:index+4) = F4Dot(t(m));                i=i+1;
    LL(i,index:index+4) = F4DDot(t(m));               i=i+1;
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
    else %middle
        LL(i,index:index+3) = F3(t(m));      RR(i) = val(m); i=i+1;
        LL(i,index:index+3) = F3(t(m));           LL(i,index+4:index+7) = -F3(t(m));     i=i+1; 
        LL(i,index:index+3) = F3Dot(t(m));        LL(i,index+4:index+7) = -F3Dot(t(m));  i=i+1; 
        LL(i,index:index+3) = F3DDot(t(m));       LL(i,index+4:index+7) = -F3DDot(t(m)); i=i+1; 
        index = index + 4;
        m=m+1;
    end
    % LL(1,1:5) = F4(t(1));   RR(1) = x(1);
    % LL(2,1:5) = F4Dot(t(1));
    % LL(3,1:5) = F4DDot(t(1));
    % LL(4,1:5) = F4(t(2));   RR(4) = x(2);
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