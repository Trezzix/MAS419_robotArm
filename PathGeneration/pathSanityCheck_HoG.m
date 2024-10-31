clc; close all;

%% Plotting same as in Simulink

t = 0;
step = 1e-4;
stopTime = 20;
idx = 1;

tIntervals = [0 1 2 3 4]; % [sec] test hard code from 3Dpath
while t <= stopTime
    if t <= tIntervals(2)
        x = F4(t)*coeffx(1:5);
        y = F4(t)*coeffy(1:5);
        z = F4(t)*coeffz(1:5);
    elseif t <= tIntervals(3)
        x = F3(t)*coeffx(6:9);
        y = F3(t)*coeffy(6:9);
        z = F3(t)*coeffz(6:9);
    elseif t <= tIntervals(4)
        x = F3(t)*coeffx(10:13);
        y = F3(t)*coeffy(10:13);
        z = F3(t)*coeffz(10:13);
    elseif t <= tIntervals(5)
        x = F4(t)*coeffx(14:18);
        y = F4(t)*coeffy(14:18);
        z = F4(t)*coeffz(14:18);
    end

    plotTime(idx) = t;
    plotX(idx) = x;
    plotY(idx) = y;
    plotZ(idx) = z;

    t = t+step;
    idx = idx + 1;
end

figure
plot3(plotX,plotY,plotZ, '.k')

x = [2000e-3 2000e-3 1600e-3 1600e-3 2000e-3]; %m
y = [500e-3 -500e-3 500e-3 0 500e-3]; %m
z = [1600e-3 1600e-3 900e-3 900e-3 1600e-3]; %m
hold on
plot3(x,y,z,'o')
title('3D Plot')

figure
plot(plotTime, plotX, 'r.')
hold on
plot(plotTime, plotY, 'g.')
plot(plotTime, plotZ, 'b.')
title('Positons as fcn of time')
xlabel('Time [seconds]')
ylabel('Position [m]')

function [out] = F4(t) 
    out =   [1   t    t.^2    t.^3     t.^4];
end
function [out] = F3(t) 
    out =   [1   t    t.^2    t.^3];
end