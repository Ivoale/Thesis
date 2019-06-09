function plotted = plot_target(oneTarget,DoSaveFile)
% Plot the processed targets

figure('units','normalized','outerposition',[0 0 1 1])
subplot(2,3,1)
plot(oneTarget(1,:),'LineWidth',2)
title('No touch');
xlabel('Data Points');
ylim([0 1.1]);
set(gca,'FontSize',17);

subplot(2,3,2)
plot(oneTarget(2,:),'LineWidth',2)
title('Brush');
xlabel('Data Points');
ylim([0 1.1]);
set(gca,'FontSize',17);

subplot(2,3,3)
plot(oneTarget(3,:),'LineWidth',2)
title('Flick');
xlabel('Data Points');
ylim([0 1.1]);
set(gca,'FontSize',17);

subplot(2,3,4)
plot(oneTarget(4,:),'LineWidth',2)
title('Tip');
xlabel('Data Points');
ylim([0 1.1]);
set(gca,'FontSize',17);

subplot(2,3,5)
plot(oneTarget(5,:),'LineWidth',2)
title('Hold');
xlabel('Data Points');
ylim([0 1.1]);
set(gca,'FontSize',17);

if DoSaveFile == 1
    saveas(gcf,'Targets_auto.jpg')
end

end