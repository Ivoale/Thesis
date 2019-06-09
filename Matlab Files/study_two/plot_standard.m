function plotted = plot_standard(sensor,trial,DoSaveFile)
% Plot the standard moving standard deviation of the z-scores but only of 
% one chosen sensor

figure('visible','off','units','normalized','outerposition',[0 0 1 1])

plot(sensor(:,trial),'m','LineWidth',3)
title('Standard Deviation of Z-scores');
ax = gca;
ax.FontSize = 17;
xlabel('Data Samples');
ylabel('Standard Deviation')


if DoSaveFile == 1
    filename = sprintf('OneSantard.jpg') ;
    saveas(gcf,filename)
end
end
