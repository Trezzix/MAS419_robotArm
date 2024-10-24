clc
clear all
close all 
x = [2 6 5 2];
t = [0 1 2 3];

AA = zeros(14,14);
BB = zeros(14,1);

AA(1,1:5) = F4(t(1));                                    BB(1) = x(1);
AA(2,1:5) = F4Dot(t(1));
AA(3,1:5) = F4DDot(t(1));
AA(4,1:5) = F4(t(2));                                    BB(4) = x(2);
AA(5,1:5) = F4(t(2));      AA(5,6:9) = -F3(t(2));
AA(6,1:5) = F4Dot(t(2));   AA(6,6:9) = -F3Dot(t(2));
AA(7,1:5) = F4DDot(t(2));  AA(7,6:9) = -F3DDot(t(2));
AA(8,6:9) = F3(t(3));                                    BB(8) = x(3);
AA(9,6:9) = F3(t(3));      AA(9,10:14) = -F4(t(3));
AA(10,6:9) = F3Dot(t(3));  AA(10,10:14) = -F4Dot(t(3));
AA(11,6:9) = F3DDot(t(3)); AA(11,10:14) = -F4DDot(t(3));
AA(12,10:14) = F4(t(4));                                 BB(12) = x(4);
AA(13,10:14) = F4Dot(t(4));
AA(14,10:14) = F4DDot(t(4));

coeff = AA\BB;

a = coeff(1:5);
b = coeff(6:9);
c = coeff(10:14);

tsamp1 = linspace(t(1),t(2),100);
tsamp2 = linspace(t(2),t(3),100);
tsamp3 = linspace(t(3),t(4),100);

for i = 1:length(tsamp1)
    xsamp1(i) = F4(tsamp1(i))*a;
    vsamp1(i) = F4Dot(tsamp1(i))*a;
    asamp1(i) = F4DDot(tsamp1(i))*a;
end
for i = 1:length(tsamp2)
    xsamp2(i) = F3(tsamp2(i))*b;
    vsamp2(i) = F3Dot(tsamp2(i))*b;
    asamp2(i) = F3DDot(tsamp2(i))*b;
end
for i = 1:length(tsamp3)
    xsamp3(i) = F4(tsamp3(i))*c;
    vsamp3(i) = F4Dot(tsamp3(i))*c;
    asamp3(i) = F4DDot(tsamp3(i))*c;
end


 plot(t,x,'o')
 hold on
 plot(tsamp1,xsamp1,'--')
 plot(tsamp2,xsamp2,'--')
 plot(tsamp3,xsamp3,'--')

 figure
 plot(tsamp1,vsamp1,'--')
 hold on
 plot(tsamp2,vsamp2,'--')
 plot(tsamp3,vsamp3,'--')
 plot(tsamp1,asamp1,'.')
 plot(tsamp2,asamp2,'.')
 plot(tsamp3,asamp3,'.')
 
















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