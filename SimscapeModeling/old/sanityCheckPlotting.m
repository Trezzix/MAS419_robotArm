clc; close all;

%% Plotting All Joints

% figure
% plot(thetas(1,:), thetas(2,:))
% hold on
% for i = 3:10
%     plot(thetas(1,:), thetas(i,:))
% end

%% Plotting Actuated Joints

data = thetas';
plot(data(:,1), data(:,3))