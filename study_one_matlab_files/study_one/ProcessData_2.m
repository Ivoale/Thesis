function [target] = ProcessData_2(Yva)
%Threshold function that takes the standard deviations of the z-scores as
%input and returns the targets

[sizel sizen] = size(Yva);

mean1 = mean(Yva(1:100,:));
std1 = std(Yva(1:100,:));

% Each sensor has its own calculations
n = 4;
target(1) = mean1(1) + n*std1(1);  
n = 4.5;
target(2) = mean1(2) + n*std1(2);  
n = 3;
target(3) = mean1(3) + n*std1(3);
n = 3.7;
target(4) = mean1(4) + n*std1(4);
n = 4.5;
target(5) = mean1(5) + n*std1(5);
n = 2.5;
target(6) = mean1(6) + n*std1(6);
n = 3;
target(7) = mean1(7) + n*std1(7);
n = 3;
target(8) = mean1(8) + n*std1(8);
n = 3.5;
target(9) = mean1(9) + n*std1(9);
n = 4.5;
target(10) = mean1(10) + n*std1(10);
n = 6.5;
target(11) = mean1(11) + n*std1(11);
n = 6.5;
target(12) = mean1(12) + n*std1(12);

end


