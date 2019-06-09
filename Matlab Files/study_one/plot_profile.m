function plotted = plot_profile(sensor,DoSaveFile)
% Plot the raw data of the 12 sensors on just one graph

figure('units','normalized','outerposition',[0 0 1 1])
subplot(3,4,1)
plot(sensor(:,1))
title('Whisker sensor movement profile 1');
xlabel('Data Points');
ylabel('Pressure (Pha)')

subplot(3,4,2)
plot(sensor(:,2))
title('Whisker sensor movement profile 2');
xlabel('Data Points');
ylabel('Pressure (Pha)')

subplot(3,4,3)
plot(sensor(:,3))
title('Whisker sensor movement profile 3');
xlabel('Data Points');
ylabel('Pressure (Pha)')

subplot(3,4,4)
plot(sensor(:,4))
title('Whisker sensor movement profile 4');
xlabel('Data Points');
ylabel('Pressure (Pha)')

subplot(3,4,5)
plot(sensor(:,5))
title('Whisker sensor movement profile 5');
xlabel('Data Points');
ylabel('Pressure (Pha)')

subplot(3,4,6)
plot(sensor(:,6))
title('Whisker sensor movement profile 6');
xlabel('Data Points');
ylabel('Pressure (Pha)')

subplot(3,4,7)
plot(sensor(:,7))
title('Whisker sensor movement profile 7');
xlabel('Data Points');
ylabel('Pressure (Pha)')

subplot(3,4,8)
plot(sensor(:,8))
title('Whisker sensor movement profile 8');
xlabel('Data Points');
ylabel('Pressure (Pha)')

subplot(3,4,9)
plot(sensor(:,9))
title('Whisker sensor movement profile 9');
xlabel('Data Points');
ylabel('Pressure (Pha)')

subplot(3,4,10)
plot(sensor(:,10))
title('Whisker sensor movement profile 10');
xlabel('Data Points');
ylabel('Pressure (Pha)')

subplot(3,4,11)
plot(sensor(:,11))
title('Whisker sensor movement profile 11');
xlabel('Data Points');
ylabel('Pressure (Pha)')

subplot(3,4,12)
plot(sensor(:,12))
title('Whisker sensor movement profile 12');
xlabel('Data Points');
ylabel('Pressure (Pha)')

if DoSaveFile == 1
    saveas(gcf,'SensorsProfile.jpg')
end

end