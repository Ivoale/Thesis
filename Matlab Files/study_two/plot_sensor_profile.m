function plotted = plot_sensor_profile(sensor,trial,DoSaveFile)
% Plot the sensors profile, i.e. the raw data but only of one chosen sensor

figure('visible','off','units','normalized','outerposition',[0 0 1 1])
plot(sensor(:,trial),'b','LineWidth',2)
title('Whisker sensor movement profile (Automated)');
ax = gca;
ax.FontSize = 17;
xlabel('Data Samples');
ylabel('Pressure (Pa)')


if DoSaveFile == 1
    filename = sprintf('OneSensor.jpg') ;
    saveas(gcf,filename)
end
end
