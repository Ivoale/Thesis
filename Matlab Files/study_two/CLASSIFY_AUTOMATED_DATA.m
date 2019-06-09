% Process raw data from autonomous experiment, the targets are processed
% manually
% created by Ivonne Vera Pauta
% source and helper: Andrew Back

close all, clear all
%Set parameters for moving calculations
kb = 49;
kf = 0;
DoSaveFile = 1;
output = 5;
input = 12;
oneSensor = 3;
%=========================================================================
%
% Read in whiskers data and normalize
numData = dlmread('raw_data.csv',',');

% Get the number of trials and all the necessary data
[total,sensors] = size(numData);
numData_short = numData(1:4945,:);
trials = sensors/12;

%Normalize the sensors data
Ynorm_orig = numData_short;

plot_sensor_profile(numData_short, oneSensor, DoSaveFile);
%% =======================================================================
%Plot profile of each sensor
plot_profile_short(numData_short, trials, DoSaveFile);

% add noise to the data
numData_norm = Ynorm_orig + 0.01*rand(size(numData_short));

%% ======================================================================

%Calculate Z-scores of all data
Zscore = zscore(numData_norm);

plot_profile_norm(numData_norm, trials, DoSaveFile);
%%
%Plot the zcores
plot_zscores_short(Zscore,trials,DoSaveFile);

%calculate the mean with moving average
meanZscore = movmean(Zscore,[kb kf],1);

%Plot the mean of the z-scores
plot_meanZscore_short(meanZscore,trials,DoSaveFile);

%calculate the standard deviation with moving std
standardZscore = movstd(Zscore,[kb kf],0,1);

%plot the standard deviation of the z-scores
plot_standardZscore_short(standardZscore,trials,DoSaveFile);

%calculate maximum value of the standard deviation
%gives one for each sensor 
maxV = max(standardZscore);

[total,sensors_short] = size(numData_short);

%copy the maximum value in matrix
norms = repmat(maxV,total,1);

%normalize the standard deviation
normli = standardZscore./norms;

%plot the normalized standard deviation of zscore
plot_normStandardZscore_short(normli,trials,DoSaveFile);

plot_standard(normli,oneSensor,DoSaveFile);

%process the data
varianceData = normli;

%% PROCESS THE MANUAL TARGETS

flick1 = 593;
flick2 = 640;
tip1 = 1710;
tip2 = 2310;
hold1 = 3090;
hold2 = 3233;
brush1 = 4266;
brush2 = 4600;

target = ones(1,total);
target(flick1:flick2) = 0;
target(tip1:tip2) = 0;
target(hold1:hold2) = 0;
target(brush1:brush2) = 0;

%%

varianceData = normli;
manyTarget = repmat(target,5,1);
oneTarget = zeros(1,total);
oneTarget = manyTarget(1,:);
oneTarget(2,flick1:flick2) = 1;
oneTarget(3,tip1:tip2) = 1;
oneTarget(4,hold1:hold2) = 1;
oneTarget(5,brush1:brush2) = 1;

%plot targets
plot_target(oneTarget,DoSaveFile);

%% ===============================================================
% save the random values, so it is the same next time
s = rng;

%% Design neural network
input = 12;
train1 = 17; % number of training sets
test = 17; %number of testing sets
normtr = normli(:,1:input)';
mv = minmax(normtr);

layer_1 = 40;
number_wb = input*(layer_1) + layer_1*output + layer_1 + output;

net = newff(mv,[layer_1 5],{'tansig','purelin'});


%set the weight and bias values
%use the previous random values
rng(s);
matrix_wb1 = rand(number_wb,1);
net = setwb(net,matrix_wb1);

%% ======================================================================
%set net parameters
net.trainParam.epochs = 5;
net.trainParam.show = 1;
net.trainParam.goal = 0;

net = configure(net,normtr,oneTarget);
mse_per = []; %mse values from training 

for h = 1:train1
    
     p = 12 * h;
     [net,tr,X,E] = train(net,normtr,oneTarget);
     figure('visible','off','units','normalized','outerposition',[0 0 1 1])
     plotperform(tr);
     filename = sprintf('per_%d.jpg', h);
     saveas(gcf,filename)
     normtr = normli(:,1+p:input+p)';
     per = tr.perf;
     
     mse_per = [mse_per; per];
     
     % evaluate performance: decoding network response
     [m,i] = max(oneTarget); 
     [m,j] = max(X); 
     N = length(X); 
     k = 0; 
     if find(i-j) 
         k = length(find(i-j));
     end
     fprintf('Correct classified samples: %.1f%% samples\n', 100*(N-k)/N)
    
     %plot network output
     figure('visible','off','units','normalized','outerposition',[0 0 1 1])
     subplot(2,2,1);  plot(X(2,:),'b','LineWidth',3)
     titlestr = sprintf('Flick');
     title(titlestr,'Interpreter','latex','FontSize',17,'HorizontalAlignment','center');
     set(gca,'FontSize',17);
     xlabel('Data Samples');
     ylabel('Touch Target');
     ylim([-2 2])
     
     subplot(2,2,2);  plot(X(3,:),'m','LineWidth',3)    
     titlestr = sprintf('Tip');
     title(titlestr,'Interpreter','latex','FontSize',17,'HorizontalAlignment','center');
     set(gca,'FontSize',17);
     xlabel('Data Samples');
     ylabel('Touch Target');
     ylim([-2 2])
     
     subplot(2,2,3);  plot(X(4,:),'g','LineWidth',3)     
     titlestr = sprintf('Hold');
     title(titlestr,'Interpreter','latex','FontSize',17,'HorizontalAlignment','center');
     set(gca,'FontSize',17);
     xlabel('Data Samples');
     ylabel('Touch Target');
     ylim([-2 2])
     
     subplot(2,2,4);  plot(X(5,:),'c','LineWidth',3)     
     titlestr = sprintf('Brush');
     title(titlestr,'Interpreter','latex','FontSize',17,'HorizontalAlignment','center');
     set(gca,'FontSize',17);
     xlabel('Data Samples');
     ylabel('Touch Target');
     ylim([-2 2])
     
     filename = sprintf('RESTRAIN_%d.jpg', h);
     saveas(gcf,filename)
         

end 

%% Test the trained network with processed data

b = 37;
v = 48;

oneTargeTest = oneTarget;

% save the maximum values for the classification of each output
flick = [];
tip = [];
holds = [];
brush = [];

percentage = [];
mse_te = [];
p = 0;

% total number of sample points for each touch type
total_f = flick2-flick1;
total_t = tip2-tip1;
total_h = hold2-hold1;
total_b = brush2-brush1;

%% test the neural network on the testing set

% save the values to calculate the percentages of correct number of sample
% points being classified

results = [];
compare = [];
real_brush = [];
real_flick = [];
real_tip = [];
real_hold = [];

for c = 1:(test)
    p = 12 * c;
    normte = normli(:,b+p:v+p)';
    Yn = sim(net,normte);
    
    % evaluate performance: decoding network response
    [m,i] = max(oneTargeTest); 
    [m,j] = max(Yn); 
    N = length(Yn); 
    k = 0; 
    if find(i-j), 
        k = length(find(i-j)); 
    end
    percen = 100*(N-k)/N;
    fprintf('Correct classified samples testing: %.1f%% samples\n', percen)
    
    % get the number of sample points being classified as a specific touch
    % type
    real_f = length(find(i(:,flick1:flick2)-j(:,flick1:flick2)));
    real_f = 100*(total_f-real_f)/total_f;
    real_t = length(find(i(:,tip1:tip2)-j(:,tip1:tip2)));
    real_t = 100*(total_t-real_t)/total_t;
    real_h = length(find(i(:,hold1:hold2)-j(:,hold1:hold2)));
    real_h = 100*(total_h-real_h)/total_h;
    real_b = length(find(i(:,brush1:brush2)-j(:,brush1:brush2)));
    real_b = 100*(total_b-real_b)/total_b;
    real_brush = [real_brush real_b];
    real_flick = [real_flick real_f];
    real_tip = [real_tip real_t];
    real_hold = [real_hold real_h];
    compare = [compare; i];
    results = [results; j];
    percentage = [percentage percen];
    err = immse(Yn,oneTargeTest);
    mse_te = [mse_te err];
      
    % Find the maximum values of each output    
    max_flick = find(Yn(2,:)==max(Yn(2,:)));
    max_tip = find(Yn(3,:)==max(Yn(3,:)));
    max_hold = find(Yn(4,:)==max(Yn(4,:)));
    max_brush = find(Yn(5,:)==max(Yn(5,:)));
    flick = [flick max_flick];
    tip = [tip max_tip];
    holds = [holds max_hold];
    brush = [brush max_brush];
     
    figure('visible','off','units','normalized','outerposition',[0 0 1 1])       
    subplot(2,2,1);  plot(Yn(2,:),'b','LineWidth',3)
    hold on
    plot(max_flick,1.9,'rp','MarkerSize',20,'MarkerFaceColor','r');
    hold off
    titlestr = sprintf('Flick');
    title(titlestr,'Interpreter','latex','FontSize',17,'HorizontalAlignment','center');
    set(gca,'FontSize',17);
    xlabel('Data Samples');
    ylabel('Touch Target');
    ylim([-2 2])
    
    subplot(2,2,2);  plot(Yn(3,:),'m','LineWidth',3)
    hold on
    plot(max_tip,1.9,'rp','MarkerSize',20,'MarkerFaceColor','r');
    hold off
    titlestr = sprintf('Tip');
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
    titlestr = sprintf('Brush');
    title(titlestr,'Interpreter','latex','FontSize',17,'HorizontalAlignment','center');
    set(gca,'FontSize',17);
    xlabel('Data Samples');
    ylabel('Touch Target');
    ylim([-2 2])
    
    filename = sprintf('RESULT_%d.jpg', c);
    saveas(gcf,filename)
          
end
%% Plot the performance of the training set

figure('visible','off','units','normalized','outerposition',[0 0 1 1])  

x = [0 1 2 3 4 5];
plot(x,mse_per(17,:),'b','LineWidth',5);
set(gca,'xtick', [0:1:6]); 
title('Training Performance');
set(gca,'FontSize',17);
xlabel('Epochs');
ylabel('Mean Squared Error (mse)');
ylim([0.009 0.015])
filename = sprintf('Train_perfo.jpg');
saveas(gcf,filename)

%% Process the confusion matrix

% This calculates the percentage at which the samples points are classified
% as tip, hold, brush or flick for each of the outputs

divide_flick = (total_f+1)*16;
fake_f_t = (find_3(results,flick1,flick2)/divide_flick)*100;
fake_f_h = (find_4(results,flick1,flick2)/divide_flick)*100;
fake_f_b = (find_5(results,flick1,flick2)/divide_flick)*100;
fake_f_f = (find_2(results,flick1,flick2)/divide_flick)*100;
fake_f_n = (find_1(results,flick1,flick2)/divide_flick)*100;

divide_tip = (total_t+1)*16;
fake_t_t = (find_3(results,tip1,tip2)/divide_tip)*100;
fake_t_h = (find_4(results,tip1,tip2)/divide_tip)*100;
fake_t_b = (find_5(results,tip1,tip2)/divide_tip)*100;
fake_t_f = (find_2(results,tip1,tip2)/divide_tip)*100;
fake_t_n = (find_1(results,tip1,tip2)/divide_tip)*100;

divide_hold = (total_h+1)*16;
fake_h_t = (find_3(results,hold1,hold2)/divide_hold)*100;
fake_h_h = (find_4(results,hold1,hold2)/divide_hold)*100;
fake_h_b = (find_5(results,hold1,hold2)/divide_hold)*100;
fake_h_f = (find_2(results,hold1,hold2)/divide_hold)*100;
fake_h_n = (find_1(results,hold1,hold2)/divide_hold)*100;

divide_brush = (total_b+1)*16;
fake_b_t = (find_3(results,brush1,brush2)/divide_brush)*100;
fake_b_h = (find_4(results,brush1,brush2)/divide_brush)*100;
fake_b_b = (find_5(results,brush1,brush2)/divide_brush)*100;
fake_b_f = (find_2(results,brush1,brush2)/divide_brush)*100;
fake_b_n = (find_1(results,brush1,brush2)/divide_brush)*100;

