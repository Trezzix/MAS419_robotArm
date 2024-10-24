clc
clear all
close all 
x = [2 5 2];
y = [1 -1 5];
z = [0 1 3];
t = [0 1 3];

AA = zeros(10,10); %x
BB = zeros(10,1);
CC = zeros(10,10); %y
DD = zeros(10,1);
EE = zeros(10,10); %z
FF = zeros(10,1);

TT = zeros(10,10); %x
RR = zeros(10,1);

%x
AA(1,1:5) = F4(t(1));                                       BB(1) = x(1);
AA(2,1:5) = F4Dot(t(1));
AA(3,1:5) = F4DDot(t(1));
AA(4,1:5) = F4(t(2));                                       BB(4) = x(2);
AA(5,1:5) = F4(t(2));           AA(5,6:10) = -F4(t(2));
AA(6,1:5) = F4Dot(t(2));        AA(6,6:10) = -F4Dot(t(2));
AA(7,1:5) = F4DDot(t(2));       AA(7,6:10) = -F4DDot(t(2));
                                AA(8,6:10) = F4(t(3));      BB(8) = x(3);
                                AA(9,6:10) = F4Dot(t(3));
                                AA(10,6:10) = F4DDot(t(3));
% [TT,RR] = pathGen(TT,RR,3,t,x);
% TT == AA
% RR == BB
                                
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%                                
%y
CC(1,1:5) = F4(t(1));                                       DD(1) = y(1);
CC(2,1:5) = F4Dot(t(1));
CC(3,1:5) = F4DDot(t(1));
CC(4,1:5) = F4(t(2));                                   DD(4) = y(2);
CC(5,1:5) = F4(t(2));           CC(5,6:10) = -F4(t(2));
CC(6,1:5) = F4Dot(t(2));        CC(6,6:10) = -F4Dot(t(2));
CC(7,1:5) = F4DDot(t(2));       CC(7,6:10) = -F4DDot(t(2));
                                CC(8,6:10) = F4(t(3));      DD(8) = y(3);
                                CC(9,6:10) = F4Dot(t(3));
                                CC(10,6:10) = F4DDot(t(3));
                                
%z
EE(1,1:5) = F4(t(1));                                       FF(1) = z(1);
EE(2,1:5) = F4Dot(t(1));
EE(3,1:5) = F4DDot(t(1));
EE(4,1:5) = F4(t(2));                                       FF(4) = z(2);
EE(5,1:5) = F4(t(2));           EE(5,6:10) = -F4(t(2));
EE(6,1:5) = F4Dot(t(2));        EE(6,6:10) = -F4Dot(t(2));
EE(7,1:5) = F4DDot(t(2));       EE(7,6:10) = -F4DDot(t(2));
                                EE(8,6:10) = F4(t(3));      FF(8) = z(3);
                                EE(9,6:10) = F4Dot(t(3));
                                EE(10,6:10) = F4DDot(t(3));
% AA(1,1:5) = F4(t(1));                                                                BB(1) = x(1);
% AA(2,1:5) = F4Dot(t(1));
% AA(3,1:5) = F4DDot(t(1));
% AA(4,1:5) = F4(t(2));                                                                BB(4) = x(2);
% AA(5,1:5) = F4(t(2));      AA(5,6:9) = -F3(t(2));
% AA(6,1:5) = F4Dot(t(2));   AA(6,6:9) = -F3Dot(t(2));
% AA(7,1:5) = F4DDot(t(2));  AA(7,6:9) = -F3DDot(t(2));
%                             AA(8,6:9) = F3(t(3));                                    BB(8) = x(3);
%                             AA(9,6:9) = F3(t(3));      AA(9,10:14) = -F4(t(3));
%                             AA(10,6:9) = F3Dot(t(3));  AA(10,10:14) = -F4Dot(t(3));
%                             AA(11,6:9) = F3DDot(t(3)); AA(11,10:14) = -F4DDot(t(3));
%                                                         AA(12,10:14) = F4(t(4));     BB(12) = x(4);
%                                                         AA(13,10:14) = F4Dot(t(4));
%                                                         AA(14,10:14) = F4DDot(t(4));

coeffx = AA\BB;
coeffy = CC\DD;
coeffz = EE\FF;

a = coeffx(1:5);
b = coeffx(6:10);
c = coeffy(1:5);
d = coeffy(6:10);
e = coeffz(1:5);
f = coeffz(6:10);

tsamp1 = linspace(t(1),t(2),100);
tsamp2 = linspace(t(2),t(3),100);
%tsamp3 = linspace(t(3),t(4),100);

for i = 1:length(tsamp1)
    xsamp1(i) = F4(tsamp1(i))*a;
    vxsamp1(i) = F4Dot(tsamp1(i))*a;
    axsamp1(i) = F4DDot(tsamp1(i))*a;
    ysamp1(i) = F4(tsamp1(i))*c;
    vysamp1(i) = F4Dot(tsamp1(i))*c;
    aysamp1(i) = F4DDot(tsamp1(i))*c;
    zsamp1(i) = F4(tsamp1(i))*e;
    vzsamp1(i) = F4Dot(tsamp1(i))*e;
    azsamp1(i) = F4DDot(tsamp1(i))*e;
end
% for i = 1:length(tsamp2)
%     xsamp2(i) = F3(tsamp2(i))*b;
%     vsamp2(i) = F3Dot(tsamp2(i))*b;
%     asamp2(i) = F3DDot(tsamp2(i))*b;
% end
for i = 1:length(tsamp2)
    xsamp2(i) = F4(tsamp2(i))*b;
    vxsamp2(i) = F4Dot(tsamp2(i))*b;
    axsamp2(i) = F4DDot(tsamp2(i))*b;
    ysamp2(i) = F4(tsamp2(i))*d;
    vysamp2(i) = F4Dot(tsamp2(i))*d;
    aysamp2(i) = F4DDot(tsamp2(i))*d;
    zsamp2(i) = F4(tsamp2(i))*f;
    vzsamp2(i) = F4Dot(tsamp2(i))*f;
    azsamp2(i) = F4DDot(tsamp2(i))*f;
end


 plot3(x,y,z,'o')
 hold on
 plot3(xsamp1,ysamp1,zsamp1,'--')
 plot3(xsamp2,ysamp2,zsamp2,'--')
 xlabel("X")
 ylabel("Y")
 zlabel("Z")
 % plot(tsamp3,xsamp3,'--')

 figure
 plot3(vxsamp1,vysamp1,vzsamp1,'--')
 hold on
 plot3(vxsamp2,vysamp2,vzsamp2,'--')
 % plot(tsamp3,vsamp3,'--')
 plot3(axsamp1,aysamp1,azsamp1,'.')
 plot3(axsamp2,aysamp2,azsamp2,'.')
 % plot(tsamp3,asamp3,'.')
 legend("v1", "v2", "a1", "a2")









% function [LL,RR] = pathGen(LL,RR,pointNum,t,val) 
%     i = 1;
%     m = 1;
%     index = 1;
%     LL(i,index:index+4) = F4(t(m));   RR(i) = val(m);   i=i+1; 
%     LL(i,index:index+4) = F4Dot(t(m));                i=i+1;
%     LL(i,index:index+4) = F4DDot(t(m));               i=i+1;
%     m=m+1;
%     LL(i,index:index+4) = F4(t(m));   RR(i) = val(m);   i=i+1;
%     %m=m+1;
%     if pointNum < 3
%         error("Too few points")
%     end
% 
%     if pointNum == 3
%         [LL,RR,index,i,m]= middleSec(LL,RR,"3",index,i,m,t,val);
%     else
%         for n = 1:pointNum-1
%             if n == 1
%                 [LL,RR,index,i,m]= middleSec(LL,RR,"first",index,i,m,t,val);
%             elseif n == pointNum-1
%                 [LL,RR,index,i,m]= middleSec(LL,RR,"last",index,i,m,t,val);
%                 break
%             else
%                 [LL,RR,index,i,m]= middleSec(LL,RR,"middle",index,i,m,t,val);
%             end
%         end
%     end
%     LL(i,index:index+4) = F4(t(m));     RR(i) = val(m); i=i+1;
%     LL(i,index:index+4) = F4Dot(t(m));                i=i+1;
%     LL(i,index:index+4) = F4DDot(t(m));
% 
% end
% function [LL,RR,index,i,m] = middleSec(LL,RR,pos,index,i,m,t,val) 
%     if pos == "first"
%         LL(i,index:index+4) = F4(t(m));      LL(5,index+5:index+9) = -F3(t(m));
%         LL(i,index:index+4) = F4Dot(t(m));   LL(6,index+5:index+9) = -F3Dot(t(m));
%         LL(i,index:index+4) = F4DDot(t(m));  LL(7,index+5:index+9) = -F3DDot(t(m));
%         index = index + 5;
%         m=m+1;
%     elseif pos == "last"
%         LL(i,index:index+4) = F3(t(m));      RR(i) = val(m);
%         LL(i,index:index+4) = F3(t(m));      LL(i,index+5:index+9) = -F4(t(m));
%         LL(i,index:index+4) = F3Dot(t(m));   LL(i,index+5:index+9) = -F4Dot(t(m));
%         LL(i,index:index+4) = F3DDot(t(m));  LL(i,index+5:index+9) = -F4DDot(t(m));
%         index = index + 5;
%         m=m+1;
%     elseif pos == "3"
%         LL(i,index:index+4) = F4(t(m));           LL(i,index+5:index+9) = -F4(t(m));     i=i+1; 
%         LL(i,index:index+4) = F4Dot(t(m));        LL(i,index+5:index+9) = -F4Dot(t(m));  i=i+1; 
%         LL(i,index:index+4) = F4DDot(t(m));       LL(i,index+5:index+9) = -F4DDot(t(m)); i=i+1; 
%         index = index + 5;
%         m=m+1;
%     else %middle
%         LL(i,index:index+4) = F3(t(m));      RR(i) = val(m);
%         LL(i,index:index+4) = F3(t(m));           LL(i,index+5:index+9) = -F3(t(m));     i=i+1; 
%         LL(i,index:index+4) = F3Dot(t(m));        LL(i,index+5:index+9) = -F3Dot(t(m));  i=i+1; 
%         LL(i,index:index+4) = F3DDot(t(m));       LL(i,index+5:index+9) = -F3DDot(t(m)); i=i+1; 
%         index = index + 5;
%         m=m+1;
%     end
%     % LL(1,1:5) = F4(t(1));   RR(1) = x(1);
%     % LL(2,1:5) = F4Dot(t(1));
%     % LL(3,1:5) = F4DDot(t(1));
%     % LL(4,1:5) = F4(t(2));   RR(4) = x(2);
% end

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