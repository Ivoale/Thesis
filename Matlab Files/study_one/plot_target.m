function plotted = plot_target(oneTarget,DoSaveFile)
%Plot the targets obtained 

figure('units','normalized','outerposition',[0 0 1 1])
subplot(2,3,1)
plot(oneTarget(1,:),'LineWidth',3)
ax = gca;
ax.FontSize = 17;
title('No touch');
xlabel('Data Points');
ylim([0 1.1]);

subplot(2,3,2)
plot(oneTarget(2,:),'LineWidth',3)
ax = gca;
ax.FontSize = 17;
title('Brush');
xlabel('Data Points');
ylim([0 1.1]);

subplot(2,3,3)
plot(oneTarget(3,:),'LineWidth',3)
ax = gca;
ax.FontSize = 17;
title('Flick');
xlabel('Data Points');
ylim([0 1.1]);

subplot(2,3,4)
plot(oneTarget(4,:),'LineWidth',3)
ax = gca;
ax.FontSize = 17;
title('Tip');
xlabel('Data Points');
ylim([0 1.1]);

subplot(2,3,5)
plot(oneTarget(5,:),'LineWidth',3)
ax = gca;
ax.FontSize = 17;
title('Hold');
xlabel('Data Points');
ylim([0 1.1]);

if DoSaveFile == 1
    saveas(gcf,'Targets.jpg')
end

end