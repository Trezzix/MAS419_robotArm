clc
clear all
close all 
x = [2 6 5 2 8 9 3 10 2 3 4 5];
t = [0 1 2 3 4 5 6 7 8 9 10 11];

AA = zeros(14,14);
BB = zeros(14,1);
TT = zeros(14,14);
RR = zeros(14,1);

AA(1,1:5) = F4(t(1));                                                                BB(1) = x(1);
AA(2,1:5) = F4Dot(t(1));
AA(3,1:5) = F4DDot(t(1));
AA(4,1:5) = F4(t(2));                                                                BB(4) = x(2);
AA(5,1:5) = F4(t(2));      AA(5,6:9) = -F3(t(2));
AA(6,1:5) = F4Dot(t(2));   AA(6,6:9) = -F3Dot(t(2));
AA(7,1:5) = F4DDot(t(2));  AA(7,6:9) = -F3DDot(t(2));
                            AA(8,6:9) = F3(t(3));                                    BB(8) = x(3);
                            AA(9,6:9) = F3(t(3));      AA(9,10:14) = -F4(t(3));
                            AA(10,6:9) = F3Dot(t(3));  AA(10,10:14) = -F4Dot(t(3));
                            AA(11,6:9) = F3DDot(t(3)); AA(11,10:14) = -F4DDot(t(3));
                                                        AA(12,10:14) = F4(t(4));     BB(12) = x(4);
                                                        AA(13,10:14) = F4Dot(t(4));
                                                        AA(14,10:14) = F4DDot(t(4));
[TT,RR,matsize] = pathGen(12,t,x);
%TT == AA


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
coeff = TT\RR;
matsize
a = coeff(1:5);
b = coeff(6:9);
c = coeff(10:13);
d = coeff(14:17);
e = coeff(18:21);
f = coeff(22:25);
g = coeff(26:29);
h = coeff(30:33);
i2 =coeff(34:37);
j = coeff(38:41);
k = coeff(42:46);

tsamp1 = linspace(t(1),t(2),100);
tsamp2 = linspace(t(2),t(3),100);
tsamp3 = linspace(t(3),t(4),100);
tsamp4 = linspace(t(4),t(5),100);
tsamp5 = linspace(t(5),t(6),100);
tsamp6 = linspace(t(6),t(7),100);
tsamp7 = linspace(t(7),t(8),100);
tsamp8 = linspace(t(8),t(9),100);
tsamp9 = linspace(t(9),t(10),100);
tsamp10 = linspace(t(10),t(11),100);
tsamp11 = linspace(t(11),t(12),100);

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
    xsamp3(i) = F3(tsamp3(i))*c;
    vsamp3(i) = F3Dot(tsamp3(i))*c;
    asamp3(i) = F3DDot(tsamp3(i))*c;
end
for i = 1:length(tsamp3)
    xsamp4(i) = F3(tsamp4(i))*d;
    xsamp5(i) = F3(tsamp5(i))*e;
    xsamp6(i) = F3(tsamp6(i))*f;
    xsamp7(i) = F3(tsamp7(i))*g;
    xsamp8(i) = F3(tsamp8(i))*h;
    xsamp9(i) = F3(tsamp9(i))*i2;
    xsamp10(i) = F3(tsamp10(i))*j;
    xsamp11(i) = F4(tsamp11(i))*k;
end


 plot(t,x,'o')
 hold on
 plot(tsamp1,xsamp1,'--')
 plot(tsamp2,xsamp2,'--')
 plot(tsamp3,xsamp3,'--')
 plot(tsamp4,xsamp4,'--')
 plot(tsamp5,xsamp5,'--')
 plot(tsamp6,xsamp6,'--')
 plot(tsamp7,xsamp7,'--')
 plot(tsamp8,xsamp8,'--')
 plot(tsamp9,xsamp9,'--')
 plot(tsamp10,xsamp10,'--')
  plot(tsamp11,xsamp11,'--')
 %plot(tsamp11,xsamp11,'--')
 

 figure
 plot(tsamp1,vsamp1,'--')
 hold on
 plot(tsamp2,vsamp2,'--')
 plot(tsamp3,vsamp3,'--')
 plot(tsamp1,asamp1,'.')
 plot(tsamp2,asamp2,'.')
 plot(tsamp3,asamp3,'.')

function [LL,RR,matsize] = pathGen(pointNum,t,val) 
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