% Process raw data from manual experiment. This file sets the targets
% manually.
% created by Ivonne Vera Pauta
% source and helper: Andrew Back

close all, clear all

%Set parameters for moving average and standard deviation calculations
kb = 49;
kf = 0;
DoSaveFile = 1;
output = 5;
input = 12;
firstH = 1812; %Set the half of the data for the 6 cases
first = 1;
secondH = 1813;

%=========================================================================
%
% Read in whiskers data and normalize
numData = dlmread('whiskers.csv',',');
[total,whiskers] = size(numData);
threshold = 0.009;

%Normalize the sensors data
Ynorm_orig = numData;
numData = Ynorm_orig + 0.01*rand(size(numData));

%Calculate Z-scores of all data
Zscore = zscore(numData);

%Plot profile of each sensor
plot_profile(numData, DoSaveFile);

%Plot the zcores
plot_zscores(Zscore,DoSaveFile);

%calculate the mean with moving average
meanZscore = movmean(Zscore,[kb kf],1);

%Plot the mean of the z-scores
plot_meanZscore(meanZscore,DoSaveFile);

%calculate the standard deviation with moving std
standardZscore = movstd(Zscore,[kb kf],0,1);

%plot the standard deviation of the z-scores
plot_standardZscore(standardZscore,DoSaveFile);

%calculate maximum value of the standard deviation
%gives one for each sensor 
maxV = max(standardZscore);

%copy the maximum value in matrix of 3624x12
norms = repmat(maxV,total,1);

%normalize the standard deviation
normli = standardZscore./norms;

%plot the normalized standard deviation of zscore
plot_normStandardZscore(normli,DoSaveFile);

%process the data
varianceData = normli;
%% ======================================================================
% Add the targets manually
flick1 = 410;
flick2 = 750;
tip1 = 1140;
tip2 = 1500;
hold1 = 2106;
hold2 = 2420;
brush1 = 3166;
brush2 = 3260;

target = ones(1,total);
target(flick1:flick2) = 0;
target(tip1:tip2) = 0;
target(hold1:hold2) = 0;
target(brush1:brush2) = 0;

manyTarget = repmat(target,5,1);
oneTarget = zeros(1,total);
oneTarget = manyTarget(1,:);
oneTarget(2,flick1:flick2) = 1;
oneTarget(3,tip1:tip2) = 1;
oneTarget(4,hold1:hold2) = 1;
oneTarget(5,brush1:brush2) = 1;
plot_target(oneTarget,DoSaveFile);
%% ======================================================================
% save the random values, so it is the same next time
s = rng;

%% =======================================================================
% Design neural network

close all

inputNor = normli';

%1.first half training with second half testing
% normtr = inputNor(:,first:firstH);
% oneTargeTest = oneTarget(:,secondH:total);
% oneTargetTrain = oneTarget(:,first:firstH);

%2.first half testing with second half training
% normtr = inputNor(:,secondH:total);
% oneTargeTest = oneTarget(:,first:firstH);
% oneTargetTrain = oneTarget(:,secondH:total);

%3.Training all data
% normtr = normli';

%3.1
% oneTargeTest1 = oneTarget(:,secondH:total);
% oneTargeTest2 = oneTarget(:,first:firstH);
% oneTargeTest = cat(2,oneTargeTest1,oneTargeTest2);
% oneTargetTrain = oneTarget;

%3.2
% oneTargeTest1 = oneTarget(:,501:total);
% oneTargeTest2 = oneTarget(:,first:500);
% oneTargeTest = cat(2,oneTargeTest1,oneTargeTest2);
% oneTargetTrain = oneTarget;

%4.every second from 1
% normtr = inputNor(:,first:2:total);
% oneTargeTest = oneTarget(:,2*first:2:total);
% oneTargetTrain = oneTarget(:,first:2:total);

%5.every second from 2
normtr = inputNor(:,2*first:2:total);
oneTargeTest = oneTarget(:,first:2:total);
oneTargetTrain = oneTarget(:,2*first:2:total);

%6. use first 6 sensors for training
% normtr = inputNor(1:6,:);
% oneTargeTest = oneTarget;
% oneTargetTrain = oneTarget;

%7. use last 6 sensors for training
% normtr = inputNor(7:12,:);
% oneTargeTest = oneTarget;
% oneTargetTrain = oneTarget;

mv = minmax(normtr);

layer_1 = 40;
number_wb = input*(layer_1) + layer_1*output + layer_1 + output;
net = newff(mv,[layer_1 5],{'tansig','purelin'},'trainlm');

%use the previous random values
rng(s);

%set the weight and bias values
matrix_wb1 = rand(number_wb,1);
net = setwb(net,matrix_wb1);

%set net parameters
net.trainParam.epochs = 5;
net.trainParam.show = 1;
net.trainParam.goal = 0;

net = configure(net,normtr,oneTargetTrain);

%get the initial weight and bias values
wb1 = getwb(net);
[b,iw,lw] = separatewb(net,wb1);

%Train the network
[net,tr,X,E] = train(net,normtr,oneTargetTrain);
initial_output = net(normtr);
perf = perform(net, oneTargetTrain, initial_output);

%get the final weight and bias values
wb = getwb(net);
[b1,iw1,lw1] = separatewb(net,wb);
figure
plotwb(net)

% evaluate performance: decoding network response
[m,i] = max(oneTargetTrain); 
[m,j] = max(X); 
N = length(X); 
k = 0; 
if find(i-j), 
    k = length(find(i-j)); 
end
fprintf('Correct classified samples training: %.1f%% samples\n', 100*(N-k)/N)

%% ======================================================================
% Test the trained network with processed data
% Choose the testing set according the training (from 1 to 7)

%1.second half testing with first half training
% normte = inputNor(:,secondH:total);

%2.first half testing with second half training
% normte = inputNor(:,first:firstH);

%4.every second from 1
% normte = inputNor(:,2*first:2:total);

%5.every second from 2
normte = inputNor(:,first:2:total);

%3 Training all data
% normte = inputNor;

%6. use first 6 sensors for training
% normte = inputNor(7:12,:);

%7. use last 6 sensors for training
%normte = inputNor(1:6,:);

Yn = sim(net,normte);
x=1;

% evaluate performance: decoding network response
[m,i] = max(oneTargeTest);
[m,j] = max(Yn); 
N = length(Yn); 
k = 0; 
if find(i-j), 
    k = length(find(i-j)); 
end
fprintf('Correct classified samples testing: %.1f%% samples\n', 100*(N-k)/N)

%% ==============================================================
% Graph the test outputs from the neural network

max_flick = find(Yn(2,:)==max(Yn(2,:)));
max_tip = find(Yn(3,:)==max(Yn(3,:)));
max_hold = find(Yn(4,:)==max(Yn(4,:)));
max_brush = find(Yn(5,:)==max(Yn(5,:)));


figure('units','normalized','outerposition',[0 0 1 1])
subplot(2,2,1);  plot(Yn(2,:),'b','LineWidth',3)
hold on
plot(max_flick,1.9,'rp','MarkerSize',20,'MarkerFaceColor','r');
hold off
titlestr = sprintf('Brush');
title(titlestr,'Interpreter','latex','FontSize',17,'HorizontalAlignment','center');
set(gca,'FontSize',17);
xlabel('Data Samples');
ylabel('Touch Target');
ylim([-2 2])

subplot(2,2,2);  plot(Yn(3,:),'m','LineWidth',3)
hold on
plot(max_tip,1.9,'rp','MarkerSize',20,'MarkerFaceColor','r');
hold off
titlestr = sprintf('Flick');
title(titlestr,'Interpreter','latex','FontSize',17,'HorizontalAlignment','center');
set(gca,'FontSize',17);
xlabel('Data Samples');
ylabel('Touch Target');
ylim([-2 2])

subplot(2,2,3);  plot(Yn(4,:),'g','LineWidth',3)
hold on
plot(max_hold,1.9,'rp','MarkerSize',20,'MarkerFaceColor','r');
hold off
titlestr = sprintf('Hold');
title(titlestr,'Interpreter','latex','FontSize',17,'HorizontalAlignment','center');
set(gca,'FontSize',17);
xlabel('Data Samples');
ylabel('Touch Target');
ylim([-2 2])

subplot(2,2,4);  plot(Yn(5,:),'c','LineWidth',3)
hold on
plot(max_brush,1.9,'rp','MarkerSize',20,'MarkerFaceColor','r');
hold off
titlestr = sprintf('Tip');
title(titlestr,'Interpreter','latex','FontSize',17,'HorizontalAlignment','center');
set(gca,'FontSize',17);
xlabel('Data Samples');
ylabel('Touch Target');
ylim([-2 2])

filename = sprintf('RESULT_hand.jpg');
saveas(gcf,filename)





