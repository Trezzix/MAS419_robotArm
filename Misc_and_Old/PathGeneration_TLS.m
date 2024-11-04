clc; clear; close all;

%% Project Supplement 3: Path Generation

x = [2 6 5 2];
t = [0 1 2 3];

% Initialize to all zeros
AA = zeros(14,14);
BB = zeros(14,1);

% Equation 1
AA(1,1:5) = F4(t(1));
BB(1) = x(1);
% Equation 2
AA(2,1:5) = F4Dot(t(1));
% Equation 3
AA(3,1:5) = F4DotDot(t(1));
% Equation 4
AA(4,1:5) = F4(t(2));
BB(4) = x(2);
% Equation 5
AA(5,1:5) = F4(t(2));
AA(5,6:9) = -F3(t(2));
% Equation 6
AA(6,1:5) = F4Dot(t(2));
AA(6,6:9) = -F3Dot(t(2));
% Equation 7
AA(7,1:5) = F4DotDot(t(2));
AA(7,6:9) = -F3DotDot(t(2));
% Equation 8
AA(8,6:9) = F3(t(3));
BB(8) = x(3);
% Equation 9
AA(9,6:9) = F3(t(3));
AA(9,10:14) = -F4(t(3));
% Equation 10
AA(10,6:9) = F3Dot(t(3));
AA(10,10:14) = -F4Dot(t(3));
% Equation 11
AA(11,6:9) = F3DotDot(t(3));
AA(11,10:14) = -F4DotDot(t(3));
% Equation 12
AA(12,10:14) = F4(t(4));
BB(12) = x(4);
% Equation 13
AA(13,10:14) = F4Dot(t(4));
% Equation 14
AA(14,10:14) = F4DotDot(t(4));

% Calculate coefficients
coeff = AA\BB;

a = coeff(1:5);
b = coeff(6:9);
c = coeff(10:14);


% Sample 100 points from polynomial 1
tsamp1 = linspace(t(1),t(2),100);
for i = 1:length(tsamp1)
    xsamp1(i) = F4(tsamp1(i))*a;
    vsamp1(i) = F4Dot(tsamp1(i))*a;
    asamp1(i) = F4DotDot(tsamp1(i))*a;
end
% Sample 100 points from polynomial 2
tsamp2 = linspace(t(2),t(3),100);
for i = 1:length(tsamp2)
    xsamp2(i) = F3(tsamp2(i))*b;
    vsamp2(i) = F3Dot(tsamp2(i))*b;
    asamp2(i) = F3DotDot(tsamp2(i))*b;
end
% Sample 100 points from polynomial 3
tsamp3 = linspace(t(3),t(4),100);
for i = 1:length(tsamp3)
    xsamp3(i) = F4(tsamp3(i))*c;
    vsamp3(i) = F4Dot(tsamp3(i))*c;
    asamp3(i) = F4DotDot(tsamp3(i))*c;
end

figure
subplot(3,1,1)
hold on
plot(tsamp1,xsamp1,'Color','#00AF00')
plot(tsamp2,xsamp2,'Color','#00AFFF')
plot(tsamp3,xsamp3,'Color','#60FF60')
plot(t,x,'o','Color','#0000B2', 'LineWidth',3) 
legend('Polynomial 1','Polynomial 2','Polynomial 3','Path Points')
title('Position')

subplot(3,1,2)
hold on
plot(tsamp1,vsamp1,'Color','#00AF00')
plot(tsamp2,vsamp2,'Color','#00AFFF')
plot(tsamp3,vsamp3,'Color','#60FF60')
legend('Polynomial 1','Polynomial 2','Polynomial 3')
title('Velocity')

subplot(3,1,3)
hold on
plot(tsamp1,asamp1,'Color','#00AF00')
plot(tsamp2,asamp2,'Color','#00AFFF')
plot(tsamp3,asamp3,'Color','#60FF60')
legend('Polynomial 1','Polynomial 2','Polynomial 3', ...
        'Location', 'southeast')
title('Acceleration')
% Change size of plot
x0=300;
y0=120;
width=550;
height=400;
set(gcf,'units','points' ,'position',[x0,y0,width,height])

%% Define functions for time-dependent values for polynomials

function [out] = F4(t) 
out =   [1   t    t.^2    t.^3     t.^4];
end

function [out] = F4Dot(t)
out =   [0   1    2*t    3*t.^2   4*t.^3];
end

function [out] = F4DotDot(t)
out = [0   0    2      6*t     12*t.^2];
end

function [out] = F3(t) 
out =   [1   t    t.^2    t.^3];
end

function [out] = F3Dot(t)
out =   [0   1    2*t    3*t.^2];
end

function [out] = F3DotDot(t)
out = [0   0    2      6*t];
end